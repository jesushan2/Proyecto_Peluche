<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Dashboard</title>
    <link rel="stylesheet" href="Style/register.css">
</head>
<body>
    <div class="popup" id="popup">
        <h2>¿Qué tipo de cuenta deseas crear?</h2>
        <div class="buttons">
            <button onclick="seleccionarTipo('admin')">Administrador</button>
            <button onclick="seleccionarTipo('vendedor')">Vendedor</button>
        </div>
    </div>

    <div class="form-container" id="formContainer" style="display: none;">
        <h2 id="tituloFormulario">Formulario</h2>
        <form method="POST" action="index.php?controller=register&action=registrar">
            <input type="hidden" name="tipo" id="tipoSeleccionado">

            <label>Nombres:</label>
            <input type="text" name="nombres" required>

            <label>Apellidos:</label>
            <input type="text" name="apellidos" required>

            <label>Teléfono:</label>
            <input type="text" name="telefono" required>

            <label>Correo:</label>
            <input type="email" name="correo" required>

            <label>Contraseña:</label>
            <input type="password" name="clave" required>

            <button type="submit">Registrar</button>
        </form>

        <p><a href="index.php?controller=login">¿Ya tienes cuenta? Inicia sesión</a></p>
    </div>

    <script>
        function seleccionarTipo(tipo) {
            const formContainer = document.getElementById('formContainer');
            const popup = document.getElementById('popup');
            const tipoInput = document.getElementById('tipoSeleccionado');
            const tituloFormulario = document.getElementById('tituloFormulario');

            tipoInput.value = tipo;

            if (tipo === 'admin') {
                tituloFormulario.innerText = "Formulario de Administrador";
            } else {
                tituloFormulario.innerText = "Formulario de Vendedor";
            }

            popup.style.display = 'none';
            formContainer.style.display = 'block';
        }
    </script>
</body>
</html>




