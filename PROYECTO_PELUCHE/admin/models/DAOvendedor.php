<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOvendedor {
    private $db;

    public function __construct() {
        $this->db = Database::connect();
    }

    public function obtenerVendedores() {
        $sql = "SELECT id_vendedor, nombres, apellidos, telefono, correo, estado_activo FROM vendedores WHERE estado_activo = 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerVendedorPorId($id) {
        $sql = "SELECT id_vendedor, nombres, apellidos, telefono, correo FROM vendedores WHERE id_vendedor = :id AND estado_activo = 1";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function actualizarVendedor($id, $nombres, $apellidos, $telefono, $correo) {
        $sql = "UPDATE vendedores SET nombres = :nombres, apellidos = :apellidos, telefono = :telefono, correo = :correo WHERE id_vendedor = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':nombres', $nombres);
        $stmt->bindParam(':apellidos', $apellidos);
        $stmt->bindParam(':telefono', $telefono);
        $stmt->bindParam(':correo', $correo);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function desactivarVendedor($id) {
        $sql = "UPDATE vendedores SET estado_activo = 0 WHERE id_vendedor = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function listarTodos() {
        $stmt = $this->db->query("SELECT * FROM vendedores");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
