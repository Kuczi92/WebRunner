<%-- 
    Document   : addPicturesToEvent
    Created on : 2017-09-03, 15:39:51
    Author     : Quchi
--%>

<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Picture"%>
<%@page import="javax.persistence.Query"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.Event"%>
<%@page import="Model.User"%>
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
 <div class="container">
      <div class="jumbotron">
           
        
        <%
            List <Event> Events = null;
            Event ChosenEvent = null;
            EntityManager em = DatabaseConnection.getEntityManager();
            Collection <Picture> EventPictures =null;
            boolean redirect = true;
         try
         {
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
             Query query = em.createQuery("select e from Event e");
             Events = query.getResultList();
             Integer EventID =Integer.valueOf((String) request.getParameter("EventID"));
             
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
        %>
    <div class="row">
        <div class="col col-md-12 col-sm-6">
            <h3>Panel wyboru :</h3>
        
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
                                                                    <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail picture hidden-xs" width="200"/>
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
                    
            <div class="col col-md-12 col-sm-6">
              <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <img src="chooseEvent.jpg" width = "200" height="100">
                      Wybierz Event
                      <span class="glyphicon glyphicon-chevron-down"></span>
                    </button>
                <ul class="dropdown-menu">
                    <% 
                    if(Events!=null){
                        %> 
                           <li class="dropdown-header">Dodaj zdjęcia do jednych z poniższych eventów.</li>
                              <%
                                for (Event currentEvent : Events) 
                                        {
                                            byte[] imageInByteArray = currentEvent.getIcon();
                                            String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
                                            %>
                                            <li>
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
                                                                <p><a href="addPicturesToEvent.jsp?EventID=<%out.print(currentEvent.getIdevent());%>"><%out.print(currentEvent.getName());%></a></p> <small><cite title="Source Title"><%   out.print(currentEvent.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
                                                            </blockquote>
                                                            <p> <i class="glyphicon glyphicon-calendar"></i><% out.print(currentEvent.getDate());%>
                                                                <br/> 

                                                        </div>
                                                    </div> 
                                            </li>
                                            <%
                                                
                                                
                                        }
                    }
                    else                
                                        {
                                            %>
                                            <li class="dropdown-header">Brak eventów.</li>
                                            <% 
                                        }
                    %>
                    </ul>
                </div>  
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
                            byte[] imageInByteArray = currentPic.getPicture();
                            String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray); 
                        %>
                            <div class="col col-md-6 col-sm-6">
                                    <img src ="data:image/jpg;base64, <%=b64%>" width ="550" />
                                    <label><% out.print(currentPic.getNumbersOnPicture()); %></label>
                                    <form name="DeleteChoosenPicture"  method="post" action="deletePictureFromEvent">
                                         <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenPictureID" value="<%out.print(currentPic.getPicturePK().getIdpicture());%>" >Usuń Zdjęcie.</button>
                                    </form>
                                    <form name="JoinUsersToPic"  method="get" action="chooseRunnerstoJoinPic.jsp">
                                         <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenPictureID" value="<%out.print(currentPic.getPicturePK().getIdpicture());%>" >Dołącz zdjęcie do biegacza.</button>
                                    </form>
                            </div>
                                  
                                    
                        <%
                        }
                        %>
                         <div class="col col-md-6 col-sm-6">
                                <form class="form-signin" method="post" action="addPictureToEvent" enctype="multipart/form-data" >
                                <label>Opisz zdjęcie.</label>    
                                <input name="inputEventPictureDescribe" type="text" class="form-control" placeholder="Opis" required />
                                     <label>Załaduj zdjęcie.</label>
                                                        <div class="input-group">
                                                            <span class="input-group-btn">
                                                            <span class="btn btn-default btn-file">Przeglądaj <input name = "inputEventPicture" type="file" id="imgInp" />
                                                            </span>
                                                            </span>
                                                            <input type="text" class="form-control" readonly>
                                                        </div>
                                                        <img id='img-upload'/>
                                    <button class="btn btn-lg btn-primary btn-block" type="submit" >Dodaj zdjęcie.</button>
                                </form>
                         </div> 
                        <%
                    }
                    %>
                    

                    
    </div>              
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script src="scripts/inputimage.js"></script>
    </body>
</html>
