<?php
    $usuario = $_GET['usuario'];
    $fecha = $_GET['fecha'];
?>
<div class="row">
    <div class="col col-md-9 col-xs-8 text-center pedido-confirmar">
        <div class="pedido-head">
            <div class="pedido-title h3">Confirmación de pedido</div>
            <div class="pedido-title h4">
                <span>Usuario: <?=$usuario?></span>
                <span>Fecha: <?=$fecha?></span>
            </div> 
        </div>
        <hr>
        <?php
            $pedido = new cPedido();
            $productospedido = $pedido->mostrarProductosPedido($_GET['id']);
            echo '<form method="POST" enctype="multipart/form-data" action="'.base_url('index.php/cPedido/confirmarProductosPedido?pedido='.$_GET["id"]).'">';
            for ($i=0; $i < count($productospedido); $i++) { 
                ########################
                echo '<h5><span>Producto:</span> '.$productospedido[$i]['NOMBRE'].'</h5>';
                echo '<div class="mb-3 row">
                        <label for="txtCantidad" class="col-sm-3 col-form-label text-center">ID:</label>
                        <div class="col-sm-9">';
                echo '      <input type="number" class="form-control" id="1'.$productospedido[$i]['CLAVE'].'" name="1'.$productospedido[$i]['CLAVE'].'" value="'.$productospedido[$i]['CLAVE'].'" required readonly>';
                echo '  </div>
                    </div>';
                ########################
                 echo '<div class="mb-3 row">
                        <label for="txtCantidad" class="col-sm-3 col-form-label text-center">Cantidad:</label>
                        <div class="col-sm-9">';
                echo '      <input type="number" class="form-control" id="2'.$productospedido[$i]['CLAVE'].'" name="2'.$productospedido[$i]['CLAVE'].'" value="'.$productospedido[$i]['CANTIDAD'].'" required>';
                echo '  </div>
                    </div>';
                ########################
                echo '<div class="mb-3 row">
                        <label for="txtCantidad" class="col-sm-3 col-form-label text-center">Costo:</label>
                        <div class="col-sm-9">';
                echo '      <input type="number" class="form-control" id="3'.$productospedido[$i]['CLAVE'].'" name="3'.$productospedido[$i]['CLAVE'].'" required>';
                echo '  </div>
                    </div>';
                ########################
                echo '<div class="mb-3 row">
                        <label for="txtCantidad" class="col-sm-3 col-form-label text-center">Fecha de caducidad:</label>
                        <div class="col-sm-9">';
                echo '      <input type="date" class="form-control" id="4'.$productospedido[$i]['CLAVE'].'" name="4'.$productospedido[$i]['CLAVE'].'" required>';
                echo '  </div>
                    </div>';
            }
        ?>
        <hr>
        <div class="h1">
            <button type="submit" class="btn btn-sys">Confirmar pedido&nbsp;</button>
            <button class="btn btn-danger" type="reset">Cancelar&nbsp;</button>
        </div>
        </form>
    </div>
<?php
    require('sidebar.php');
?>
    
</div>