<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Vendedores</title>
    <link rel="stylesheet" href="Style/estilo_lista.css">
</head>
<body>
    <h1>Vendedores Registrados</h1>

    <table border="1" cellpadding="10">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Teléfono</th>
                <th>Correo</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($vendedores as $vendedor): ?>
            <tr>
                <td><?= htmlspecialchars($vendedor['id_vendedor']) ?></td>
                <td><?= htmlspecialchars($vendedor['nombres']) ?></td>
                <td><?= htmlspecialchars($vendedor['apellidos']) ?></td>
                <td><?= htmlspecialchars($vendedor['telefono']) ?></td>
                <td><?= htmlspecialchars($vendedor['correo']) ?></td>
                <td>
                    <a href="index.php?controller=vendedor&action=editar&id=<?= $vendedor['id_vendedor'] ?>">Editar</a> |
                    <a href="index.php?controller=vendedor&action=desactivar&id=<?= $vendedor['id_vendedor'] ?>" onclick="return confirm('¿Seguro que deseas desactivar este vendedor?');">Desactivar</a>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>

    <br>
    <button><a href="index.php?controller=dashboard&action=index">Volver al Dashboard</a></button>
</body>
</html>
