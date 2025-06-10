<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Franquicia</title>
    <link rel="stylesheet" href="Style/estilo_editar.css">
</head>
<body>
    <h2>Editar Franquicia</h2>

    <?php if (isset($error)): ?>
        <p style="color:red;"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="POST" action="index.php?controller=franquicia&action=actualizar">
        <input type="hidden" name="id_franquicia" value="<?= htmlspecialchars($franquicia['id_franquicia']) ?>">

        <label for="nombre_fran">Nombre de la Franquicia:</label><br>
        <input type="text" id="nombre_fran" name="nombre_fran" value="<?= htmlspecialchars($franquicia['nombre_fran']) ?>" required><br><br>

        <div style="display: flex; gap: 10px;">
    <button type="submit">Actualizar</button>
    <button type="button" onclick="window.location.href='index.php?controller=dashboard&action=index'">Volver al Dashboard</button>
    <button type="button" onclick="window.location.href='index.php?controller=franquicia&action=listar'">Cancelar Cambios</button>
</div>
</form>
</body>
</html>

