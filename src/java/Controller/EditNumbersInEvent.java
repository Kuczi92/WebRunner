/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Number;
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
@WebServlet(name = "EditNumbersInEvent", urlPatterns = {"/EditNumbersInEvent"})
public class EditNumbersInEvent extends HttpServlet {



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    Integer EventID = (Integer) request.getSession().getAttribute("EventID");
    
    String Username= request.getParameter("ChoosenUserNameEditNumber");
    Integer NewNumber =  Integer.valueOf(request.getParameter("inputNewNumber"));
    
    
    Number SelectedNumberToEdit;
    EntityManager em = DatabaseConnection.getEntityManager();
    boolean redirect = true;
 
     try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("select N from Event E, User U ,Number N where N Member E.numberList and N Member U.numberList and E.idevent=:EventID and U.username=:username")
                        .setParameter("EventID", EventID).setParameter("username", Username);
                SelectedNumberToEdit = (Number) query.getSingleResult();
                SelectedNumberToEdit.setEventNumber(NewNumber);
                em.persist(SelectedNumberToEdit);
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
     response.sendRedirect("EditUsersNumberInEvent.jsp");
    }

   

}
