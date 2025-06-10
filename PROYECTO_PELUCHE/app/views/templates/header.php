<?php
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

$contadorCarrito = 0;
if (!empty($_SESSION['carrito'])) {
  foreach ($_SESSION['carrito'] as $item) {
    $contadorCarrito += $item['cantidad'];
  }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>TODO BARRANCA</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link rel="stylesheet" href="style/header.css" />
</head>

<body>

  <nav class="navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="index.php?controller=home&action=index">
        <img src="image/logo.png" alt="Logo TODO BARRANCA" /> TODO BARRANCA
      </a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">

        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item"><a class="nav-link" href="index.php?controller=home&action=index">Inicio</a></li>
          <li class="nav-item"><a class="nav-link" href="index.php?controller=producto&action=catalogo">Catálogo</a></li>
          <li class="nav-item"><a class="nav-link" href="index.php?controller=home&action=contacto">Contacto</a></li>
        </ul>

        <ul class="navbar-nav ms-auto nav-user-area">
          <li class="nav-item position-relative">
            <a class="nav-link carrito-icono" href="index.php?controller=reserva&action=verCarrito" title="Ver carrito">
              <i class="bi bi-cart3"></i>
              <span class="contador-carrito"><?= $contadorCarrito ?></span>
            </a>
          </li>

          <?php if (isset($_SESSION['usuario'])): ?>
            <li class="nav-item">
              <a class="nav-link" href="#">
                Hola, <?= htmlspecialchars($_SESSION['usuario']['nombres']) ?>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="index.php?controller=login&action=logout">Cerrar sesión</a>
            </li>
          <?php else: ?>
            <li class="nav-item">
              <a class="nav-link" href="index.php?controller=login&action=index">Iniciar sesión</a>
            </li>
          <?php endif; ?>
        </ul>

      </div>
    </div>
  </nav>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
