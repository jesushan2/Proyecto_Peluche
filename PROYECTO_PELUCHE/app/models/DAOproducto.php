<?php
require_once __DIR__ . '/../../config/database.php';

class DAOproducto {
    private $db;

    public function __construct() {
        $this->db = Database::connect();
    }

    public function obtenerProductosConFranquicia() {
        $sql = "SELECT p.*, f.nombre_fran AS franquicia
                FROM productos p
                INNER JOIN franquicias f ON p.id_franquicia = f.id_franquicia
                ORDER BY f.nombre_fran ASC, p.nombre_prod ASC";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}


