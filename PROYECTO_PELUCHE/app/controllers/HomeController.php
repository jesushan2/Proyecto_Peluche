<?php

class HomeController {

    public function index() {
        require_once __DIR__ . '/../views/home/index.php';
    }

    public function contacto() {
        require_once __DIR__ . '/../views/home/contacto.php';
    }
}


