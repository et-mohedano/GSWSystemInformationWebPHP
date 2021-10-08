<?php
if(@$_GET["ruta"] == "reportes-pdf"){
  require_once "application/controllers/cProducto.php";
  $this->load->view('reportes-pdf');
}elseif(@$_GET["ruta"] == "pedido-pdf"){
  require_once "application/controllers/cPedido.php";
  $datosPedido = array(
    "usuario" => $_GET["usuario"],
    "fecha" => $_GET["fecha"],
    "idPedido" => $_GET["idPedido"]
  );
  $this->load->view('pedido-pdf', $datosPedido);
}else{
  session_start();
  require_once "application/controllers/cUsuario.php";
  require_once "application/controllers/cProducto.php";
  require_once "application/controllers/CCategorias.php";
  require_once "application/controllers/cProveedor.php";
  require_once "application/controllers/cPedido.php";

  
echo '<!DOCTYPE html>
<html>
<head>
  <link rel="shortcut icon" href="'. base_url('assests/icon-head.ico').'">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="stylesheet" href="'. base_url('assests/bootstrap/css/bootstrap.css').'">
  <link rel="stylesheet" href="'. base_url('assests/style.css').'">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
  <!-- Default theme -->
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
  <!-- Semantic UI theme -->
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
  <!-- Bootstrap theme -->
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/bootstrap.min.css"/>
    <title>GSW</title>
  <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
  <script language="javascript" src="'.base_url("assests/bootstrap/js/system.js").'"></script>
</head>
<!--=====================================
CUERPO DOCUMENTO
======================================-->
<body class="">';
  if(isset($_SESSION["id"]) && !isset($_POST["salir"])){
    /*=============================================
    CONTENIDO
    =============================================*/
    
    if(isset($_GET["ruta"])){
      // ejemplo
        if($_GET["ruta"] == "inicio" ||
        $_GET["ruta"] == "about" ||
        $_GET["ruta"] == "categorias" ||
        $_GET["ruta"] == "productos" ||
        $_GET["ruta"] == "pedidos" ||
        $_GET["ruta"] == "agregarProd-pedidos" ||
        $_GET["ruta"] == "pedido-listado" ||
        $_GET["ruta"] == "pedido-confirmar" ||
        $_GET["ruta"] == "ventas" ||
        $_GET["ruta"] == "usuarios" ||
        $_GET["ruta"] == "activar-producto" ||
        $_GET["ruta"] == "activar-categoria" ||
        $_GET["ruta"] == "activar-proveedores" || 
        $_GET["ruta"] == "modificar-categoria" ||
        $_GET["ruta"] == "modificar-usuario" ||
        $_GET["ruta"] == "modificar-producto" ||
        $_GET["ruta"] == "modificar-proveedor" || 
        $_GET["ruta"] == "registrar-categoria" ||
        $_GET["ruta"] == "registrar-producto" ||
        $_GET["ruta"] == "registrar-proveedores" || 
        $_GET["ruta"] == "registrar-usuario" || 
        $_GET["ruta"] == "activar-usuario" || 
        $_GET["ruta"] == "reportes-pdf" ||
        $_GET["ruta"] == "proveedores" ||    
        $_GET["ruta"] == "salir"){
          include "modulos/header.php";
          include "modulos/".$_GET["ruta"].".php";
          include "modulos/footer.php";
        }else{
          include "modulos/404.php";
        }
    }else{
      include "modulos/header.php";
      include "modulos/inicio.php";
      include "modulos/footer.php";
    }
    echo '</div>';
  }else{
    if(isset($_POST["salir"]))
      session_destroy();
    include "modulos/login.php";
  }
echo'
  <script language="javascript" src="'. base_url('assests/bootstrap/js/bootstrap.js').'"></script>
  <script src="https://kit.fontawesome.com/85be78ad34.js" crossorigin="anonymous"></script>
</body>
</html>';
}
?>
