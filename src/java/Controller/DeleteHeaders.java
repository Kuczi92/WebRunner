/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Headers;
import java.io.IOException;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Quchi
 */
@WebServlet(name = "DeleteHeaders", urlPatterns = {"/DeleteHeaders"})
public class DeleteHeaders extends HttpServlet {


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
        
        
        Integer ChoosenHeaders = Integer.valueOf(request.getParameter("ChoosenHeaderID"));
        Integer ChoosenArticleheader = (Integer) request.getSession().getAttribute("ArticleID");
        request.getSession().removeAttribute("ArticleID");
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            Query query = em.createQuery("Select H from Headers H where H.idHeaders=:ID").setParameter("ID",ChoosenHeaders );
              Headers Header = (Headers)  query.getSingleResult();
                em.remove(Header);
                em.getTransaction()
            .commit();
        }
        catch(Exception ex){
          
            redirect = false;
            response.sendRedirect("EditArticle.jsp?ArticleID="+ChoosenArticleheader);
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect)
          response.sendRedirect("EditArticle.jsp?ArticleID="+ChoosenArticleheader);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
