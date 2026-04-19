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

CREATE TABLE Usuarios (
    cod_usuario VARCHAR(15) PRIMARY KEY,
    id_usuario INT IDENTITY(1,1) NOT NULL,
    contraseña VARCHAR(75) NOT NULL,
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_usuario VARCHAR(50) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    creado_el DATETIME NOT NULL DEFAULT GETDATE()
);
GO