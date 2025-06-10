<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Administradores</title>
    <link rel="stylesheet" href="Style/estilo_lista.css">
</head>
<body>
    <h2>Lista de Administradores</h2>

    <?php if (!empty($_GET['msg']) && $_GET['msg'] === 'updated'): ?>
        <div class="msg-success">Administrador actualizado correctamente.</div>
    <?php elseif (!empty($_GET['msg']) && $_GET['msg'] === 'deleted'): ?>
        <div class="msg-success">Administrador eliminado correctamente.</div>
    <?php endif; ?>

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
            <?php foreach ($administradores as $admin): ?>
                <tr>
                    <td><?= htmlspecialchars($admin['id_admin']) ?></td>
                    <td><?= htmlspecialchars($admin['nombres']) ?></td>
                    <td><?= htmlspecialchars($admin['apellidos']) ?></td>
                    <td><?= htmlspecialchars($admin['telefono']) ?></td>
                    <td><?= htmlspecialchars($admin['correo']) ?></td>
                    <td>
                        <a href="index.php?controller=administrador&action=editar&id=<?= $admin['id_admin'] ?>">Editar</a> |
                        <a href="index.php?controller=administrador&action=eliminar&id=<?= $admin['id_admin'] ?>" onclick="return confirm('¿Estás seguro de eliminar este administrador?')">Eliminar</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <br>
    <button><a href="index.php?controller=dashboard&action=index">Volver al Dashboard</a></button>
</body>
</html>
