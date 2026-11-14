-- 1. Tabel Kategori
create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz default now()
);

-- 2. Tabel Produk
create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category_id uuid references categories(id),
  description text,
  price integer not null,
  cost_price integer not null,
  sizes text[] default '{}',
  colors text[] default '{}',
  can_custom boolean default false,
  custom_fee integer default 15000,
  image_url text,
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 3. Bikin VIEW Publik (Biar harga modal aman)
create or replace view products_public as
select 
  p.id, p.name, c.name as category_name, p.description, 
  p.price, p.sizes, p.colors, p.can_custom, p.custom_fee, 
  p.image_url, p.is_active, p.created_at
from products p
left join categories c on p.category_id = c.id
where p.is_active = true;

-- 4. Benerin Izin Akses (RLS)
alter table categories enable row level security;
alter table products enable row level security;

-- Izinkan publik baca VIEW
grant select on products_public to anon;
grant select on categories to anon;

-- 5. Masukin Produk Contoh
insert into categories (id, name) values 
('11111111-1111-1111-1111-111111111111', 'Tumbler'),
('22222222-2222-2222-2222-222222222222', 'Tempat Makan');

insert into products (name, category_id, price, cost_price, sizes, colors, can_custom, image_url) values 
('Selara Blush', '11111111-1111-1111-1111-111111111111', 85000, 55000, ARRAY['500ml', '750ml'], ARRAY['Pink', 'Ungu'], true, 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400&q=80'),
('Selara Lunch Box', '22222222-2222-2222-2222-222222222222', 115000, 80000, ARRAY['800ml'], ARRAY['Pink', 'Cream'], false, 'https://images.unsplash.com/photo-1604302660826-7b3f5c5c0b8e?w=400&q=80');
