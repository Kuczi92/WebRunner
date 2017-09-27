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
@WebServlet(name = "ChangeUserPermission", urlPatterns = {"/ChangeUserPermission"})
public class ChangeUserPermission extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String Username = (String) request.getSession().getAttribute("ChoosenUserNameEdit");
        String Role = request.getParameter("inputRole");
        
        User user;
                EntityManager em = DatabaseConnection.getEntityManager();
                Role RoleChosen = null;
                boolean redirect = true;
                 try{
                       em.getTransaction() //rozpoczęcie tranzakcji    
                        .begin();
                            
                            Query query = em.createQuery("select U from User U where U.username=:username").setParameter("username", Username);
                            user = (User) query.getSingleResult();
                            Query queryRole = em.createQuery("Select R from Role R where R.role=:rolename").setParameter("rolename",Role);
                            user.clearRoleCollection();
                            RoleChosen= (Role) queryRole.getSingleResult();
                            RoleChosen.deleteUserFromCollection(user);
                            
                            user.addToRoleCollection(RoleChosen);
                            RoleChosen.addUserToCollection(user);
                            em.persist(RoleChosen);
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
                 if(redirect){
                     response.sendRedirect("EditUserPermission.jsp");
                 }
        
    }

 
}
