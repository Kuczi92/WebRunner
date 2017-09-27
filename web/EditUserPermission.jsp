<%-- 
    Document   : EditUserPermission
    Created on : 2017-09-07, 18:28:40
    Author     : Quchi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.Role"%>
<%@page import="javax.persistence.Query"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
        <title>Wybrany użytkownik do edycji</title>
    </head>
    <body>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/styles.min.css" rel="stylesheet">
        <jsp:include page="/WEB-INF/fragments/header.jspf"/>
        <% 
                        User user = null;
                        EntityManager em = DatabaseConnection.getEntityManager();
                        List <Role> Roles = null;
                boolean redirect = true;
                 try{
                       em.getTransaction() //rozpoczęcie tranzakcji    
                        .begin();
                            String Username = (String) request.getSession().getAttribute("ChoosenUserNameEdit");
                            Query query = em.createQuery("select U from User U where U.username=:username").setParameter("username", Username);
                            user = (User) query.getSingleResult();
                            Query queryRole = em.createQuery("Select R from Role R");
                            Roles= queryRole.getResultList();
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
   
   
        <%
          String b64 = null;
          byte[] imageInByteArray = user.getIcon();
          b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
        %>
        
<div class="container">
      <div class="jumbotron">
        <h3>Panel zmiany uprawnienia.</h3>
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
                            <div class="col col-md-4 col-sm-6">
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
                                    <i class="glyphicon glyphicon-gift"></i><% out.print(user.getBirth()); %>
                                    
                                </p>
                                
                            </div>
                            <div class="col col-md-3 col-sm-6">
                                <p> <i class="glyphicon glyphicon-user"></i><% 
                                        
                                        ArrayList <Role> CurrentUserRole = new ArrayList<>(user.getRoleCollection());
                                        
                                        out.print("Posiadane Uprawnienia : "+CurrentUserRole.get(0).getRole()); %>
                                </p>
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
      <div class="col col-md-4 col-sm-6">
        <div class="container">
         <div class="col-sm-6 col-md-4 col-md-offset-4">
            <form class="form-signin" method="post" action="ChangeUserPermission" >
                    <h5 class="form-signin-heading">Wybierz uprawnienia dla wybranego użytkownika.</h5>
                     
                       <div class="form-group">
                            <select name="inputRole" class="form-control" id="sel1">
                              <%   
                              for (Role currentRole : Roles){
                                  %>
                                  <option value="<%out.print(currentRole.getRole());%>"><%out.print(currentRole.getRole());%></option>
                                  <%
                              }
                              %>  
                            </select>
                       </div>

                    <button class="btn btn-lg btn-primary btn-block" type="submit" >Zmień uprawnienia</button>
            </form>
        </div>
      </div>                       
    
     
      </div>
      
   </div>
</div>                     
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script type="text/javascript" src="scripts/moment.js"></script>
    <script type="text/javascript" src="scripts/bootstrap-datetimepicker.js"></script>
    <script src="scripts/inputimage.js"></script>
    <script src="scripts/datepicker.js"></script>>                        
    </body>
</html>
