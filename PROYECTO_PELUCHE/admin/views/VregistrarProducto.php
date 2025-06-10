<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Registrar Producto</title>
    <link rel="stylesheet" href="Style/estilo_registro.css" />
</head>
<body>
    <h2>Registrar Producto</h2>

    <?php if (!empty($error)): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php elseif (!empty($_GET['msg']) && $_GET['msg'] === 'success'): ?>
        <div class="msg-success">Producto registrado correctamente.</div>
    <?php endif; ?>

    <form method="POST" action="index.php?controller=producto&action=guardar">
        <label for="id_franquicia">Franquicia</label>
        <select id="id_franquicia" name="id_franquicia" required>
            <option value="">-- Seleccionar franquicia --</option>
            <?php foreach ($franquicias as $f): ?>
                <option value="<?= $f['id_franquicia'] ?>" <?= (isset($_POST['id_franquicia']) && $_POST['id_franquicia'] == $f['id_franquicia']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($f['nombre_fran']) ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="nombre_prod">Nombre del Producto</label>
        <input type="text" id="nombre_prod" name="nombre_prod" value="<?= htmlspecialchars($_POST['nombre_prod'] ?? '') ?>" required />

        <label for="descripcion">Descripción</label>
        <textarea id="descripcion" name="descripcion" required><?= htmlspecialchars($_POST['descripcion'] ?? '') ?></textarea>

        <label for="altura">Altura</label>
        <input type="text" id="altura" name="altura" value="<?= htmlspecialchars($_POST['altura'] ?? '') ?>" />

        <label for="color">Color</label>
        <input type="text" id="color" name="color" value="<?= htmlspecialchars($_POST['color'] ?? '') ?>" />

        <label for="stock">Stock</label>
        <input type="number" id="stock" name="stock" min="1" value="<?= htmlspecialchars($_POST['stock'] ?? '1') ?>" required />

        <label for="precio">Precio</label>
        <input type="number" step="0.01" min="0.01" id="precio" name="precio" value="<?= htmlspecialchars($_POST['precio'] ?? '') ?>" required />

        <label for="imagen">Nombre archivo imagen</label>
        <input type="text" id="imagen" name="imagen" value="<?= htmlspecialchars($_POST['imagen'] ?? '') ?>" placeholder="ejemplo.png" />

        <button type="submit">Registrar Producto</button>
        <a href="index.php?controller=dashboard&action=index" class="btn-volver">Volver al Dashboard</a>
    </form>
</body>
</html>

