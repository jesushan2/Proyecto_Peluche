<?php
session_start();

$controller = $_GET['controller'] ?? 'login';
$action = $_GET['action'] ?? 'index';

$controllerFile = "app/controllers/" . ucfirst($controller) . "Controller.php";
$controllerClass = ucfirst($controller) . "Controller";

if (file_exists($controllerFile)) {
    require_once $controllerFile;

    if (class_exists($controllerClass)) {
        $controllerInstance = new $controllerClass();

        if (method_exists($controllerInstance, $action)) {
            $controllerInstance->$action();
        } else {
            http_response_code(404);
            echo "Error 404: La acción '$action' no existe en el controlador '$controllerClass'.";
        }
    } else {
        http_response_code(500);
        echo "Error: La clase controlador '$controllerClass' no está definida.";
    }
} else {
    http_response_code(404);
    echo "Error 404: El archivo del controlador '$controllerFile' no fue encontrado.";
}
