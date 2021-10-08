<?php
$estado = "0";
$datos=array();
$datosDel=array();
$totalRegistro=0;
$numRegistro=3;
$proveedores = new cProveedor();

    //OBITNE LA PÁGINA ACTUAL O A LA QUE SE LE HIZO CLIC
    if(isset($_GET['pagina'])){
	  $numPagina=$_GET['pagina'];		
	}
	else{ //la primera vez que mostrará los datos
		  $inicioPag=0;
		  $numPagina=1;
	}	 	 
	//DETERMINA CUÁNTOS REGISTROS SE TRAERAN POR PÁGINA
	if($numPagina>1){		  
		$inicioPag=($numPagina-1)*$numRegistro;	  		
	}
	else{ //CUANDO ES LA PRIMERA VEZ
		$inicioPag=0;
	}	  
	    
	//###SE EJECUTA UN MÉTODO DEL SERVICIO WEB, PASANDO SUS PARAMETROS
    
	$totalRegistro=$proveedores->contarProveedores();	
	
    
	//DETEMRINA EL TOTAL DE PAÁGINAS
	$totalPaginas=ceil($totalRegistro/$numRegistro);	  	  					    
		
	//###SE EJECUTA UN MÉTODO DEL SERVICIO WEB, PASANDO SUS PARAMETROS
	//OBTIENE EL TOTAL DE REGISTROS A MOSTRAR EN LA PÁGINA
    
	$datosPag=$proveedores->consultarProveedores($inicioPag,$numRegistro);
    $estado=1;
   
    // //VERIFICA QUE LA VARIABLE ne TENGA VALOR PARA ELIMINAR AL USUARIO
    if (isset($_GET['ne'])){
       
       	$datosDel=$proveedores->eliminarProveedores($_GET['ne']);	
       	if((int)$datosDel[0]["ID"]!=0)
       	{
       	    echo '<script language="javascript">alert("Proveedor eliminado correctamente")</script>';
       	    echo "<script language='javascript'>document.location.href = '?ruta=proveedores';</script>";
       	}
    }

?>
<main>
    <div class="row">
        <div class="col col-md-9 col-xs-8">
              <div class="col-auto">
                <h2><b for="" class="col-form-label">Administrar Proveedores:</b></h2>
              </div>
              <form id="frmConexion" name="frmConexion" method="POST">
                <div class="container">
                    <div class="table-responsive table-report">
                      <table align="center" class="table table-dark table-striped">
                        <thead>
                        <tr>
                              <td><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
                              <td><b>Clave</b></td>
                              <td><b>Nombre</b></td>
                              <td><b>Empresa</b></td>  
                              <td><b>Contacto</b></td>
                              <td><b>Correo</b></td> 
                              <td><b>Contacto supervisor</b></td>
                          </tr>
                        </thead>
                        <tbody>
                    <?php
                     if($estado!="0")
                      {	          
                    	for($rr=0;$rr<count($datosPag);$rr++){	
                    		echo "<tr>";
                    		echo "<td bg-primary><a href='?ruta=modificar-proveedor&cve=".$datosPag[$rr]["CLAVE"]."' class='btn btn-sys btn-options' title='Editar' ><i class='fa fa-pencil-square-o'></i></a>
                                <br/><a href='?ruta=proveedores&ne=".$datosPag[$rr]["CLAVE"]."' class='btn btn-sys' title='Eliminar' ><i class='fa fa-times-circle'></i></a></td>";
                            echo "<td><font class='Etiquetas2'>".$datosPag[$rr]["CLAVE"]."</td>";
                    		echo "<td><font class='Etiquetas2'>".$datosPag[$rr]["NOMBRE"]."</td>";
                    		echo "<td><font class='Etiquetas2'>".$datosPag[$rr]["EMPRESA"]."</td>";
                    	    echo "<td><font class='Etiquetas2'>".$datosPag[$rr]["CONTACTO"]."</td>";
                    	    echo "<td><font class='Etiquetas2'>".$datosPag[$rr]["CORREO"]."</td>";
                    	    echo "<td><font class='Etiquetas2'>".$datosPag[$rr]["CONTACTO_SUPERVISOR"]."</td>";
                    		echo "</tr>";
                          }
                    	  echo "</tbody></table></div><center>";
                	  if($totalPaginas>1)
                	  {
                	     echo "<font class='Etiquetas2'>P&aacute;ginas: </font>";
                	  }
                	  else
                	  {
                		  echo "P&aacute;gina:";
                	  }	  
                	  for ($i=1; $i<=$totalPaginas; $i++)
                	  {		
                		if ($numPagina == $i)
                		{
                			echo "<font class='text-primary'><b> $numPagina </b> </font>";
                		}
                		else
                		{		
                			echo " <a href='?ruta=proveedores&pagina=$i'>$i</a> ";
                		}
                	  }
                	  echo "</center>";
                	  
                  }
                ?>
                </div>
                </form>
                <hr>
                  <div class="text-center">
                      <a href='?ruta=registrar-proveedores' class="btn btn-sys">Registrar Proveedores&nbsp;</a>
                      <a href='?ruta=activar-proveedores' class="btn btn-sys">Activar Proveedores&nbsp;</a>
                      <!--<button type="button" class="btn btn-sys">Cancelar&nbsp;</button>-->
                  </div>
                <hr>
        </div>
        <?php
            require('sidebar.php');
        ?>
    </div>
</main>