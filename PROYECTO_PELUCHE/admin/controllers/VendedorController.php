<?php
require_once(__DIR__ . '/../models/DAOvendedor.php');

class VendedorController {
    private $vendedorModel;

    public function __construct() {
        $this->vendedorModel = new DAOvendedor();
    }
    public function index() {
        $this->listar();
    }

    public function listar() {
        $vendedores = $this->vendedorModel->obtenerVendedores();
        require_once(__DIR__ . '/../views/VlistarVendedor.php');
    }

    public function editar() {
        if (!isset($_GET['id'])) {
            header('Location: index.php?controller=vendedor&action=listar');
            exit();
        }

        $id = intval($_GET['id']);
        $vendedor = $this->vendedorModel->obtenerVendedorPorId($id);

        if (!$vendedor) {
            header('Location: index.php?controller=vendedor&action=listar');
            exit();
        }

        require_once(__DIR__ . '/../views/VeditarVendedor.php');
    }

    public function actualizar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = intval($_POST['id_vendedor']);
            $nombres = $_POST['nombres'];
            $apellidos = $_POST['apellidos'];
            $telefono = $_POST['telefono'];
            $correo = $_POST['correo'];

            $this->vendedorModel->actualizarVendedor($id, $nombres, $apellidos, $telefono, $correo);

            header('Location: index.php?controller=vendedor&action=listar');
            exit();
        }
    }

    public function desactivar() {
        if (!isset($_GET['id'])) {
            header('Location: index.php?controller=vendedor&action=listar');
            exit();
        }

        $id = intval($_GET['id']);
        $this->vendedorModel->desactivarVendedor($id);

        header('Location: index.php?controller=vendedor&action=listar');
        exit();
    }

    public function listarVista() {
        require_once 'models/DAOvendedor.php';
        $dao = new DAOvendedor();
        $vendedores = $dao->listarTodos();
        require_once 'views/VvistaVendedor.php';
    }
}

