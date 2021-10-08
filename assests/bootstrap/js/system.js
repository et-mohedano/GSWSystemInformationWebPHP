function agregarPedido(usuario,fecha){
    alertify.confirm('Confirmación de pedido', '¿Desea agregar un pedido?', 
    function(){
        location.href='?ruta=pedido-listado&agregar=1';
    }, 
    function(){ alertify.error('Pedido cancelado')});
    
}
function setProductoPedido(idPedido, fecha){
    var idProd = document.getElementById("txtProd").value;
    var cant = document.getElementById("txtCant").value;
    location.href = "?ruta=pedido-listado&ID="+idPedido+"&FECHA="+fecha+"&idProd="+idProd+"&cant="+cant;
}
function seleccionarCategoria(id){
    var selectCat = document.getElementById('txtCat');
    selectCat.value = id;
}