<?php
    class mProveedor extends CI_Model{
        public function mContarProveedores(){
            $result = $this->db->query('call spConsProveedor(0,0,0);');
            $totalProveedores = $result->result_array();
            return count($totalProveedores);
        }
        public function mConsultarProveedores($inicioPag, $numReg){
            $result = $this->db->query("call spConsProveedor(1,".$inicioPag.",".$numReg.");");
            $totalProveedores = $result->result_array();
            return $totalProveedores;
        }
        public function mFiltrarProveedores($cve){
            $result = $this->db->query("call spTraProveedor($cve);");
            $totalProveedores = $result->result_array();
            return $totalProveedores;
        }
        public function mModificarProveedores($cve,$nomEm,$numSup,$tel,$correo,$nom,$ap,$am){
            $result = $this->db->query("CALL spModProveedor('$cve', '$nomEm','$numSup','$tel','$correo','$nom','$ap','$am', 1);");
            return $result->result_array();
        }
        public function mEliminarProveedores($cve){
            $result = $this->db->query("CALL spDelProveedor('$cve');");
            return $result->result_array();
        }
        public function mRegistrarProveedores($nomEm,$numSup,$tel,$correo,$nom,$ap,$am){
            $result = $this->db->query("CALL spInsProveedor('$nomEm','$numSup','$tel','$correo','$nom','$ap','$am');");
            return $result->result_array();
        }
        public function mContarProveedoresIna(){
            $result = $this->db->query('call spConsProveedor(2,0,0);');
            $totalProveedores = $result->result_array();
            return count($totalProveedores);
        }
        public function mConsultarProveedoresIna($inicioPag, $numReg){
            $result = $this->db->query("call spConsProveedor(4,$inicioPag,$numReg);");
            $totalProveedores = $result->result_array();
            return $totalProveedores;
        }
        public function mActivarProveedores($cve){
            $result = $this->db->query("CALL spModProveedor($cve, '','','','','','','', 1);");
            $totalProveedores = $result->result_array();
            return $totalProveedores;
        }
    }
?>