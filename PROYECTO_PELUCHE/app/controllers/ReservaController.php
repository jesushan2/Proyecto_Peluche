<?php
require_once __DIR__ . '/../models/DAOreserva.php';

class ReservaController {
    private $modelo;

    public function __construct() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        if (!isset($_SESSION['carrito'])) {
            $_SESSION['carrito'] = [];
        }

        $this->modelo = new DAOreserva();
    }

    public function agregar() {
        if (isset($_GET['id'])) {
            $idProducto = intval($_GET['id']);

            if (isset($_SESSION['carrito'][$idProducto])) {
                $_SESSION['carrito'][$idProducto]['cantidad'] += 1;
            } else {
                $producto = $this->modelo->obtenerProductoPorId($idProducto);
                if ($producto) {
                    $_SESSION['carrito'][$idProducto] = [
                        'id_producto' => $producto['id_producto'],
                        'nombre'     => $producto['nombre_prod'],
                        'precio'     => $producto['precio'],
                        'imagen'     => $producto['imagen'],
                        'cantidad'   => 1
                    ];
                }
            }
        }

        header('Location: index.php?controller=producto&action=catalogo');
        exit();
    }

    public function verCarrito() {
        require_once __DIR__ . '/../views/reserva/carrito.php';
    }

    public function eliminar() {
        if (isset($_GET['id'])) {
            $id = intval($_GET['id']);
            if (isset($_SESSION['carrito'][$id])) {
                unset($_SESSION['carrito'][$id]);
                $_SESSION['mensaje'] = "Producto eliminado del carrito.";
            } else {
                $_SESSION['error'] = "Producto no encontrado en el carrito.";
            }
        }

        header('Location: index.php?controller=reserva&action=verCarrito');
        exit();
    }

   public function procesarReserva() {
    if (!isset($_SESSION['usuario'])) {
        $_SESSION['error'] = "Debes iniciar sesión para procesar la reserva.";
        header("Location: index.php?controller=login&action=index");
        exit();
    }

    if (empty($_SESSION['carrito'])) {
        $_SESSION['error'] = "El carrito está vacío.";
        header("Location: index.php?controller=reserva&action=verCarrito");
        exit();
    }

    try {
        $this->modelo->conexion->beginTransaction();

        $id_usuario = $_SESSION['usuario']['id_usuario'];
        $id_estado = 1; 

        $total = 0;
        foreach ($_SESSION['carrito'] as $item) {
            $subtotal = $item['precio'] * $item['cantidad'];
            $total += $subtotal;
        }

        $id_reserva = $this->modelo->insertarReserva($id_usuario, $id_estado, $total);

        foreach ($_SESSION['carrito'] as $item) {
            $stock = $this->modelo->obtenerStockProducto($item['id_producto']);
            if ($stock < $item['cantidad']) {
                throw new Exception("Stock insuficiente para el producto '{$item['nombre']}'");
            }

            $this->modelo->insertarDetalleReserva($id_reserva, $item['id_producto'], $item['cantidad'], $item['precio']);
            $this->modelo->actualizarStockProducto($item['id_producto'], $item['cantidad']);
        }

        $this->modelo->conexion->commit();

        $_SESSION['carrito'] = [];
        $_SESSION['mensaje'] = "¡Reserva procesada con éxito!";

    } catch (Exception $e) {
        $this->modelo->conexion->rollBack();
        $_SESSION['error'] = "Error al procesar reserva: " . $e->getMessage();
    }

    header("Location: index.php?controller=reserva&action=verCarrito");
    exit();
}

}

