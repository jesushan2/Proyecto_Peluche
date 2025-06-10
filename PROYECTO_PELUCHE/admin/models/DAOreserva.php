<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOreserva {
    private $db;

    public function __construct() {
        $this->db = Database::connect();
    }

    public function obtenerReservas() {
        $sql = "SELECT r.id_reserva, r.id_usuario, r.id_estado, r.id_vendedor, r.fecha_reserva, r.total, r.estado_activo,
                       u.nombres AS usuario_nombres, u.apellidos AS usuario_apellidos,
                       e.nombre_est AS nombre_est,
                       v.nombres AS vendedor_nombres, v.apellidos AS vendedor_apellidos
                FROM reservas r
                JOIN usuarios u ON r.id_usuario = u.id_usuario
                JOIN estados_reserva e ON r.id_estado = e.id_estado
                LEFT JOIN vendedores v ON r.id_vendedor = v.id_vendedor
                WHERE r.estado_activo = 1
                ORDER BY r.fecha_reserva DESC";

        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerReservaPorId($id) {
        $sql = "SELECT r.*, e.nombre_est
                FROM reservas r
                JOIN estados_reserva e ON r.id_estado = e.id_estado
                WHERE r.id_reserva = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function obtenerEstadosReserva() {
        $sql = "SELECT id_estado, nombre_est FROM estados_reserva";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerVendedores() {
        $sql = "SELECT id_vendedor, nombres, apellidos FROM vendedores WHERE estado_activo = 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function actualizarReserva($id, $id_estado, $id_vendedor) {
        $sql = "UPDATE reservas SET id_estado = :id_estado, id_vendedor = :id_vendedor WHERE id_reserva = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id_estado', $id_estado, PDO::PARAM_INT);
        $stmt->bindParam(':id_vendedor', $id_vendedor, PDO::PARAM_INT);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function desactivarReserva($id) {
        $sql = "UPDATE reservas SET estado_activo = 0 WHERE id_reserva = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }
}

