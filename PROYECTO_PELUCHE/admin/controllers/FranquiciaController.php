<?php
require_once(__DIR__ . '/../models/DAOFranquicia.php');

class FranquiciaController {

    public function index() {
        $this->listar();
    }

    public function mostrarFormulario() {
        require_once(__DIR__ . '/../views/VregistrarFranquicia.php');
    }

    public function guardar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $nombre_fran = trim($_POST['nombre_fran'] ?? '');

            if ($nombre_fran === '') {
                $error = "El nombre de la franquicia es obligatorio.";
                require_once(__DIR__ . '/../views/VregistrarFranquicia.php');
                return;
            }

            $dao = new DAOFranquicia();
            if ($dao->crearFranquicia($nombre_fran)) {
                header("Location: index.php?controller=franquicia&action=listar&msg=success");
                exit();
            } else {
                $error = "Error al guardar la franquicia.";
                require_once(__DIR__ . '/../views/VregistrarFranquicia.php');
            }
        }
    }

    public function listar() {
        $dao = new DAOFranquicia();
        $franquicias = $dao->obtenerFranquiciasActivas();
        require_once(__DIR__ . '/../views/VlistarFranquicias.php');
    }

    public function editar() {
        $id = $_GET['id'] ?? null;
        if (!$id) {
            header("Location: index.php?controller=franquicia&action=listar");
            exit();
        }
        $dao = new DAOFranquicia();
        $franquicia = $dao->obtenerFranquiciaPorId($id);
        if (!$franquicia) {
            header("Location: index.php?controller=franquicia&action=listar");
            exit();
        }
        require_once(__DIR__ . '/../views/VeditarFranquicia.php');
    }

    public function actualizar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id_franquicia'] ?? null;
            $nombre_fran = trim($_POST['nombre_fran'] ?? '');

            if (!$id || $nombre_fran === '') {
                $error = "Todos los campos son obligatorios.";
                $franquicia = ['id_franquicia' => $id, 'nombre_fran' => $nombre_fran];
                require_once(__DIR__ . '/../views/VeditarFranquicia.php');
                return;
            }

            $dao = new DAOFranquicia();
            if ($dao->actualizarFranquicia($id, $nombre_fran)) {
                header("Location: index.php?controller=franquicia&action=listar&msg=updated");
                exit();
            } else {
                $error = "Error al actualizar la franquicia.";
                $franquicia = ['id_franquicia' => $id, 'nombre_fran' => $nombre_fran];
                require_once(__DIR__ . '/../views/VeditarFranquicia.php');
            }
        }
    }

    public function eliminar() {
        $id = $_GET['id'] ?? null;
        if ($id) {
            $dao = new DAOFranquicia();
            $dao->eliminarFranquicia($id);
        }
        header("Location: index.php?controller=franquicia&action=listar&msg=deleted");
        exit();
    }

    public function listarVista() {
        require_once 'models/DAOFranquicia.php';
        $dao = new DAOFranquicia();
        $franquicias = $dao->listarTodos();
        require_once 'views/VvistaFranquicia.php';
    }
    
}


