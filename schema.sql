-- ============================================================
-- FDT Portal – Uttara University
-- Database Schema
-- ============================================================

create extension if not exists "uuid-ossp";

-- PROFILES
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'student' check (role in ('student','admin')),
  name text not null,
  student_id text,
  email text not null,
  semester text,
  batch text,
  created_at timestamptz default now()
);

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, name, email, role, student_id)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', 'Student'),
    new.email,
    coalesce(new.raw_user_meta_data->>'role', 'student'),
    new.raw_user_meta_data->>'student_id'
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- TEACHERS
create table public.teachers (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  designation text,
  email text,
  phone text,
  office text,
  created_at timestamptz default now()
);

-- STAFF
create table public.staff (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  role text,
  email text,
  phone text,
  created_at timestamptz default now()
);

-- COURSES
create table public.courses (
  id uuid primary key default uuid_generate_v4(),
  code text not null unique,
  title text not null,
  credits numeric not null default 3,
  category text check (category in ('core','ged','elective')),
  prereq text default 'None',
  description text,
  teacher_id uuid references public.teachers(id) on delete set null,
  created_at timestamptz default now()
);

-- REGISTERED COURSES
create table public.registered_courses (
  id uuid primary key default uuid_generate_v4(),
  student_id uuid references public.profiles(id) on delete cascade,
  course_id uuid references public.courses(id) on delete cascade,
  semester text not null,
  created_at timestamptz default now(),
  unique(student_id, course_id, semester)
);

-- ROUTINES
create table public.routines (
  id uuid primary key default uuid_generate_v4(),
  type text not null check (type in ('class','exam','quiz','presentation','assignment')),
  title text,
  course_id uuid references public.courses(id) on delete cascade,
  teacher_id uuid references public.teachers(id) on delete set null,
  day text,
  date date,
  start_time time,
  end_time time,
  room text,
  created_at timestamptz default now()
);

-- EVENTS
create table public.events (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  description text,
  date date not null,
  time time,
  location text,
  created_at timestamptz default now()
);

-- BUSES
create table public.buses (
  id uuid primary key default uuid_generate_v4(),
  bus_number text not null,
  route text not null,
  arrival_time time,
  departure_time time,
  driver_name text,
  driver_contact text,
  created_at timestamptz default now()
);

-- RESULTS
create table public.results (
  id uuid primary key default uuid_generate_v4(),
  student_id uuid references public.profiles(id) on delete cascade,
  course_id uuid references public.courses(id) on delete cascade,
  quiz1 numeric, quiz2 numeric, quiz3 numeric, quiz_avg numeric,
  mid_term numeric, final numeric, total numeric,
  grade text check (grade in ('A+','A','A-','B+','B','B-','C+','C','D','F')),
  created_at timestamptz default now(),
  unique(student_id, course_id)
);

-- STUDY MATERIALS
create table public.materials (
  id uuid primary key default uuid_generate_v4(),
  course_id uuid references public.courses(id) on delete cascade,
  title text not null,
  file_url text,
  file_path text,
  file_name text,
  file_size bigint,
  mime_type text,
  upload_date date default current_date,
  created_at timestamptz default now()
);

-- NOTICES
create table public.notices (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  content text not null,
  date date not null default current_date,
  pinned boolean default false,
  audience text default 'all',
  target_batch text,
  target_semester text,
  created_at timestamptz default now()
);

-- ATTENDANCE
create table public.attendance (
  id uuid primary key default uuid_generate_v4(),
  student_id uuid references public.profiles(id) on delete cascade,
  course_id uuid references public.courses(id) on delete cascade,
  date date not null,
  status text not null check (status in ('present','absent','late','excused')),
  marked_by uuid references public.profiles(id),
  created_at timestamptz default now(),
  unique(student_id, course_id, date)
);

-- ASSIGNMENTS
create table public.assignments (
  id uuid primary key default uuid_generate_v4(),
  course_id uuid references public.courses(id) on delete cascade,
  title text not null,
  description text,
  due_date timestamptz not null,
  max_marks numeric default 100,
  created_by uuid references public.profiles(id),
  created_at timestamptz default now()
);

-- SUBMISSIONS
create table public.submissions (
  id uuid primary key default uuid_generate_v4(),
  assignment_id uuid references public.assignments(id) on delete cascade,
  student_id uuid references public.profiles(id) on delete cascade,
  file_path text,
  file_name text,
  submitted_at timestamptz default now(),
  marks numeric,
  feedback text,
  status text default 'submitted' check (status in ('submitted','late','graded')),
  unique(assignment_id, student_id)
);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================
alter table public.profiles enable row level security;
alter table public.teachers enable row level security;
alter table public.staff enable row level security;
alter table public.courses enable row level security;
alter table public.registered_courses enable row level security;
alter table public.routines enable row level security;
alter table public.events enable row level security;
alter table public.buses enable row level security;
alter table public.results enable row level security;
alter table public.materials enable row level security;
alter table public.notices enable row level security;
alter table public.attendance enable row level security;
alter table public.assignments enable row level security;
alter table public.submissions enable row level security;

create or replace function public.is_admin()
returns boolean as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$ language sql security definer;

-- Profiles
create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id or public.is_admin());
create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id or public.is_admin());

-- Public read
create policy "teachers_read_all" on public.teachers for select using (true);
create policy "staff_read_all" on public.staff for select using (true);
create policy "courses_read_all" on public.courses for select using (true);
create policy "routines_read_all" on public.routines for select using (true);
create policy "events_read_all" on public.events for select using (true);
create policy "buses_read_all" on public.buses for select using (true);
create policy "materials_read_all" on public.materials for select using (true);
create policy "notices_read_all" on public.notices for select using (true);
create policy "assignments_read_all" on public.assignments for select using (true);

-- Own data
create policy "results_select_own" on public.results
  for select using (student_id = auth.uid() or public.is_admin());
create policy "registered_select_own" on public.registered_courses
  for select using (student_id = auth.uid() or public.is_admin());
create policy "attendance_select_own" on public.attendance
  for select using (student_id = auth.uid() or public.is_admin());
create policy "submissions_select_own" on public.submissions
  for select using (student_id = auth.uid() or public.is_admin());
create policy "submissions_insert_own" on public.submissions
  for insert with check (student_id = auth.uid());

-- Admin writes
create policy "teachers_admin_write" on public.teachers for all using (public.is_admin());
create policy "staff_admin_write" on public.staff for all using (public.is_admin());
create policy "courses_admin_write" on public.courses for all using (public.is_admin());
create policy "routines_admin_write" on public.routines for all using (public.is_admin());
create policy "events_admin_write" on public.events for all using (public.is_admin());
create policy "buses_admin_write" on public.buses for all using (public.is_admin());
create policy "materials_admin_write" on public.materials for all using (public.is_admin());
create policy "notices_admin_write" on public.notices for all using (public.is_admin());
create policy "results_admin_write" on public.results for all using (public.is_admin());
create policy "registered_admin_write" on public.registered_courses for all using (public.is_admin());
create policy "attendance_admin_write" on public.attendance for all using (public.is_admin());
create policy "assignments_admin_write" on public.assignments for all using (public.is_admin());
create policy "submissions_admin_write" on public.submissions for all using (public.is_admin());

-- ============================================================
-- STORAGE BUCKETS
-- ============================================================
insert into storage.buckets (id, name, public)
values ('study-materials', 'study-materials', false)
on conflict (id) do nothing;

insert into storage.buckets (id, name, public)
values ('assignments', 'assignments', false)
on conflict (id) do nothing;

-- Storage policies
create policy "Authenticated read study materials"
on storage.objects for select to authenticated
using (bucket_id = 'study-materials');

create policy "Admins upload study materials"
on storage.objects for insert to authenticated
with check (bucket_id = 'study-materials' and public.is_admin());

create policy "Admins delete study materials"
on storage.objects for delete to authenticated
using (bucket_id = 'study-materials' and public.is_admin());

create policy "Students upload own assignments"
on storage.objects for insert to authenticated
with check (
  bucket_id = 'assignments'
  and (storage.foldername(name))[1] = (select auth.jwt()->>'sub')
);

create policy "Students read own assignments"
on storage.objects for select to authenticated
using (
  bucket_id = 'assignments'
  and (storage.foldername(name))[1] = (select auth.jwt()->>'sub')
);

create policy "Admins read all assignments"
on storage.objects for select to authenticated
using (bucket_id = 'assignments' and public.is_admin());