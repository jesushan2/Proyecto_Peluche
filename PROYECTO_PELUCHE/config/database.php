<?php
class Database {
    public static function connect() {
        $host = 'localhost';
        $db = 'bdpeluches';
        $user = 'root';
        $pass = '';

        try {
            $conexion = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
            $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conexion;
        } catch (PDOException $e) {
            die("Conexión fallida: " . $e->getMessage());
        }
    }
}
