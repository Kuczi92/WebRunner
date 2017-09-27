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
@WebServlet(name = "getEvent", urlPatterns = {"/joinToEvent"})
public class joinEvent extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
  
    }

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
      User user =  (User) request.getSession().getAttribute("user");
      String a= request.getParameter("inputNumberEvent");
      Integer EventID = (Integer) request.getSession().getAttribute("EventID");
      Event currentEvent = null;
      EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        Number currentNumber;
        String ErrorMessage = null;
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("select u from User u where u.username=:username").setParameter("username", user.getUsername());
                user = (User) query.getSingleResult();
                Query queryEvent = em.createQuery("select e from Event e where e.idevent=:nameEv").setParameter("nameEv", EventID);
                currentEvent = (Event) queryEvent.getSingleResult();
                Query NumberExistquery = em.createQuery("Select N from Number N where N.event=:Event and N.eventNumber=:NumberEvent")
                       .setParameter("Event", currentEvent).setParameter("NumberEvent", Integer.valueOf(a)); 
                
                List<Number> Numbers = NumberExistquery.getResultList();
                
                //currentNumber = (Number) NumberExistquery.getSingleResult();
                  if(Numbers.isEmpty()){
                            currentNumber = new Number(user.getUsername(),currentEvent.getIdevent());
                            currentNumber.setEventNumber(Integer.valueOf(a));
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
            response.sendRedirect("currentEvent.jsp?EventID="+EventID);
        }
        else{
            request.getRequestDispatcher("joinEvent.jsp?EventID="+EventID+"&error="+ErrorMessage.replace(" ", "_")).forward(request, response);
        }
    }
}
