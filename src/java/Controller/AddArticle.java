/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Articleheader;
import Model.Headers;
import Model.User;
import Tasks.FileIO;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Quchi
 */
@WebServlet(name = "AddArticle", urlPatterns = {"/SaveArticle"})
@MultipartConfig(maxFileSize = 16177215)  
public class AddArticle extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       response.setCharacterEncoding("UTF-8");
       request.setCharacterEncoding("UTF-8");
       Articleheader CurrentHeader = new Articleheader();
       User User = (User) request.getSession().getAttribute("user");
       CurrentHeader.setAutor(User.getUsername());
       CurrentHeader.setDate(new Date());
       CurrentHeader.setHeader(request.getParameter("inputArticleHeaderName"));
       CurrentHeader.setDescription(request.getParameter("inputArticleHeaderDescription"));
       Part filePart = request.getPart("inputArticleHeaderPicture");
       InputStream is = null;
       if (filePart != null) {
            is = filePart.getInputStream();
             CurrentHeader.setPicture( FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
        }
       
       
       EntityManager em = DatabaseConnection.getEntityManager();
       boolean redirect = true;
       List<Headers> HeaderList = null;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query  query = em.createQuery("Select H from Headers H where H.articleHeaderidArticleHeader is null");
                
                HeaderList  =  query.getResultList();
                CurrentHeader.setHeadersList(HeaderList);
                
                for(Headers CurrHeader:HeaderList){
                    CurrHeader.setArticleHeaderidArticleHeader(CurrentHeader);
                }
               
                em.persist(CurrentHeader);
                em.getTransaction()
            .commit();
        }
        catch(Exception ex){
          
            redirect = false;
            response.sendRedirect("addArticle.jsp");
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect)
          response.sendRedirect("addArticle.jsp");
        
        
        
        
    }

    


}
