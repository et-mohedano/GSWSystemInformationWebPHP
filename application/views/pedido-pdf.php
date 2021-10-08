<?php
$rr=0;
$pedido = new cPedido();
$consulta = $pedido->mostrarProductosPedido($idPedido);
require('application/pdf/fpdf.php');
//CREAR UN NUEVO ARCHIVO PDF 
$pdf=new FPDF();
$pdf->SetTitle('Pedido');
//AGREGAR UNA NUEVA PÁGINA AL ARCHIVO PDF
$pdf->AddPage();
//CONFIGURAR LA FUENTE: TIPO, LETRA, ESTILO, TAMAÑO
$pdf->SetFont('Arial','B',16);
//Image(rutaNombreImagen,col, renglon, largo, alto, ruta) -->permite colocar una imagen en el reporte
$pdf->Image('assests/images/sistema/logo.png' , 10 ,10, 30 , 20,'PNG', '');
//col, ren
$pdf->Cell(50,10);
//se recomienda manejarlo separado para poder dejarlo en el mismo renglón del logo
$pdf->write(15, 'Pedido: '.$idPedido.' | Fecha: '.$fecha);
// $pdf->Cell(50,10,'Usuario: '.$usuario);
// $pdf->write(25, 'Usuario: '.$usuario);
// $pdf->write(35, 'Fecha: '.$fecha);
//GENERA UNA LÍNEA, X1,Y1, X2,Y2
$pdf->line(10,40,183,40);
$pdf->Ln(); //hace un enter
$pdf->Ln();
$pdf->SetFont('Arial','B',12);
//GENERA UNA NUEVA CELDA DENTRO DE LA HOJA
//CELL(COLUMNA, ANCHO DE LA CELDA GENERADA, VALOR A IMPRIMIR, BORDE-->0|1)
$pdf->Cell(30,10, '',0);
$pdf->Cell(65,10, 'Producto',0);
$pdf->Cell(40,10, 'Cantidad',0);
$pdf->Cell(25,10, 'Foto',0);
$pdf->line(10,48,183,48);
$pdf->Ln();
$pdf->SetFont('Arial','',11);
// RECORREN LOS DATOS DE LA CONSULTA PARA AGREGARLOS A UNA CELDA DE LA MISMA PÁGINA
 for($rr=0;$rr<count($consulta);$rr++) {
    $pdf->Cell(30,10, '',0);
    $pdf->Cell(65,13,$consulta[$rr]['NOMBRE'],0);
    $pdf->Cell(40,13,$consulta[$rr]['CANTIDAD'],0);
    $pdf->Image("assests/images/".$consulta[$rr]['FOTO'], 145 , 51+(13*$rr), 10, 10);
    $pdf->Ln();
 }
 $pdf->write(15, 'Creado por: '.$usuario);
$pdf->Output();
?>