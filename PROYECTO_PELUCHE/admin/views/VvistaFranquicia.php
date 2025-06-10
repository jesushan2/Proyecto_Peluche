<?php
if (!isset($franquicias)) $franquicias = [];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Franquicias</title>
    <link rel="stylesheet" href="Style/estilo_lista.css">
</head>
<body>
    <h2>Franquicias Registradas</h2>

    <?php if (isset($_GET['msg'])): ?>
        <p style="color:green;">
            <?php
            switch ($_GET['msg']) {
                case 'success': echo "Franquicia registrada con éxito."; break;
                case 'updated': echo "Franquicia actualizada con éxito."; break;
                case 'deleted': echo "Franquicia eliminada con éxito."; break;
            }
            ?>
        </p>
    <?php endif; ?>

    <?php if (count($franquicias) === 0): ?>
        <p>No hay franquicias activas registradas.</p>
    <?php else: ?>
        <table border="1" cellpadding="8" cellspacing="0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($franquicias as $f): ?>
                <tr>
                    <td><?= htmlspecialchars($f['id_franquicia']) ?></td>
                    <td><?= htmlspecialchars($f['nombre_fran']) ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <button><a href="index.php?controller=dashboard&action=index">Volver al Dashboard</a></button>
    <?php endif; ?>
</body>
</html>