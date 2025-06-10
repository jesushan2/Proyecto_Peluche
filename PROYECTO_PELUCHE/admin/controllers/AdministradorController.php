<?php
require_once(__DIR__ . '/../models/DAOAdministrador.php');

class AdministradorController {

    public function index() {
        $dao = new DAOAdministrador();
        $administradores = $dao->obtenerAdministradoresActivos();
        require_once(__DIR__ . '/../views/VlistarAdministradores.php');
    }

    public function editar() {
        $id_admin = $_GET['id'] ?? null;
        if (!$id_admin) {
            header("Location: index.php?controller=administrador&action=index");
            exit();
        }

        $dao = new DAOAdministrador();
        $administrador = $dao->obtenerAdministradorPorId($id_admin);
        require_once(__DIR__ . '/../views/VeditarAdministrador.php');
    }

    public function actualizar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id_admin = $_POST['id_admin'] ?? '';
            $nombres = trim($_POST['nombres'] ?? '');
            $apellidos = trim($_POST['apellidos'] ?? '');
            $telefono = trim($_POST['telefono'] ?? '');
            $correo = trim($_POST['correo'] ?? '');
            $clave = trim($_POST['clave'] ?? '');

            if ($id_admin === '' || $nombres === '' || $apellidos === '' || $telefono === '' || $correo === '' || $clave === '') {
                $error = "Por favor, completa todos los campos obligatorios.";
                $dao = new DAOAdministrador();
                $administrador = $dao->obtenerAdministradorPorId($id_admin);
                require_once(__DIR__ . '/../views/VeditarAdministrador.php');
                return;
            }

            $dao = new DAOAdministrador();
            if ($dao->actualizarAdministrador($id_admin, $nombres, $apellidos, $telefono, $correo, $clave)) {
                header("Location: index.php?controller=administrador&action=index&msg=updated");
                exit();
            } else {
                $error = "Error al actualizar el administrador.";
                $administrador = $dao->obtenerAdministradorPorId($id_admin);
                require_once(__DIR__ . '/../views/VeditarAdministrador.php');
            }
        }
    }

    public function eliminar() {
        $id_admin = $_GET['id'] ?? null;
        if (!$id_admin) {
            header("Location: index.php?controller=administrador&action=index");
            exit();
        }

        $dao = new DAOAdministrador();
        if ($dao->eliminarAdministrador($id_admin)) {
            header("Location: index.php?controller=administrador&action=index&msg=deleted");
            exit();
        } else {
            $error = "Error al eliminar el administrador.";
            $administradores = $dao->obtenerAdministradoresActivos();
            require_once(__DIR__ . '/../views/VlistarAdministradores.php');
        }
    }

    public function listarVista() {
        require_once 'models/DAOadministrador.php';
        $dao = new DAOadministrador();
        $administradores = $dao->listarTodos();
        require_once 'views/VvistaAdministrador.php';
    }
    
}
