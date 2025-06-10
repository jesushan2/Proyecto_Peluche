<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Reserva #<?= htmlspecialchars($reserva['id_reserva']) ?></title>
    <link rel="stylesheet" href="Style/estilo_editar.css">
</head>
<body>
    <h1>Editar Reserva #<?= htmlspecialchars($reserva['id_reserva']) ?></h1>
    <form action="index.php?controller=reserva&action=actualizar" method="POST">
        <input type="hidden" name="id_reserva" value="<?= htmlspecialchars($reserva['id_reserva']) ?>">

        <p><strong>Usuario ID:</strong> <?= htmlspecialchars($reserva['id_usuario']) ?></p>

        <label for="id_estado">Estado de la Reserva:</label>
        <select name="id_estado" id="id_estado" required>
            <?php foreach ($estados as $estado): ?>
                <option value="<?= $estado['id_estado'] ?>" <?= ($estado['id_estado'] == $reserva['id_estado']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($estado['nombre_est']) ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br><br>

        <label for="id_vendedor">Vendedor Encargado:</label>
        <select name="id_vendedor" id="id_vendedor">
            <option value="">-- Ninguno --</option>
            <?php foreach ($vendedores as $vendedor): ?>
                <option value="<?= $vendedor['id_vendedor'] ?>" <?= ($vendedor['id_vendedor'] == $reserva['id_vendedor']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($vendedor['nombres'] . ' ' . $vendedor['apellidos']) ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br><br>

        <label for="total">Total:</label>
        <input type="number" step="0.01" name="total" id="total" value="<?= htmlspecialchars($reserva['total']) ?>" required>
        <br><br>

    <div style="display: flex; gap: 10px;">
    <button type="submit">Actualizar</button>
    <button type="button" onclick="window.location.href='index.php?controller=dashboard&action=index'">Volver al Dashboard</button>
    <button type="button" onclick="window.location.href='index.php?controller=reserva&action=listar'">Cancelar Cambios</button>
</div>
</form>
</body>
</html>
