# Babi & Glow — Sistema de inventario

Aplicación Next.js para administrar productos, cantidades, precios, fechas e imágenes, con búsqueda, filtros por rango y orden ascendente/descendente, resumen de stock y exportación CSV.

## Requisitos
- Node.js 20.9 o superior
- Proyecto de Supabase

## Configuración local
1. Instala dependencias: `npm install`
2. Copia `.env.example` a `.env.local`.
3. En `.env.local`, configura `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY` con los valores de tu proyecto Supabase.
4. En Supabase → SQL Editor, ejecuta `supabase/schema.sql`.
5. Inicia con `npm run dev` y abre `http://localhost:3000`.

## Despliegue en Vercel
1. Sube el proyecto a GitHub sin subir `.env.local`.
2. Importa el repositorio en Vercel como proyecto Next.js.
3. En Environment Variables, agrega `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
4. Pulsa Deploy.

## Advertencia de seguridad importante
El inicio de sesión por nombre de usuario solamente es una identificación visual, no una autenticación segura. El SQL incluido aplica políticas públicas de demostración para permitir el CRUD sin configurar Auth. Cualquier persona que conozca la URL pública puede leer, añadir, modificar o eliminar productos e imágenes. No uses esta configuración con datos comerciales reales ni publiques la aplicación sin reemplazar estas políticas por Supabase Auth y políticas RLS restringidas. Las claves secretas nunca deben llevar el prefijo `NEXT_PUBLIC_` ni estar en GitHub.

## Logo
La interfaz usa una marca tipográfica B&G de muestra con la paleta vino, rosa y dorado. Para insertar el logo oficial, guarda una copia autorizada como `public/logo-babi-glow.jpg` y modifica el componente de marca en `app/page.tsx`.
