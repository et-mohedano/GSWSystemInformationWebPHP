<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class cProducto extends CI_Controller {
	public function buscarProductos($nom){
		$this->load->model('mProducto');
        $datos = $this->mProducto->mBuscarProductos($nom);
        $this->db->close();
        return $datos;
	}
    public function consultarProductosPDF($op){
        $this->load->model('mProducto');
        $datos = $this->mProducto->mConsultarProductosPDF($op);
        $this->db->close();
        return $datos;
    }
    public function contarProductos(){
		$this->load->model('mProducto');
        $total = $this->mProducto->mContarProductos();
        $this->db->close();		
		return $total;
	}
    public function consultarProductos($inicioPag,$numReg){
		$this->load->model('mProducto');
        $total = $this->mProducto->mConsultarProductos($inicioPag,$numReg);
        $this->db->close();		
		return $total;
	}
    public function filtrarProducto($cve){
		$this->load->model('mProducto');
        $total = $this->mProducto->mFiltrarProducto($cve);
        $this->db->close();		
		return $total;
	}
    public function consproveedores(){
		$this->load->model('mProducto');
        $total = $this->mProducto->mConsProveedores();
        $this->db->close();		
		return $total;
	}
    public function consCategorias(){
		$this->load->model('mProducto');
        $total = $this->mProducto->mConsCategorias();
        $this->db->close();		
		return $total;
	}
    public function consDatRel($cve){
		$this->load->model('mProducto');
        $total = $this->mProducto->mConsDatRel($cve);
        $this->db->close();		
		return $total;
	}
    public function modificarProducto($cve, $prov, $pres, $nom, $cant, $cad, $usu, $precio_v, $precio_a, $foto, $ubi, $cat){
		$this->load->model('mProducto');
        $total = $this->mProducto->mModificarProducto($cve, $prov, $pres, $nom, $cant, $cad, $usu, $precio_v, $precio_a, $foto, $ubi, $cat);
        $this->db->close();		
		return $total;
	}
    public function eliminarProducto($cve){
		$this->load->model('mProducto');
        $total = $this->mProducto->mEliminarProducto($cve);
        $this->db->close();		
		return $total;
	}
    public function contarProductosIna(){
		$this->load->model('mProducto');
        $total = $this->mProducto->mContarProductosIna();
        $this->db->close();		
		return $total;
	}
    public function consultarProductosIna($inicioPag,$numRegistro){
		$this->load->model('mProducto');
        $total = $this->mProducto->mConsultarProductosIna($inicioPag,$numRegistro);
        $this->db->close();		
		return $total;
	}
    public function actProducto($cve){
		$this->load->model('mProducto');
        $total = $this->mProducto->mActProducto($cve);
        $this->db->close();		
		return $total;
	}
    public function registrarProducto($prov, $pres, $nom, $cant, $cad, $usu, $precio_v, $precio_a, $foto, $cat, $ubi){
		$this->load->model('mProducto');
        $total = $this->mProducto->mRegistrarProducto($prov, $pres, $nom, $cant, $cad, $usu, $precio_v, $precio_a, $foto, $cat, $ubi);
        $this->db->close();		
		return $total;
	}
    public function consultarProductosAlerta(){
		$this->load->model('mProducto');
        $datos = $this->mProducto->mConsultarProductosAlerta();
        $this->db->close();		
		return $datos;
	}
    public function getProdCat($cat){
		$this->load->model('mProducto');
        $datos = $this->mProducto->mGetProdCat($cat);
        $this->db->close();		
		return $datos;
	}
    
}
?>