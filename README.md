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
5. Para activar subtipos, galerías, edición de términos y métricas de visitas, ejecuta una sola vez `supabase/phase2-catalog-management.sql` en el MISMO proyecto Supabase que usa el catálogo.
6. Despliega también el ZIP actualizado del catálogo para mostrar el contador de visitas y personas en línea.
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


## Funciones añadidas en Fase 2
- Etiqueta de subtipo por producto (por ejemplo, Bodys, Baggys o Vestidos); el catálogo crea los filtros a partir de las etiquetas usadas.
- Varias imágenes por producto, selección de portada y eliminación de fotos guardadas.
- Editor de términos y condiciones que actualiza la tabla compartida `catalog_terms`; el catálogo los recibe mediante Realtime.
- Panel de métricas: visitantes únicos registrados, visitantes únicos de hoy y navegadores activos en los últimos 90 segundos. El contador empieza a registrar cuando se despliega la migración y el nuevo catálogo; no reconstruye visitas históricas anteriores.

## Nota de seguridad
La pantalla de acceso actual solo solicita un nombre y no autentica realmente al usuario. Para mantener la edición de términos funcional con esta demo, la migración habilita escritura pública en `catalog_terms`; cualquiera con acceso al proyecto podría alterar esos términos. Antes de usarlo comercialmente, hay que implementar Supabase Auth y restringir las políticas RLS. Las métricas son aproximadas: identifican navegadores mediante un ID aleatorio local, no verifican identidades humanas, y una persona con varios dispositivos puede contarse varias veces.
