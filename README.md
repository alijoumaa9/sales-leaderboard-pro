# Deploy Sales Leaderboard PRO to Railway

This adds **one-click-style** hosting with the least effort. You’ll get two services (backend + frontend) and a managed Postgres DB.

## What you’ll do (5–7 minutes)
1) Push your project to GitHub (or create a private repo and upload the zip contents).
2) In Railway:
   - New Project → **Deploy from GitHub** → select the repo.
   - Add **Postgres** (Database → “Add” → Postgres).
   - Add **Service → Deploy from Repo** twice:
     - Service A: `backend/` (detects Dockerfile)
     - Service B: `frontend/` (detects Dockerfile)
3) Configure variables:
   - **Backend service:**
     - `APP_SECRET` = (generate a random string)
     - `APP_BOOTSTRAP_ADMIN` = `true`
     - `APP_ADMIN_EMAIL` = `admin@yourdomain.com`
     - `APP_ADMIN_PASSWORD` = `ChangeMe!123`
     - `APP_ADMIN_NAME` = `Admin`
     - `APP_TZ` = `America/Los_Angeles` (or your timezone)
     - `DATABASE_URL` → **link it to the Postgres plugin** (Railway lets you map the DB URL into this variable)
   - **Frontend service:**
     - `NEXT_PUBLIC_API_BASE` = `https://<BACKEND_PUBLIC_URL>`  (copy the URL from the backend service)
4) Deploy. When the backend shows “Running”, copy its public URL to the frontend var and redeploy the frontend.  
5) Open the **frontend** public URL. Login with the admin you set.

### Notes
- These Dockerfiles are adjusted to honor Railway’s `PORT` env var.
- CORS is permissive by default in the backend so the browser can call the API.

## Optional: Auto-imports
Railway containers are ephemeral. For auto-import **CSV drop folder**, attach a **Persistent Volume** to the backend and mount it at `/app/imports`. Then you can upload files there from the Railway UI or via SFTP (if enabled). The importer runs every 60 seconds.

## Troubleshooting
- 502 or “App crashed”: check that the service actually listens on `PORT` (the provided Dockerfiles do).
- DB connection errors: ensure `DATABASE_URL` in the backend is mapped to the Postgres plugin.
- CORS: the backend allows all origins; you can lock this down later.
