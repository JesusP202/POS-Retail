CREATE DATABASE BioRed
GO

USE BioRed
GO

CREATE TABLE Estados (
    id_estado INT IDENTITY(1,1) PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE,
    descripcion_estado VARCHAR(200) NULL,
    activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Empresa(
    cod_empresa VARCHAR(15) PRIMARY KEY,
    id_empresa INT IDENTITY(1,1) NOT NULL,
    nombre_empresa VARCHAR(100) NOT NULL,
    direccion_empresa VARCHAR(200) NOT NULL,
    telefono_empresa VARCHAR(20) NOT NULL,
    email_empresa VARCHAR(100) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE Sucursal (
    cod_sucursal VARCHAR(15) PRIMARY KEY,
    id_sucursal INT IDENTITY(1,1) NOT NULL,
    cod_empresa VARCHAR(15) NOT NULL,
    nombre_sucursal VARCHAR(100) NOT NULL,
    direccion_sucursal VARCHAR(200) NOT NULL,
    telefono_sucursal VARCHAR(20) NOT NULL,
    email_sucursal VARCHAR(100) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (cod_empresa) REFERENCES Empresa(cod_empresa)
);
GO

CREATE TABLE Rol (
    cod_rol VARCHAR(15) PRIMARY KEY,
    id_rol INT IDENTITY(1,1) NOT NULL,
    nombre_rol VARCHAR(50) NOT NULL,
    nivel INT NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE Usuarios (
    cod_usuario VARCHAR(15) PRIMARY KEY,
    id_usuario INT IDENTITY(1,1) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    cod_rol VARCHAR(15) NOT NULL,
    pass VARCHAR(75) NOT NULL, --Contraseña
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_usuario VARCHAR(50) NOT NULL,
    email_usuario VARCHAR(100) NOT NULL,
    primer_cambio BIT NOT NULL DEFAULT 1,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_rol) REFERENCES Rol(cod_rol)
);
GO

CREATE TABLE RecuperacionContraseña (
    id_recuperacion INT IDENTITY(1,1) PRIMARY KEY,
    cod_usuario VARCHAR(15) NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_expiracion DATETIME NOT NULL,
    utilizado BIT NOT NULL DEFAULT 0,
    fecha_uso DATETIME NULL,
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario)
);
GO

CREATE TABLE IntentosSesion (
    id_intento INT IDENTITY(1,1) PRIMARY KEY,
    cod_usuario VARCHAR(15) NOT NULL,
    fecha_intento DATETIME NOT NULL DEFAULT GETDATE(),
    exitoso BIT NOT NULL,
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario)
);
GO

CREATE TABLE Auditoria_Contrasena (
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    cod_usuario VARCHAR(15) NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT GETDATE(),
    cambiado_por VARCHAR(15),
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cambiado_por) REFERENCES Usuarios(cod_usuario)
);
GO

CREATE TABLE Proveedores (
    cod_proveedor VARCHAR(15) PRIMARY KEY,
    id_proveedor INT IDENTITY(1,1) NOT NULL,
    cod_empresa VARCHAR(15) NOT NULL,
    nombre_proveedor VARCHAR(100) NOT NULL,
    CUI_NIT VARCHAR(20) NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    telefono_proveedor VARCHAR(20) NOT NULL,
    email_proveedor VARCHAR(100) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE(),
    creado_por VARCHAR(15) NOT NULL,
    FOREIGN KEY (creado_por) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cod_empresa) REFERENCES Empresa(cod_empresa)
);
GO

CREATE TABLE Clientes (
    cod_cliente VARCHAR(15) PRIMARY KEY,
    id_cliente INT IDENTITY(1,1) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    nombre_cliente VARCHAR(100) NOT NULL,
    apellido_cliente VARCHAR(100) NOT NULL,
    CUI_NIT VARCHAR(20) NOT NULL,
    telefono_cliente VARCHAR(20) NULL,
    email_cliente VARCHAR(100) NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE(),
    creado_por VARCHAR(15) NOT NULL,
    FOREIGN KEY (creado_por) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal)
); 
GO

CREATE TABLE Productos (
    cod_producto VARCHAR(15) PRIMARY KEY,
    id_producto INT IDENTITY(1,1) NOT NULL,
    cod_empresa VARCHAR(15) NOT NULL,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(200) NULL,
    precio_costo DECIMAL(18,2) NOT NULL,
    precio_venta DECIMAL(18,2) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE(),
    creado_por VARCHAR(15) NOT NULL,
    FOREIGN KEY (creado_por) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cod_empresa) REFERENCES Empresa(cod_empresa)
);
GO

CREATE TABLE Lotes (
    id_lote INT IDENTITY(1,1) PRIMARY KEY,
    cod_producto VARCHAR(15) NOT NULL,
    numero_lote VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    cantidad_lote INT NOT NULL,
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);
GO

CREATE TABLE Inventario(
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    cod_sucursal VARCHAR(15) NOT NULL,
    cod_producto VARCHAR(15) NOT NULL,
    cantidad_actual INT NOT NULL,
    stock_minimo INT NOT NULL,
    stock_maximo INT NOT NULL,
    ultima_actualizacion DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);
GO

CREATE TABLE Kardex (
    id_kardex INT IDENTITY(1,1) PRIMARY KEY,
    cod_producto VARCHAR(15) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL, -- Entrada, Salida, Ajuste
    cantidad INT NOT NULL,
    fecha_movimiento DATETIME NOT NULL DEFAULT GETDATE(),
    referencia_id INT,
    observacion VARCHAR(200),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal)
);
GO

CREATE TABLE Tipo_Pago (
    cod_tipo_pago VARCHAR(15) PRIMARY KEY,
    id_tipo_pago INT IDENTITY(1,1) NOT NULL,
    nombre_tipo_pago VARCHAR(50) NOT NULL,
    estado BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE TransaccionesBancarias (
    id_transaccion INT IDENTITY(1,1) PRIMARY KEY,
    cod_empresa VARCHAR(15) NOT NULL,
    tipo_transaccion VARCHAR(50) NOT NULL, -- Depósito, Retiro
    monto DECIMAL(18,2) NOT NULL,
    fecha_transaccion DATETIME NOT NULL DEFAULT GETDATE(),
    referencia VARCHAR(100),
    id_factura INT,
    FOREIGN KEY (cod_empresa) REFERENCES Empresa(cod_empresa),
    FOREIGN KEY (id_factura) REFERENCES FacturaEncabezado(id_factura)
);
GO

CREATE TABLE CompraEncabezado (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    cod_proveedor VARCHAR(15) NOT NULL,
    cod_usuario VARCHAR(15) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    fecha_compra DATETIME NOT NULL DEFAULT GETDATE(),
    total_compra DECIMAL(18,2) NOT NULL,
    cod_tipo_pago VARCHAR(15) NOT NULL,
    id_estado INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cod_proveedor) REFERENCES Proveedores(cod_proveedor),
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_tipo_pago) REFERENCES Tipo_Pago(cod_tipo_pago),
    FOREIGN KEY (id_estado) REFERENCES Estados(id_estado)
);
GO

CREATE TABLE CompraDetalle (
    id_compradetalle INT IDENTITY(1,1) PRIMARY KEY,
    id_compra INT NOT NULL,
    cod_producto VARCHAR(15) NOT NULL,
    cantidad INT NOT NULL,
    precio_costo DECIMAL(18,2) NOT NULL,
    precio_venta DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES CompraEncabezado(id_compra),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);
GO

CREATE TABLE FacturaEncabezado (
    id_factura INT IDENTITY(1,1) PRIMARY KEY,
    cod_cliente VARCHAR(15) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    cod_usuario VARCHAR(15) NOT NULL,
    cod_tipo_pago VARCHAR(15) NOT NULL,
    fecha_factura DATETIME NOT NULL DEFAULT GETDATE(),
    total_factura DECIMAL(18,2) NOT NULL,
    id_estado INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cod_tipo_pago) REFERENCES Tipo_Pago(cod_tipo_pago),
    FOREIGN KEY (id_estado) REFERENCES Estados(id_estado)
);
GO

CREATE TABLE FacturaDetalle (
    id_facturadetalle INT IDENTITY(1,1) PRIMARY KEY,
    id_factura INT NOT NULL,
    cod_producto VARCHAR(15) NOT NULL,
    cantidad INT NOT NULL,
    precio_costo DECIMAL(18,2) NOT NULL,
    precio_venta DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_factura) REFERENCES FacturaEncabezado(id_factura),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);
GO

CREATE TABLE DevolucionEncabezado (
    id_devolucion INT IDENTITY(1,1) PRIMARY KEY,
    cod_cliente VARCHAR(15) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    cod_usuario VARCHAR(15) NOT NULL,
    cod_tipo_pago VARCHAR(15) NOT NULL,
    fecha_devolucion DATETIME NOT NULL DEFAULT GETDATE(),
    total_devolucion DECIMAL(18,2) NOT NULL,
    id_estado INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (cod_tipo_pago) REFERENCES Tipo_Pago(cod_tipo_pago),
    FOREIGN KEY (id_estado) REFERENCES Estados(id_estado)
);
GO

CREATE TABLE DevolucionDetalle (
    id_devoluciondetalle INT IDENTITY(1,1) PRIMARY KEY,
    id_devolucion INT NOT NULL,
    cod_producto VARCHAR(15) NOT NULL,
    cantidad INT NOT NULL,
    precio_costo DECIMAL(18,2) NOT NULL,
    precio_venta DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_devolucion) REFERENCES DevolucionEncabezado(id_devolucion),
    FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);
GO

CREATE TABLE CxCEncabezado (
    id_cxc INT IDENTITY(1,1) PRIMARY KEY,
    cod_cliente VARCHAR(15) NOT NULL,
    cod_usuario VARCHAR(15) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    fecha_cxc DATETIME NOT NULL DEFAULT GETDATE(),
    total_cxc DECIMAL(18,2) NOT NULL,
    id_estado INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cod_cliente) REFERENCES Clientes(cod_cliente),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (id_estado) REFERENCES Estados(id_estado)
);
GO

CREATE TABLE CxCDetalle (
    id_cxcdetalle INT IDENTITY(1,1) PRIMARY KEY,
    id_cxc INT NOT NULL,
    cod_factura VARCHAR(15) NOT NULL,
    monto_pagado DECIMAL(18,2) NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_cxc) REFERENCES CxCEncabezado(id_cxc)
);
GO

CREATE TABLE CxPEncabezado (
    id_cxp INT IDENTITY(1,1) PRIMARY KEY,
    cod_proveedor VARCHAR(15) NOT NULL,
    cod_usuario VARCHAR(15) NOT NULL,
    cod_sucursal VARCHAR(15) NOT NULL,
    fecha_cxp DATETIME NOT NULL DEFAULT GETDATE(),
    total_cxp DECIMAL(18,2) NOT NULL,
    id_estado INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cod_proveedor) REFERENCES Proveedores(cod_proveedor),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_usuario) REFERENCES Usuarios(cod_usuario),
    FOREIGN KEY (id_estado) REFERENCES Estados(id_estado)
);
GO

CREATE TABLE CxPDetalle (
    id_cxpdetalle INT IDENTITY(1,1) PRIMARY KEY,
    id_cxp INT NOT NULL,
    cod_compra VARCHAR(15) NOT NULL,
    monto_pagado DECIMAL(18,2) NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_cxp) REFERENCES CxPEncabezado(id_cxp)
);
GO

CREATE TABLE Soundex_Cache (
    id_soundex INT IDENTITY(1,1) PRIMARY KEY,
    tipo_entidad VARCHAR(20), -- Cliente, Proveedor
    id_entidad VARCHAR(15),
    nombre_original VARCHAR(200),
    codigo_soundex VARCHAR(4),
    UNIQUE(tipo_entidad, id_entidad)
);
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - MÓDULO DE SEGURIDAD
-- =====================================================

-- 1. Registrar intento de sesión
CREATE PROCEDURE sp_RegistrarIntentoSesion
    @cod_usuario VARCHAR(15),
    @exitoso BIT
AS
BEGIN
    BEGIN TRY
        INSERT INTO IntentosSesion (cod_usuario, fecha_intento, exitoso)
        VALUES (@cod_usuario, GETDATE(), @exitoso);
        
        -- Si es exitoso, resetear intentos fallidos
        IF @exitoso = 1
        BEGIN
            DELETE FROM IntentosSesion 
            WHERE cod_usuario = @cod_usuario AND exitoso = 0;
        END
        
        SELECT 'Intento registrado correctamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 2. Verificar si usuario está bloqueado
CREATE PROCEDURE sp_VerificarBloqueoUsuario
    @cod_usuario VARCHAR(15),
    @bloqueado BIT OUTPUT
AS
BEGIN
    DECLARE @intentos_fallidos INT;
    
    SET @intentos_fallidos = (
        SELECT COUNT(*) FROM IntentosSesion 
        WHERE cod_usuario = @cod_usuario 
        AND exitoso = 0
        AND DATEDIFF(HOUR, fecha_intento, GETDATE()) < 24
    );
    
    IF @intentos_fallidos >= 3
        SET @bloqueado = 1;
    ELSE
        SET @bloqueado = 0;
        
    SELECT @bloqueado AS Bloqueado, @intentos_fallidos AS IntentosActuales;
END;
GO

-- 3. Cambiar contraseña (con validación de primer cambio)
CREATE PROCEDURE sp_CambiarContrasena
    @cod_usuario VARCHAR(15),
    @nueva_contrasena VARCHAR(75),
    @cambio_obligatorio BIT = 0
AS
BEGIN
    BEGIN TRY
        -- Validar que la contraseña cumpla requisitos
        -- Entre 8 y 11 caracteres, mayúsculas, minúsculas, números y caracteres especiales
        IF LEN(@nueva_contrasena) < 8 OR LEN(@nueva_contrasena) > 11
        BEGIN
            RAISERROR('La contraseña debe tener entre 8 y 11 caracteres', 16, 1);
        END
        
        UPDATE Usuarios 
        SET pass = @nueva_contrasena,
            primer_cambio = 0
        WHERE cod_usuario = @cod_usuario;
        
        -- Registrar en auditoría
        INSERT INTO Auditoria_Contrasena (cod_usuario, fecha_cambio, cambiado_por)
        VALUES (@cod_usuario, GETDATE(), @cod_usuario);
        
        SELECT 'Contraseña cambiada exitosamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 4. Cambiar contraseña por recuperación (con token)
CREATE PROCEDURE sp_RecuperarContrasena
    @token VARCHAR(255),
    @nueva_contrasena VARCHAR(75),
    @cod_usuario_admin VARCHAR(15) = NULL
AS
BEGIN
    BEGIN TRY
        DECLARE @cod_usuario VARCHAR(15);
        DECLARE @token_valido BIT = 0;
        
        -- Verificar token válido y no expirado
        SELECT @cod_usuario = cod_usuario 
        FROM RecuperacionContraseña
        WHERE token = @token
        AND utilizado = 0
        AND fecha_expiracion > GETDATE();
        
        IF @cod_usuario IS NULL
        BEGIN
            RAISERROR('Token inválido o expirado', 16, 1);
        END
        
        -- Cambiar contraseña
        UPDATE Usuarios 
        SET pass = @nueva_contrasena
        WHERE cod_usuario = @cod_usuario;
        
        -- Marcar token como utilizado
        UPDATE RecuperacionContraseña
        SET utilizado = 1, fecha_uso = GETDATE()
        WHERE token = @token;
        
        -- Registrar en auditoría
        INSERT INTO Auditoria_Contrasena (cod_usuario, fecha_cambio, cambiado_por)
        VALUES (@cod_usuario, GETDATE(), @cod_usuario_admin);
        
        SELECT 'Contraseña recuperada exitosamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 5. Generar token de recuperación
CREATE PROCEDURE sp_GenerarTokenRecuperacion
    @cod_usuario VARCHAR(15),
    @horas_validez INT = 24
AS
BEGIN
    BEGIN TRY
        DECLARE @token VARCHAR(255) = CONVERT(VARCHAR(255), NEWID());
        
        INSERT INTO RecuperacionContraseña (cod_usuario, token, fecha_expiracion)
        VALUES (@cod_usuario, @token, DATEADD(HOUR, @horas_validez, GETDATE()));
        
        SELECT @token AS Token, DATEADD(HOUR, @horas_validez, GETDATE()) AS FechaExpiracion;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - MÓDULO DE KARDEX
-- =====================================================

-- 6. Registrar movimiento de inventario
CREATE PROCEDURE sp_RegistrarMovimientoKardex
    @cod_producto VARCHAR(15),
    @cod_sucursal VARCHAR(15),
    @tipo_movimiento VARCHAR(20), -- Entrada, Salida, Ajuste
    @cantidad INT,
    @referencia_id INT = NULL,
    @observacion VARCHAR(200) = NULL
AS
BEGIN
    BEGIN TRY
        -- Validar tipo de movimiento
        IF @tipo_movimiento NOT IN ('Entrada', 'Salida', 'Ajuste')
        BEGIN
            RAISERROR('Tipo de movimiento inválido', 16, 1);
        END
        
        -- Registrar movimiento en Kardex
        INSERT INTO Kardex (cod_producto, cod_sucursal, tipo_movimiento, cantidad, 
                           referencia_id, observacion)
        VALUES (@cod_producto, @cod_sucursal, @tipo_movimiento, @cantidad, 
                @referencia_id, @observacion);
        
        -- Actualizar inventario según tipo de movimiento
        IF @tipo_movimiento = 'Entrada'
        BEGIN
            UPDATE Inventario 
            SET cantidad_actual = cantidad_actual + @cantidad,
                ultima_actualizacion = GETDATE()
            WHERE cod_producto = @cod_producto AND cod_sucursal = @cod_sucursal;
        END
        ELSE IF @tipo_movimiento = 'Salida'
        BEGIN
            UPDATE Inventario 
            SET cantidad_actual = cantidad_actual - @cantidad,
                ultima_actualizacion = GETDATE()
            WHERE cod_producto = @cod_producto AND cod_sucursal = @cod_sucursal;
        END
        ELSE IF @tipo_movimiento = 'Ajuste'
        BEGIN
            UPDATE Inventario 
            SET cantidad_actual = cantidad_actual + @cantidad,
                ultima_actualizacion = GETDATE()
            WHERE cod_producto = @cod_producto AND cod_sucursal = @cod_sucursal;
        END
        
        SELECT 'Movimiento registrado correctamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 7. Obtener Kardex completo de un producto
CREATE PROCEDURE sp_ObtenerKardexProducto
    @cod_producto VARCHAR(15),
    @cod_sucursal VARCHAR(15) = NULL
AS
BEGIN
    SELECT 
        k.id_kardex,
        k.cod_producto,
        p.nombre_producto,
        k.cod_sucursal,
        s.nombre_sucursal,
        k.tipo_movimiento,
        k.cantidad,
        k.fecha_movimiento,
        k.referencia_id,
        k.observacion,
        i.cantidad_actual AS StockActual
    FROM Kardex k
    INNER JOIN Productos p ON k.cod_producto = p.cod_producto
    INNER JOIN Sucursal s ON k.cod_sucursal = s.cod_sucursal
    INNER JOIN Inventario i ON k.cod_producto = i.cod_producto AND k.cod_sucursal = i.cod_sucursal
    WHERE k.cod_producto = @cod_producto
    AND (@cod_sucursal IS NULL OR k.cod_sucursal = @cod_sucursal)
    ORDER BY k.fecha_movimiento DESC;
END;
GO

-- 8. Alerta de stock mínimo
CREATE PROCEDURE sp_AlertaStockMinimo
    @cod_sucursal VARCHAR(15) = NULL
AS
BEGIN
    SELECT 
        i.cod_sucursal,
        s.nombre_sucursal,
        i.cod_producto,
        p.nombre_producto,
        i.cantidad_actual,
        i.stock_minimo,
        CASE 
            WHEN i.cantidad_actual <= i.stock_minimo THEN 'CRÍTICO'
            ELSE 'NORMAL'
        END AS Estado
    FROM Inventario i
    INNER JOIN Sucursal s ON i.cod_sucursal = s.cod_sucursal
    INNER JOIN Productos p ON i.cod_producto = p.cod_producto
    WHERE i.cantidad_actual <= i.stock_minimo
    AND (@cod_sucursal IS NULL OR i.cod_sucursal = @cod_sucursal)
    ORDER BY i.cantidad_actual ASC;
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - MÓDULO DE BANCOS
-- =====================================================

-- 9. Registrar transacción bancaria
CREATE PROCEDURE sp_RegistrarTransaccionBancaria
    @cod_empresa VARCHAR(15),
    @tipo_transaccion VARCHAR(50), -- Depósito, Retiro
    @monto DECIMAL(18,2),
    @referencia VARCHAR(100) = NULL,
    @id_factura INT = NULL
AS
BEGIN
    BEGIN TRY
        -- Validar tipo de transacción
        IF @tipo_transaccion NOT IN ('Depósito', 'Retiro')
        BEGIN
            RAISERROR('Tipo de transacción inválido', 16, 1);
        END
        
        -- Validar que la factura pertenezca a la empresa si se proporciona
        IF @id_factura IS NOT NULL
        BEGIN
            DECLARE @cod_empresa_factura VARCHAR(15);
            SELECT @cod_empresa_factura = cod_empresa 
            FROM FacturaEncabezado fe
            INNER JOIN Sucursal s ON fe.cod_sucursal = s.cod_sucursal
            WHERE fe.id_factura = @id_factura;
            
            IF @cod_empresa_factura <> @cod_empresa
            BEGIN
                RAISERROR('La factura no pertenece a la empresa especificada', 16, 1);
            END
        END
        
        INSERT INTO TransaccionesBancarias 
        (cod_empresa, tipo_transaccion, monto, fecha_transaccion, referencia, id_factura)
        VALUES (@cod_empresa, @tipo_transaccion, @monto, GETDATE(), @referencia, @id_factura);
        
        SELECT 'Transacción registrada correctamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS Mensaje;
    END CATCH
END;
GO

-- 10. Reporte de ingresos por ventas
CREATE PROCEDURE sp_ReporteIngresosPorVentas
    @cod_empresa VARCHAR(15),
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SELECT 
        CONVERT(VARCHAR(10), t.fecha_transaccion, 120) AS Fecha,
        COUNT(DISTINCT t.id_transaccion) AS CantidadTransacciones,
        SUM(t.monto) AS MontoTotal,
        t.tipo_transaccion,
        e.nombre_empresa
    FROM TransaccionesBancarias t
    INNER JOIN Empresa e ON t.cod_empresa = e.cod_empresa
    WHERE t.cod_empresa = @cod_empresa
    AND CAST(t.fecha_transaccion AS DATE) BETWEEN @fecha_inicio AND @fecha_fin
    AND t.tipo_transaccion = 'Depósito'
    GROUP BY CAST(t.fecha_transaccion AS DATE), t.tipo_transaccion, e.nombre_empresa
    ORDER BY CAST(t.fecha_transaccion AS DATE) DESC;
END;
GO

-- 11. Resumen financiero por empresa
CREATE PROCEDURE sp_ResumenFinancieroPorEmpresa
    @cod_empresa VARCHAR(15)
AS
BEGIN
    DECLARE @ingresos DECIMAL(18,2) = 0;
    DECLARE @egresos DECIMAL(18,2) = 0;
    
    SELECT @ingresos = ISNULL(SUM(monto), 0)
    FROM TransaccionesBancarias
    WHERE cod_empresa = @cod_empresa AND tipo_transaccion = 'Depósito';
    
    SELECT @egresos = ISNULL(SUM(monto), 0)
    FROM TransaccionesBancarias
    WHERE cod_empresa = @cod_empresa AND tipo_transaccion = 'Retiro';
    
    SELECT 
        e.cod_empresa,
        e.nombre_empresa,
        @ingresos AS TotalIngresos,
        @egresos AS TotalEgresos,
        (@ingresos - @egresos) AS Saldo
    FROM Empresa e
    WHERE e.cod_empresa = @cod_empresa;
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - AUDITORÍA
-- =====================================================

-- 12. Reporte de auditoría de contraseñas
CREATE PROCEDURE sp_ReporteAuditoria_Contrasena
    @cod_usuario VARCHAR(15) = NULL,
    @fecha_inicio DATE = NULL,
    @fecha_fin DATE = NULL
AS
BEGIN
    SELECT 
        ac.id_auditoria,
        ac.cod_usuario,
        u.nombre_usuario,
        u.apellido_usuario,
        ac.fecha_cambio,
        ac.cambiado_por,
        CASE 
            WHEN ac.cambiado_por = ac.cod_usuario THEN 'Usuario'
            ELSE 'Administrador'
        END AS TipoCambio
    FROM Auditoria_Contrasena ac
    INNER JOIN Usuarios u ON ac.cod_usuario = u.cod_usuario
    WHERE (@cod_usuario IS NULL OR ac.cod_usuario = @cod_usuario)
    AND (@fecha_inicio IS NULL OR CAST(ac.fecha_cambio AS DATE) >= @fecha_inicio)
    AND (@fecha_fin IS NULL OR CAST(ac.fecha_cambio AS DATE) <= @fecha_fin)
    ORDER BY ac.fecha_cambio DESC;
END;
GO

-- 13. Reporte de intentos de sesión
CREATE PROCEDURE sp_ReporteIntentosSesion
    @cod_usuario VARCHAR(15) = NULL,
    @fecha_inicio DATE = NULL,
    @fecha_fin DATE = NULL
AS
BEGIN
    SELECT 
        is.id_intento,
        is.cod_usuario,
        u.nombre_usuario,
        u.apellido_usuario,
        is.fecha_intento,
        CASE 
            WHEN is.exitoso = 1 THEN 'Exitoso'
            ELSE 'Fallido'
        END AS Resultado
    FROM IntentosSesion is
    INNER JOIN Usuarios u ON is.cod_usuario = u.cod_usuario
    WHERE (@cod_usuario IS NULL OR is.cod_usuario = @cod_usuario)
    AND (@fecha_inicio IS NULL OR CAST(is.fecha_intento AS DATE) >= @fecha_inicio)
    AND (@fecha_fin IS NULL OR CAST(is.fecha_intento AS DATE) <= @fecha_fin)
    ORDER BY is.fecha_intento DESC;
END;
GO

