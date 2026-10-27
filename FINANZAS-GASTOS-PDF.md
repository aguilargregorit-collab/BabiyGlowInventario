# Control de costos, ganancias y gastos

## Instalación de la tabla de gastos
1. Abre el proyecto de Supabase que ya usa Babi&Glow.
2. Entra en **SQL Editor**.
3. Ejecuta el contenido de `supabase/expense-records.sql`.
4. Despliega de nuevo esta versión del inventario.

## Uso
- Registra cada gasto con descripción, categoría, monto y fecha.
- Usa Desde/Hasta para consultar un día, mes o periodo personalizado.
- **Descargar PDF** / **PDF / Imprimir** abre el diálogo de impresión del navegador. Selecciona **Guardar como PDF**. El reporte imprime el resumen financiero y el detalle filtrado de gastos.
- **Descargar gastos CSV** exporta el detalle filtrado, que puedes abrir en Excel o una hoja de cálculo.

Los gastos se guardan en Supabase y no se mezclan con los productos. La cifra «Resultado estimado tras gastos» resta los gastos del periodo seleccionado de la ganancia potencial actual del inventario; es una referencia de gestión, no un estado contable de ventas realizadas.

## Seguridad
La política SQL incluida es compatible con el inicio de sesión demo existente, que no autentica realmente a la persona. No uses esta configuración con información financiera sensible en un sitio público hasta implementar Supabase Auth y políticas RLS apropiadas.
