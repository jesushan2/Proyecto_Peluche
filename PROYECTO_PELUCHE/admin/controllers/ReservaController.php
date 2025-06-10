<?php
require_once(__DIR__ . '/../models/DAOreserva.php');

class ReservaController {
    private $reservaModel;

    public function __construct() {
        $this->reservaModel = new DAOreserva();
    }

    public function index() {
        $this->listar();
    }

    public function listar() {
        $reservas = $this->reservaModel->obtenerReservas();
        require_once(__DIR__ . '/../views/VlistarReserva.php');
    }

    public function listarVista() {
        $reservas = $this->reservaModel->obtenerReservas();
        require_once(__DIR__ . '/../views/VvistaReserva.php');
    }

    public function editar() {
        if (!isset($_GET['id'])) {
            header('Location: index.php?controller=reserva&action=listar');
            exit();
        }

        $id = intval($_GET['id']);
        $reserva = $this->reservaModel->obtenerReservaPorId($id);

        if (!$reserva) {
            header('Location: index.php?controller=reserva&action=listar');
            exit();
        }

        $estados = $this->reservaModel->obtenerEstadosReserva();
        $vendedores = $this->reservaModel->obtenerVendedores();

        require_once(__DIR__ . '/../views/VeditarReserva.php');
    }

    public function actualizar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = intval($_POST['id_reserva']);
            $id_estado = intval($_POST['id_estado']);
            $id_vendedor = !empty($_POST['id_vendedor']) ? intval($_POST['id_vendedor']) : null;

            $this->reservaModel->actualizarReserva($id, $id_estado, $id_vendedor);

            header('Location: index.php?controller=reserva&action=listar');
            exit();
        }
    }

    public function desactivar() {
        if (!isset($_GET['id'])) {
            header('Location: index.php?controller=reserva&action=listar');
            exit();
        }

        $id = intval($_GET['id']);
        $this->reservaModel->desactivarReserva($id);

        header('Location: index.php?controller=reserva&action=listar');
        exit();
    }
}

