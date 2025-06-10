<?php
require_once(__DIR__ . '/../../config/database.php');

class DAOProducto {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::connect();
    }

    public function crearProducto($id_franquicia, $nombre_prod, $descripcion, $altura, $color, $stock, $precio, $imagen) {
        $sql = "INSERT INTO productos 
                (id_franquicia, nombre_prod, descripcion, altura, color, stock, precio, imagen, estado_activo) 
                VALUES 
                (:id_franquicia, :nombre_prod, :descripcion, :altura, :color, :stock, :precio, :imagen, 1)";
        $stmt = $this->pdo->prepare($sql);

        $stmt->bindParam(':id_franquicia', $id_franquicia);
        $stmt->bindParam(':nombre_prod', $nombre_prod);
        $stmt->bindParam(':descripcion', $descripcion);
        $stmt->bindParam(':altura', $altura ?: null);  
        $stmt->bindParam(':color', $color ?: null);    
        $stmt->bindParam(':stock', $stock, PDO::PARAM_INT);
        $stmt->bindParam(':precio', $precio);
        $stmt->bindParam(':imagen', $imagen ?: null); 

        return $stmt->execute();
    }

    public function obtenerProductoPorId($id) {
        $sql = "SELECT * FROM productos WHERE id_producto = :id AND estado_activo = 1";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

public function actualizarProducto($id_producto, $id_franquicia, $nombre_prod, $descripcion, $altura, $color, $stock, $precio, $imagen) {
    $sql = "UPDATE productos SET 
                id_franquicia = :id_franquicia,
                nombre_prod = :nombre_prod,
                descripcion = :descripcion,
                altura = :altura,
                color = :color,
                stock = :stock,
                precio = :precio,
                imagen = :imagen
            WHERE id_producto = :id_producto";

    $stmt = $this->pdo->prepare($sql);
    $stmt->bindParam(':id_producto', $id_producto, PDO::PARAM_INT);
    $stmt->bindParam(':id_franquicia', $id_franquicia);
    $stmt->bindParam(':nombre_prod', $nombre_prod);
    $stmt->bindParam(':descripcion', $descripcion);
    $stmt->bindParam(':altura', $altura);
    $stmt->bindParam(':color', $color);
    $stmt->bindParam(':stock', $stock);
    $stmt->bindParam(':precio', $precio);
    $stmt->bindParam(':imagen', $imagen);

    return $stmt->execute();
}

    public function obtenerProductosActivos() {
$sql = "SELECT p.*, f.nombre_fran AS nombre_franquicia 
        FROM productos p
        INNER JOIN franquicias f ON p.id_franquicia = f.id_franquicia
        WHERE p.estado_activo = 1
        ORDER BY p.id_producto DESC";
        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function desactivarProducto($id_producto) {
        $sql = "UPDATE productos SET estado_activo = 0 WHERE id_producto = :id_producto";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindParam(':id_producto', $id_producto, PDO::PARAM_INT);
        return $stmt->execute();
    }

}

