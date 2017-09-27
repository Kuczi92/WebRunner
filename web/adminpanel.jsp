<%-- 
    Document   : adminpanel
    Created on : 2017-08-29, 14:21:23
    Author     : Quchi
--%>


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
                                <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail" width="200"/>
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
          <img class="img-responsive" src="runners.jpg" />
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="addEvent.jsp">Dodaj Event.</a></h3>
          <p>Dodaj event biegowy. Podając o nim podstawowe informację. Tworząc event umozliwiasz dołączenie do niego przez innych użytkowników.</p>
        </div>
      </div>
    </div>
                            
                            
    <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
            <img class="img-responsive" src="IconAddArticle.jpg" height="500"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="addArticle.jsp">Dodaj Artykuł.</a></h3>
          <p>Dodaj oraz zredaguj artykuł, tak aby inny użytkownicy oraz goście mogli czytać wiadomości ze świata sportowego. </p>
        </div>
      </div>
    </div>                        

                            
    <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="EditChoosenArticle.jpg"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="ChooseArticleToEdit.jsp">Edytuj/Usuń Artykuł.</a></h3>
          <p>Zredaguj wybrany artykuł, aby inny użytkownicy oraz goście mogli czytać zaktualizowane wiadomości ze świata sportowego. Bądź usuń już nieaktualny artykuł.</p>
        </div>
      </div>
    </div>                        

      
    <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="addPhotos.jpg" />
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="addPicturesToEvent.jsp">Dodaj zdjęcia oraz przyłącz do nich uczestników Eventu .</a></h3>
          <p>Dodaj zdjęcia do wybranego przez siebie eventu biegowego, dla każdego zdjęcia masz możliwość dopięcia każdego uczestnika biegu gdy się na takim zdjęciu znajduję.</p>
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
          <p style="line-height: 0.3cm;"><font face="arial" color="black">Przejżyj listę wszystkich dostępnych Eventów by móc wybrać </p>
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
    
    <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="terryfyingFace.jpg" height="42" width="300"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="EditDeleteUserList.jsp">Edytuj lub usuń profil bądź profile użytkowników.</a></h3>
          <p style="line-height: 0.3cm;"><font face="arial" color="black">Dokonaj zmian parametrów profilów innych urzytkowników lub ich usuń.</p>
        </div>
      </div>
    </div>                        
                            
                            
    <div class="container">
      <div class="row">
        <div class="col col-md-3 col-sm-6">
          <img class="img-responsive" src="LostRunner.jpg" height="200" width="300"/>
        </div>
        <div class="col col-md-9 col-sm-6">
          <h3><a href="EditDeleteEventList.jsp">Edytuj lub usuń wybrany Event.</a></h3>
          <p style="line-height: 0.3cm;"><font face="arial" color="black">Dokonaj zmian w wybranym evencie Biegowym lub go usuń.</p>
        </div>
      </div>
    </div>                          
                            
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    </body>
</html>
