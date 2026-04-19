CREATE DATABASE POSRETAIL
GO

USE POSRETAIL
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
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (cod_sucursal) REFERENCES Sucursal(cod_sucursal),
    FOREIGN KEY (cod_rol) REFERENCES Rol(cod_rol)
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