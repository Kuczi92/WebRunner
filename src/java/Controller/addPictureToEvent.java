/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Event;
import Model.Picture;
import Model.PicturePK;
import Tasks.FileIO;
import java.io.IOException;
import java.io.InputStream;
import javax.persistence.EntityManager;
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
@WebServlet(name = "addPictureToEvent", urlPatterns = {"/addPictureToEvent"})
public class addPictureToEvent extends HttpServlet {


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
       
       
       Picture CurrentPicture = new Picture(); 
       
       String Describe = request.getParameter("inputEventPictureDescribe");
       Part filePart = request.getPart("inputEventPicture");
       Event EventName = (Event) request.getSession().getAttribute("EventName");
       request.getSession().removeAttribute("EventName");
       CurrentPicture.setEvent(EventName);
       CurrentPicture.setNumbersOnPicture(Describe);
       PicturePK PK = new PicturePK();
       PK.setEventIdevent(EventName.getIdevent());
       CurrentPicture.setPicturePK(PK);
       InputStream is = null;
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            is = filePart.getInputStream();
            CurrentPicture.setPicture(FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
        }
        
         EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            em.persist(CurrentPicture);
           
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
            String Parameter = EventName.getName().replace(" ", "_");
            request.getRequestDispatcher("addPicturesToEvent.jsp?ChoosenEvent="+Parameter).include(request, response);
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
