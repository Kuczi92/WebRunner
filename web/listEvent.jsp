<%-- 
    Document   : listEvent
    Created on : 2017-09-03, 03:42:34
    Author     : Quchi
--%>

<%@page import="javax.persistence.Query"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Event"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Strona Główna</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
  
  </head>
  
  <body>
   <jsp:include page="/WEB-INF/fragments/header.jspf"/>
   <div class="container">
      <div class="jumbotron">
        <h3>Lista wydarzeń :</h3>
        </div>
      </div>
    </div>
   
   
   
    <% List<Event> events = new ArrayList<>(); %>
    
    
    <% 
    EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
           
            Query query = em.createQuery("select e from Event e");
            events = query.getResultList();
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
    
    <% if(events.size()>0)
    {
             for(Event event: events){ 
             byte[] imageInByteArray = event.getIcon();
             String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
            %>
            <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
	<div class="row panel">
           <div class="header">
                <span>
                    <div class="container" >
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
                            <div class="col col-md-9 col-sm-9" style="background-image: url('EventBackground.png');">
                                <blockquote>
                                    <p><a href="currentEvent.jsp?EventID=<%out.print(event.getIdevent());%>"><%out.print(event.getName());%></a></p> <small><cite title="Source Title"><%   out.print(event.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
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
            <% }
    }
    %>
      
   
   
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    </body>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
 
  
</html>
