CREATE DATABASE IF NOT EXISTS hotel_reservas;
USE hotel_reservas;

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
);

UPDATE habitacion 
SET estado = 'mantenimiento' 
WHERE numero = '103';

INSERT INTO pago (id_reserva, fecha_pago, monto, id_metodo_pago) 
VALUES (5, CURDATE(), 100.00, 1);

INSERT INTO pago (id_reserva, fecha_pago, monto, id_metodo_pago) 
VALUES (5, CURDATE(), 100.00, 1);

DELETE FROM reserva 
WHERE id_reserva = 30;

SELECT id_pago, id_reserva, fecha_pago, monto, id_metodo_pago
FROM pago
WHERE id_reserva = 5
  AND monto = 100.00
  AND id_metodo_pago = 1;

DELETE FROM pago
WHERE id_pago = 32;

SELECT * 
FROM habitacion 
WHERE estado = 'disponible';

SELECT * 
FROM reserva 
WHERE CURDATE() BETWEEN fecha_entrada AND fecha_salida;

INSERT INTO reserva (id_cliente, id_habitacion, fecha_entrada, fecha_salida) 
VALUES (20, 5, '2026-11-10', '2026-11-20');

SELECT id_reserva, id_cliente, fecha_entrada, fecha_salida, 
       DATEDIFF(fecha_salida, fecha_entrada) AS noches_totales
FROM reserva 
WHERE DATEDIFF(fecha_salida, fecha_entrada) > 3;

SELECT DISTINCT c.nombre, c.correo, c.telefono, th.nombre_tipo
FROM cliente c
JOIN reserva r ON c.id_cliente = r.id_cliente
JOIN habitacion h ON r.id_habitacion = h.id_habitacion
JOIN tipo_habitacion th ON h.id_tipo_habitacion = th.id_tipo_habitacion
WHERE th.nombre_tipo = 'Suite';

SELECT DISTINCT
    c.id_cliente,
    c.nombre,
    n.nombre_pais AS nacionalidad
FROM cliente AS c
JOIN nacionalidad AS n
    ON c.id_nacionalidad = n.id_nacionalidad
JOIN reserva AS r
    ON c.id_cliente = r.id_cliente;
  
SELECT DISTINCT c.nombre, n.nombre_pais
FROM cliente c
JOIN nacionalidad n ON c.id_nacionalidad = n.id_nacionalidad
JOIN reserva r ON c.id_cliente = r.id_cliente
WHERE n.nombre_pais = 'Argentina';


    