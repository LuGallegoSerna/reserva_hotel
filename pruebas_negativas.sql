USE hotel_reservas;

-- PARTE 2: PRUEBAS NEGATIVAS INTENCIONALES

-- Violar llave foránea (Insertar un cliente con una nacionalidad que no existe, ej. ID 999)
INSERT INTO cliente (nombre, correo, telefono, id_nacionalidad) 
VALUES ('Cliente Falso', 'falso@email.com', '000000', 999);

-- Violar CHECK de fechas (Fecha de salida anterior a la fecha de entrada)
-- (Nota: Fallará por la restricción de fecha)
INSERT INTO reserva (id_cliente, id_habitacion, fecha_entrada, fecha_salida) 
VALUES (1, 1, '2026-10-10', '2026-10-05');

-- Violar CHECK de monto (Insertar un pago con valor negativo)
INSERT INTO pago (id_reserva, fecha_pago, monto, id_metodo_pago) 
VALUES (1, '2026-10-10', -50.00, 1);