<?php

class cPedido extends CI_Controller {

    public function mostrarPedidos()
    {
        $this->load->model('mPedido');
        $pedidos = $this->mPedido->mMostrarPedidos();
        $this->db->close();		
		return $pedidos;
	}
    public function cambiarEstado($id, $estado)
    {
        $this->load->model('mPedido');
        $pedidos = $this->mPedido->mCambiarEstado($id, $estado);
        $this->db->close();	
        if($pedidos[0]["ID"] == 1){
            $resultado = '<script>
                alertify.success("Pedido actualizado"); 
                </script>';
        }else{
            $resultado = '<script>
                    alertify.error("Error al actualizar"); 
                </script>';
        }	
		return $resultado;
	}
    public function insPedido($usuario)
    {
        $this->load->model('mPedido');
        $pedido = $this->mPedido->mInsPedido($usuario);
        $this->db->close();		
		return $pedido;
	}
    public function mostrarProductosPedido($id)
    {
        $this->load->model('mPedido');
        $productosPedido = $this->mPedido->mMostrarProductosPedido($id);
        $this->db->close();		
		return $productosPedido;
	}
    public function insPedidoProducto($pedido, $prod, $cant, $fecha)
    {
        $this->load->model('mPedido');
        $productosPedido = $this->mPedido->mInsPedidoProducto($pedido, $prod, $cant, $fecha);
        $this->db->close();		
		return $productosPedido;
	}
    public function delPedidoProducto($prod, $pedido)
    {
        $this->load->model('mPedido');
        $productosPedido = $this->mPedido->mDelPedidoProducto($prod, $pedido);
        $this->db->close();		
		return $productosPedido;
	}   
    public function confirmarProductosPedido()
    {
        $pedido = $_GET['pedido'];
        $this->load->model('mPedido');
        $id = null;
        $cantidad = null;
        $fecha = null;
        $costo = null;
        foreach ($_POST as $clave=>$valor){
            if(substr($clave, 0, 1) == '1')
                $id = $valor;
            if(substr($clave, 0, 1) == '2')
                $cantidad = $valor;
            if(substr($clave, 0, 1) == '3')
                $costo = $valor;
            if(substr($clave, 0, 1) == '4')
                $fecha = $valor;
            if($id != null & $cantidad != null & $fecha !=null & $costo !=null){
                $productosPedido = $this->mPedido->mConfirmarProductosPedido($pedido, $id, $cantidad, $costo, $fecha);
                $this->db->close();
                $id = null;
                $cantidad = null;
                $fecha = null;
                $costo = null;
            }
        }
        redirect('../?ruta=pedidos');
	}   
    
}

?>
