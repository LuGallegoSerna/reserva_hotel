USE hotel_reservas;

-- ==================================================
-- 1. REINICIO LIMPIO DE DATOS (Evita errores duplicados)
-- ==================================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE pago;
TRUNCATE TABLE reserva;
TRUNCATE TABLE cliente;
TRUNCATE TABLE habitacion;
TRUNCATE TABLE nacionalidad;
TRUNCATE TABLE tipo_habitacion;
TRUNCATE TABLE metodo_pago;
SET FOREIGN_KEY_CHECKS = 1;

-- ==================================================
-- 2. CARGA DE DATOS SINTÉTICOS (Parte 3)
-- ==================================================
-- Catálogos
INSERT INTO nacionalidad (codigo_iso, nombre_pais) VALUES 
('CO', 'Colombia'), ('US', 'Estados Unidos'), ('MX', 'México'), ('ES', 'España'), ('AR', 'Argentina');

INSERT INTO tipo_habitacion (nombre_tipo, descripcion, tarifa_base) VALUES 
('Sencilla', 'Cama individual, vista interior', 100.00),
('Doble', 'Dos camas, vista exterior', 150.00),
('Suite', 'Cama King, jacuzzi, balcón', 300.00);

INSERT INTO metodo_pago (nombre_metodo) VALUES 
('Efectivo'), ('Tarjeta'), ('Transferencia');

-- 20 Clientes 
INSERT INTO cliente (nombre, correo, telefono, id_nacionalidad) VALUES 
('Ana Garcia', 'ana.garcia@email.com', '3001112233', 1), ('John Smith', 'jsmith@email.com', '15550123', 2),
('Maria Lopez', 'mlopez@email.com', '3102223344', 1), ('Carlos Ruiz', 'cruiz@email.com', '52551234', 3),
('Laura Perez', 'lperez@email.com', '3203334455', 1), ('David Jones', 'djones@email.com', '15550456', 2),
('Sofia Martin', 'smartin@email.com', '346112233', 4), ('Diego Torres', 'dtorres@email.com', '3154445566', 1),
('Elena Gomez', 'egomez@email.com', '54114321', 5), ('Kevin White', 'kwhite@email.com', '15550789', 2),
('Carmen Diaz', 'cdiaz@email.com', '3115556677', 1), ('Jose Silva', 'jsilva@email.com', '3186667788', 1),
('Lucia Fernandez', 'lfernandez@email.com', '346998877', 4), ('Pablo Moreno', 'pmoreno@email.com', '3197778899', 1),
('Emma Brown', 'ebrown@email.com', '15550321', 2), ('Jorge Castro', 'jcastro@email.com', '52559876', 3),
('Paula Romero', 'promero@email.com', '3008889900', 1), ('Hugo Sosa', 'hsosa@email.com', '54119876', 5),
('Alba Navarro', 'anavarro@email.com', '346554433', 4), ('Luis Gallego', 'lgallego@email.com', '3109990011', 1);

-- 10 Habitaciones
INSERT INTO habitacion (numero, id_tipo_habitacion, precio_noche, estado) VALUES 
('101', 1, 100.00, 'disponible'), ('102', 1, 100.00, 'disponible'), ('103', 1, 100.00, 'ocupada'),
('201', 2, 150.00, 'disponible'), ('202', 2, 150.00, 'ocupada'), ('203', 2, 150.00, 'mantenimiento'),
('204', 2, 150.00, 'disponible'), ('301', 3, 300.00, 'disponible'), ('302', 3, 300.00, 'ocupada'),
('303', 3, 300.00, 'disponible');

-- 30 Reservas
INSERT INTO reserva (id_cliente, id_habitacion, fecha_entrada, fecha_salida) VALUES 
(1, 1, '2026-10-01', '2026-10-05'), (2, 2, '2026-10-02', '2026-10-06'), (3, 3, '2026-10-03', '2026-10-07'),
(4, 4, '2026-10-04', '2026-10-08'), (5, 5, '2026-10-05', '2026-10-09'), (6, 6, '2026-10-06', '2026-10-10'),
(7, 7, '2026-10-07', '2026-10-11'), (8, 8, '2026-10-08', '2026-10-12'), (9, 9, '2026-10-09', '2026-10-13'),
(10, 10, '2026-10-10', '2026-10-14'), (11, 1, '2026-10-15', '2026-10-20'), (12, 2, '2026-10-16', '2026-10-21'),
(13, 3, '2026-10-17', '2026-10-22'), (14, 4, '2026-10-18', '2026-10-23'), (15, 5, '2026-10-19', '2026-10-24'),
(16, 6, '2026-10-20', '2026-10-25'), (17, 7, '2026-10-21', '2026-10-26'), (18, 8, '2026-10-22', '2026-10-27'),
(19, 9, '2026-10-23', '2026-10-28'), (20, 10, '2026-10-24', '2026-10-29'), (1, 1, '2026-11-01', '2026-11-05'),
(2, 2, '2026-11-02', '2026-11-06'), (3, 3, '2026-11-03', '2026-11-07'), (4, 4, '2026-11-04', '2026-11-08'),
(5, 5, '2026-11-05', '2026-11-09'), (6, 6, '2026-11-06', '2026-11-10'), (7, 7, '2026-11-07', '2026-11-11'),
(8, 8, '2026-11-08', '2026-11-12'), (9, 9, '2026-11-09', '2026-11-13'), (10, 10, '2026-11-10', '2026-11-14');

-- 30 Pagos
INSERT INTO pago (id_reserva, fecha_pago, monto, id_metodo_pago) VALUES 
(1, '2026-10-01', 400.00, 2), (2, '2026-10-02', 400.00, 3), (3, '2026-10-03', 400.00, 1),
(4, '2026-10-04', 600.00, 2), (5, '2026-10-05', 600.00, 2), (6, '2026-10-06', 600.00, 1),
(7, '2026-10-07', 600.00, 3), (8, '2026-10-08', 1200.00, 2), (9, '2026-10-09', 1200.00, 2),
(10, '2026-10-10', 1200.00, 3), (11, '2026-10-15', 500.00, 1), (12, '2026-10-16', 500.00, 2),
(13, '2026-10-17', 500.00, 3), (14, '2026-10-18', 750.00, 2), (15, '2026-10-19', 750.00, 1),
(16, '2026-10-20', 750.00, 3), (17, '2026-10-21', 750.00, 2), (18, '2026-10-22', 1500.00, 2),
(19, '2026-10-23', 1500.00, 3), (20, '2026-10-24', 1500.00, 1), (21, '2026-11-01', 400.00, 2),
(22, '2026-11-02', 400.00, 3), (23, '2026-11-03', 400.00, 1), (24, '2026-11-04', 600.00, 2),
(25, '2026-11-05', 600.00, 2), (26, '2026-11-06', 600.00, 3), (27, '2026-11-07', 600.00, 1),
(28, '2026-11-08', 1200.00, 2), (29, '2026-11-09', 1200.00, 3), (30, '2026-11-10', 1200.00, 1);