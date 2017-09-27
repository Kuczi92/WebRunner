<%-- 
    Document   : chooseRunnerstoJoinPic
    Created on : 2017-09-04, 20:26:21
    Author     : Quchi
--%>

<%@page import="Model.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="Model.Picture"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="Model.Event"%>
<%@page import="Model.Number"%>
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
        
    Event ChosenEvent =(Event) request.getSession().getAttribute("EventName");
    byte[] imageInByteArray = ChosenEvent.getIcon();
    String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
    EntityManager em = DatabaseConnection.getEntityManager();
    Integer IDpicture = Integer.valueOf(request.getParameter("ChoosenPictureID"));
    request.getSession().setAttribute("IDpicture",request.getParameter("ChoosenPictureID"));
    Picture currentPic = null;
    List <Number> NumberOnEvent = null;
    boolean redirect = true;
     try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query =  em.createQuery("select p from Picture P where P.picturePK.idpicture=:ID").setParameter("ID", IDpicture);
                currentPic =  (Picture)  query.getSingleResult();
                Query queryUsers =
              em.createQuery("select N from Number N where N.event.idevent=:IDEvent and :PKpic NOT MEMBER OF N.pictureList")
             .setParameter("IDEvent", ChosenEvent.getIdevent()).setParameter("PKpic", currentPic);
                NumberOnEvent =  queryUsers.getResultList();
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
            <div class="col col-md-12 col-sm-6">
                <div class="col col-md-8 col-sm-6">
                      <h3>Wybierz biegaczy znajdujących się na podanym zdjęciu :</h3>
                                          <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
                                            <div class="row panel">
                                                        <div class="container">
                                                            <div class="row">
                                                                <div class="col col-md-3 col-sm-6">
                                                                    <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail" width="200"/>
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
                                         <div class="col col-md-8 col-sm-6"><%
                                              if(currentPic!=null)
                                              {
                                                  imageInByteArray = currentPic.getPicture();
                                                  b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray); %>  
                                                  <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail picture hidden-xs"/>
                                              <%
                                                }  
                                              %>
                                              
                                              
                                         </div>                               
               </div>
            </div>
        </div>
                                              
                                              
                                              
    </div>
    <div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="page-header">
                <h1>Dołącz poszczególnych biegaczy do danego obrazka.</h1>
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
            <table class="table" id="table">
                <thead>
                    <tr>
                        <th>Imię</th>
                        <th>Nazwisko</th>
                        <th>Avatar</th>
                        <th>Numer Startowy</th>
                    </tr>
                </thead> 
                <% for (Number CurrentNumber : NumberOnEvent){
                    User CurrentUser = CurrentNumber.getUser();
                    imageInByteArray = CurrentUser.getIcon();
                    b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray); 
                    
                    %>
                    
                           <tr>
                              <td><% out.print(CurrentUser.getName()); %></td>
                              <td><% out.print(CurrentUser.getSurname()); %></td>
                              <td><img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail picture hidden-xs" width="50" height="50"/></td>
                              <td><% out.print(CurrentNumber.getEventNumber()); %></td>
                              <td>
                                  <form name="DeleteChoosenPicture"  method="post" action="JoinPictureToEventUsers">
                                         <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenUserName" value="<%out.print(CurrentUser.getUsername());%>" >Dołącz</button>
                                  </form></td>
                           </tr>
                    
                    <%
                }
                    %>
                                    
                          

            </table>
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
