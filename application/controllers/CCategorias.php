<?php

class CCategorias extends CI_Controller {

    public function contarCategorias()
    {
        $this->load->model('MCategoria');
        $total = $this->MCategoria->mContarCategorias();
        $this->db->close();		
		return $total;
	}
    public function contarCategoriasIna()
    {
        $this->load->model('MCategoria');
        $total = $this->MCategoria->mContarCategoriasIna();
        $this->db->close();		
		return $total;
	}
    public function consultarCategorias($inicioPag,$numReg){
		$this->load->model('MCategoria');
        $datos = $this->MCategoria->mConsultarCategorias($inicioPag,$numReg);				
		$this->db->close();
        return $datos;
	}
    public function consultarCategoriasIna($inicioPag,$numReg){
		$this->load->model('MCategoria');
        $datos = $this->MCategoria->mConsultarCategoriasIna($inicioPag,$numReg);				
		$this->db->close();
        return $datos;
	}
    public function filtrarCategorias($cve){
        $this->load->model('MCategoria');
        $datos = $this->MCategoria->mFiltrarCategorias($cve);				
		$this->db->close();
        return $datos;
	}
    public function modificarCategorias($cve, $nom){
        $this->load->model('MCategoria');
        $datos = $this->MCategoria->mModificarCategorias($cve,$nom);				
		$this->db->close();
        return $datos;
    }
    public function eliminarCategorias($cve){
        $this->load->model('MCategoria');
        $datos = $this->MCategoria->mEliminarCategorias($cve);				
		$this->db->close();
        return $datos;
    }
    public function activarCategorias($cve, $nom){
        $this->load->model('MCategoria');
        $datos = $this->MCategoria->mActivarCategorias($cve, $nom );				
		$this->db->close();
        return $datos;
	}
    public function registrarCategorias($nom){
        $this->load->model('MCategoria');
        $datos = $this->MCategoria->mRegistrarCategorias($nom);				
		$this->db->close();
        return $datos;
	}
}

?>
