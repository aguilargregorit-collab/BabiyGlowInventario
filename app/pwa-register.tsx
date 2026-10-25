'use client';
import { useEffect } from 'react';

export default function PwaRegister() {
  useEffect(() => {
    if ('serviceWorker' in navigator && (window.location.protocol === 'https:' || window.location.hostname === 'localhost')) {
      navigator.serviceWorker.register('/sw.js').catch((error) => console.error('No se pudo registrar el service worker:', error));
    }
  }, []);
  return null;
}
