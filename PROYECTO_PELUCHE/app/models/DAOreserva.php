<?php
require_once __DIR__ . '/../../config/database.php';

class DAOreserva {
    public $conexion;

    public function __construct() {
        $this->conexion = Database::connect();
    }

    public function obtenerProductoPorId(int $idProducto) {
        $stmt = $this->conexion->prepare("SELECT id_producto, nombre_prod, precio, imagen FROM productos WHERE id_producto = :id");
        $stmt->bindParam(':id', $idProducto, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

public function insertarReserva(int $id_usuario, int $id_estado, float $total): int {
    $stmt = $this->conexion->prepare("INSERT INTO reservas (id_usuario, id_estado, total) VALUES (?, ?, ?)");
    $stmt->execute([$id_usuario, $id_estado, $total]);
    return $this->conexion->lastInsertId();
}


    public function insertarDetalleReserva(int $id_reserva, int $id_producto, int $cantidad, float $precio_unitario) {
        $stmt = $this->conexion->prepare("INSERT INTO detalles_reserva (id_reserva, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?)");
        $stmt->execute([$id_reserva, $id_producto, $cantidad, $precio_unitario]);
    }

    public function obtenerStockProducto(int $idProducto): int {
        $stmt = $this->conexion->prepare("SELECT stock FROM productos WHERE id_producto = ?");
        $stmt->execute([$idProducto]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ? intval($row['stock']) : 0;
    }

    public function actualizarStockProducto(int $idProducto, int $cantidad) {
        $stmt = $this->conexion->prepare("UPDATE productos SET stock = stock - ? WHERE id_producto = ?");
        $stmt->execute([$cantidad, $idProducto]);
    }
}
