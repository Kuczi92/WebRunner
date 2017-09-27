<%-- 
    Document   : ChosenArticle
    Created on : 2017-09-22, 19:02:36
    Author     : Quchi
--%>

<%@page import="Model.Articleheader"%>
<%@page import="javax.persistence.Query"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="Model.Headers"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <title>Artykuł</title>
    </head>
    <body>
       <jsp:include page="/WEB-INF/fragments/header.jspf"/>
       <div class="container">
        <div class="jumbotron">
            <div class="container">
           <h3>Aktualności</h3><%
           Integer IDArt = Integer.valueOf(request.getParameter("ArticleID"));
           EntityManager em = DatabaseConnection.getEntityManager();
           Articleheader HeaderArticle;
           List<Headers> HeadersList = null;
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query  query = em.createQuery("Select A from Articleheader A where A.idArticleHeader=:ID").setParameter("ID", IDArt);
                HeaderArticle  = (Articleheader) query.getSingleResult();
                HeadersList = HeaderArticle.getHeadersList();
                em.getTransaction()
            .commit();
            em.close();
            DatabaseConnection.getEntityManager().close();
            

            byte[] imageInByteArray = HeaderArticle.getPicture();
            String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);

            %>
                <!-- Wrapper for slides -->
                        <div class="col-lg-8">
                            <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail">
                        </div>
                        <div class="col-lg-4">                            
                                            <h2><%out.print(HeaderArticle.getHeader()); %><br>
                                                <small>by <%out.print(HeaderArticle.getAutor()); %> in <%out.print(HeaderArticle.getDate()); %></small></h2>
                                            <p>
                                                <%out.print(HeaderArticle.getDescription()); %>
                                            </p>
                        </div>
                                      
                   </div>
      </div>
      </div>
                                            
 <div class="container">                                   
       <%
               
               
               if(HeadersList!=null){
                   for (Headers CurrentHeader:HeadersList){
                       
                             imageInByteArray = CurrentHeader.getPicture();
                              b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);

                       %>
                       
                         <div class="col-md-12 blogShort">
                             <% 
                                 if(CurrentHeader.getTitle()!=null)
                                     {
                                        %>
                                        <h1><% out.print(CurrentHeader.getTitle()); %></h1>
                                        <%
                                     }
                             %>
                             
                             <%
                                 if(CurrentHeader.getPicture().length>30)
                                    {
                                        %>
                                        <img src="data:image/jpg;base64, <%=b64%>" alt="post img" width="400" class="pull-left img-responsive postImg img-thumbnail margin10">
                                        <%
                                    }
                             %>

                            <article>
                                <%
                                    if(CurrentHeader.getDescription()!=null) 
                                {
                                            %>
                                            <h2><% out.print(CurrentHeader.getDescription()); %></h2>
                                            <%
                                }
                                %>
                                
                                <% if(CurrentHeader.getArticle()!=null)
                                         {
                                            %>
                                             <p>
                                                <% out.print(CurrentHeader.getArticle()); %>
                                             </p>
                                            <%
                                         }
                                    %>
                                    
                                    <%
                                   if(CurrentHeader.getYoutubeLinks().length()>15){
                                            %>
                                             <br>
                                              <iframe width="100%" height="480" src="<% out.print(CurrentHeader.getYoutubeLinks()); %>" frameborder="0" allowfullscreen></iframe>
                                            <%
                                    }    
                                    %>
                                    
                                    
                            </article>
                        </div>
                       <%
                   }
               }
               
                %>
      </div>
      <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    </body>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
</html>
