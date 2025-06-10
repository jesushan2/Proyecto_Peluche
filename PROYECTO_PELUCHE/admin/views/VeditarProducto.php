<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Editar Producto</title>
    <link rel="stylesheet" href="Style/estiloProducto.css" />
</head>
<body>
    <h2>Editar Producto</h2>

    <?php if (!empty($error)): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form method="POST" action="index.php?controller=producto&action=actualizar">
        <input type="hidden" name="id_producto" value="<?= htmlspecialchars($producto['id_producto']) ?>" />

        <label for="id_franquicia">Franquicia</label>
        <select id="id_franquicia" name="id_franquicia" required>
            <option value="">-- Seleccionar franquicia --</option>
            <?php foreach ($franquicias as $f): ?>
                <option value="<?= $f['id_franquicia'] ?>" <?= ($producto['id_franquicia'] == $f['id_franquicia']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($f['nombre_fran']) ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="nombre_prod">Nombre del Producto</label>
        <input type="text" id="nombre_prod" name="nombre_prod" value="<?= htmlspecialchars($producto['nombre_prod']) ?>" required />

        <label for="descripcion">Descripción</label>
        <textarea id="descripcion" name="descripcion" required><?= htmlspecialchars($producto['descripcion']) ?></textarea>

        <label for="altura">Altura</label>
        <input type="text" id="altura" name="altura" value="<?= htmlspecialchars($producto['altura']) ?>" />

        <label for="color">Color</label>
        <input type="text" id="color" name="color" value="<?= htmlspecialchars($producto['color']) ?>" />

        <label for="stock">Stock</label>
        <input type="number" id="stock" name="stock" min="1" value="<?= htmlspecialchars($producto['stock']) ?>" required />

        <label for="precio">Precio</label>
        <input type="number" step="0.01" min="0.01" id="precio" name="precio" value="<?= htmlspecialchars($producto['precio']) ?>" required />

        <label for="imagen">Nombre archivo imagen</label>
        <input type="text" id="imagen" name="imagen" value="<?= htmlspecialchars($producto['imagen']) ?>" placeholder="ejemplo.jpg" />

        <?php if (!empty($producto['imagen'])): ?>
            <div class="preview-image">
                <strong>Vista previa:</strong>
                <img src="image/<?= htmlspecialchars($producto['imagen']) ?>" alt="Imagen del producto" />
                <span><?= htmlspecialchars($producto['imagen']) ?></span>
            </div>
        <?php else: ?>
            <p>No se ha asignado imagen</p>
        <?php endif; ?>

        <div style="display: flex; gap: 10px;">
    <button type="submit">Actualizar</button>
    <button type="button" onclick="window.location.href='index.php?controller=dashboard&action=index'">Volver al Dashboard</button>
    <button type="button" onclick="window.location.href='index.php?controller=producto&action=listar'">Cancelar Cambios</button>
</div>
</form>
</body>
</html>






