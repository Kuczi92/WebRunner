<%-- 
    Document   : ChooseArticleToEdit
    Created on : 2017-09-26, 01:03:34
    Author     : Quchi
--%>

<%@page import="javax.persistence.Query"%>
<%@page import="Model.Articleheader"%>
<%@page import="java.util.List"%>
<%@page import="DataBase.DatabaseConnection"%>
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
    List <Articleheader> ArticleHeaders = null;
    EntityManager em = DatabaseConnection.getEntityManager();
    boolean redirect = true;
     try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("select A from Articleheader A");
                ArticleHeaders =  query.getResultList();
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
            
            </div>
        </div>
                                              
                                              
                                              
    </div>
    <div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="page-header">
                <h1>Wyszukaj konktretnego Artykułu do edycji lub usunięcia.</h1>
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
                        <th>Tytuł</th>
                        <th>Autor</th>
                        <th>Data</th>
                        <th>Obraz tytułowy</th>
                    </tr>
                </thead> 
                <% for (Articleheader CurrentArticleheader : ArticleHeaders){
                    byte[] imageInByteArray = CurrentArticleheader.getPicture();
                    String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray); 
                    %>
                    
                           <tr>
                              <td><% out.print(CurrentArticleheader.getHeader()); %></td>
                              <td><% out.print(CurrentArticleheader.getAutor()); %></td>
                               <td><% out.print(CurrentArticleheader.getDate()); %></td>
                              <td><%
                                                                        if(b64.length()>30){
                                                                          %>
                                                                            <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail" width="50"/>
                                                                          <%}
                                                                        else{
                                                                           %>  
                                                                            <img src="defaultAvatar.jpg" class="img-thumbnail" width="50"/>
                                                                        <% } 
                                                                    %>
                              </td>
                              <td>
                                  <form name="EditChoosenPicture"  method="post" action="EditArticle.jsp?ArticleID=<% out.print(CurrentArticleheader.getIdArticleHeader()); %>">
                                         <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenArticleheaderEdit" value="<%out.print(CurrentArticleheader.getIdArticleHeader());%>" >Edytuj</button>
                                  </form>
                              </td>
                              <td>
                                  <form name="DeleteChoosenPicture"  method="post" action="DeleteChosenArticleheader">
                                         <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenArticleheaderDelete" value="<%out.print(CurrentArticleheader.getIdArticleHeader());%>" >Usuń</button>
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
