<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="Style/estilo_editar.css">
</head>
<body>
    <h1>Editar Usuario</h1>

    <form action="index.php?controller=usuario&action=actualizar" method="POST">
        <input type="hidden" name="id_usuario" value="<?= htmlspecialchars($usuario['id_usuario']) ?>">

        <label for="nombres">Nombres:</label><br>
        <input type="text" id="nombres" name="nombres" value="<?= htmlspecialchars($usuario['nombres']) ?>" required><br><br>

        <label for="apellidos">Apellidos:</label><br>
        <input type="text" id="apellidos" name="apellidos" value="<?= htmlspecialchars($usuario['apellidos']) ?>" required><br><br>

        <label for="telefono">Teléfono:</label><br>
        <input type="text" id="telefono" name="telefono" value="<?= htmlspecialchars($usuario['telefono']) ?>" required><br><br>

        <label for="correo">Correo:</label><br>
        <input type="email" id="correo" name="correo" value="<?= htmlspecialchars($usuario['correo']) ?>" required><br><br>


    <div style="display: flex; gap: 10px;">
    <button type="submit">Guardar Cambios</button>
    <button type="button" onclick="window.location.href='index.php?controller=dashboard&action=index'">Volver al Dashboard</button>
    <button type="button" onclick="window.location.href='index.php?controller=usuario&action=listar'">Cancelar Cambios</button>
</div>
</form>
    
</body>
</html>



