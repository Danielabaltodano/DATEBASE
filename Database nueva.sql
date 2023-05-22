USE MASTER
CREATE DATABASE DB_HotelMilenio
GO
USE DB_HotelMilenio


CREATE TABLE [Empleado] (
  [ID_Empleado] INT IDENTITY(1,1) PRIMARY KEY,
  [Nombre] VARCHAR(15),
  [Apellido] VARCHAR(15),
  [Telefono] int,
  [usuario] varchar (15),
  [Contraseña] int
)
GO

CREATE TABLE [Cliente] (
  [ID_cliente] INT IDENTITY(1,1) PRIMARY KEY,
  [Cedula_cliente] NCHAR(15),
  [Nombre1] VARCHAR(15),
  [Nombre2] VARCHAR(15),
  [Apellido1] VARCHAR(15),
  [Apellido2] VARCHAR(15),
  [Procedencia] VARCHAR(40),
  [Telefono] INT
)
GO

CREATE TABLE [Reservacion] (
  [ID_Reservaciones] INT IDENTITY(1,1) PRIMARY KEY,
  [ID_cliente] INT,
  [F_entrada] DATETIME,
  [F_salida] DATETIME,
  [ID_Empleado] INT
)
GO

CREATE TABLE [Tipo_de_habitacion] (
  [ID_tipoHabitacion] INT IDENTITY(1,1) PRIMARY KEY,
  [Baño] VARCHAR(20),
  [Num_cama] INT,
  [Aire_Acondi] BIT,
  [Television] BIT,
)
GO

CREATE TABLE [Habitacion] (
  [N_de_habitacion] INT PRIMARY KEY,
  [ID_tipoHabitacion] INT,
  [Estado] BIT,
  [Precio] INT
)
GO

CREATE TABLE [InicioSesion] (
  [ID_InicioSesion] INT IDENTITY(1,1) PRIMARY KEY,
  [ID_Empleado] INT UNIQUE,
  [Usuario] VARCHAR(20),
  [Contraseña] INT
)
GO

CREATE TABLE [DetalleReservacion] (
  [ID_DetalleReservacion] INT IDENTITY(1,1),
  [N_de_habitacion] INT,
  [ID_Reservaciones] INT
)
GO

ALTER TABLE [InicioSesion] ADD FOREIGN KEY ([ID_Empleado]) REFERENCES [Empleado] ([ID_Empleado])
GO

ALTER TABLE [Reservacion] ADD FOREIGN KEY ([ID_cliente]) REFERENCES [Cliente] ([ID_cliente])
GO

ALTER TABLE [Reservacion] ADD FOREIGN KEY ([ID_Empleado]) REFERENCES [Empleado] ([ID_Empleado])
GO

ALTER TABLE [Habitacion] ADD FOREIGN KEY ([ID_tipoHabitacion]) REFERENCES [Tipo_de_habitacion] ([ID_tipoHabitacion])
GO

ALTER TABLE [Habitacion] ADD FOREIGN KEY ([N_de_habitacion]) REFERENCES [Reservacion] ([ID_Reservaciones])
GO

ALTER TABLE [DetalleReservacion] ADD FOREIGN KEY ([ID_Reservaciones]) REFERENCES [Reservacion] ([ID_Reservaciones])
GO

ALTER TABLE [DetalleReservacion] ADD FOREIGN KEY ([N_de_habitacion]) REFERENCES [Habitacion] ([N_de_habitacion])
GO


USE[DB_HotelMilenio]
GO
CREATE PROCEDURE MostrarClientes
AS
BEGIN
    SELECT * FROM Cliente;
END



--------------------------------
USE [DB_HotelMilenio]
GO
CREATE PROCEDURE [dbo].[ConsultarClientes]
    @dato VARCHAR(50)
AS
BEGIN
    SELECT ID_cliente, Cedula_cliente, Nombre1, Nombre2, Apellido1, Apellido2, Procedencia, Telefono
    FROM cliente
    WHERE Cedula_cliente LIKE '%' + RTRIM(@dato) + '%'
        OR Nombre1 LIKE '%' + RTRIM(@dato) + '%'
        OR Nombre2 LIKE '%' + RTRIM(@dato) + '%'
        OR Apellido1 LIKE '%' + RTRIM(@dato) + '%'
        OR Apellido2 LIKE '%' + RTRIM(@dato) + '%';
END
--------------------------------------------------------------------


USE [DB_HotelMilenio]
GO
CREATE PROCEDURE InsertarCliente
    @ID_cliente INT,
    @Cedula_cliente NCHAR(15),
    @Nombre1 VARCHAR(15),
    @Nombre2 VARCHAR(15),
    @Apellido1 VARCHAR(15),
    @Apellido2 VARCHAR(15),
    @Procedencia VARCHAR(40),
    @Telefono INT
AS
BEGIN
    INSERT INTO Cliente (ID_cliente, Cedula_cliente, Nombre1, Nombre2, Apellido1, Apellido2, Procedencia, Telefono)
    VALUES (@ID_cliente, @Cedula_cliente, @Nombre1, @Nombre2, @Apellido1, @Apellido2, @Procedencia, @Telefono)
END

--------------------------------------------------------------------------
USE [DB_HotelMilenio]
GO
CREATE PROCEDURE [dbo].[ModificarCliente]
@ID_cliente INT,
@Cedula_cliente NCHAR(15),
@Nombre1 VARCHAR(15),
@Nombre2 VARCHAR(15),
@Apellido1 VARCHAR(15),
@Apellido2 VARCHAR(15),
@Procedencia VARCHAR(40),
@Telefono INT
AS
BEGIN
UPDATE Cliente SET
    Cedula_cliente = @Cedula_cliente,
    Nombre1 = @Nombre1,
    Nombre2 = @Nombre2,
    Apellido1 = @Apellido1,
    Apellido2 = @Apellido2,
    Procedencia = @Procedencia,
    Telefono = @Telefono
WHERE ID_cliente = @ID_cliente
END

-------------------------------------------------------------------------
USE [DB_HotelMilenio]
GO
CREATE PROCEDURE EliminarCliente
    @ID_cliente INT
AS
BEGIN
    DELETE FROM Cliente
    WHERE ID_cliente = @ID_cliente;
END


--------------------------------------------------
CREATE PROCEDURE InsertarEmpleado
    @Nombre VARCHAR(15),
    @Apellido VARCHAR(15),
    @Telefono INT,
	@usuario varchar(15),
	@Contraseña int
AS
BEGIN
    INSERT INTO Empleado (Nombre, Apellido, Telefono, usuario,contraseña)
    VALUES (@Nombre, @Apellido, @Telefono,@usuario,@Contraseña);
END


CREATE PROCEDURE ActualizarEmpleado
    @ID_Empleado INT,
    @Nombre VARCHAR(15),
    @Apellido VARCHAR(15),
    @Telefono INT,
	@usuario varchar(15),
	@Contraseña int
AS
BEGIN
    UPDATE Empleado
    SET Nombre = @Nombre, Apellido = @Apellido, Telefono = @Telefono, usuario = @usuario, Contraseña = @Contraseña
    WHERE ID_Empleado = @ID_Empleado;
END


CREATE PROCEDURE EliminarEmpleado
    @ID_Empleado INT
AS
BEGIN
    DELETE FROM Empleado
    WHERE ID_Empleado = @ID_Empleado;
END

CREATE PROCEDURE InsertarReservacion
    @ID_Cliente INT,
    @F_Entrada DATETIME,
    @F_Salida DATETIME,
    @ID_Empleado INT
AS
BEGIN
    INSERT INTO Reservacion (ID_Cliente, F_Entrada, F_Salida, ID_Empleado)
    VALUES (@ID_Cliente, @F_Entrada, @F_Salida, @ID_Empleado);
END

CREATE PROCEDURE ActualizarReservacion
    @ID_Reservacion INT,
    @ID_Cliente INT,
    @F_Entrada DATETIME,
    @F_Salida DATETIME,
    @ID_Empleado INT
AS
BEGIN
    UPDATE Reservacion
    SET ID_Cliente = @ID_Cliente, F_Entrada = @F_Entrada, F_Salida = @F_Salida, ID_Empleado = @ID_Empleado
    WHERE ID_Reservaciones = @ID_Reservacion;
END

CREATE PROCEDURE EliminarReservacion
    @ID_Reservacion INT
AS
BEGIN
    DELETE FROM Reservacion
    WHERE ID_Reservaciones = @ID_Reservacion;
END