/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Event;
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
@WebServlet(name = "deletePictureFromEvent", urlPatterns = {"/deletePictureFromEvent"})
public class deletePictureFromEvent extends HttpServlet {
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       request.setCharacterEncoding("UTF-8");
       response.setCharacterEncoding("UTF-8");
       
       Event EventName = (Event) request.getSession().getAttribute("EventName");
       request.getSession().removeAttribute("EventName"); 
       Integer IDPic = Integer.valueOf(request.getParameter("ChoosenPictureID"));
       
       EntityManager em = DatabaseConnection.getEntityManager();
       boolean redirect = true;
       try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
           Query query=  em.createQuery("delete from Picture P where P.picturePK.idpicture=:SelectID").setParameter("SelectID",IDPic);
           query.executeUpdate();
           em.getTransaction()
            .commit();
        
        }
        catch(Exception ex){
           System.out.print(ex.getMessage());
        }
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
       }
       
       if(redirect){
            String Parameter = EventName.getName().replace(" ", "_");
            request.getRequestDispatcher("addPicturesToEvent.jsp?ChoosenEvent="+Parameter).include(request, response);
        }
       
    }



}
