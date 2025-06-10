<?php
require_once(__DIR__ . '/../models/DAOusuario.php');

class UsuarioController {
    private $usuarioModel;

    public function __construct() {
        $this->usuarioModel = new DAOusuario();
    }

    public function listar() {
        $usuarios = $this->usuarioModel->obtenerUsuarios();
        require_once(__DIR__ . '/../views/VlistarUsuario.php');
    }

    public function editar() {
        if (!isset($_GET['id'])) {
            header('Location: index.php?controller=usuario&action=listar');
            exit();
        }

        $id = intval($_GET['id']);
        $usuario = $this->usuarioModel->obtenerUsuarioPorId($id);

        if (!$usuario) {
            header('Location: index.php?controller=usuario&action=listar');
            exit();
        }

        require_once(__DIR__ . '/../views/VeditarUsuario.php');
    }

    public function actualizar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = intval($_POST['id_usuario']);
            $nombres = $_POST['nombres'];
            $apellidos = $_POST['apellidos'];
            $telefono = $_POST['telefono'];
            $correo = $_POST['correo'];

            $this->usuarioModel->actualizarUsuario($id, $nombres, $apellidos, $telefono, $correo);

            header('Location: index.php?controller=usuario&action=listar');
            exit();
        }
    }

    public function desactivar() {
        if (!isset($_GET['id'])) {
            header('Location: index.php?controller=usuario&action=listar');
            exit();
        }

        $id = intval($_GET['id']);
        $this->usuarioModel->desactivarUsuario($id);

        header('Location: index.php?controller=usuario&action=listar');
        exit();
    }

    public function listarVista() {
        require_once 'models/DAOusuario.php';
        $dao = new DAOusuario();
        $usuarios = $dao->listarTodos();
        require_once 'views/VvistaUsuario.php';
    }
}


