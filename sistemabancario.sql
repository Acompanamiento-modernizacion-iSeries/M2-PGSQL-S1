CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE CuentasBancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    numero_cuenta VARCHAR(50) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('corriente', 'ahorro')),
    saldo DECIMAL(15, 2) DEFAULT 0.00,
    fecha_apertura DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'cerrada'))
);

CREATE TABLE Transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES CuentasBancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) CHECK (tipo_transaccion IN ('deposito', 'retiro', 'transferencia')),
    monto DECIMAL(15, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(200)
);

CREATE TABLE Sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100),
    fecha_contratacion DATE,
    posicion VARCHAR(100),
    salario DECIMAL(15, 2),
    sucursal_id INTEGER REFERENCES Sucursales(sucursal_id)
);

CREATE TABLE ProductosFinancieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) CHECK (tipo_producto IN ('prestamo', 'tarjeta de credito', 'seguro')),
    descripcion VARCHAR(100),
    tasa_interes DECIMAL(5, 2)
);

CREATE TABLE Prestamos (
    préstamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES CuentasBancarias(cuenta_id),
    monto DECIMAL(15, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'pagado'))
);

CREATE TABLE TarjetasDeCredito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES CuentasBancarias(cuenta_id),
    numero_tarjeta VARCHAR(50) UNIQUE NOT NULL,
    limite_credito DECIMAL(15, 2),
    saldo_actual DECIMAL(15, 2) DEFAULT 0.00,
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'bloqueada'))
);

CREATE TABLE RelacionClientesProductos (
    cliente_id INTEGER REFERENCES Clientes(cliente_id),
    producto_id INTEGER REFERENCES ProductosFinancieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);