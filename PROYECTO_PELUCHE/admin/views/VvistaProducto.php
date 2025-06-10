<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Productos</title>
    <link rel="stylesheet" href="Style/estilo_lista.css">
</head>
<body>
    <h1>Productos Registrados</h1>

    <table border="1" cellpadding="10">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Franquicia</th>
                <th>Descripción</th>
                <th>Altura</th>
                <th>Color</th>
                <th>Stock</th>
                <th>Precio</th>
                <th>Imagen</th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($productos as $producto): ?>
            <tr>
                <td><?= htmlspecialchars($producto['id_producto']) ?></td>
                <td><?= htmlspecialchars($producto['nombre_prod']) ?></td>
                <td><?= htmlspecialchars($producto['nombre_franquicia']) ?></td>
                <td><?= htmlspecialchars($producto['descripcion']) ?></td>
                <td><?= htmlspecialchars($producto['altura']) ?></td>
                <td><?= htmlspecialchars($producto['color']) ?></td>
                <td><?= htmlspecialchars($producto['stock']) ?></td>
                <td><?= htmlspecialchars($producto['precio']) ?></td>
                <td>
                    <?php if (!empty($producto['imagen'])): ?>
                        <img src="image/<?= htmlspecialchars($producto['imagen']) ?>" width="60" height="60">
                    <?php else: ?>
                        Sin imagen
                    <?php endif; ?>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    <br>
    <button><a href="index.php?controller=dashboard&action=index">Volver al Dashboard</a></button>
</body>
</html>