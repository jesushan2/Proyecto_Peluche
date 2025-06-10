<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Reservas</title>
    <link rel="stylesheet" href="Style/estilo_lista.css">
</head>
<body>
    <h1>Lista de Reservas</h1>
    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Estado</th>
                <th>Vendedor Encargado</th>
                <th>Fecha Reserva</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <?php if (!empty($reservas)): ?>
                <?php foreach ($reservas as $reserva): ?>
                    <tr>
                        <td><?= htmlspecialchars($reserva['id_reserva']) ?></td>
                        <td><?= htmlspecialchars($reserva['usuario_nombres'] . ' ' . $reserva['usuario_apellidos']) ?></td>
                        <td><?= htmlspecialchars($reserva['nombre_est']) ?></td>
                        <td>
                            <?= $reserva['vendedor_nombres'] ? 
                                htmlspecialchars($reserva['vendedor_nombres'] . ' ' . $reserva['vendedor_apellidos']) : 
                                '<em>No asignado</em>' ?>
                        </td>
                        <td><?= htmlspecialchars($reserva['fecha_reserva']) ?></td>
                        <td><?= htmlspecialchars(number_format($reserva['total'], 2)) ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr><td colspan="7">No hay reservas activas.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>
    <button><a href="index.php?controller=dashboard&action=index">Volver al Dashboard</a></button>
</body>
</html>