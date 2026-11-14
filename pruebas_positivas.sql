USE hotel_reservas;

-- PARTE 2: PRUEBAS POSITIVAS

-- Inserción válida en tabla catálogo
INSERT INTO nacionalidad (codigo_iso, nombre_pais) 
VALUES ('CO', 'Colombia');

-- Inserción válida respetando la restricción UNIQUE
INSERT INTO metodo_pago (nombre_metodo) 
VALUES ('Billetera Digital');

-- Inserción válida respetando el CHECK de tarifa_base > 0
INSERT INTO tipo_habitacion (nombre_tipo, descripcion, tarifa_base) 
VALUES ('Presidencial', 'Lujo total', 1000.00);