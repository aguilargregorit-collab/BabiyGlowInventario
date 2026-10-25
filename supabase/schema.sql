-- Babi & Glow Inventory: esquema inicial.
-- IMPORTANTE: el acceso por nombre de usuario NO autentica la identidad.
-- Estas políticas permiten CRUD público para facilitar una demo privada/de prueba.
-- NO uses estas políticas en un inventario comercial público sin implementar autenticación real y políticas RLS por usuario.

create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  quantity integer not null default 0 check (quantity >= 0),
  price numeric(12,2) not null default 0 check (price >= 0),
  entry_date date not null default current_date,
  image_url text,
  created_at timestamptz not null default now()
);

alter table public.products enable row level security;
drop policy if exists "demo_read_products" on public.products;
drop policy if exists "demo_insert_products" on public.products;
drop policy if exists "demo_update_products" on public.products;
drop policy if exists "demo_delete_products" on public.products;
create policy "demo_read_products" on public.products for select to anon, authenticated using (true);
create policy "demo_insert_products" on public.products for insert to anon, authenticated with check (true);
create policy "demo_update_products" on public.products for update to anon, authenticated using (true) with check (true);
create policy "demo_delete_products" on public.products for delete to anon, authenticated using (true);

-- Bucket público para mostrar imágenes desde URL pública. Cualquier persona con el enlace podrá verlas.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('productos', 'productos', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 5242880, allowed_mime_types = array['image/jpeg','image/png','image/webp'];

drop policy if exists "demo_upload_product_images" on storage.objects;
drop policy if exists "demo_update_product_images" on storage.objects;
drop policy if exists "demo_delete_product_images" on storage.objects;
create policy "demo_upload_product_images" on storage.objects for insert to anon, authenticated with check (bucket_id = 'productos');
create policy "demo_update_product_images" on storage.objects for update to anon, authenticated using (bucket_id = 'productos') with check (bucket_id = 'productos');
create policy "demo_delete_product_images" on storage.objects for delete to anon, authenticated using (bucket_id = 'productos');
