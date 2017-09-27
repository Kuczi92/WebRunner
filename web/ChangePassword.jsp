<%-- 
    Document   : ChangePassword
    Created on : 2017-09-06, 17:45:41
    Author     : Quchi
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edycja urzytkownika</title>
    </head>
    <body>
      
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
  </head>
  <body>
     
   <jsp:include page="/WEB-INF/fragments/header.jspf"/>
     <% User user = (User)session.getAttribute("user"); %>
        <%
          String b64 = null;
          byte[] imageInByteArray = user.getIcon();
          b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
        %>
    <div class="container">
      <div class="jumbotron">
        <h3>Panel użytkownika</h3>
        <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
	<div class="row panel">
           <div class="header">
                <span>
                    <div class="container">
                        <div class="row">
                            <div class="col col-md-3 col-sm-6">
                                <%
                                   if(b64.length()>30){
                                     %>
                                       <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail" width="200"/>
                                     <%}
                                   else{
                                      %>  
                                       <img src="defaultAvatar.jpg" class="img-thumbnail" width="200"/>
                                   <% } 
                               %>
                            </div>
                            <div class="col col-md-6 col-sm-6">
                                <blockquote>
                                    <p><% out.print(user.getName()); %>  <% out.print(user.getSurname()); %> </p> <small><cite title="Source Title"><% out.print(user.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
                                </blockquote>
                                <p> <i class="glyphicon glyphicon-envelope"></i><% out.print(user.getEmail()); %>
                                    <br/> 
                                    <i class="glyphicon glyphicon-user"></i> <% 
                                        if(user.getSex().equals("M")){
                                            out.print("Mężczyzna");
                                            }
                                        else
                                            {
                                                out.print("Kobieta");
                                            } 
                                         %>
                                    <br/> 
                                    <i class="glyphicon glyphicon-gift"></i><% out.print(user.getBirth()); %></p>
                            </div>
                        </div>
                    </div>
                </span>
           </div>
          </div>
        </div>              
      </div>
    </div>
<div class="container">
    <div class="row">
        <div class="col col-md-8 col-md-offset-4">  
                <div class="container">
                     <div class="col-sm-6 col-md-4 col-md-4">
                         <form data-toggle="validator" role="form" action="ChangePassword" method="post">
                                        <label for="inputPassword" class="control-label">Zmiana hasła.</label>
                                              <input name="inputOldPassword" type="password" class="form-control" placeholder="Wpisz stare hasło" required />
                                              <input type="password" data-minlength="6" class="form-control" id="inputPassword" placeholder="Wpisz nowe hasło" required>
                                              <div class="help-block">Minimalnie 6 znaków.</div>
                                              <input name="inputNewPassword" type="password" class="form-control" id="inputPasswordConfirm" data-match="#inputPassword" data-match-error="Napisz poprawnie nowe hasło" placeholder="Potwierdź nowe hasło" required>
                                              <div class="help-block with-errors"><%
                                                  if(request.getParameter("error")!=null)
                                                       out.print(request.getParameter("error"));
                                                  %></div>
                                        <div class="form-group">
                                          <button type="submit" class="btn btn-primary">Potwierdź zmiany.</button>
                                        </div>
                        </form>
                     </div>
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
    <script type="text/javascript" src="scripts/PasswordChecking.js"></script>
    </body>
</html>
