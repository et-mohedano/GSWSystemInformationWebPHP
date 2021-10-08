<?php
    if(@$_GET['estadoPedido']>-1){
        $pedido = new cPedido();
        echo $pedido->cambiarEstado($_GET["id"],$_GET['estadoPedido']);
        if($_GET['estadoPedido'] == 2){
            echo "<script>
                location.href='?ruta=pedido-confirmar&id=".$_GET["id"]."&usuario=".$_GET["usuario"]."&fecha=".$_GET["fecha"]."';
            </script>";
        }
    }
?>
<main>
    <div class="row">
        <div class="col col-md-9 col-xs-8">
            <div class="col-auto">
                <h2><b for="" class="col-form-label">Pedidos:</b></h2>
                  <form id="frmConexion" name="frmConexion" method="POST">
                    <div class="container">
                        <table align="center" class="table table-dark table-striped text-center">
                            <thead>
                                <tr>
                                    <td>
                                        ID Pedido
                                    </td>
                                    <td>
                                        Usuario
                                    </td>
                                    <td>
                                        Fecha
                                    </td>
                                    <td>
                                        Ver Pedido
                                    </td>
                                    <td>
                                        Estado del Pedido
                                    </td>
                                <tr>
                            </thead>
                            <tbody>
                                <?php
                                    if(@!$pedido)
                                        $pedido = new cPedido();
                                    $pedidos=$pedido->mostrarPedidos();
                                    $estados = array('Realizado' => 0, 'Solicitado' => 1, 'Entregado' => 2, 'Cancelado' => 3);
                                    for($rr=0;$rr<count($pedidos);$rr++){
                                        echo '<tr>';
                                            echo '<td>'.$pedidos[$rr]["CLAVE"].'</td>';
                                            echo '<td>'.$pedidos[$rr]["NOMBRE"].'</td>';
                                            echo '<td>'.$pedidos[$rr]["FECHA"].'</td>';
                                            echo "<td><a target='_blank' href='?ruta=pedido-pdf&idPedido=".$pedidos[$rr]["CLAVE"]."&usuario=".$pedidos[$rr]["NOMBRE"]."&fecha=".$pedidos[$rr]["FECHA"]."' class='btn btn-sys'>Ver Pedido&nbsp;</a></td>";
                                            if($pedidos[$rr]["ESTADO"] == 2){
                                                echo '<td><span class="btn btn-success">'.array_search($pedidos[$rr]["ESTADO"], $estados).'</span></td>';
                                            }else if($pedidos[$rr]["ESTADO"] == 3){
                                                echo '<td><span class="btn btn-danger">'.array_search($pedidos[$rr]["ESTADO"], $estados).'</span></td>';
                                            }else{
                                                echo '<td>
                                                        <select class="form-control" name="select" onChange="window.location.href = this.options[this.selectedIndex].value;">';
                                                        foreach($estados as $i_value => $i) {
                                                            if($i == $pedidos[$rr]["ESTADO"]){
                                                                echo '<option value="?ruta=pedidos&id='.$pedidos[$rr]["CLAVE"].'&estadoPedido='.$i.'&usuario='.$pedidos[$rr]["NOMBRE"].'&fecha='.$pedidos[$rr]["FECHA"].'" selected>'.$i_value.'</option>';
                                                            }else{
                                                                echo '<option value="?ruta=pedidos&id='.$pedidos[$rr]["CLAVE"].'&estadoPedido='.$i.'&usuario='.$pedidos[$rr]["NOMBRE"].'&fecha='.$pedidos[$rr]["FECHA"].'">'.$i_value.'</option>';
                                                            }
                                                        }
                                                            
                                                        echo '</select>
                                                    </td>';
                                            }
                                        echo '</tr>';
                                    }	
                                ?>

                            </tbody>
                        </table>
                    </div>  
                  </form>
                    <hr>
                      <div class="text-center">
                          <button onClick="agregarPedido()" class="btn btn-sys"'>Agregar Pedido&nbsp;</button>
                      </div>
                    <hr>
            </div>
        </div>
    <?php
        require('sidebar.php');
    ?>
        
    </div>
</main>
<br><br>
<script language="javascript" src="<?=base_url('assests/bootstrap/js/system.js')?>"></script>
