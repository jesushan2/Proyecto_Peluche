<?php
class DAOlogin {
    public static function obtenerPorCorreo(PDO $conexion, string $correo) {
        $stmt = $conexion->prepare("SELECT * FROM usuarios WHERE correo = :correo AND estado_activo = 1");
        $stmt->bindParam(':correo', $correo);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
