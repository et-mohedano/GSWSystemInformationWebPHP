<div class="container-fluid">
    <header>
        <div class="row">
            <div class="col-4 text-center">
              <img src="assests/images/sistema/logo.png" class="img-fluid logo-sys" alt="...">
            </div>
            <div class="col title-logo">
                <span class="title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;GrasShopperWeb</span>
            </div>
        </div>
        <div class="row">
            <div class="text-center bg-dark bg-gradient footer-login col-12">
              <p class="footer-text">
                  Iniciar sesión</p>
            </div>
        </div>
    </header>
<main style="min-height: 26.55em !important;">
    <div class="row content-login">
        <div class="col-md">
        </div>
        <div class="col-md">
            <form method="POST">
              <div class="mb-3">
                <label for="name" class="form-label">Ingresa tu usuario:</label>
                <input type="text" class="form-control" name="name" id="name" aria-describedby="emailHelp">
              </div>
              <div class="mb-3">
                <label for="psw" class="form-label">Ingresa tu contraseña:</label>
                <input type="password" class="form-control" name="psw" id="psw">
              </div>
              <?php
                if(isset($_POST["btn-login"])){
                    if(!empty($_POST['name']) && !empty($_POST['psw'])){
                        $login = new cUsuario();
                        $login -> cLogin();
                    }else{
                        echo '<br><div class="alert alert-danger alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                Error al ingresar, rellena todos los campos
                            </div>';
                    }
                }
            ?>
              <div align="right">
                  <button type="submit" name="btn-login" id="btn-login" class="btn btn-sys">Aceptar</button>
              </div>
            </form>
        </div>
        <div class="col-md">
        </div>
    </div>
</main>
