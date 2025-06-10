<?php require 'app/views/templates/header.php'; ?>

<div class="container mt-4">
    <h2>Mi Carrito de Reservas</h2>

    <?php if (isset($_SESSION['mensaje'])): ?>
        <div class="alert alert-success"><?= $_SESSION['mensaje']; unset($_SESSION['mensaje']); ?></div>
    <?php endif; ?>

    <?php if (isset($_SESSION['error'])): ?>
        <div class="alert alert-danger"><?= $_SESSION['error']; unset($_SESSION['error']); ?></div>
    <?php endif; ?>

    <?php if (!empty($_SESSION['carrito'])): ?>
        <div class="table-responsive">
            <table class="table table-bordered align-middle text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Imagen</th>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Eliminar</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $total = 0; ?>
                    <?php foreach ($_SESSION['carrito'] as $item): ?>
                        <?php $subtotal = $item['precio'] * $item['cantidad']; ?>
                        <?php $total += $subtotal; ?>
                        <tr>
                            <td><img src="image/<?= htmlspecialchars($item['imagen']) ?>" width="60"></td>
                            <td><?= htmlspecialchars($item['nombre']) ?></td>
                            <td>S/. <?= number_format($item['precio'], 2) ?></td>
                            <td><?= $item['cantidad'] ?></td>
                            <td>S/. <?= number_format($subtotal, 2) ?></td>
                            <td>
                                <a href="index.php?controller=reserva&action=eliminar&id=<?= $item['id_producto'] ?>" class="btn btn-danger btn-sm">
                                    ❌
                                </a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <h4 class="mt-3">Total: <strong>S/. <?= number_format($total, 2) ?></strong></h4>

        <form method="post" action="index.php?controller=reserva&action=procesarReserva" class="mt-3">
            <button type="submit" class="btn btn-success">Procesar Reserva</button>
        </form>
    <?php else: ?>
        <p class="mt-3">No hay productos en el carrito.</p>
    <?php endif; ?>
</div>

<?php require 'app/views/templates/footer.php'; ?>

