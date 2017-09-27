/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Headers;
import Tasks.FileIO;
import java.io.IOException;
import java.io.InputStream;
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
@MultipartConfig(maxFileSize = 16177215)  
@WebServlet(name = "EditHeaders", urlPatterns = {"/EditHeaders"})
public class EditHeaders extends HttpServlet {


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        Integer IDInt = Integer.valueOf(request.getParameter("ChoosenHeaderID"));
        Integer RedirectArticle = 0;
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
               Query query = em.createQuery("Select H from Headers H where H.idHeaders=:ID").setParameter("ID", IDInt);
               Headers ChoosenHeader = (Headers) query.getSingleResult();
               ChoosenHeader.setArticle(request.getParameter("inputHeaderArticle"));
               ChoosenHeader.setTitle(request.getParameter("inputHeaderTitle"));
               ChoosenHeader.setDescription(request.getParameter("inputHeaderDescription"));
               ChoosenHeader.setYoutubeLinks(request.getParameter("inputHeaderYoutubeLink"));
               RedirectArticle = ChoosenHeader.getArticleHeaderidArticleHeader().getIdArticleHeader();
               
               Part filePart = request.getPart("inputHeaderAvatar");
               InputStream is = null;
               if (filePart != null) {
                    is = filePart.getInputStream();
                    ChoosenHeader.setPicture(FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
                }
                em.persist(ChoosenHeader);
                em.getTransaction()
            .commit();
        }
        
        catch(Exception ex){
           redirect = false;
           response.sendRedirect("EditArticle.jsp?ArticleID="+RedirectArticle);
        }
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect)
          response.sendRedirect("EditArticle.jsp?ArticleID="+RedirectArticle);
    }

 
}
