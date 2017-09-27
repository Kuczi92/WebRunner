<%-- 
    Document   : addArticle
    Created on : 2017-09-24, 15:18:54
    Author     : Quchi
--%>

<%@page import="java.util.List"%>
<%@page import="Model.Headers"%>
<%@page import="javax.persistence.Query"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Date"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
html>
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
           <h3>Dodaj Artykuł oraz stwórz miniaturę.</h3>
           <form class="form-signin" method="post" action="SaveArticle" enctype="multipart/form-data" id="artform">
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
                             
                                <input name="inputArticleHeaderName" type="text" class="form-control" placeholder="Wpisz nagłówek" required />
                                <br>
                                <small>by <%
                                   User User = (User) request.getSession().getAttribute("user");
                                    
                                  out.print(User.getUsername()); %>
                                  in <% out.print(new Date()); %>
                               </small>
                           
                            <p>
                               <div class="form-group">
                                            <label for="comment">Opis nagłówka</label>
                                                  <textarea name="inputArticleHeaderDescription" class="form-control" rows="5" id="comment" form="artform"></textarea>
                                                  
                               </div>
                            </p>
                        </div>
                
                
                 <button class="btn btn-lg btn-primary btn-block" type="submit" >Potwierdź zmiany i pogrupuj poniższe fragmenty do jednego Artykułu.</button>
           </form>
        </div>
      </div>
      </div>
       
       <div class="container">
           <% 
           
               List<Headers> HeaderList = null;
               EntityManager em = DatabaseConnection.getEntityManager();
                 
                boolean redirect = true;
                 try{
                       em.getTransaction() //rozpoczęcie tranzakcji    
                        .begin();
                            Query  query = em.createQuery("Select H from Headers H where H.articleHeaderidArticleHeader is null");
                            HeaderList  =  query.getResultList();
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
               
               
               if(HeaderList!=null){
                   for (Headers CurrentHeader:HeaderList){
                       
                            byte[] imageInByteArray = CurrentHeader.getPicture();
                            String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);

                       %>
                       
                         <div class="col-md-12 col-sm-8 blogShort" >
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
                                  <form name="DeleteChoosenPicture"  method="post" action="DeleteHeaders">
                                         <button class="btn btn-lg btn-primary btn-block" type="submit" name="ChoosenHeaderID" value="<%out.print(CurrentHeader.getIdHeaders());%>" >Usuń Fragment/Akapit</button>
                                  </form>
                        </div>
                       <%
                   }
               }
               
                %>
                 
           
           
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
                              <button class="btn btn-lg btn-primary btn-block" type="submit" >Zapisz fragment do powyższego artykułu.</button>
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
