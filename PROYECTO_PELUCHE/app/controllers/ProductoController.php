<?php
require_once __DIR__ . '/../models/DAOproducto.php';

class ProductoController {

    public function catalogo() {
        $productoModel = new DAOproducto();
        $productos = $productoModel->obtenerProductosConFranquicia();
        require_once __DIR__ . '/../views/producto/catalogo.php';
    }

}

