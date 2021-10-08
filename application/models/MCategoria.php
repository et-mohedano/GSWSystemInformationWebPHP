<?php
    class MCategoria extends CI_Model{
        
        public function mContarCategorias(){
            $result = $this->db->query('call spConsCategoria(0,0,0);');
            $totalCategorias = $result->result_array();
            return count($totalCategorias);
        }
        public function mContarCategoriasIna(){
            $result = $this->db->query('call spConsCategoria(2,0,0);');
            $totalCategorias = $result->result_array();
            return count($totalCategorias);
        }
        public function mConsultarCategorias($inicioPag, $numReg){
            $result = $this->db->query("call spConsCategoria(1,".$inicioPag.",".$numReg.");");
            $totalCategorias = $result->result_array();
            return $totalCategorias;
        }
        public function mConsultarCategoriasIna($inicioPag, $numReg){
            $result = $this->db->query("call spConsCategoria(4,$inicioPag,$numReg);");
            $totalCategorias = $result->result_array();
            return $totalCategorias;
        }
        public function mFiltrarCategorias($cve){
            $result = $this->db->query("call spTraCategoria($cve);");
            $totalCategorias = $result->result_array();
            return $totalCategorias;
        }
        public function mModificarCategorias($cve,$nom){
            $result = $this->db->query("CALL spModCategoria($cve, '$nom', 1);");
            return $result->result_array();
        }
        public function mEliminarCategorias($cve){
            $result = $this->db->query("CALL spDelCategoria('$cve');");
            return $result->result_array();
        }
        public function mActivarCategorias($cve, $nom){
            $result = $this->db->query("CALL spModCategoria('$cve', '$nom', 1);");
            return $result->result_array();
        }
        public function mRegistrarCategorias($nom){
            $result = $this->db->query("call spInsCategoria('$nom');");
            $totalCategorias = $result->result_array();
            return $totalCategorias;
        }
    }
?>