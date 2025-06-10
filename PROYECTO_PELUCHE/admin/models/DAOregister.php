<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOregister {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function registrarCuenta($tipo, $nombres, $apellidos, $telefono, $correo, $clave) {
        try {
            if ($tipo === 'admin') {
                $sql = "INSERT INTO administradores (nombres, apellidos, telefono, correo, clave, estado_activo)
                        VALUES (:nombres, :apellidos, :telefono, :correo, :clave, 1)";
            } elseif ($tipo === 'vendedor') {
                $sql = "INSERT INTO vendedores (nombres, apellidos, telefono, correo, clave, estado_activo)
                        VALUES (:nombres, :apellidos, :telefono, :correo, :clave, 1)";
            } else {
                return false;
            }

            $stmt = $this->pdo->prepare($sql);
            $stmt->bindParam(':nombres', $nombres);
            $stmt->bindParam(':apellidos', $apellidos);
            $stmt->bindParam(':telefono', $telefono);
            $stmt->bindParam(':correo', $correo);
            $stmt->bindParam(':clave', $clave);

            return $stmt->execute();

        } catch (PDOException $e) {
            echo "Error al registrar: " . $e->getMessage();
            return false;
        }
    }
}





