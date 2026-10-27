# Actualización del inventario Babi&Glow

## Cambios
- El menú del logo ahora abre rutas independientes: `/` productos, `/finance` costos y ganancias, `/terms` términos del catálogo y `/calendar` calendario.
- Se añadieron páginas independientes para finanzas, términos y calendario.
- En el formulario del calendario aparece **Probar evento**. Abre una vista previa animada del mensaje con el nombre, descripción y tema elegidos, incluso antes de guardar.
- La prueba es local: no publica en redes, no modifica la fecha ni activa el evento en el catálogo.

## Instalación
1. Reemplaza el proyecto de inventario con el contenido de este ZIP.
2. Conserva tus variables `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY` en `.env.local`.
3. Ejecuta `supabase/calendar-events.sql` en el proyecto Supabase compartido si todavía no lo hiciste.
4. Instala dependencias con `npm install` y prueba con `npm run dev`; para producción, `npm run build`.

Nota: el entorno de preparación no tenía instaladas las dependencias del proyecto, por lo que no se pudo completar una compilación de verificación.
