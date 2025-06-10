<?php
require_once(__DIR__ . '/../models/DAOProducto.php');
require_once(__DIR__ . '/../models/DAOFranquicia.php');

class ProductoController {

    public function index() {
        $daoFranquicia = new DAOFranquicia();
        $franquicias = $daoFranquicia->obtenerFranquiciasActivas();
        require_once(__DIR__ . '/../views/VregistrarProducto.php');
    }

    public function guardar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id_franquicia = $_POST['id_franquicia'] ?? '';
            $nombre_prod = trim($_POST['nombre_prod'] ?? '');
            $descripcion = trim($_POST['descripcion'] ?? '');
            $altura = trim($_POST['altura'] ?? '');
            $color = trim($_POST['color'] ?? '');
            $stock = intval($_POST['stock'] ?? 0);
            $precio = floatval($_POST['precio'] ?? 0);
            $imagen = trim($_POST['imagen'] ?? '');

            if ($id_franquicia === '' || $nombre_prod === '' || $descripcion === '' || $stock <= 0 || $precio <= 0) {
                $error = "Por favor, completa todos los campos obligatorios correctamente.";
                $daoFranquicia = new DAOFranquicia();
                $franquicias = $daoFranquicia->obtenerFranquiciasActivas();
                require_once(__DIR__ . '/../views/VregistrarProducto.php');
                return;
            }

            $dao = new DAOProducto();
            if ($dao->crearProducto($id_franquicia, $nombre_prod, $descripcion, $altura, $color, $stock, $precio, $imagen)) {
                header("Location: index.php?controller=producto&action=index&msg=success");
                exit();
            } else {
                $error = "Error al guardar el producto.";
                $daoFranquicia = new DAOFranquicia();
                $franquicias = $daoFranquicia->obtenerFranquiciasActivas();
                require_once(__DIR__ . '/../views/VregistrarProducto.php');
            }
        }
    }

    public function mostrarFormulario() {
        $daoFranquicia = new DAOFranquicia();
        $franquicias = $daoFranquicia->obtenerFranquiciasActivas();
        require_once(__DIR__ . '/../views/VregistrarProducto.php');
    }

    public function listar() {
        $daoProducto = new DAOProducto();
        $productos = $daoProducto->obtenerProductosActivos(); 
        require_once(__DIR__ . '/../views/VlistarProducto.php'); 
    }

    public function listarVista() {
        $daoProducto = new DAOProducto();
        $productos = $daoProducto->obtenerProductosActivos(); 
        require_once(__DIR__ . '/../views/VvistaProducto.php'); 
    }

    public function editar() {
        $id = $_GET['id'] ?? null;
        if (!$id) {
            header("Location: index.php?controller=producto&action=index");
            exit();
        }
        $daoProducto = new DAOProducto();
        $producto = $daoProducto->obtenerProductoPorId($id);
        if (!$producto) {
            header("Location: index.php?controller=producto&action=index");
            exit();
        }
        $daoFranquicia = new DAOFranquicia();
        $franquicias = $daoFranquicia->obtenerFranquiciasActivas();

        require_once(__DIR__ . '/../views/VeditarProducto.php');
    }

    public function actualizar() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id_producto = $_POST['id_producto'] ?? null;
            $id_franquicia = $_POST['id_franquicia'] ?? '';
            $nombre_prod = trim($_POST['nombre_prod'] ?? '');
            $descripcion = trim($_POST['descripcion'] ?? '');
            $altura = trim($_POST['altura'] ?? '');
            $color = trim($_POST['color'] ?? '');
            $stock = intval($_POST['stock'] ?? 0);
            $precio = floatval($_POST['precio'] ?? 0);
            $imagen = trim($_POST['imagen'] ?? '');

            if (!$id_producto || $id_franquicia === '' || $nombre_prod === '' || $descripcion === '' || $stock <= 0 || $precio <= 0) {
                $error = "Por favor, completa todos los campos obligatorios correctamente.";
                $producto = [
                    'id_producto' => $id_producto,
                    'id_franquicia' => $id_franquicia,
                    'nombre_prod' => $nombre_prod,
                    'descripcion' => $descripcion,
                    'altura' => $altura,
                    'color' => $color,
                    'stock' => $stock,
                    'precio' => $precio,
                    'imagen' => $imagen
                ];
                $daoFranquicia = new DAOFranquicia();
                $franquicias = $daoFranquicia->obtenerFranquiciasActivas();
                require_once(__DIR__ . '/../views/VeditarProducto.php');
                return;
            }

            $daoProducto = new DAOProducto();
            if ($daoProducto->actualizarProducto($id_producto, $id_franquicia, $nombre_prod, $descripcion, $altura, $color, $stock, $precio, $imagen)) {
                header("Location: index.php?controller=producto&action=listar&msg=updated");
                exit();
            } else {
                $error = "Error al actualizar el producto.";
                $producto = [
                    'id_producto' => $id_producto,
                    'id_franquicia' => $id_franquicia,
                    'nombre_prod' => $nombre_prod,
                    'descripcion' => $descripcion,
                    'altura' => $altura,
                    'color' => $color,
                    'stock' => $stock,
                    'precio' => $precio,
                    'imagen' => $imagen
                ];
                $daoFranquicia = new DAOFranquicia();
                $franquicias = $daoFranquicia->obtenerFranquiciasActivas();
                require_once(__DIR__ . '/../views/VeditarProducto.php');
            }
        }
    }

}


