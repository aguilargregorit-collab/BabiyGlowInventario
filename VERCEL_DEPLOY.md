# Despliegue rápido

- Framework: Next.js
- Build command: `next build` (predeterminado)
- Install command: `npm install`
- Output directory: dejar el predeterminado
- Variables necesarias: `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- SQL: ejecutar `supabase/schema.sql` en Supabase antes de probar CRUD e imágenes.

El login por nombre de usuario es solo una pantalla de identificación. Para una publicación segura, implementar autenticación y RLS antes de abrir la app al público.
