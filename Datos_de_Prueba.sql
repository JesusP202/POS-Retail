USE BioRed;
GO

-- 1. Insertar Estados básicos
INSERT INTO Estados (nombre_estado, descripcion_estado) VALUES 
('Activo', 'Entidad operativa en el sistema'),
('Inactivo', 'Entidad deshabilitada'),
('Bloqueado', 'Usuario con exceso de intentos fallidos');

-- 2. Insertar una Empresa y Sucursal de prueba
INSERT INTO Empresa (cod_empresa, nombre_empresa, direccion_empresa, telefono_empresa, email_empresa)
VALUES ('EMP001', 'Corporación BioRed Pharma', 'Ciudad de Guatemala', '77755100', 'info@biored.com');

INSERT INTO Sucursal (cod_sucursal, cod_empresa, nombre_sucursal, direccion_sucursal, telefono_sucursal, email_sucursal)
VALUES ('SUC001', 'EMP001', 'Sucursal Coatepeque', 'Zona 1, Coatepeque', '87654321', 'central@biored.com');

-- 3. Insertar Roles (Nivel 1 es el más alto)
INSERT INTO Rol (cod_rol, nombre_rol, nivel) VALUES 
('ROL_ADMIN', 'Administrador de Sistema', 1),
('ROL_VENTAS', 'Agente de Ventas', 2),
('ROL_INV', 'Encargado de Inventario', 2);

-- 4. Insertar 3 Usuarios de prueba
-- Nota: La contraseña 'Pass123!' es solo de ejemplo, recuerda manejar el hash en tu app
INSERT INTO Usuarios (cod_usuario, cod_sucursal, cod_rol, pass, nombre_usuario, apellido_usuario, email_usuario, primer_cambio)
VALUES 
('USR_ADMIN', 'SUC001', 'ROL_ADMIN', 'Admin2026!', 'Carlos', 'García', 'cgarcia@biored.com', 1),
('USR_VENDEDOR', 'SUC001', 'ROL_VENTAS', 'Ventas2026!', 'Ana', 'Martínez', 'amartinez@biored.com', 1),
('USR_BODEGA', 'SUC001', 'ROL_INV', 'Stock2026!', 'Luis', 'Rodríguez', 'lrodriguez@biored.com', 1);

SELECT 'Datos de prueba insertados correctamente' AS Resultado;
GO