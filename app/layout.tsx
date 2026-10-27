import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'Babi & Glow | Inventario', description: 'Sistema de gestión de inventario de Babi & Glow' };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="es"><body>{children}</body></html>; }
