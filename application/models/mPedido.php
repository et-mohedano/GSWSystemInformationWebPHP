<?php
    class mPedido extends CI_Model{
        public function mMostrarPedidos(){
            $result = $this->db->query('call spConsPedido();');
            $pedidos = $result->result_array();
            return $pedidos;
        }
        public function mCambiarEstado($id, $estado){
            $result = $this->db->query('call spConfiPedido('.$id.','.$estado.');');
            $resultado = $result->result_array();
            return $resultado;
        }
        public function mInsPedido($usuario){
            $result = $this->db->query('call spInsPedido("'.$usuario.'");');
            $resultado = $result->result_array();
            return $resultado;
        }
        public function mMostrarProductosPedido($id){
            $result = $this->db->query('call spVerPedido("'.$id.'");');
            $resultado = $result->result_array();
            return $resultado;
        }
        public function mInsPedidoProducto($pedido, $prod, $cant, $fecha){
            $result = $this->db->query('call spInsProdPed('.$pedido.','.$prod.','.$cant.',"'.$fecha.'");');
            $resultado = $result->result_array();
            return $resultado;
        }
        public function mDelPedidoProducto($prod, $pedido){
            $result = $this->db->query('call spDelProdPed('.$prod.','.$pedido.');');
            $resultado = $result->result_array();
            return $resultado;
        }
        public function mConfirmarProductosPedido($pedido, $id, $cantidad, $costo, $fecha){
            $result = $this->db->query('call spModPedPro('.$pedido.','.$id.',"'.$fecha.'","'.$cantidad.'","'.$costo.'");');
            $resultado = $result->result_array();
            return $resultado;
        }
    }
?>