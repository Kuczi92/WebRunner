/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Event;
import Model.User;
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
@WebServlet(name = "DeleteUsersFromEvent", urlPatterns = {"/DeleteUsersFromEvent"})
public class DeleteUsersFromEvent extends HttpServlet {



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
    
   
   String UserToDelete = request.getParameter("ChoosenUserNameDelete");
   Integer EventID = (Integer) request.getSession().getAttribute("EventID");
    
   Event currentEvent = null;
      EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        Model.Number currentNumber;
        String ErrorMessage = "";
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("select u from User u where u.username=:username").setParameter("username",UserToDelete);
               User user = (User) query.getSingleResult();
               
                Query queryEvent = em.createQuery("select e from Event e where e.idevent=:nameEv").setParameter("nameEv", EventID);
                currentEvent = (Event) queryEvent.getSingleResult();
                
                Query NumberExistquery = em.createQuery("Select N from Number N where N.event=:Event and N.user.username=:Username")
                       .setParameter("Event", currentEvent).setParameter("Username", UserToDelete); 
                
                Number Number = (Number) NumberExistquery.getSingleResult();
                
                user.deleteNumber(Number);
                currentEvent.deleteNumber(Number);
                em.remove(Number);
                
               em.getTransaction()
              .commit();             
                
                
        }
        catch(Exception ex){
            ErrorMessage= "Błąd połączenia z bazą danych";
            redirect = false;
        }
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
         }
        if(redirect){
            response.sendRedirect("DeleteUsersFromEvent.jsp");
        }
        else{
            request.getRequestDispatcher("DeleteUsersFromEvent.jsp?error="+ErrorMessage.replace(" ", "_")).forward(request, response);
        }
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
