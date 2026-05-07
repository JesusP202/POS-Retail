# POS System - Gestión de Inventario y Ventas

## 📝 Descripción General
Este sistema de Punto de Venta (POS) está diseñado para automatizar los procesos operativos de entidades que comercializan productos al mayoreo y menudeo. El sistema permite realizar compras al contado y crédito a proveedores, gestionar devoluciones, y controlar ventas multimedida con diversas formas de pago para distintos tipos de clientes.

## 🎯 Objetivos

### Objetivo General
Aplicar principios, técnicas y herramientas de análisis de sistemas para diseñar una propuesta tecnológica que automatice los procesos operativos de compra-venta.

### Objetivos Específicos
*   **Identificación:** Analizar procesos críticos y requerimientos funcionales de la organización.
*   **Arquitectura:** Proponer una estructura general del sistema, incluyendo subsistemas y módulos funcionales.
*   **Gestión:** Utilizar herramientas de diseño avanzadas para optimizar la administración del proyecto.
*   **Ingeniería:** Aplicar metodologías estándar de Ingeniería de Software.

## 🚀 Alcance del Sistema

### 🔐 Módulo de Seguridad
*   **Control de Acceso:** Bloqueo automático de usuario tras 3 intentos fallidos de inicio de sesión.
*   **Recuperación:** Sistema de recuperación de cuenta mediante correo electrónico.
*   **Políticas de Contraseña:**
    *   Extensión: Entre 8 y 11 caracteres.
    *   Complejidad: Obligatoriedad de mayúsculas, minúsculas, números y caracteres especiales.
    *   Seguridad: Almacenamiento encriptado en Base de Datos.
    *   Primer uso: Cambio de contraseña obligatorio al primer ingreso.
*   **Codificación:** Implementación de sistema de codificación fonética (Soundex).

### 📦 Módulo de Compras
*   Gestión de compras al contado y crédito.
*   Proceso de devoluciones a proveedores.
*   Control de existencias mediante **Kardex de productos**.

### 💰 Módulo de Bancos
*   Generación de reportes de ingresos derivados de las ventas realizadas.

### 🛒 Módulo de Ventas
*   Ventas multimedida al contado y crédito.
*   Gestión de lotes de productos.
*   Actualización automática de **Kardex**.
*   Generación de documentos:
    *   Comprobante de venta.
    *   Comprobante de pago.

## 🛠️ Metodología
El desarrollo se rige bajo **metodologías ágiles**. La gestión de tareas y el seguimiento del progreso de los integrantes se realiza a través de la herramienta **Trello**.

---
*Este proyecto es parte del curso de Análisis de Sistemas.*
