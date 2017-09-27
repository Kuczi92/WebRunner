/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Event;
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
@WebServlet(name = "ChangeEventParameters", urlPatterns = {"/ChangeEventParameters"})
public class ChangeEventParameters extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      request.setCharacterEncoding("UTF-8");
      Integer EventID =   (Integer) request.getSession().getAttribute("EventID");
      request.getSession().removeAttribute("EventID");
      String NewEventName =  request.getParameter("inputEventName");
      String NewEventAdress = request.getParameter("inputEventAdress");
      Part filePart = request.getPart("inputEventAvatar");
       EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Event CurrentEvent;
                Query query = em.createQuery("select E from Event E where E.idevent =:IDEvent").setParameter("IDEvent", EventID);
                if(request.getParameter("Delete").equals("true")){
                    CurrentEvent = (Event) query.getSingleResult();
                    em.remove(CurrentEvent);
                }
                else
                {
                            CurrentEvent = (Event) query.getSingleResult();
                            if (filePart != null) {
                                // prints out some information for debugging
                                System.out.println(filePart.getName());
                                System.out.println(filePart.getSize());
                                System.out.println(filePart.getContentType());

                                // obtains input stream of the upload file
                                InputStream    is = filePart.getInputStream();

                                CurrentEvent.setIcon( FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
                            }
                            CurrentEvent.setAdress(NewEventAdress);
                            CurrentEvent.setName(NewEventName);
                            em.persist(CurrentEvent);  
                }
                            
                em.getTransaction()
            .commit();
        }
        catch(Exception ex){
            request.getRequestDispatcher("EditDeleteEventList.jsp").forward(request, response);
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect){
            request.getRequestDispatcher("EditDeleteEventList.jsp").forward(request, response);
        }
       
       
    }


}
