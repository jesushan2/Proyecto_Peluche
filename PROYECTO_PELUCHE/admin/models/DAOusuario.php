<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOusuario {
    private $db;

    public function __construct() {
        $this->db = Database::connect();
    }

    public function obtenerUsuarios() {
        $sql = "SELECT id_usuario, nombres, apellidos, telefono, correo, fecha_registro, estado_activo FROM usuarios WHERE estado_activo = 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerUsuarioPorId($id) {
        $sql = "SELECT id_usuario, nombres, apellidos, telefono, correo FROM usuarios WHERE id_usuario = :id AND estado_activo = 1";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function actualizarUsuario($id, $nombres, $apellidos, $telefono, $correo) {
        $sql = "UPDATE usuarios SET nombres = :nombres, apellidos = :apellidos, telefono = :telefono, correo = :correo WHERE id_usuario = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':nombres', $nombres);
        $stmt->bindParam(':apellidos', $apellidos);
        $stmt->bindParam(':telefono', $telefono);
        $stmt->bindParam(':correo', $correo);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function desactivarUsuario($id) {
        $sql = "UPDATE usuarios SET estado_activo = 0 WHERE id_usuario = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function listarTodos() {
        $stmt = $this->db->query("SELECT * FROM usuarios");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}


