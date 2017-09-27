<%-- 
    Document   : eventpicturesList
    Created on : 2017-09-03, 15:38:43
    Author     : Quchi
--%>

<%@page import="javax.persistence.Query"%>
<%@page import="java.util.Collection"%>
<%@page import="Model.Picture"%>
<%@page import="Model.Picture"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="Model.Event"%>
<%@page import="Model.Event"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
   
       <title>Strona Główna</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.min.css" rel="stylesheet">
  </head>
  <body>
     
   <jsp:include page="/WEB-INF/fragments/header.jspf"/>
     <%
         
            Event ChosenEvent = null;
            EntityManager em = DatabaseConnection.getEntityManager();
            Collection <Picture> EventPictures =null;
            boolean redirect = true;
         try
         {
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            
             Integer EventID = Integer.valueOf((String)request.getParameter("EventID"));
             
                if(EventID==null){
                }
                else{
                   Query queryEv = em.createQuery("select e from Event e where e.idevent=:nameEv").setParameter("nameEv", EventID);
                   ChosenEvent = (Event) queryEv.getSingleResult();
                   em.refresh(ChosenEvent);
                   Query querypic = em.createQuery("select p from Picture p where p.picturePK.eventIdevent =:IdIvent").setParameter("IdIvent", ChosenEvent.getIdevent());
                   
                   EventPictures = querypic.getResultList();
                   request.getSession().setAttribute("EventName", ChosenEvent);
                }
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
         byte[] imageInByteArray = ChosenEvent.getIcon();
         String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);  
        %>
        
<div class="container">
      <div class="jumbotron">
        <h3>Lista wszystkich zdjęć z eventu.</h3>
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
                                    <p><a href="currentEvent.jsp?EventID=<%out.print(ChosenEvent.getIdevent());%>"><%out.print(ChosenEvent.getName());%></a></p> <small><cite title="Source Title"><%   out.print(ChosenEvent.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
                                </blockquote>
                                <p> <i class="glyphicon glyphicon-calendar"></i><% out.print(ChosenEvent.getDate());%>
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
                    <%
                        
                    
                    
                    if(ChosenEvent!=null){
                        if(!ChosenEvent.getPictureCollection().isEmpty()){
                             EventPictures = ChosenEvent.getPictureCollection();   
                        }
                    
                    }
                     
                    if(EventPictures==null){
                        
                    }
                    else
                    {
                        for( Picture currentPic : EventPictures)
                        {
                          imageInByteArray = currentPic.getPicture();
                           b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray); 
                        %>
                            <div class="col col-md-6 col-sm-6">
                                    <img src ="data:image/jpg;base64, <%=b64%>" width ="550" />
                                    <label><% out.print(currentPic.getNumbersOnPicture()); %></label>
                            </div>                            
                        <%
                        }
                        
                    }
                    %>      
    </div>
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    </body>
</html>
