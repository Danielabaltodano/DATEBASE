	USE MASTER
CREATE DATABASE DB_HotelMilenio
GO
USE DB_HotelMilenio


CREATE TABLE [Empleado] (
  [ID_Empleado] INT PRIMARY KEY,
  [Nombre] VARCHAR(15),
  [Apellido] VARCHAR(15),
  [Telefono] VARCHAR
)
GO

CREATE TABLE [Cliente] (
  [ID_cliente] INT PRIMARY KEY,
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
  [ID_Reservaciones] INT PRIMARY KEY,
  [ID_cliente] INT,
  [F_entreda] DATETIME,
  [F_salida] DATETIME,
  [ID_Empleado] INT
)
GO

CREATE TABLE [Tipo_de_habitacion] (
  [ID_tipoHabitacion] INT PRIMARY KEY,
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
  [ID_InicioSesion] INT PRIMARY KEY,
  [ID_Empleado] INT UNIQUE,
  [Usuario] VARCHAR(20),
  [Contraseña] INT
)
GO

CREATE TABLE [DetalleResravacion] (
  [ID_DetalleReservacion] INT,
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

ALTER TABLE [DetalleResravacion] ADD FOREIGN KEY ([ID_Reservaciones]) REFERENCES [Reservacion] ([ID_Reservaciones])
GO

ALTER TABLE [DetalleResravacion] ADD FOREIGN KEY ([N_de_habitacion]) REFERENCES [Habitacion] ([N_de_habitacion])
GO
