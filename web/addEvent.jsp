<%-- 
    Document   : addEvent
    Created on : 2017-09-02, 14:24:51
    Author     : Quchi
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Strona Główna</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/styles.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
        <title>JSP Page</title>
    </head>
    
  <body>
     
   <jsp:include page="/WEB-INF/fragments/header.jspf"/>
     
    <div class="container">
      <div class="jumbotron">
        <h3>Dodaj Event do bazy</h3>
        <div class="container">
            <div class="col-sm-6 col-md-4 col-md-offset-4">
            <form class="form-signin" method="post" action="addEvent" enctype="multipart/form-data" >
                    <h2 class="form-signin-heading">Dodaj Event</h2>
                    <input name="inputEventName" type="text" class="form-control" placeholder="Podaj nazwę eventu" required autofocus />
                    <input name="inputEventAdress" type="text"  class="form-control" placeholder="Miejsce wydarzenia" required autofocus />
                    
                       
                                <label>Wybierz logo</label>
                                <div class="input-group">
                                    <span class="input-group-btn">
                                        <span class="btn btn-default btn-file">
                                            Przeglądaj <input type="file" id="imgInp" name = "inputEventAvatar">
                                        </span>
                                    </span>
                                    <input type="text" class="form-control" readonly>
                                </div>
                                <img id='img-upload'/>
                
                        
                    <label>Data wydarzenia</label>  
                    <div class='input-group date' id='datetimepicker5'>
                                        <input type='text' name ="inputEventDate" class="form-control" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                   </div>
                     
                  <button class="btn btn-lg btn-primary btn-block" type="submit" >Dodaj wydarzenie</button>
               
                
            </form>
        </div>
        </div>
        
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
