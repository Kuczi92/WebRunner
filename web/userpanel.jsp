<%-- 
    Document   : userpanel
    Created on : 2017-08-29, 16:40:53
    Author     : Quchi
--%>




<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <title>Strona Główna</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.min.css" rel="stylesheet">
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
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="dołączenie.jpg" height="42" width="300"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="listEvent.jsp">Dołącz do Eventu</a></h3>
          <p style="line-height: 0.3cm;"><font face="arial" color="black">Przejżyj listę wszystkich dostępnych Eventów biegowych, by wybrać tę najabrdziej odpowiednią dla siebie.</p>
        </div>
      </div>
    </div>
  
    <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="ViewYourself.jpg" height="42" width="300"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="listEvent.jsp">Zobacz zdjęcia na których jesteś.</a></h3>
          <p style="line-height: 0.3cm;"><font face="arial" color="black">Przejżyj listę wszystkich dostępnych zdjęć z Eventów biegowych , na których znajduję się twoja osoba.</p>
        </div>
      </div>
    </div> 
  
   <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="EditProfile.jpg" height="42" width="300"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="EditUser.jsp">Edytuj swój profil.</a></h3>
          <p style="line-height: 0.3cm;"><font face="arial" color="black">Dokonaj zmian parametrów swojego profilu, tutaj masz równierz możliwość zmiany hasła dostępu do swojego konta.</p>
        </div>
      </div>
    </div>                         
                            
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
                
    </body>
</html>
