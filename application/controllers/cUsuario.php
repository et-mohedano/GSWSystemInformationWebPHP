
<?php

class cUsuario extends CI_Controller {

	
	public function cLogin()
	{
		$this->load->model('mUsuario');
        $name=$this->input->post('name');
        $psw=$this->input->post('psw');
        $dato=[
            'name'  => $name,
            'psw'   => $psw
        ];
        $acceso = $this->mUsuario->mLogin($dato);
        if($acceso[0]["CLAVE"] != 0){
            // Logeado
			$_SESSION["id"] = $acceso[0]["CLAVE"];
            $_SESSION['nomUsuario'] = $acceso[0]['USUARIO'];
            $_SESSION['rolUsuario'] = $acceso[0]['ROL'];
            echo '<script>
                    alertify.alert("Acceso al sistema", "Bienvenid@ '.$_SESSION['nomUsuario'].'", function(){ window.location = "index.php?ruta=inicio"; });
                </script>';
        }else{
            // Error
            echo '<script>
                    alertify.alert("Acceso al sistema", "Error al ingresa, intentalo de nuevo", function(){ window.location = "index.php?ruta=login"; });
                </script>';
        }
	}
    public function contarUsuarios()
    {
        $this->load->model('mUsuario');
        $total = $this->mUsuario->mContarUsuarios();
        $this->db->close();		
		return $total;
	}
    public function consultarUsuarios($inicioPag,$numReg){
		$this->load->model('mUsuario');
        $datos = $this->mUsuario->mConsultarUsuarios($inicioPag,$numReg);				
		$this->db->close();
        return $datos;
	}
    public function filtrarUsuario($cve){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mFiltrarUsuario($cve);				
		$this->db->close();
        return $datos;
	}
    public function modificarUsuario($cve,$nom,$ap,$am,$tel,$per,$pas, $rol){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mModificarUsuario($cve,$nom,$ap,$am,$tel,$per,$pas, $rol);				
		$this->db->close();
        return $datos;
    }
    public function eliminarUsuario($cve){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mEliminarUsuario($cve);				
		$this->db->close();
        return $datos;
    }
    public function registrarUsuario($nom, $pat, $mat, $tel, $per, $pswd, $rol){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mRegistrarUsuario($nom, $pat, $mat, $tel, $per, $pswd, $rol);				
		$this->db->close();
        return $datos;
    }
    public function contarUsuariosIna(){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mContarUsuariosIna();				
		$this->db->close();
        return $datos;
    }
    public function consultarUsuariosIna($inicioPag,$numRegistro){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mConsultarUsuariosIna($inicioPag,$numRegistro);				
		$this->db->close();
        return $datos;
    }
    public function actUsuario($cve){
        $this->load->model('mUsuario');
        $datos = $this->mUsuario->mActUsuario($cve);
		$this->db->close();
        return $datos;
    }
}

?>
