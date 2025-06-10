<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Registrar Franquicia</title>
    <link rel="stylesheet" href="Style/estilo_registro.css" />
</head>
<body>
    <h2>Registrar Franquicia</h2>

    <?php if (!empty($error)): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php elseif (!empty($_GET['msg']) && $_GET['msg'] === 'success'): ?>
        <div class="msg-success">Franquicia registrada correctamente.</div>
    <?php endif; ?>

    <form method="POST" action="index.php?controller=franquicia&action=guardar">
        <label for="nombre_fran">Nombre de la Franquicia</label>
        <input type="text" id="nombre_fran" name="nombre_fran" value="<?= htmlspecialchars($_POST['nombre_fran'] ?? '') ?>" required />
        <button type="submit">Registrar</button>
        <a href="index.php?controller=dashboard&action=index" class="btn-volver">Volver al Dashboard</a>
    </form>
</body>
</html>

