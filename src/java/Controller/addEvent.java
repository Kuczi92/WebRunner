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
import java.util.Date;
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
@WebServlet(name = "addEvent", urlPatterns = {"/addEvent"})
public class addEvent extends HttpServlet {

  

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
       response.setCharacterEncoding("UTF-8");
       request.setCharacterEncoding("UTF-8");
       Event NewEvent = new Event(); 
       NewEvent.setName(request.getParameter("inputEventName"));
       NewEvent.setAdress(request.getParameter("inputEventAdress"));
       Part filePart = request.getPart("inputEventAvatar");
       InputStream is = null;
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            is = filePart.getInputStream();
            NewEvent.setIcon( FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
        }
        NewEvent.setDate(new Date(request.getParameter("inputEventDate")));
        
        
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
         try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            em.persist(NewEvent);
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
         
        if(redirect)
           response.sendRedirect("UserRedirect");
    }
 
}
