/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Articleheader;
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
@WebServlet(name = "AddHeader", urlPatterns = {"/AddHeader"})
public class AddHeader extends HttpServlet {

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
       response.setCharacterEncoding("UTF-8");
       request.setCharacterEncoding("UTF-8");
       Headers CurrentHeader = new Headers();
       CurrentHeader.setArticle(request.getParameter("inputHeaderArticle"));
       CurrentHeader.setDescription(request.getParameter("inputHeaderDescription"));
       CurrentHeader.setTitle(request.getParameter("inputHeaderTitle"));
       CurrentHeader.setYoutubeLinks(request.getParameter("inputHeaderYoutubeLink"));
       
       
       
       Part filePart = request.getPart("inputHeaderAvatar");
       InputStream is = null;
       if (filePart != null) {
            is = filePart.getInputStream();
             CurrentHeader.setPicture( FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
        }
      
       
       Integer RedirectToEdit=null;
       EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                if(request.getParameter("ChoosenHeaderID")!=null){
                 Integer IDart= Integer.valueOf(request.getParameter("ChoosenHeaderID"));  
                   Query query = em.createQuery("Select A from Articleheader A where A.idArticleHeader=:ID").setParameter("ID",IDart);
                   Articleheader ChoosenArticle = (Articleheader) query.getSingleResult();
                   CurrentHeader.setArticleHeaderidArticleHeader(ChoosenArticle);
                   RedirectToEdit = ChoosenArticle.getIdArticleHeader();
                } 
           
                em.persist(CurrentHeader);
                em.getTransaction()
            .commit();
        }
        catch(Exception ex){
          
            redirect = false;
            if(RedirectToEdit!=null){
                response.sendRedirect("EditArticle.jsp?ArticleID="+RedirectToEdit);
            }
            else{
                response.sendRedirect("addArticle.jsp");
            }
           
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect)
           if(RedirectToEdit!=null){
                response.sendRedirect("EditArticle.jsp?ArticleID="+RedirectToEdit);
            }
            else{
                response.sendRedirect("addArticle.jsp");
            }
        
        
    }
    }


