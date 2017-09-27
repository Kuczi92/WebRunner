/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Event;
import Model.Number;
import Model.Picture;
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
@WebServlet(name = "JoinPictureToEventUsers", urlPatterns = {"/JoinPictureToEventUsers"})
public class JoinPictureToEventUsers extends HttpServlet {

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String ChoosenUsername  = request.getParameter("ChoosenUserName");
        Event ChosenEvent =(Event) request.getSession().getAttribute("EventName");
        Integer Picture = Integer.valueOf((String)request.getSession().getAttribute("IDpicture"));
        
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        
        Number CurrentNumber;
        
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
               .begin();
                Query query = em.createQuery("select N from Number N where N.event=:Event and N.user.username=:User").setParameter("Event", ChosenEvent).setParameter("User", ChoosenUsername);
                CurrentNumber = (Number) query.getSingleResult();
                Query queryPic = em.createQuery("select p from Picture p where p.picturePK.idpicture=:ID").setParameter("ID", Picture);
                Picture currentPic = (Picture) queryPic.getSingleResult();
                CurrentNumber.AddPicture(currentPic);
                currentPic.AddNumber(CurrentNumber);
                 
              
        
                
                
                em.persist(CurrentNumber);
                em.persist(currentPic);
                
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
         if(redirect){
            request.getRequestDispatcher("chooseRunnerstoJoinPic.jsp?ChoosenPictureID="+Picture).include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
  
    }

   

}
