
<?php
    $pedido = new cPedido();

    if(@$_GET['agregar']){
        $datos_pedido = $pedido->insPedido($_SESSION['id']);
        $fecha = $datos_pedido[0]['FECHA'];
        $idPedido = $datos_pedido[0]['ID'];
    }else{
        $fecha = $_GET["FECHA"];
        $idPedido = $_GET["ID"];
    }
    $usuario = $_SESSION['nomUsuario'];
    if(@$_GET["cant"] && @$_GET["idProd"])
        $pedido->insPedidoProducto($idPedido, $_GET["idProd"], $_GET["cant"], $fecha);
    if(@$_GET["ne"])
        $pedido->delPedidoProducto($_GET["ne"], $idPedido);
    
?>
<div class="row">
    <div class="col col-md-9 col-xs-8 text-center pedido-confirmar">
        <div class="pedido-head">
            <div class="pedido-title h3">Pedido: <?=$idPedido?></div>
            <div class="pedido-title h4">
                <span>Usuario: <?=$usuario?></span>
                <span>Fecha: <?=$fecha?></span>
            </div> 
        </div>
        <hr>
        <?php
            $productosPedido = $pedido->mostrarProductosPedido($idPedido);
            for($rr=0;$rr<count($productosPedido);$rr++){
                echo '<div class="row h5 pedido-producto">
                        <div class="col col-sm-0 col-md-2"></div>
                        <div class="col col-sm-6 col-md-4">';
                echo 'Producto: ' . $productosPedido[$rr]["NOMBRE"].'<br>Cantidad: '.$productosPedido[$rr]["CANTIDAD"];
                echo '</div>
                    <div class="col col-sm-3 col-md-2">
                        <img src="assests/images/'.$productosPedido[$rr]["FOTO"].'" alt="" class="img-fluid logo-sys"/>
                    </div>
                    <div class="col col-sm-3 col-md-1 pedido-cancelar">
                        <a class="btn btn-danger pedido-cancelar-btn" title="Quitar producto" href="?ruta=pedido-listado&ID='.$idPedido.'&FECHA='.$fecha.'&ne='.$productosPedido[$rr]["CLAVE"].'">X</a>
                    </div>
                </div>
                <hr>';
            }
        ?>
        <div class="h1">
            <a href='?ruta=agregarProd-pedidos&id=<?=$idPedido.'&'.'fecha='.$fecha?>' class="btn btn-sys">Agregar producto&nbsp;</a>
            <a href='?ruta=pedidos' class="btn btn-danger">Cerrar pedido&nbsp;</a>
        </div>
    </div>
<?php
    require('sidebar.php');
?>
    
</div>
    <br><br><br><br>