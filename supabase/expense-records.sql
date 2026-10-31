-- Babi&Glow: registro de gastos con fecha para filtrar y exportar reportes.
-- Ejecutar en el SQL Editor del mismo proyecto Supabase usado por el inventario.
-- Estas políticas son compatibles con el modo demo actual; no son apropiadas para un sistema público comercial.
create table if not exists public.expense_records (
  id uuid primary key default gen_random_uuid(),
  description text not null check (length(trim(description)) > 0),
  category text not null default 'Otros',
  amount numeric(12,2) not null check (amount > 0),
  expense_date date not null default current_date,
  notes text,
  created_at timestamptz not null default now()
);
create index if not exists expense_records_date_idx on public.expense_records (expense_date desc);
alter table public.expense_records enable row level security;
drop policy if exists "demo_read_expense_records" on public.expense_records;
drop policy if exists "demo_insert_expense_records" on public.expense_records;
drop policy if exists "demo_delete_expense_records" on public.expense_records;
create policy "demo_read_expense_records" on public.expense_records for select to anon, authenticated using (true);
create policy "demo_insert_expense_records" on public.expense_records for insert to anon, authenticated with check (true);
create policy "demo_delete_expense_records" on public.expense_records for delete to anon, authenticated using (true);
grant select, insert, delete on public.expense_records to anon, authenticated;
