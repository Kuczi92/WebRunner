<%-- 
    Document   : EditArticle
    Created on : 2017-09-26, 02:46:45
    Author     : Quchi
--%>

<%@page import="java.util.Date"%>
<%@page import="Model.User"%>
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
        <link rel="stylesheet" href="styles/inputimage.css" type="text/css">
        <title>Artykuł</title>
    </head>
    <body>
       <jsp:include page="/WEB-INF/fragments/header.jspf"/>
       <div class="container">
        <div class="jumbotron">
            <div class="container">
           <h3>Edytuj Wybrane fragmenty Artykułu.</h3><%
           Integer IDArt = Integer.valueOf(request.getParameter("ArticleID"));
           EntityManager em = DatabaseConnection.getEntityManager();
           Articleheader HeaderArticle;
           List<Headers> HeadersList = null;
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query  query = em.createQuery("Select A from Articleheader A where A.idArticleHeader=:ID").setParameter("ID", IDArt);
                HeaderArticle  = (Articleheader) query.getSingleResult();
                em.refresh(HeaderArticle);
                HeadersList = HeaderArticle.getHeadersList();
                em.getTransaction()
            .commit();
            em.close();
            DatabaseConnection.getEntityManager().close();
            
            request.getSession().setAttribute("ArticleID", IDArt);
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
               <form class="form-signin" method="post" action="EditArticleheader" enctype="multipart/form-data" id="artform">
                <!-- Wrapper for slides -->
                
                        <div class="col-lg-8">
                            <label>Wybierz Obraz tematyczny.</label>
                                         <div class="input-group">
                                             <span class="input-group-btn">
                                                 <span class="btn btn-default btn-file">
                                                     Przeglądaj <input name = "inputArticleHeaderPicture" type="file" id="imgInp" />
                                                 </span>
                                             </span>
                                             <input type="text" class="form-control" readonly>
                                         </div>
                            <img id='img-upload' width="400"/>
                        </div>
                
               
                        <div class="col-lg-4">                            
                             
                                <input name="inputArticleHeaderName" type="text" class="form-control" placeholder="Wpisz nowy nagłówek" required />
                                <br>
                                <small>by <%
                                   User User = (User) request.getSession().getAttribute("user");
                                    
                                  out.print(User.getUsername()); %>
                                  in <% out.print(new Date()); %>
                               </small>
                           
                            <p>
                               <div class="form-group">
                                            <label for="comment">Nowy opis nagłówka</label>
                                                  <textarea name="inputArticleHeaderDescription" class="form-control" rows="5" id="comment" form="artform"></textarea>
                                                  
                               </div>
                            </p>
                        </div>
                 <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenHeaderID" value="<%out.print(HeaderArticle.getIdArticleHeader());%>">Potwierdź Edytowane zmiany i pogrupuj zmiany fragmentów do jednego Artykułu.</button>
           </form>
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
                            <div class="container">
                                    <div class="col-sm-12 col-md-12">
                                            <form class="form-signin" method="post" action="EditHeaders" enctype="multipart/form-data" id="Headerform">
                                                  <h3>Edytuj powyższy Nagłówek/fragment Artykułu.</h3>
                                                    <input name="inputHeaderTitle" type="text" class="form-control" placeholder="Wpisz Tytuł nagłówka"  autofocus />
                                                    <input name="inputHeaderDescription" type="text" class="form-control" placeholder="Wpisz opis nagłówka" autofocus />
                                                    <div class="form-group">
                                                        <label for="comment">Nowy Artykuł</label>
                                                            <textarea name = "inputHeaderArticle" class="form-control" rows="5" id="comment" form="Headerform"></textarea>
                                                    </div>
                                                    <input name="inputHeaderYoutubeLink" type="text" class="form-control" placeholder="Link zewnętrzny do filmu" />
                                                    <div class="col-md-12">
                                                            <label>Wybierz ponownie obraz dla Artykułu.</label>
                                                            <div class="input-group">
                                                                <span class="input-group-btn">
                                                                    <span class="btn btn-default btn-file">
                                                                        Przeglądaj <input name = "inputHeaderAvatar" type="file" id="imgInp" />
                                                                    </span>
                                                                </span>
                                                                <input type="text" class="form-control" readonly>
                                                            </div>
                                                            <img id='img-upload'/>
                                                    </div>
                                                    
                                                  <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenHeaderID" value="<%out.print(CurrentHeader.getIdHeaders());%>" >Odśwież wyedytowany fragment</button>
                                            </form>
                                            <form name="DeleteChoosenHeader"  method="post" action="DeleteHeaders">
                                                <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenHeaderID" value="<%out.print(CurrentHeader.getIdHeaders());%>" >Usuń Fragment/Akapit</button>
                                            </form>                                       
                                    </div>
                                </div>        
                                    
                                    
                        </div>
                       <%
                   }
               }
               
                %>
      </div>
      
      <div class="container">
                <div class="col-sm-12 col-md-12">
                        <form class="form-signin" method="post" action="AddHeader" enctype="multipart/form-data" id="Headerform">
                              <h3>Dodaj Nagłówek/fragment do Artykułu.</h3>
                                <input name="inputHeaderTitle" type="text" class="form-control" placeholder="Wpisz Tytuł nagłówka"  autofocus />
                                <input name="inputHeaderDescription" type="text" class="form-control" placeholder="Wpisz opis nagłówka" autofocus />
                                <div class="form-group">
                                    <label for="comment">Artykuł</label>
                                        <textarea name = "inputHeaderArticle" class="form-control" rows="5" id="comment" form="Headerform"></textarea>
                                </div>
                                <input name="inputHeaderYoutubeLink" type="text" class="form-control" placeholder="Link zewnętrzny do filmu" />
                                <div class="col-md-12">
                                        <label>Wybierz obraz dla Artykułu.</label>
                                        <div class="input-group">
                                            <span class="input-group-btn">
                                                <span class="btn btn-default btn-file">
                                                    Przeglądaj <input name = "inputHeaderAvatar" type="file" id="imgInp" />
                                                </span>
                                            </span>
                                            <input type="text" class="form-control" readonly>
                                        </div>
                                        <img id='img-upload'/>
                                </div>
                              <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenHeaderID" value="<%out.print(HeaderArticle.getIdArticleHeader());%>">Zapisz fragment do powyższego artykułu.</button>
                        </form>
                </div>
       </div>
      <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    </body>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script src="scripts/inputimage.js"></script>
</html>
