-- EDH Tracker · esquema para Supabase (pegar en SQL Editor y ejecutar)
-- Sin login: cualquiera con el link puede ver, agregar y editar.
-- Protección: no se borra nada de verdad (borrado = papelera) y cada cambio
-- queda copiado en *_history, así siempre se puede recuperar.

create table players (
  name text primary key,
  created_at timestamptz default now()
);

create table decks (
  id text primary key,                 -- 'toto/ashling-the-limitless'
  commander text not null,
  owner text not null references players(name) on update cascade,
  colors text not null default '',     -- identidad en orden WUBRG, 'C' = incoloro
  ub boolean not null default false,   -- Universes Beyond
  list_url text,
  retired boolean not null default false,
  created_at timestamptz default now(),
  unique (owner, commander)
);

create table matches (
  id bigserial primary key,
  played_on date not null,
  turns int,
  duration_min int,                    -- duración de la partida en minutos (opcional)
  winner text references players(name) on update cascade,
  seats jsonb not null,                -- [{"p":"Toto","deck":"toto/kuja-genome-sorcerer"}, ...]
  deleted_at timestamptz,              -- papelera
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table ideas (
  id bigserial primary key,
  name text,
  rule text not null,
  kind text                            -- 'General' | 'Particular'
);

-- Historial: copia de cada fila antes de cada cambio
create table matches_history (id bigserial primary key, at timestamptz default now(), op text, row jsonb);
create table decks_history   (id bigserial primary key, at timestamptz default now(), op text, row jsonb);

-- security definer: guarda el historial con permisos del dueño (la web no puede leerlo ni escribirlo directo)
create or replace function log_change() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  execute format('insert into %I(op,row) values ($1,$2)', TG_TABLE_NAME || '_history')
    using TG_OP, to_jsonb(OLD);
  if TG_OP = 'UPDATE' and TG_TABLE_NAME = 'matches' then NEW.updated_at = now(); end if;
  return coalesce(NEW, OLD);
end $$;
create trigger matches_log before update or delete on matches for each row execute function log_change();
create trigger decks_log   before update or delete on decks   for each row execute function log_change();

-- Acceso público (anon): leer, agregar y editar. Sin DELETE desde la web.
alter table players enable row level security;
alter table decks   enable row level security;
alter table matches enable row level security;
alter table ideas   enable row level security;
alter table matches_history enable row level security;
alter table decks_history   enable row level security;

create policy "leer"    on players for select using (true);
create policy "agregar" on players for insert with check (true);
create policy "editar"  on players for update using (true);
create policy "leer"    on decks   for select using (true);
create policy "agregar" on decks   for insert with check (true);
create policy "editar"  on decks   for update using (true);
create policy "leer"    on matches for select using (true);
create policy "agregar" on matches for insert with check (true);
create policy "editar"  on matches for update using (true);
create policy "leer"    on ideas   for select using (true);
-- El historial no es accesible desde la web; solo tú desde el panel de Supabase.
