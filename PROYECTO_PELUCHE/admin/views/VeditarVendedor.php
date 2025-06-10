<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Vendedor</title>
    <link rel="stylesheet" href="Style/estilo_editar.css">
</head>
<body>
    <h1>Editar Vendedor</h1>

    <form action="index.php?controller=vendedor&action=actualizar" method="POST">
        <input type="hidden" name="id_vendedor" value="<?= htmlspecialchars($vendedor['id_vendedor']) ?>">

        <label for="nombres">Nombres:</label><br>
        <input type="text" id="nombres" name="nombres" value="<?= htmlspecialchars($vendedor['nombres']) ?>" required><br><br>

        <label for="apellidos">Apellidos:</label><br>
        <input type="text" id="apellidos" name="apellidos" value="<?= htmlspecialchars($vendedor['apellidos']) ?>" required><br><br>

        <label for="telefono">Teléfono:</label><br>
        <input type="text" id="telefono" name="telefono" value="<?= htmlspecialchars($vendedor['telefono']) ?>" required><br><br>

        <label for="correo">Correo:</label><br>
        <input type="email" id="correo" name="correo" value="<?= htmlspecialchars($vendedor['correo']) ?>" required><br><br>

   
<div style="display: flex; gap: 10px;">
    <button type="submit">Guardar Cambios</button>
    <button type="button" onclick="window.location.href='index.php?controller=dashboard&action=index'">Volver al Dashboard</button>
    <button type="button" onclick="window.location.href='index.php?controller=vendedor&action=listar'">Cancelar Cambios</button>
</div>
</form>
    
</body>
</html>