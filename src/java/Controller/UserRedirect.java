/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.Role;
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
@WebServlet(name = "UserRedirect", urlPatterns = {"/UserRedirect"})
public class UserRedirect extends HttpServlet {

   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      User user;  
      List<Role> Roles;  
      user = (User) request.getSession(true).getAttribute("user");
      
      if (getServletContext().getAttribute("Roles") == null){
         EntityManager em = DatabaseConnection.getEntityManager();
         em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
         Query query = em.createQuery("select r from Role r");
        
         Roles =  (List<Role>) query.getResultList();
         em.getTransaction()
            .commit();
         em.close();
            DatabaseConnection.getEntityManager().close();  
            getServletContext().setAttribute("Roles", Roles);
      }
      else{
         Roles = (List<Role>) getServletContext().getAttribute("Roles");
      }
         
        for (Role Role : Roles) {
            

            if(user.getRoleCollection().contains(Role)){
             String path = Role.getRole().toLowerCase()+"panel.jsp";    
             response.sendRedirect(path);
            }
        }
       
            
            
       
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            doGet(request,response);
    }
 
}
