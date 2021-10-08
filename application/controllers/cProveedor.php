<?php

class cProveedor extends CI_Controller {

	
    public function contarProveedores()
    {
        $this->load->model('mProveedor');
        $total = $this->mProveedor->mContarProveedores();
        $this->db->close();		
		return $total;
	}
    public function consultarProveedores($inicioPag,$numReg){
		$this->load->model('mProveedor');
        $datos = $this->mProveedor->mConsultarProveedores($inicioPag,$numReg);				
		$this->db->close();
        return $datos;
	}
    public function filtrarProveedores($cve){
        $this->load->model('mProveedor');
        $datos = $this->mProveedor->mFiltrarProveedores($cve);				
		$this->db->close();
        return $datos;
	}
    public function modificarProveedores($cve,$nomEm,$numSup,$tel,$correo,$nom,$ap,$am){
        $this->load->model('mProveedor');
        $datos = $this->mProveedor->mModificarProveedores($cve,$nomEm,$numSup,$tel,$correo,$nom,$ap,$am);				
		$this->db->close();
        return $datos;
    }
    public function eliminarProveedores($cve){
        $this->load->model('mProveedor');
        $datos = $this->mProveedor->mEliminarProveedores($cve);				
		$this->db->close();
        return $datos;
    }
    public function registrarProveedores($nomEm,$numSup,$tel,$correo,$nom,$ap,$am){
        $this->load->model('mProveedor');
        $datos = $this->mProveedor->mRegistrarProveedores($nomEm,$numSup,$tel,$correo,$nom,$ap,$am);				
		$this->db->close();
        return $datos;
    }
    public function contarProveedoresIna()
    {
        $this->load->model('mProveedor');
        $total = $this->mProveedor->mContarProveedoresIna();
        $this->db->close();		
		return $total;
	}
    public function consultarProveedoresIna($inicioPag,$numReg){
		$this->load->model('mProveedor');
        $datos = $this->mProveedor->mConsultarProveedoresIna($inicioPag,$numReg);				
		$this->db->close();
        return $datos;
	}
    public function activarProveedores($cve){
        $this->load->model('mProveedor');
        $datos = $this->mProveedor->mActivarProveedores($cve);				
		$this->db->close();
        return $datos;
    }
}

?>
