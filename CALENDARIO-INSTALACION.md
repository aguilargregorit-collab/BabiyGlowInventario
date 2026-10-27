# Calendario dinámico Babi&Glow

## Activar la tabla compartida
1. Abre Supabase → SQL Editor.
2. Ejecuta `supabase/calendar-events.sql` una sola vez.
3. Despliega de nuevo la aplicación de inventario y el catálogo para que ambos usen la versión actualizada.
4. En el inventario, pulsa el logo Babi&Glow y elige **Calendario**. Crea el evento con fecha, mensaje y animación.
5. En esa fecha, el catálogo muestra una bienvenida una vez por sesión del navegador para el evento activo.

Los temas disponibles son confeti, Navidad, Halloween, corazones y brillos. La tabla es compartida por ambas aplicaciones a través del mismo proyecto Supabase.

## Seguridad importante
El login actual del inventario usa un nombre local y no Supabase Auth. Por compatibilidad con ese sistema, el SQL incluye políticas de escritura públicas de demostración. No uses esas políticas en producción con información sensible. Antes de abrir el inventario comercialmente, migra el login a Supabase Auth y limita INSERT/UPDATE/DELETE a usuarios autorizados.
