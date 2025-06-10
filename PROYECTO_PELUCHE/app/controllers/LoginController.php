<?php
class LoginController {
    private $conexion;

    public function __construct() {
        require_once __DIR__ . '/../../config/database.php';
        require_once __DIR__ . '/../models/DAOlogin.php';  
        $this->conexion = Database::connect();  
    }
    public function index() {
        require_once 'app/views/login/index.php';
    }

    public function login() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $correo = $_POST['correo'] ?? '';
            $contrasena = $_POST['contrasena'] ?? '';
            $usuario = DAOlogin::obtenerPorCorreo($this->conexion, $correo);

            if ($usuario) {
                if ($contrasena === $usuario['contraseña']) {
                    if (session_status() === PHP_SESSION_NONE) {
                        session_start();
                    }
                    $_SESSION['usuario'] = $usuario;
                    header('Location: index.php?controller=home&action=index');
                    exit();
                } else {
                    $error = "Correo o contraseña incorrectos.";
                    require_once 'app/views/login/index.php';
                }
            } else {
                $error = "Correo o contraseña incorrectos.";
                require_once 'app/views/login/index.php';
            }
        } else {
            header('Location: index.php?controller=login&action=index');
            exit();
        }
    }

    public function logout() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
        session_destroy();
        header('Location: index.php?controller=login&action=index');
        exit();
    }
}
