<?php
require_once __DIR__ . '/../models/DAOregister.php';

class RegisterController {
    private $dao;

    public function __construct() {
        $this->dao = new DAOregister();
    }

    public function index() {
       include __DIR__ . '/../views/Vregister.php';
    }

    public function registrar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $tipo = $_POST['tipo'] ?? '';
            $nombres = $_POST['nombres'] ?? '';
            $apellidos = $_POST['apellidos'] ?? '';
            $telefono = $_POST['telefono'] ?? '';
            $correo = $_POST['correo'] ?? '';
            $clave = $_POST['clave'] ?? '';

            $registrado = $this->dao->registrarCuenta($tipo, $nombres, $apellidos, $telefono, $correo, $clave);

            if ($registrado) {
                echo "<script>alert('¡Registro exitoso!'); window.location.href='index.php?controller=login';</script>";
            } else {
                echo "<script>alert('Error al registrar. Revisa los datos o si el correo ya existe.'); window.location.href='index.php?controller=register';</script>";
            }
        }
    }
}




