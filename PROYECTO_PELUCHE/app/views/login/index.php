<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Login - TODO BARRANCA</title>
    <link rel="stylesheet" href="style/login.css">
</head>
<body>
    <div class="login-container">
        <h2>Iniciar Sesión</h2>

        <?php if (!empty($error)): ?>
            <div class="error"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>

        <form action="index.php?controller=login&action=login" method="post">
            <input type="email" name="correo" placeholder="Correo" required />
            <input type="password" name="contrasena" placeholder="Contraseña" required />
            <button type="submit">Ingresar</button>
        </form>
    </div>
</body>
</html>

