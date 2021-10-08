<?php
    $idPedido = $_GET['id'];
    $fecha = $_GET['fecha'];
    $usuario = $_SESSION['nomUsuario'];
?>
<main>
    <div class="row">
        <div class="col col-md-9 col-xs-8 text-center pedido-agregar">
            <div class="col-auto">
                <h2><strong for="" class="col-form-label">Pedido: <?=$idPedido?></strong></h2>
                    <div class="container">
                        <div class="h4">
                            <span>Usuario: <?=$usuario?></span>
                            <span>Fecha: <?=$fecha?></span>
                        </div>
                    </div>
                    <hr>
                        <div class="row h5 ">
                            <div class="col col-sm-0 col-md-2">
                            </div>
                            <div class="col col-sm-6 col-md-4 categoria-pedido">
                                Categoria:
                            </div>

                            <div class="col col-sm-3 col-md-4">
                            <select class="form-select" id="txtCat" name="txtCat" required onChange="window.location.href = this.options[this.selectedIndex].value;">
                            <?php
                                $productos = new cProducto();
                                $datos_categorias = $productos->consCategorias();
                                echo '<option value="" disabled selected>Elige una categoría</option>';
                                for($reg = 0; $reg < count($datos_categorias); $reg++){
                                    echo '<option value="?ruta=agregarProd-pedidos&id='.$idPedido.'&fecha='.$fecha.'&cat='.$datos_categorias[$reg]["Clave"].'">'.$datos_categorias[$reg]["Categoria"].'</option>';
                                }
                            ?>
                          </select>
                            </div>
                        </div>
                        <?php
                            if(@$_GET["cat"]){
                                $productos_cat = $productos->getProdCat($_GET["cat"]);
                               echo '<div class="row h5 ">
                                        <div class="col col-sm-0 col-md-2">
                                        </div>
                                        <div class="col col-sm-6 col-md-4 categoria-pedido">
                                            Producto:
                                        </div>
                                        <div class="col col-sm-3 col-md-4">'; 
                                echo '<select class="form-select" id="txtProd" name="txtProd" required>';
                                            
                                            for($reg = 0; $reg < count($productos_cat); $reg++){
                                                echo '<option selected value="'.$productos_cat[$reg]["CLAVE"].'">'.$productos_cat[$reg]["ARTICULO"].'</option>';
                                            }
                                            if(count($productos_cat) == 0){
                                                echo '<option value="" disabled selected>No hay productos registrados</option></select></div></div>';
                                            }else{
                                                echo '<option value="" disabled selected>Elige un producto</option>';
                                                echo '</select></div></div>
                                                        <div class="row h5 ">
                                                            <div class="col col-sm-0 col-md-2">
                                                            </div>
                                                            <div class="col col-sm-6 col-md-4 categoria-pedido">
                                                                Cantidad:
                                                            </div>
                                                            <div class="col col-sm-3 col-md-4">
                                                                <input type="number" name="txtCant" id="txtCant" class="form-control" id="buscarProducto" placeholder="Cantidad de productos a elegir...">
                                                            </div>
                                                    </div>';
                                            }
                                echo '<script>seleccionarCategoria("?ruta=agregarProd-pedidos&id='.$idPedido.'&fecha='.$fecha.'&cat='.$_GET["cat"].'")</script>';
                                echo '
                                <div class="text-center">
                                    <button onClick="setProductoPedido('.$idPedido.",'".$fecha."'".')" class="btn btn-sys">Agregar Pedido&nbsp;</button>
                                    <a href="?ruta=pedido-listado&ID='.$idPedido.'&FECHA='.$fecha.'" class="btn btn-danger">Cancelar&nbsp;</a>
                                </div>';
                            }
                        ?>
                        
                    <hr>
            </div>
        </div>
    <?php
        require('sidebar.php');
    ?>
        
    </div>
</main>
