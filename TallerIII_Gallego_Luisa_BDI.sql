-- 1. Crear y usar la base de datos
CREATE DATABASE IF NOT EXISTS hotel_reservas;
USE hotel_reservas;

-- 2. Tablas maestras o de catálogo (sin claves foráneas)
CREATE TABLE nacionalidad (
    id_nacionalidad INT AUTO_INCREMENT PRIMARY KEY,
    codigo_iso VARCHAR(5) UNIQUE NOT NULL,
    nombre_pais VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE tipo_habitacion (
    id_tipo_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(200),
    tarifa_base DECIMAL(10,2) NOT NULL,
    CHECK (tarifa_base > 0)
);

CREATE TABLE metodo_pago (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre_metodo VARCHAR(50) UNIQUE NOT NULL
);

-- 3. Tablas intermedias (con claves foráneas hacia los catálogos)
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id_nacionalidad) ON DELETE RESTRICT
);

CREATE TABLE habitacion (
    id_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    id_tipo_habitacion INT NOT NULL,
    precio_noche DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    CHECK (estado IN ('disponible', 'ocupada', 'mantenimiento')),
    FOREIGN KEY (id_tipo_habitacion) REFERENCES tipo_habitacion(id_tipo_habitacion) ON DELETE RESTRICT
);

-- 4. Tablas transaccionales principales
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    CHECK (fecha_salida > fecha_entrada),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE RESTRICT,
    FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion) ON DELETE RESTRICT
);

CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    id_metodo_pago INT NOT NULL,
    CHECK (monto > 0),
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva) ON DELETE CASCADE,
    FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago) ON DELETE RESTRICT
);cliente