<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Dashboard</title>
    <link rel="stylesheet" href="Style/login.css">
</head>
<body>
    <div class="form-container">
        <h2>Iniciar Sesión</h2>
        <?php if (!empty($error)) echo "<p style='color:red;'>$error</p>"; ?>
        <form method="POST" action="index.php?controller=login&action=validar">
            <label>Correo:</label>
            <input type="email" name="correo" required>

            <label>Contraseña:</label>
            <input type="password" name="clave" required>

            <button type="submit">Ingresar</button>
            </form>

            <button onclick="window.location.href='index.php?controller=login&action=register'" class="styled-button">Registrarse</button>

</div> 

</body>
</html>

