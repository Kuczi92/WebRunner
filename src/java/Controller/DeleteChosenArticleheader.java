/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Articleheader;
import Model.Headers;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "DeleteChosenArticleheader", urlPatterns = {"/DeleteChosenArticleheader"})
public class DeleteChosenArticleheader extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     Integer ChoosenArticleheaderDeleteID = Integer.valueOf(request.getParameter("ChoosenArticleheaderDelete"));
     EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            Query query = em.createQuery("Select A from Articleheader A where A.idArticleHeader=:ID").setParameter("ID",ChoosenArticleheaderDeleteID );
             Articleheader Header = (Articleheader)  query.getSingleResult();
             Query query1 = em.createQuery("Select H from Headers H where H.articleHeaderidArticleHeader=:Article").setParameter("Article", Header);
             List<Headers>  HeadersFromArticle = query1.getResultList();
             HeadersFromArticle.forEach((CurrentHeader) -> {
             em.remove(CurrentHeader);
             });
             em.remove(Header);
                em.getTransaction()
            .commit();
        }
        catch(Exception ex){
            redirect = false;
            response.sendRedirect("ChooseArticleToEdit.jsp");
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect)
          response.sendRedirect("ChooseArticleToEdit.jsp");
     
    }


}
