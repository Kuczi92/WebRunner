/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import DataBase.UserService;
import Model.User;
import Tasks.FileIO;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.RollbackException;
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
@WebServlet(name = "ChangeUserParameters", urlPatterns = {"/ChangeUserParameters"})
public class ChangeUserParameters extends HttpServlet {

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
        User  userfromSession = (User) request.getSession(true).getAttribute("user");     
        User user = userfromSession;
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                Query query = em.createQuery("Select U from User U where U.username=:username").setParameter("username", userfromSession.getUsername());
                user = (User) query.getSingleResult();
                user.setAdress(request.getParameter("inputAdress"));
                user.setName(request.getParameter("inputName"));
                user.setSex(request.getParameter("sex"));
                user.setBirth(new Date(request.getParameter("inputbirth")));
                user.setEmail(request.getParameter("inputEmail"));
                Part filePart = request.getPart("inputAvatar");
                InputStream is = null;
                 if (filePart != null) {
                     // obtains input stream of the upload file
                     is = filePart.getInputStream();
                     user.setIcon( FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
                     user.setSurname(request.getParameter("inputSurname"));
                 }
                 
                em.persist(user);
                em.getTransaction()
            .commit();
           request.getSession(true).setAttribute("user",new UserService().GetUserByUsername(user.getUsername()));
            
        }
        catch(Exception ex){
            
            if (ex instanceof RollbackException){
                RollbackException exc =( RollbackException) ex; 
                String we = exc.getMessage();
                        if (we.contains("Duplicate")){
                            String error = "Istnieje już taki login.";
                            request.setAttribute("error",error);
                            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
                            }
                        else if(we.contains("Column 'sex' cannot be null")){
                            String error = "Wybierz swoją płeć.";
                            request.setAttribute("error",error);
                            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
                        }
                        else if(we.contains("Data too long for column 'icon'")){
                            String error = "Wybierz avatar o mniejszej pojemnośći.";
                            request.setAttribute("error",error);
                            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
                        }
                        else{
                            String error = "Wystąpił nieokreślony błąd podczas połączenia z bazą danych";
                            request.setAttribute("error",error);
                            request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
                        }
                }
            else{
                String error = "Wystąpił nieokreślony błąd";
                request.setAttribute("error",error);
                request.getRequestDispatcher("errorRegistration.jsp").forward(request, response);
            }
            redirect = false;
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect){
            response.sendRedirect("UserRedirect");
        }
          
    }
    
    }


