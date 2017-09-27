<%-- 
    Document   : EditUser
    Created on : 2017-09-06, 02:26:48
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
        <div class="col col-md-4 col-sm-6">  
                <div class="container">
                     <div class="col-sm-6 col-md-4 col-md-4">
                         <form class="form-signin" method="post" action="ChangeUserParameters" enctype="multipart/form-data" >
                                 <h2 class="form-signin-heading">Wpisz swoje nowe dane.</h2>
                                 <input name="inputEmail" type="email" class="form-control" placeholder="Email" required autofocus />
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
                               
                               <button class="btn btn-lg btn-primary btn-block" type="submit" >Potwierdź zmiany</button>
                         </form>
                     </div>
                 </div>
            </div>
        
        
        <div class="col col-md-8 col-sm-6">                
                    <div class="container">   
                                   <div class="col col-md-3 col-sm-6">
                                        <img class="img-responsive" src="ChangePassword.png" width ="160" height="160" />
                                   </div>
                                   <div class="col col-md-3 col-sm-6">
                                        <h3><a href="ChangePassword.jsp">Zmień hasło.</a></h3>
                                        <p>Wypełnij formularz by zmienić hasło.</p>
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
    <script src="scripts/inputimage.js"></script>
    <script src="scripts/datepicker.js"></script>
    <script src="scripts/PasswordChecking.js"></script>
    </body>
</html>
