<%-- 
    Document   : joinEvent
    Created on : 2017-09-02, 14:25:06
    Author     : Quchi
--%>

<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="Model.Event"%>
<%@page import="javax.persistence.Query"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/styles.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
        <title>Dołącz do biegu</title>
    </head>
    <body>
     <jsp:include page="/WEB-INF/fragments/header.jspf"/>
      <div class="container">
        <% User user = (User)session.getAttribute("user"); %>
        <%
         String b64 = null;
         byte[] imageInByteArray = user.getIcon();
         b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
         Integer EventID = Integer.valueOf((String)request.getParameter("EventID"));
         request.getSession().setAttribute("EventID", EventID);
         EntityManager em = DatabaseConnection.getEntityManager();
         Event currentEvent = null;
         String Error = request.getParameter("error");
         
         boolean redirect = true;
         try{
            em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            Query query = em.createQuery("select N from Event N where N.idevent=:username").setParameter("username", EventID);
            currentEvent   =    (Event) query.getSingleResult();
            request.getSession(true).setAttribute("user",user);
            em.persist(user);
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
         
        if(redirect)
          response.sendRedirect("UserRedirect");  
        %>
        
    <div class="container">
      <div class="jumbotron">
        <h3>Informacje o tobie oraz biegu do którego się zapisujesz.</h3>
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
                            
   <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
	<div class="row panel">
           <div class="header">
                <span>
                    <div class="container" >
                        <div class="row">
                            <div class="col col-md-3 col-sm-6">
                               <%
                                   imageInByteArray = currentEvent.getIcon();
                                   b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
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
                                    <p><a href="currentEvent.jsp?EventID=<%out.print(currentEvent.getIdevent());%>"><%out.print(currentEvent.getName());%></a></p> <small><cite title="Source Title"><%   out.print(currentEvent.getAdress()); %> <i class="glyphicon glyphicon-map-marker"></i></cite></small>
                                </blockquote>
                                <p> <i class="glyphicon glyphicon-calendar"></i><% out.print(currentEvent.getDate());%>
                                    <br/> 
                                    
                            </div>
                        </div>
                    </div>
                </span>
           </div>
          </div>
        </div>                     
     
    
    <div class="container">
            <div class="row">
              <div class="col col-md-3 col-md-offset-4">                
                    <form class="form-signin" method="post" action="joinToEvent" >
                                    <h2 class="form-signin-heading">Zarejestruj się</h2>
                                    <input name="inputNumberEvent" type="text" class="form-control" placeholder="Wpisz zaproponowany numer" required autofocus />
                                   
                                    <button class="btn btn-lg btn-primary btn-block" type="submit" >Dodaj do biegu</button>
                    </form>
                                     
               </div>
            </div>
         </div>
                                    <div class="container">
                                        <h5>
                                            <div class="col col-md-3 col-md-offset-4">
                                                            <%
                                                            if(Error!=null){
                                                                out.print(Error.replace("_", " "));
                                                            }
                                                            %>
                                            </div>                
                                        </h5>
                                    </div>
    </div>   
    </body>
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>  
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
</html>
