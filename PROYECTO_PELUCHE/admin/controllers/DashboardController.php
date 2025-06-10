<?php
class DashboardController {
    public function index() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        if (!isset($_SESSION['usuario_nombre']) || !isset($_SESSION['usuario_rol'])) {
            header('Location: index.php?controller=login&action=index');
            exit();
        }

        require_once(__DIR__ . '/../views/Vdashboard.php');
    }
}
