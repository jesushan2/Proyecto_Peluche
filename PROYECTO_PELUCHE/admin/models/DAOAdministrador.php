<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOAdministrador {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function obtenerAdministradoresActivos() {
        $sql = "SELECT * FROM administradores WHERE estado_activo = 1";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerAdministradorPorId($id_admin) {
        $sql = "SELECT * FROM administradores WHERE id_admin = :id_admin";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id_admin', $id_admin);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function actualizarAdministrador($id_admin, $nombres, $apellidos, $telefono, $correo, $clave) {
        $sql = "UPDATE administradores SET nombres = :nombres, apellidos = :apellidos, telefono = :telefono, correo = :correo, clave = :clave WHERE id_admin = :id_admin";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':nombres', $nombres);
        $stmt->bindParam(':apellidos', $apellidos);
        $stmt->bindParam(':telefono', $telefono);
        $stmt->bindParam(':correo', $correo);
        $stmt->bindParam(':clave', $clave);
        $stmt->bindParam(':id_admin', $id_admin);
        return $stmt->execute();
    }

    public function eliminarAdministrador($id_admin) {
        $sql = "UPDATE administradores SET estado_activo = 0 WHERE id_admin = :id_admin";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id_admin', $id_admin);
        return $stmt->execute();
    }

    public function listarTodos() {
        $stmt = $this->pdo->query("SELECT * FROM administradores");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
}
