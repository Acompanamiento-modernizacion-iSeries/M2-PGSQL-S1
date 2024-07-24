-- Tabla clientes
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) UNIQUE,
    fecha_nacimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'inactivo'))
);

-- Tabla sucursales
CREATE TABLE sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

-- Tabla empleados
CREATE TABLE empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100) UNIQUE,
    fecha_contratacion DATE,
    posicion VARCHAR(100),
    salario DECIMAL(10, 2),
    sucursal_id INTEGER REFERENCES sucursales(sucursal_id)
);

-- Tabla cuentas_bancarias
CREATE TABLE cuentas_bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(cliente_id),
    numero_cuenta VARCHAR(20) UNIQUE,
    tipo_cuenta VARCHAR(20) CHECK (tipo_cuenta IN ('ahorro', 'corriente')),
    saldo DECIMAL(12, 2),
    fecha_apertura DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'cerrada'))
);

-- Tabla transacciones
CREATE TABLE transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES cuentas_bancarias(cuenta_id),
    tipo_transaccion VARCHAR(20) CHECK (tipo_transaccion IN ('deposito', 'retiro', 'transferencia')),
    monto DECIMAL(12, 2),
    fecha_transaccion TIMESTAMP,
    descripcion TEXT
);

-- Tabla productos_financieros
CREATE TABLE productos_financieros (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50) CHECK (tipo_producto IN ('préstamo', 'tarjeta de crédito', 'seguro')),
    descripcion VARCHAR(100),
    tasa_interes DECIMAL(5, 2)
);

-- Tabla préstamos
CREATE TABLE prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES cuentas_bancarias(cuenta_id),
    monto DECIMAL(12, 2),
    tasa_interes DECIMAL(5, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20) CHECK (estado IN ('activo', 'pagado'))
);

-- Tabla tarjetas_credito
CREATE TABLE tarjetas_credito (
    tarjeta_id SERIAL PRIMARY KEY,
    cuenta_id INTEGER REFERENCES cuentas_bancarias(cuenta_id),
    numero_tarjeta VARCHAR(20) UNIQUE,
    limite_credito DECIMAL(12, 2),
    saldo_actual DECIMAL(12, 2),
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado VARCHAR(20) CHECK (estado IN ('activa', 'bloqueada'))
);

-- Tabla relación_clientes_productos
CREATE TABLE relacion_clientes_productos (
    cliente_id INTEGER REFERENCES clientes(cliente_id),
    producto_id INTEGER REFERENCES productos_financieros(producto_id),
    fecha_adquisicion DATE,
    PRIMARY KEY (cliente_id, producto_id)
);