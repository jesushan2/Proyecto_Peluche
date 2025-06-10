<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['usuario_nombre']) || !isset($_SESSION['usuario_rol'])) {
    header("Location: index.php?controller=login&action=index");
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Administrativo de Todo Barranca</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="Style/dashboard.css">
    <script>
        
        function toggleSubmenu(id) {
            var submenu = document.getElementById(id);
            if (submenu.style.display === 'block') {
                submenu.style.display = 'none';
            } else {
                submenu.style.display = 'block';
            }
        }
    </script>
</head>
<body>
    <div class="sidebar">
        <h3>Menú</h3>
        <ul>
            <li onclick="toggleSubmenu('submenu-registros')">
                <a href="#"><i class="fas fa-plus-circle"></i> Registros</a>
            </li>
            <ul id="submenu-registros" class="submenu" style="display:none;">
                <li><a href="index.php?controller=producto&action=mostrarFormulario">Registrar Producto</a></li>
                <li><a href="index.php?controller=franquicia&action=mostrarFormulario">Registrar Franquicia</a></li>
            </ul>

            <li onclick="toggleSubmenu('submenu-edicion')">
                <a href="#"><i class="fas fa-edit"></i> Edición</a>
            </li>
            <ul id="submenu-edicion" class="submenu" style="display:none;">
                <li><a href="index.php?controller=administrador&action=index">Editar Administradores</a></li>
                <li><a href="index.php?controller=franquicia&action=index">Editar Franquicias</a></li>
                <li><a href="index.php?controller=producto&action=listar">Editar Productos</a></li> 
                <li><a href="index.php?controller=usuario&action=listar">Editar Usuarios</a></li> 
                <li><a href="index.php?controller=vendedor&action=listar">Editar Vendedores</a></li>
                <li><a href="index.php?controller=reserva&action=listar">Editar Reservas</a></li>
            </ul>
            
            <li onclick="toggleSubmenu('submenu-vistas')">
                <a href="#"><i class="fas fa-edit"></i> Vistas</a>
            </li>
            <ul id="submenu-vistas" class="submenu" style="display:none;">
            <li><a href="index.php?controller=administrador&action=listarVista">Ver Administradores</a></li>
        <li><a href="index.php?controller=franquicia&action=listarVista">Ver Franquicias</a></li>
        <li><a href="index.php?controller=producto&action=listarVista">Ver Productos</a></li>
        <li><a href="index.php?controller=usuario&action=listarVista">Ver Usuarios</a></li>
        <li><a href="index.php?controller=vendedor&action=listarVista">Ver Vendedores</a></li>
        <li><a href="index.php?controller=reserva&action=listarVista">Ver Reservas</a></li>
            </ul>

</li>
        </ul>
    </div>

    <div class="topbar">
        <div class="title">PANEL ADMINISTRATIVO DE TODO BARRANCA</div>
        <div class="user-info">
            <span><?= htmlspecialchars($_SESSION['usuario_nombre']) ?> (<?= htmlspecialchars($_SESSION['usuario_rol']) ?>)</span>
            <a href="index.php?controller=login&action=cerrarSesion" class="logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="main-content">
        <h2>Bienvenido al panel administrativo</h2>
        <p>Selecciona una opción del menú lateral para comenzar.</p>
    </div>
</body>
</html>

