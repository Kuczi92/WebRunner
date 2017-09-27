<%-- 
    Document   : DeleteUsersFromEvent
    Created on : 2017-09-09, 21:29:56
    Author     : Quchi
--%>

<%@page import="Model.Event"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Role"%>
<%@page import="javax.persistence.Query"%>
<%@page import="java.util.List"%>
<%@page import="Model.User"%>
<%@page import="Model.Number"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
        <title>JSP Page</title>
    </head>
    <body>
    <title>Strona Główna</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.min.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/fragments/header.jspf"/>
    <%
    List <Number> UsersNumber = null;
    Event ChosenEvent = null ;
    EntityManager em = DatabaseConnection.getEntityManager();
    boolean redirect = true;
    Integer EventID = (Integer) request.getSession().getAttribute("EventID");
     try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("select N from Event E, Number N where N Member E.numberList and E.idevent=:EventID").setParameter("EventID", EventID);
                UsersNumber =  query.getResultList();
                em.getTransaction()
            .commit();
        }
    catch(Exception ex){
            redirect = false;
        }
     finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
         }
    %>
    <div class="container">
        <div class="jumbotron">
            <div class="row">
             <%
                       if(ChosenEvent==null){
                                          %>
                                          
                                          <%
                                            }
                       else{
                             byte[] imageInByteArray = ChosenEvent.getIcon();
                             String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
                                          %>
                                          <div class="col col-md-9 col-sm-6"> 
                                          <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
                                            <div class="row panel">
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
                                                                            <img src="sample.png" class="img-thumbnail" width="200"/>
                                                                        <% } 
                                                                    %>
                                                                </div>
                                                                <div class="col col-md-6 col-sm-6">
                                                                    <blockquote>
                                                                        <p><a href="currentEvent.jsp?EventID=<%out.print(ChosenEvent.getIdevent());%>"><% out.print(ChosenEvent.getName()); %> </a></p> <small><cite title="Source Title"><%   out.print(ChosenEvent.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
                                                                    </blockquote>
                                                                    <p> <i class="glyphicon glyphicon-calendar"></i><% out.print(ChosenEvent.getDate());%>
                                                                        <br/> 

                                                                </div>
                                                            </div>
                                                        </div>
                                              </div>
                                            </div>
                                         </div>                         
                                       
                                          <%
                       }
                    %>    
            </div>
        </div>                               
    </div>
            
            
    <div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="page-header">
                <h1>Usuń z listy uczestników zapisanego użytkownika.</h1>
            </div>
        </div>
    </div>
    <div class="row">
    </div>
    <div class="row">
        <div class="col-lg-4 col-lg-offset-4">
            <input type="search" id="search" value="" class="form-control" placeholder="Wpisz nazwisko,imię bądź numer">
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
            <table class="table" id="table">
                <thead>
                    <tr>
                        <th>Imię</th>
                        <th>Nazwisko</th>
                        <th>Avatar</th>
                        <th>Adres</th>
                        <th>Płeć</th>
                        <th>Data urodzin</th>
                        <th>E - mail</th>
                        <th>Number startowy</th>
                    </tr>
                </thead> 
                <%  for (Number CurrentNumber : UsersNumber){
                    User CurrentUser = CurrentNumber.getUser();
                    byte[] imageInByteArray = CurrentUser.getIcon();
                    String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray); 
                    %>
                    
                           <tr>
                              <td><% out.print(CurrentUser.getName()); %></td>
                              <td><% out.print(CurrentUser.getSurname()); %></td>
                                                                     <td><%
                                                                        if(b64.length()>30){
                                                                          %>
                                                                            <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail" width="50"/>
                                                                          <%}
                                                                        else{
                                                                           %>  
                                                                            <img src="defaultAvatar.jpg" class="img-thumbnail" width="50"/>
                                                                        <% } 
                                                                    %></td>
                              <td><% out.print(CurrentUser.getAdress()); %></td>
                              <td><% out.print(CurrentUser.getSex()); %></td>
                              <td><% out.print(CurrentUser.getBirth()); %></td>
                              <td><% out.print(CurrentUser.getEmail()); %></td>
                              <td><% out.print(CurrentNumber.getEventNumber()); %></td>
                              <td>
                                  <form class="form-inline" name="DeleteChoosenPicture"  method="post" action="DeleteUsersFromEvent">
                                      <div class="form-group row">
                                              <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenUserNameDelete" value="<%out.print(CurrentUser.getUsername());%>" >Usuń</button>
                                     </div>     
                                  </form>  
                              </td>
                           </tr>
                    <%
                    }
                    %>
                      
            </table>
            </div>
            <hr>
        </div>
      </div>
    </div>                                    
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script src="scripts/inputimage.js"></script>
    <script src="scripts/searchFinder.js"></script>
    <script src="scripts/searchable.js"></script>
    </body>
</html>
