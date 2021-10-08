<?php
    class mProducto extends CI_Model{
        public function mBuscarProductos($nom){
            $renglon = $this->db->query("CALL spBuscaProducto('".$nom."')");
            $resultado = $renglon->result_array();
            return $resultado;
        }
        public function mConsultarProductosPDF($op){
            $renglon = $this->db->query("call spReportesPDF('$op');");
            $resultado = $renglon->result_array();
            return $resultado;
        }
        public function mContarProductos(){
            $result = $this->db->query('CALL spConsProducto(0,0,0);');
            $totalProductos = $result->result_array();
            return count($totalProductos);
        }
        public function mConsultarProductos($inicioPag,$numReg){
            $result = $this->db->query("call spConsProducto(1,$inicioPag,$numReg);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mFiltrarProducto($cve){
            $result = $this->db->query("call spTraProducto($cve);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mConsProveedores(){
            $result = $this->db->query("call spConsProveedor(0,0,0);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mConsCategorias(){
            $result = $this->db->query("call spConsCategoria(0,0,0);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mConsDatRel($cve){
            $result = $this->db->query("call spGetCategori($cve);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mModificarProducto($cve, $prov, $pres, $nom, $cant, $cad, $usu, $precio_v, $precio_a, $foto, $ubi, $cat){
            $result = $this->db->query("CALL spModProducto('$cve','$prov','$pres','$nom','$cant','$cad','$usu','$precio_v',' $precio_a','$foto', 1, '$ubi', '$cat');");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mEliminarProducto($cve){
            $result = $this->db->query("CALL spDelProducto('$cve');");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mContarProductosIna(){
            $result = $this->db->query("call spConsProducto(2,0,0);");
            $totalProductos = $result->result_array();
            return count($totalProductos);
        }
        public function mConsultarProductosIna($inicioPag,$numRegistro){
            $result = $this->db->query("call spConsProducto(4,$inicioPag,$numRegistro);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mActProducto($cve){
            $result = $this->db->query("CALL spModProducto('$cve',null,'','',null,null,null,null,null,'', 1, '', null);");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mRegistrarProducto($prov, $pres, $nom, $cant, $cad, $usu, $precio_v, $precio_a, $foto, $cat, $ubi){
            $result = $this->db->query("CALL spInsProducto('$prov','$pres','$nom','$cant','$cad','$usu','$precio_v','$precio_a','$foto', '$cat', '$ubi');");
            $totalProductos = $result->result_array();
            return $totalProductos;
        }
        public function mConsultarProductosAlerta(){
            $result = $this->db->query("call spConsProducto(0,0,0);");
            $productos = $result->result_array();
            return $productos;
        }
        public function mGetProdCat($cat){
            $result = $this->db->query("call spSelecProduc(".$cat.");");
            $productos = $result->result_array();
            return $productos; 
        }
        
    }
?>