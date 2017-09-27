/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Event;
import Model.User;
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
@WebServlet(name = "AddUserToSelectedEvent", urlPatterns = {"/AddUserToSelectedEvent"})
public class AddUserToSelectedEvent extends HttpServlet {
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8"); 
    
    String NewNumber = request.getParameter("inputNewNumber");
    String UserToAdd = request.getParameter("ChoosenUserNameAdd");
    Integer EventID = (Integer) request.getSession().getAttribute("EventID");
    
   Event currentEvent = null;
      EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        Model.Number currentNumber;
        String ErrorMessage = "";
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("select u from User u where u.username=:username").setParameter("username",UserToAdd);
               User user = (User) query.getSingleResult();
                Query queryEvent = em.createQuery("select e from Event e where e.idevent=:nameEv").setParameter("nameEv", EventID);
                currentEvent = (Event) queryEvent.getSingleResult();
                Query NumberExistquery = em.createQuery("Select N from Number N where N.event=:Event and N.eventNumber=:NumberEvent")
                       .setParameter("Event", currentEvent).setParameter("NumberEvent", Integer.valueOf(NewNumber)); 
                
                List<Model.Number> Numbers = NumberExistquery.getResultList();
                
                //currentNumber = (Number) NumberExistquery.getSingleResult();
                  if(Numbers.isEmpty()){
                            currentNumber = new Model.Number(user.getUsername(),currentEvent.getIdevent());
                            currentNumber.setEventNumber(Integer.valueOf(NewNumber));
                            currentNumber.setEvent(currentEvent);
                            currentNumber.setUser(user);
                            user.addNumber(currentNumber);
                            currentEvent.addNumber(currentNumber);
                            em.persist(currentNumber);
                            
                  }
                  else{
                      redirect = false;
                      ErrorMessage= "Numer już jest zajęty!";
                  }
                            
                
               em.getTransaction()
              .commit();             
                
                
        }
        catch(Exception ex){
            ErrorMessage= "Już jesteś zapisany!";
            redirect = false;
        }
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
         }
        if(redirect){
            response.sendRedirect("AddUsersToEvent.jsp");
        }
        else{
            request.getRequestDispatcher("AddUsersToEvent.jsp?error="+ErrorMessage.replace(" ", "_")).forward(request, response);
        }

 

}
}