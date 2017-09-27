<%-- 
    Document   : currentEvent
    Created on : 2017-09-02, 14:27:42
    Author     : Quchi
--%>

<%@page import="java.util.List"%>
<%@page import="Model.User"%>
<%@page import="Model.Event"%>
<%@page import="Model.Number"%>
<%@page import="javax.persistence.Query"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
        Integer EventID=null;    
        Event event = null;
        List <Number> Users = null;
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        
        
         try
         {
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            EventID = Integer.valueOf((String)request.getParameter("EventID"));
           
            Query query = em.createQuery("select e from Event e where e.idevent=:name").setParameter("name",EventID );
            event = (Event) query.getSingleResult();
            
            Query queryUsers = em.createQuery("select n From Number n where n.event=:nameEv").setParameter("nameEv",event );
            Users =  queryUsers.getResultList();
            
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
         byte[] imageInByteArray = event.getIcon();
         String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
                                
    %>
        <jsp:include page="/WEB-INF/fragments/header.jspf"/>
        
      <div class="container">
      <div class="jumbotron">
        <h3>Panel Biegu.</h3>
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
                                       <img src="sample.png" class="img-thumbnail" width="200"/>
                                   <% } 
                               %>
                            </div>
                            <div class="col col-md-6 col-sm-6">
                                <blockquote>
                                    <p><% out.print(event.getName()); %> </p> <small><cite title="Source Title"><%   out.print(event.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
                                </blockquote>
                                <p> <i class="glyphicon glyphicon-calendar"></i><% out.print(event.getDate());%>
                                    <br/> 
                                    
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
              <div class="col col-md-6 col-sm-6">  
                    <div class="container">
                            <div class="col col-md-3 col-sm-6">
                                <img class="img-responsive" src="addEventLogo.png" width ="160" height="160" />
                            </div>
                            <div class="col col-md-3 col-sm-6">
                              <h3><a href="joinEvent.jsp?EventID=<% out.print(EventID); %>">Dołącz do eventu.</a></h3>
                               <p>Dołącz do powyższego biegu.</p>
                            </div>
                    </div>
              </div>
              <div class="col col-md-6 col-sm-6">                
                    <div class="container">   
                                   <div class="col col-md-3 col-sm-6">
                                        <img class="img-responsive" src="SeePicturesEvent.png" width ="160" height="160" />
                                   </div>
                                   <div class="col col-md-3 col-sm-6">
                                        <h3><a href="eventpicturesList.jsp?EventID=<% out.print(EventID); %>">Zdjęcia z eventu.</a></h3>
                                        <p>Zobacz zdjęcia z poprzednich edycji bądź wykonanych w czasie biegu.</p>
                                  </div> 
                    </div>
              </div>  
            </div>
         </div>
   <div class="container">
            <div class="row">       
               <div class="col col-md-6 col-sm-6">  
                    <div class="container">
                            <div class="col col-md-3 col-sm-6">
                                <img class="img-responsive" src="selfie.png" width ="160" height="160" />
                            </div>
                            <div class="col col-md-3 col-sm-6">
                              <h3><a href="ListUserPicturesOnCurrentEvent.jsp?EventID=<% out.print(EventID); %>">Zobacz siebie.</a></h3>
                               <p>Zobacz zdjęcia na których się znajdujesz podczas eventu.</p>
                            </div>
                    </div>
               </div>
                               
               <div class="col col-md-6 col-sm-6">  
                    <div class="container">
                            <div class="col col-md-3 col-sm-6">
                                <img class="img-responsive" src="DeleteYourselfFromEvent.jpg" width ="160" height="160" />
                            </div>
                            <div class="col col-md-3 col-sm-6">
                              <h3><a href="DeleteYourselfFromEvent?EventID=<% out.print(EventID); %>">Odwołaj uczestnictwo w biegu.</a></h3>
                               <p>Usuń swój zapis na wybrany bieg.</p>
                            </div>
                    </div>
               </div>
                               
               </div>  
   </div>
              
           
            
                
         <div class="container">
            <h2>Lista uczestników biegu.</h2>
            <p></p>
            <div class="table-responsive">            
            <table class="table">
              <thead>
                <tr>
                  <th>Login</th>  
                  <th>Imię</th>
                  <th>Nazwisko</th>
                  <th>Data urodzin</th>
                  <th>Płeć</th>
                  <th>Adres</th>
                  <th>Numer startowy</th>
                </tr>
              </thead>
              
              
              <tbody>
                  <% if(Users!=null){
                   for(Number user: Users) 
                        {
                            %>
                                  <tr>
                                      <td><% out.print(user.getUser().getUsername()); %></td>
                                      <td><% out.print(user.getUser().getName()); %></td>
                                      <td><% out.print(user.getUser().getSurname()); %></td>
                                      <td><% out.print(user.getUser().getBirth()); %></td>
                                      <td><% out.print(user.getUser().getSex()); %></td>
                                      <td><% out.print(user.getUser().getAdress()); %></td>
                                      <td><% out.print(user.getEventNumber()); %></td>
                                  </tr>
                            <% 
                        }
                  }%>
              </tbody>
              
              
            </table>
           </div>  
          </div>               
                        
                        
         <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    </body>
      
   
   
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    
</html>
