/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.User;
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
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {


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
         
         User  user = (User) request.getSession(true).getAttribute("user");
    
    
       String Oldpassword = request.getParameter("inputOldPassword");
       String NewPassword = request.getParameter("inputNewPassword");
       String UserPassword = user.getPassword();
       if(Oldpassword.equals(UserPassword)){
       EntityManager em = DatabaseConnection.getEntityManager();
    
    
         boolean redirect = true;
         try{
            em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
            Query query = em.createQuery("select U from User U where U.username=:username").setParameter("username", request.getUserPrincipal().getName());
            user   =    (User) query.getSingleResult();
            user.setPassword(NewPassword);
            request.getSession(true).setAttribute("user",user);
            em.persist(user);
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
    
    else{
        request.getRequestDispatcher("ChangePassword.jsp?error=Podałeś złe hasło.").forward(request, response);
    }
    
     
    }
  
    }



