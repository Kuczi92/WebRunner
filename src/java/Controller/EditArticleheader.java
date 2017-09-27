/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Articleheader;
import Model.User;
import Tasks.FileIO;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
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
@WebServlet(name = "EditArticleheader", urlPatterns = {"/EditArticleheader"})
public class EditArticleheader extends HttpServlet {


  

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
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
           
               Query query = em.createQuery("Select A from Articleheader A where A.idArticleHeader=:ID").setParameter("ID", IDInt);
               Articleheader ChoosenHeader = (Articleheader) query.getSingleResult();
               
               User User = (User) request.getSession().getAttribute("user");
               ChoosenHeader.setAutor(User.getUsername());
               ChoosenHeader.setDate(new Date());
               ChoosenHeader.setDescription(request.getParameter("inputArticleHeaderDescription"));
               ChoosenHeader.setHeader(request.getParameter("inputArticleHeaderName"));
               Part filePart = request.getPart("inputArticleHeaderPicture");
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
           response.sendRedirect("EditArticle.jsp?ArticleID="+IDInt);
        }
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect)
          response.sendRedirect("EditArticle.jsp?ArticleID="+IDInt);
    }
    
    }




