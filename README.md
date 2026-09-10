# FDT Portal – Uttara University

Student portal for the Department of Fashion Design & Technology, Uttara University.

## Tech Stack
- **Frontend:** Vanilla HTML/CSS/JS + Supabase JS SDK
- **Backend:** Supabase (PostgreSQL, Auth, Storage, Edge Functions)
- **Hosting:** Vercel / Netlify

## Setup Instructions

### 1. Create Supabase Project
1. Go to https://supabase.com → New Project
2. Copy Project URL and anon key from Settings → API

### 2. Update `index.html`
Replace:
```js
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';