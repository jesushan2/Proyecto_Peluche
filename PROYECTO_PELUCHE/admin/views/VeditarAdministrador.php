<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Administrador</title>
    <link rel="stylesheet" href="Style/estilo_editar.css">
</head>
<body>
    <h2>Editar Administrador</h2>

    <?php if (!empty($error)): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form method="POST" action="index.php?controller=administrador&action=actualizar">
        <input type="hidden" name="id_admin" value="<?= htmlspecialchars($administrador['id_admin']) ?>">

        <label for="nombres">Nombres</label>
        <input type="text" id="nombres" name="nombres" value="<?= htmlspecialchars($administrador['nombres']) ?>" required>

        <label for="apellidos">Apellidos</label>
        <input type="text" id="apellidos" name="apellidos" value="<?= htmlspecialchars($administrador['apellidos']) ?>" required>

        <label for="telefono">Teléfono</label>
        <input type="text" id="telefono" name="telefono" value="<?= htmlspecialchars($administrador['telefono']) ?>" required>

        <label for="correo">Correo</label>
        <input type="email" id="correo" name="correo" value="<?= htmlspecialchars($administrador['correo']) ?>" required>

        <label for="clave">Clave</label>
        <input type="password" id="clave" name="clave" value="<?= htmlspecialchars($administrador['clave']) ?>" required>

        <div style="display: flex; gap: 10px;">
    <button type="submit">Actualizar</button>
    <button type="button" onclick="window.location.href='index.php?controller=dashboard&action=index'">Volver al Dashboard</button>
    <button type="button" onclick="window.location.href='index.php?controller=administrador&action=index'">Cancelar Cambios</button>

</div>
</form>
</body>
</html>
