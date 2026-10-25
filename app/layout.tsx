import type { Metadata } from 'next';
import './globals.css';
import PwaRegister from './pwa-register';
export const metadata: Metadata = { title: 'Babi&Glow', applicationName: 'Babi&Glow', description: 'Sistema de gestión de inventario de Babi&Glow', manifest: '/manifest.json', appleWebApp: { capable: true, title: 'Babi&Glow', statusBarStyle: 'default' }, icons: { icon: '/icons/icon-192.png', apple: '/icons/icon-192.png' }, other: { 'mobile-web-app-capable': 'yes' } };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="es"><body><PwaRegister />{children}</body></html>; }
