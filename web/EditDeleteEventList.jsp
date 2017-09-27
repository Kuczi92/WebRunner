<%-- 
    Document   : EditDeleteEventList
    Created on : 2017-09-07, 00:48:48
    Author     : Quchi
--%>

<%@page import="java.util.Collection"%>
<%@page import="Model.Picture"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.Event"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.Query"%>
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
            String EventIDN=(String)request.getParameter("EventID");
            Integer EventID = null;
            if(EventIDN!=null){
                EventID = Integer.valueOf(EventIDN);
            }
            
            
         try
         {
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
             Query query = em.createQuery("select e from Event e");
             Events = query.getResultList();
             
             request.getSession().setAttribute("EventID",EventID);
             
                if(EventID==null){
                }
                else{
                   Query queryEv = em.createQuery("select e from Event e where e.idevent=:nameEv").setParameter("nameEv", EventID);
                   ChosenEvent = (Event) queryEv.getSingleResult();
                   em.refresh(ChosenEvent);
                   Query querypic = em.createQuery("select p from Picture p where p.picturePK.eventIdevent =:IdIvent").setParameter("IdIvent", ChosenEvent.getIdevent());
                   
                   EventPictures = querypic.getResultList();
                   request.getSession().setAttribute("EventID", ChosenEvent.getIdevent());
                  
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
                                                                <p><a href="EditDeleteEventList.jsp?EventID=<%out.print(currentEvent.getIdevent());%>"><%out.print(currentEvent.getName());%></a></p> <small><cite title="Source Title"><%   out.print(currentEvent.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
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
                                                                            <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail picture hidden-xs" width="200"/>
                                                                          <%}
                                                                        else{
                                                                           %>  
                                                                            <img src="sample.png" class="img-thumbnail picture hidden-xs" width="200"/>
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
 </div>
                    
<% 
 if(EventID!=null)
 {
 %>                    
<div class="container">
        <div class="row">
            <div class="col col-md-4 col-sm-6">
                <div class="container">
                          <div class ="row">
                                           <div class="col col-md-4 col-sm-6">
                                            <form class="form-signin" method="post" action="ChangeEventParameters" enctype="multipart/form-data" >
                                                    <h2 class="form-signin-heading">Edytuj Event.</h2>
                                                    <input name="inputEventName" type="text" class="form-control" placeholder="Podaj nazwę eventu" required autofocus />
                                                    <input name="inputEventAdress" type="text"  class="form-control" placeholder="Miejsce wydarzenia" required autofocus />


                                                                <label>Wybierz logo.</label>
                                                                <div class="input-group">
                                                                    <span class="input-group-btn">
                                                                        <span class="btn btn-default btn-file">
                                                                            Przeglądaj <input type="file" id="imgInp" name = "inputEventAvatar">
                                                                        </span>
                                                                    </span>
                                                                    <input type="text" class="form-control" readonly>
                                                                </div>
                                                                <img id='img-upload'/>


                                                    <label>Data wydarzenia</label>  
                                                    <div class='input-group date' id='datetimepicker5'>
                                                                        <input type='text' name ="inputEventDate" class="form-control" />
                                                                        <span class="input-group-addon">
                                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                                        </span>
                                                    </div>

                                                  <button class="btn btn-lg btn-primary btn-block" type="submit" >Zatwierdź zmiany</button>


                                            </form>
                                                <form class="form-signin" method="post" action="ChangeEventParameters" enctype="multipart/form-data" >
                                                    <button class="btn btn-lg btn-primary btn-block" type="submit" name="Delete" value="true" >Usuń wybrany Event</button>
                                                </form>

                                          </div> 
                          </div>

                </div>
        </div>
            <div class="col col-md-4 col-sm-6">  
              <div class="container">
                 <div class="row">
                             <div class="col col-md-3 col-sm-9">
                               <img class="img-responsive" src="ChangeNumbersOnRunnerEvent.png" />
                             </div>
                             <div class="col col-md-3 col-sm-9">
                               <h3><a href="EditUsersNumberInEvent.jsp">Edytuj numery zapisanych biegaczy.</a></h3>
                               <h6><p>Dokonujesz zmian w numerach biegaczy którzy się dołączyli do wybranego biegu.</p></h6>
                             </div>
                 </div>
                 <div class="row">
                             <div class="col col-md-3 col-sm-9">
                               <img class="img-responsive" src="SignSelectedUserToEvent.jpg"  />
                             </div>
                             <div class="col col-md-3 col-sm-9">
                               <h3><a href="AddUsersToEvent.jsp">Dodaj Biegaczy do wybranego Eventu.</a></h3>
                               <h6><p>Wybierasz spośród wszystkich dostępnych biegaczy, to osoby które można dopisać do biegu.</p></h6>
                             </div>
                   </div>
                  
                  <div class="row">
                             <div class="col col-md-3 col-sm-9">
                               <img class="img-responsive" src="DeleteFromEvent.jpg"  />
                             </div>
                             <div class="col col-md-3 col-sm-9">
                               <h3><a href="DeleteUsersFromEvent.jsp">Usuń biegacza z listy.</a></h3>
                               <h6><p>Wybierasz spośród uczestników biegu tych których chcesz usunąć z listy uczestników biegów.</p></h6>
                             </div>
                   </div>
                  
                </div>
          </div>  
        </div>
      </div>   
   <% } %>           
              
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script type="text/javascript" src="scripts/moment.js"></script>
    <script type="text/javascript" src="scripts/bootstrap-datetimepicker.js"></script>
    <script src="scripts/inputimage.js"></script>
    <script src="scripts/datepicker.js"></script>
    </body>
</html>
