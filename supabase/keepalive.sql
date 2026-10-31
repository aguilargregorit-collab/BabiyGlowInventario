-- Babi&Glow: actividad real y mantenimiento automático para el proyecto compartido.
-- Ejecutar UNA VEZ en Supabase > SQL Editor.
-- La tarea programada de Vercel consulta este RPC diariamente. El RPC solo registra
-- un pulso de mantenimiento cuando han pasado al menos 72 horas desde actividad real.

create table if not exists public.babiglow_activity_guard (
  id smallint primary key check (id = 1),
  last_real_activity_at timestamptz not null default now(),
  last_maintenance_at timestamptz,
  last_activity_source text not null default 'setup'
);

insert into public.babiglow_activity_guard (id, last_real_activity_at, last_activity_source)
values (1, now(), 'setup')
on conflict (id) do nothing;

alter table public.babiglow_activity_guard enable row level security;
revoke all on public.babiglow_activity_guard from anon, authenticated, public;
grant all on public.babiglow_activity_guard to service_role;

create or replace function public.note_babiglow_real_activity()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.babiglow_activity_guard (id, last_real_activity_at, last_activity_source)
  values (1, now(), tg_table_name)
  on conflict (id) do update
    set last_real_activity_at = now(),
        last_activity_source = excluded.last_activity_source;
  if tg_op = 'DELETE' then
    return old;
  end if;
  return new;
end;
$$;

-- Registra escrituras reales en las tablas que usan las dos aplicaciones.
drop trigger if exists babiglow_activity_products on public.products;
create trigger babiglow_activity_products
after insert or update or delete on public.products
for each row execute function public.note_babiglow_real_activity();

drop trigger if exists babiglow_activity_catalog_terms on public.catalog_terms;
create trigger babiglow_activity_catalog_terms
after insert or update or delete on public.catalog_terms
for each row execute function public.note_babiglow_real_activity();

do $$
begin
  if to_regclass('public.catalog_visitors') is not null then
    execute 'drop trigger if exists babiglow_activity_catalog_visitors on public.catalog_visitors';
    execute 'create trigger babiglow_activity_catalog_visitors after insert or update or delete on public.catalog_visitors for each row execute function public.note_babiglow_real_activity()';
  end if;
  if to_regclass('public.calendar_events') is not null then
    execute 'drop trigger if exists babiglow_activity_calendar_events on public.calendar_events';
    execute 'create trigger babiglow_activity_calendar_events after insert or update or delete on public.calendar_events for each row execute function public.note_babiglow_real_activity()';
  end if;
  if to_regclass('public.expense_records') is not null then
    execute 'drop trigger if exists babiglow_activity_expense_records on public.expense_records';
    execute 'create trigger babiglow_activity_expense_records after insert or update or delete on public.expense_records for each row execute function public.note_babiglow_real_activity()';
  end if;
end;
$$;

create or replace function public.run_babiglow_keepalive()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_last_real timestamptz;
  v_last_maintenance timestamptz;
begin
  select last_real_activity_at, last_maintenance_at
    into v_last_real, v_last_maintenance
  from public.babiglow_activity_guard
  where id = 1
  for update;

  if v_last_real is null then
    return jsonb_build_object('status', 'not_initialized');
  end if;

  if now() - v_last_real < interval '72 hours' then
    return jsonb_build_object(
      'status', 'recent_activity',
      'last_real_activity_at', v_last_real,
      'next_maintenance_after', v_last_real + interval '72 hours'
    );
  end if;

  if v_last_maintenance is not null and now() - v_last_maintenance < interval '72 hours' then
    return jsonb_build_object('status', 'maintenance_recent', 'last_maintenance_at', v_last_maintenance);
  end if;

  update public.babiglow_activity_guard
  set last_maintenance_at = now()
  where id = 1;

  return jsonb_build_object(
    'status', 'maintenance_recorded',
    'last_real_activity_at', v_last_real,
    'maintenance_at', now()
  );
end;
$$;

revoke all on function public.note_babiglow_real_activity() from public, anon, authenticated;
revoke all on function public.run_babiglow_keepalive() from public, anon, authenticated;
grant execute on function public.run_babiglow_keepalive() to service_role;
