
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
  <head>
    <title>Web runner - rejestracja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
  </head>
 
  <body>
      
    <jsp:include page="/WEB-INF/fragments/header.jspf"/>
    <div class="container">
      <div class="jumbotron">
       
      </div>
    </div>
    
    <div class="container">
        <div class="col-sm-6 col-md-4 col-md-offset-4">
            <form class="form-signin" method="post" action="registration" enctype="multipart/form-data" >
                    <h2 class="form-signin-heading">Zarejestruj się</h2>
                    <input name="inputEmail" type="email" class="form-control" placeholder="Email" required autofocus />
                    <input name="inputUsername" type="text" name="inputUsername" class="form-control" placeholder="Nazwa użytkownika" required autofocus />
                    <input name="inputPassword" type="password" class="form-control" placeholder="Hasło" required />
                    <input name="inputName" type="text" class="form-control" placeholder="Imię" required />
                    <input name="inputSurname" type="text" class="form-control" placeholder="Nazwisko" required />
                    <input name="inputAdress" type="text" class="form-control" placeholder="Adres" required />
                    <label><input type="radio" name="sex" value="K">Kobieta</label>
                    <label><input type="radio" name="sex" value="M">Mężczyzna</label>
                    <div class="container">
                    <div class="col-md-3">
                            <label>Wybierz avatar</label>
                            <div class="input-group">
                                <span class="input-group-btn">
                                    <span class="btn btn-default btn-file">
                                        Przeglądaj <input name = "inputAvatar" type="file" id="imgInp" />
                                    </span>
                                </span>
                                <input type="text" class="form-control" readonly>
                            </div>
                            <img id='img-upload'/>
                    </div>
                    </div>
                  <label>Data urodzenia</label>  
                  <div class='input-group date' id='datetimepicker5'>
                                        <input type='text' name ="inputbirth" class="form-control" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                  </div>
                     
                  <button class="btn btn-lg btn-primary btn-block" type="submit" >Zarejestruj</button>
               
                
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script type="text/javascript" src="scripts/moment.js"></script>
    <script type="text/javascript" src="scripts/bootstrap-datetimepicker.js"></script>
    <script src="scripts/inputimage.js"></script>
    <script src="scripts/datepicker.js"></script>
  </body>
  
</html>
