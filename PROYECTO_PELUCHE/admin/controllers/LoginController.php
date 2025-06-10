<?php
require_once(__DIR__ . '/../models/DAOlogin.php');

class LoginController {
    public function index() {
        require_once(__DIR__ . '/../views/Vlogin.php');
    }

    public function validar() {
        $correo = $_POST['correo'] ?? '';
        $clave = $_POST['clave'] ?? '';

        $modelo = new DAOlogin();
        $usuario = $modelo->verificarCredenciales($correo, $clave);

        if ($usuario) {
            if (session_status() === PHP_SESSION_NONE) {
                session_start();
            }
            $_SESSION['usuario_nombre'] = $usuario['nombre']; 
            $_SESSION['usuario_rol'] = $usuario['rol'];

            header('Location: index.php?controller=dashboard&action=index');
            exit();
        } else {
            $error = "Correo o clave incorrectos";
            require_once(__DIR__ . '/../views/Vlogin.php');
        }

    }

    public function cerrarSesion() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
        session_destroy();
        header('Location: index.php?controller=login&action=index');
        exit();
    }

    public function register() {
        require_once(__DIR__ . '/../views/Vregister.php');
    }
    

}
