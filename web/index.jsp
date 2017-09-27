

<%@page import="Model.Articleheader"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="DataBase.DatabaseConnection"%>
<%@page import="Model.Event"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <h3>Aktualności</h3>
        <%
       List<Event> events = new ArrayList<>(); 
       EntityManager em = DatabaseConnection.getEntityManager();
       boolean redirect = true;
       List<Articleheader> ArticleHeaderList = null;
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query  query = em.createQuery("Select A from Articleheader A");
                ArticleHeaderList  =  query.getResultList();
                Query queryEvents = em.createQuery("select e from Event e");
                events = queryEvents.getResultList();
                em.getTransaction()
            .commit();
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        %>
        <div class='container carousel'>
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <% 
                        int i = 0;
                        boolean triggerOne = true;
                        if(ArticleHeaderList!=null)
                        for(Articleheader CurrentArticleheader : ArticleHeaderList){
                           if(triggerOne) {
                                    %>
                                       <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                    <%
                                      triggerOne = false;  
                           }
                                    else{
                                        i++;
                                        %>
                                       <li data-target="#carousel-example-generic" data-slide-to="<%out.print(i);%>"></li>
                                        <%
                                    }
                                    
                    }
                    %>
                </ol>
                <!-- Wrapper for slides -->
                <div class="carousel-inner text-center" role="listbox">
                    <%
                    triggerOne = true;
                    for(Articleheader CurrentArticleheader : ArticleHeaderList){
                                    if(triggerOne) {
                                             %>
                                            <div class="item active">
                                             <%
                                               triggerOne = false;  
                                    }
                                    else{
                                        %>
                                            <div class="item"> 
                                        <%
                                    }

                                    byte[] imageInByteArray = CurrentArticleheader.getPicture();
                                    String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);

                                    %>
                                        <div class="col-lg-8 pull-right">
                                            <img src="data:image/jpg;base64, <%=b64%>" class="img-thumbnail">
                                        </div>
                                        
                                        <div class="col-lg-4">                            
                                            <h2><%out.print(CurrentArticleheader.getHeader()); %><br>
                                                <small>by <%out.print(CurrentArticleheader.getAutor()); %> in <%out.print(CurrentArticleheader.getDate()); %></small></h2>
                                            <p>
                                                <%out.print(CurrentArticleheader.getDescription()); %>
                                            </p>
                                          <a class='btn btn-info pull-right'
                                               href="ChosenArticle.jsp?ArticleID=<%out.print(CurrentArticleheader.getIdArticleHeader());%>">
                                                <i class="glyphicon glyphicon-arrow-right"> </i></a>  
                                        </div>
                                       </div>
                                    <%
                    }%>
                </div>
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
      </div>
    </div>
  
    
    <% if(events.size()>0)
    {
             for(Event event: events){ 
             byte[] imageInByteArray = event.getIcon();
             String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
            %>
     <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
	<div class="row panel">
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
                            
                            <div class="col col-md-9 col-sm-6" style="background-image: url('EventBackground.png');">
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
            <% }
    }
    %>
      
   
   
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    </body>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
 
  
</html>
