<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOFranquicia {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function crearFranquicia($nombre_fran) {
        $sql = "INSERT INTO franquicias (nombre_fran, estado_activo) VALUES (:nombre_fran, 1)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':nombre_fran', $nombre_fran);
        return $stmt->execute();
    }

    public function obtenerFranquiciasActivas() {
        $sql = "SELECT * FROM franquicias WHERE estado_activo = 1 ORDER BY nombre_fran";
        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerFranquiciaPorId($id) {
        $sql = "SELECT * FROM franquicias WHERE id_franquicia = :id AND estado_activo = 1";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function actualizarFranquicia($id, $nombre_fran) {
        $sql = "UPDATE franquicias SET nombre_fran = :nombre_fran WHERE id_franquicia = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':nombre_fran', $nombre_fran);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function eliminarFranquicia($id) {
        $sql = "UPDATE franquicias SET estado_activo = 0 WHERE id_franquicia = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function listarTodos() {
        $stmt = $this->pdo->query("SELECT * FROM franquicias");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}


