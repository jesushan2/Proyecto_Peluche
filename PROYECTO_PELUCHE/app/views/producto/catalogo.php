<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/../templates/header.php';

$productosPorFranquicia = [];
foreach ($productos as $producto) {
    $productosPorFranquicia[$producto['franquicia']][] = $producto;
}
?>

<div class="container py-4">
    <h1 class="mb-4">Catálogo de Productos</h1>

    <input
        type="text"
        id="busqueda"
        placeholder="Buscar producto por nombre..."
        class="form-control mb-4"
        aria-label="Buscar producto"
    />

    <?php foreach ($productosPorFranquicia as $franquicia => $listaProductos): ?>
        <section class="franquicia-section mb-5">
            <h2 class="franquicia-title mb-3"><?= htmlspecialchars($franquicia) ?></h2>

            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                <?php foreach ($listaProductos as $producto): ?>
                    <div
                        class="col producto-item"
                        data-nombre="<?= strtolower(htmlspecialchars($producto['nombre_prod'])) ?>"
                    >
                        <div class="card h-100">
                            <img
                                src="image/<?= htmlspecialchars($producto['imagen']) ?>"
                                alt="<?= htmlspecialchars($producto['nombre_prod']) ?>"
                                class="card-img-top producto-img"
                                style="object-fit: contain; height: 200px;"
                            />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title"><?= htmlspecialchars($producto['nombre_prod']) ?></h5>
                                <p class="card-text">Altura: <?= htmlspecialchars($producto['altura']) ?></p>
                                <p class="card-text">Color: <?= htmlspecialchars($producto['color']) ?></p>
                                <p class="card-text">Stock: <?= htmlspecialchars($producto['stock']) ?></p>
                                <p class="card-text fw-bold text-success">
                                    S/ <?= number_format($producto['precio'], 2) ?>
                                </p>
                                <a
                                    href="index.php?controller=reserva&action=agregar&id=<?= intval($producto['id_producto']) ?>"
                                    class="btn btn-primary mt-auto"
                                >Reservar</a>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
    <?php endforeach; ?>
</div>

<script>
    const busquedaInput = document.getElementById('busqueda');
    busquedaInput.addEventListener('input', () => {
        const filtro = busquedaInput.value.trim().toLowerCase();
        const productos = document.querySelectorAll('.producto-item');

        productos.forEach(producto => {
            const nombre = producto.getAttribute('data-nombre');
            producto.style.display = nombre.includes(filtro) ? '' : 'none';
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
