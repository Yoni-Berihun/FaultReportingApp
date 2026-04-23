-- Apply in Supabase SQL editor or via CLI. Adjust if your `reports` table differs.
-- Reporter app + single fixer device use the anon key; tighten policies for production.

alter table public.reports
  add column if not exists tracking_id text;

create unique index if not exists reports_tracking_id_uidx
  on public.reports (tracking_id)
  where tracking_id is not null;

alter table public.reports
  add column if not exists common_name text;

alter table public.reports
  add column if not exists photo_storage_path text;

alter table public.reports
  add column if not exists seen_at timestamptz;

alter table public.reports
  add column if not exists resolved_at timestamptz;

alter table public.reports
  add column if not exists photo_deleted_at timestamptz;

alter table public.reports
  add column if not exists updated_at timestamptz default now();

-- Auto-resolve after 3 days in "seen" (authoritative on the server; schedule daily)
create or replace function public.auto_resolve_seen_reports()
returns void
language plpgsql
as $$
begin
  update public.reports
  set
    status = 'resolved',
    resolved_at = now(),
    updated_at = now()
  where status = 'seen'
    and seen_at is not null
    and seen_at < (now() - interval '3 days')
    and resolved_at is null;
end;
$$;

-- Clear photo *metadata* 14 days after resolution. The actual file in the Storage
-- bucket must be deleted in the same job using the **service role** (e.g. Edge
-- Function) by calling `storage.remove([path])` for `photo_storage_path`, then
-- call this function to null columns and set `photo_deleted_at`.
create or replace function public.clear_resolved_photo_metadata()
returns void
language plpgsql
as $$
begin
  update public.reports
  set
    photo_url = null,
    photo_storage_path = null,
    photo_deleted_at = now(),
    updated_at = now()
  where status = 'resolved'
    and resolved_at is not null
    and resolved_at < (now() - interval '14 days')
    and photo_deleted_at is null
    and (photo_url is not null or photo_storage_path is not null);
end;
$$;

alter table public.reports enable row level security;

drop policy if exists "reports_anon_insert" on public.reports;
create policy "reports_anon_insert"
  on public.reports for insert
  to anon
  with check (true);

drop policy if exists "reports_anon_select" on public.reports;
create policy "reports_anon_select"
  on public.reports for select
  to anon
  using (true);

drop policy if exists "reports_anon_update" on public.reports;
create policy "reports_anon_update"
  on public.reports for update
  to anon
  using (true)
  with check (true);

-- Storage: set bucket `fault-reports` to **private** in the dashboard, then add policies so:
-- - anon can INSERT (upload) for reporter submissions
-- - anon can SELECT objects to create signed read URLs for the fixer app
-- Exact storage policy SQL depends on your project; use the Supabase Storage UI or consult docs.
