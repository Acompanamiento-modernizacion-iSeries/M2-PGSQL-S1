INSERT INTO Clientes VALUES
(1, 'Andres Felipe', 'Martinez Granada', 'Calle 66A # 55A-51, Medellin', '(604)1234567', 'andres.martinezg@example.com', '1993-06-15', 'activo'),
(2, 'Maria Camila', 'Arboleda Zapata', 'Carrera 45 # 12-34 Apartamento 5', '300-1234-5678', 'mariazapata@example.com', '1995-08-22', 'activo'),
(3, 'Carlos Andres', 'Molano Manquillo', 'Avenida 68 # 45-23, Barrio Nuevo', '3003456789', 'carlosandresmolano@example.com', '1992-01-10', 'inactivo'),
(4, 'Jose Luis', 'Ramirez', 'Calle 178 # 10-11, Unidad Jardin Verde', '604-5678901', 'luis.ramirez87@example.com', '1987-12-19', 'inactivo');

INSERT INTO Sucursales VALUES
(1, 'Bogota', 'Torre Colpatria, Calle 45 # 102-34', '6011234567'),
(2, 'Medellin', 'Carrera 7 # 8-90, Barrio el Poblado', '6044445678'),
(3, 'Cali', 'Avenida 5 # 34-56, CC Unicentro', '6023456789'),
(4, 'Barranquilla', 'Calle 72 # 15-20', '6054567890 - 6054567891');

INSERT INTO Empleados VALUES
(1, 'Fernando', 'Castaneda', 'Calle 103 #65-67', '3201234567', 'fernando.castaneda@banco.com', '2022-01-10', 'Cajero', 2000000, 1),
(2, 'Laura', 'Soto', 'Carrera 45 # 12-34, Bello', '6042345678', 'laura.soto@banco.com', '2021-05-20', 'Asesor Comercial', 2500000, 2),
(3, 'Ricardo', 'Jorge', 'Avenida 6', '3203456789', 'ricardo.jorge@banco.com', '2019-08-30', 'Gerente', 4000000, 3),
(4, 'Sofia', 'Marin', 'La Ventana al Mundo', '3200000000', 'sofia.marin@banco.com', '2020-03-15', 'Analista de Credito', 3000000, 4);

INSERT INTO Cuentas_Bancarias VALUES
(1, 2, '1222333444', 'ahorro', 545000, '2018-08-10', 'activa'),
(2, 2, '2344325678', 'corriente', 1401200, '2019-05-15', 'activa'),
(3, 3, '3444555666', 'ahorro', 750321, '2020-01-02', 'cerrada'),
(4, 1,'4566547890', 'corriente', 305000, '2021-03-20', 'activa');

INSERT INTO Transacciones VALUES
(1, 3, 'deposito', 200000, '2020-02-01', 'Pago de nomina'),
(2, 3, 'retiro', 50000, '2020-02-02', 'Retiro en cajero automatico'),
(3, 3, 'transferencia', 15000, '2020-02-12', 'Transferencia a cuenta ahorros'),
(4, 1, 'deposito', 15000, '2020-02-12', 'Pago bancario'),
(5, 1, 'retiro', 3000, '2020-02-15', 'Retiro en oficina'),
(6, 2, 'deposito', 400000, '2020-03-13', 'Deposito en efectivo'),
(7, 2, 'transferencia', 10000, '2020-04-23', 'Transferencia interbancaria');

INSERT INTO Productos_Financieros VALUES
(1, 'Credito Hipotecario', 'prestamo', 'Credito para adquisicion de vivienda', 8.5),
(2, 'Tarjeta de Credito Oro', 'tarjeta de credito', 'Tarjeta de credito Visa Oro', 28.5),
(3, 'Seguro de Vida', 'seguro', 'Seguro de vida mas hospitalizacion', 5.2),
(4, 'Credito de Consumo', 'prestamo', 'Credito para libre inversion', 12.3),
(5, 'Tarjeta de Credito Codensa', 'tarjeta de credito', 'Tarjeta de credito de comercio', 28.5),
(6, 'Seguro de Vehiculo', 'seguro', 'Seguro todo riesgo', 6.5),
(7, 'Credito Educativo', 'prestamo', 'Credito para estudios superiores', 10.0);

INSERT INTO Prestamos VALUES
(1, 4, 30000000, 8.5, '2022-01-01', '2032-01-01', 'activo'),
(2, 1, 24000000, 12.3, '2021-05-15', '2026-05-15', 'activo'),
(3, 4, 55000000, 8.5, '2018-08-10', '2028-08-10', 'pagado'),
(4, 2, 1500000, 12.3, '2021-03-20', '2026-03-20', 'activo'),
(5, 2, 2000000, 10.0, '2021-09-15', '2031-09-15', 'pagado');

INSERT INTO Tarjetas_Credito VALUES
(1, 3, '1234432112344321', 10000000, 2000000, '2022-01-01', '2026-01-01', 'activa'),
(2, 2, '2222333344445555', 5000000, 1000000, '2021-05-15', '2025-05-15', 'activa'),
(3, 3, '1234123412341234', 2000000, 500000, '2018-08-10', '2022-08-10', 'bloqueada'),
(4, 4, '5555444433332222', 3000000, 750000, '2021-03-20', '2025-03-20', 'activa');

INSERT INTO Relacion_Clientes_Productos VALUES
(1, 1, '2022-01-01'),
(2, 3, '2021-05-15'),
(3, 5, '2018-08-10'),
(4, 7, '2021-03-20'),
(1, 2, '2021-09-15'),
(2, 5, '2020-02-28'),
(3, 7, '2019-07-11');