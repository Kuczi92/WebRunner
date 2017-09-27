<%-- 
    Document   : errorlogin
    Created on : 2017-08-29, 14:22:37
    Author     : Quchi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Weekop - logowanie</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.min.css" rel="stylesheet">
  </head>
  <body>
    <jsp:include page="/WEB-INF/fragments/header.jspf"/>
    <div class="container">
      <div class="jumbotron">
      </div>
    </div>
    <div class="container">
        <div class="col-sm-6 col-md-4 col-md-offset-4">
            <form action="j_security_check"  method="post">
                <h2 class="form-signin-heading">Zaloguj się</h2>
                <input name="j_username" type="text" class="form-control" placeholder="Nazwa uzytkownika" required autofocus>
                <input name="j_password" type="password" class="form-control" placeholder="Hasło" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Zaloguj</button>
                <a href="register.jsp">Zarejestruj</a>
                <h4 class="form-signin-heading">Błędne logowanie!</h2>
            </form>
        </div>
    </div> 
    <jsp:include page="/WEB-INF/fragments/footer.jspf"/>
    <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="resources/js/bootstrap.js"></script>
  </body>
</html>
