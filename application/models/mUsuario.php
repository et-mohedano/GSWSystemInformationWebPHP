<?php
    class mUsuario extends CI_Model{
        public function mLogin($dato){
            $result = $this->db->query('CALL spValidarAcceso("'.$dato["name"].'","'.$dato["psw"].'");');
            $acceso = $result->result_array();
            return $acceso;
        }
        public function mContarUsuarios(){
            $result = $this->db->query('call spConsUsuario(0,0,0);');
            $totalUsuarios = $result->result_array();
            return count($totalUsuarios);
        }
        public function mConsultarUsuarios($inicioPag, $numReg){
            $result = $this->db->query("call spConsUsuario(1,".$inicioPag.",".$numReg.");");
            $totalUsuarios = $result->result_array();
            return $totalUsuarios;
        }
        public function mFiltrarUsuario($cve){
            $result = $this->db->query("call spTraUsuario($cve);");
            $totalUsuarios = $result->result_array();
            return $totalUsuarios;
        }
        public function mModificarUsuario($cve,$nom,$ap,$am,$tel,$per,$pas, $rol){
            $result = $this->db->query("CALL spModUsuario($cve, '$nom','$ap','$am','$tel','$per','$pas','$rol', null);");
            return $result->result_array();
        }
        public function mEliminarUsuario($cve){
            $result = $this->db->query("CALL spDelUsuario('$cve');");
            return $result->result_array();
        }
        public function mRegistrarUsuario($nom, $pat, $mat, $tel, $per, $pswd, $rol){
            $result = $this->db->query("CALL spInsUsuario('$nom','$pat','$mat','$tel','$per','$pswd','$rol');");
            return $result->result_array();
        }
        public function mContarUsuariosIna(){
            $result = $this->db->query("call spConsUsuario(2,0,0);");
            $totalUsuarios= $result->result_array();
            return count($totalUsuarios);
        }
        public function mConsultarUsuariosIna($inicioPag,$numRegistro){
            $result = $this->db->query("call spConsUsuario(4,$inicioPag,$numRegistro);");
            $totalUsuarios= $result->result_array();
            return $totalUsuarios;
        }
        public function mActUsuario($cve){
            $result = $this->db->query("CALL spModUsuario($cve, '','','','','','','', 1);");
            return $result->result_array();
        }
    }
?>