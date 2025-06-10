<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOlogin {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function verificarCredenciales($correo, $clave) {
        $roles = ['administradores', 'vendedores'];
        foreach ($roles as $rol) {
            $sql = "SELECT * FROM $rol WHERE correo = :correo AND clave = :clave AND estado_activo = 1";
            $stmt = $this->pdo->prepare($sql);
            $stmt->bindParam(':correo', $correo);
            $stmt->bindParam(':clave', $clave);
            $stmt->execute();

            if ($stmt->rowCount() === 1) {
                $usuario = $stmt->fetch(PDO::FETCH_ASSOC);
                $usuario['rol'] = $rol === 'administradores' ? 'admin' : 'vendedor';

                $usuario['nombre'] = trim($usuario['nombres'] . ' ' . $usuario['apellidos']);

                return $usuario;
            }
        }
        return false;
    }
}


