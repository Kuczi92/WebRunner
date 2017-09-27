/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataBase.DatabaseConnection;
import Model.User;
import Tasks.FileIO;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
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
@WebServlet(name = "EditDeleteCurrentUser", urlPatterns = {"/EditDeleteCurrentUser"})
public class EditDeleteCurrentUser extends HttpServlet {

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        EntityManager em = DatabaseConnection.getEntityManager();
        boolean redirect = true;
        try{
           em.getTransaction() //rozpoczęcie tranzakcji    
            .begin();
                if(request.getParameter("ChoosenUserNameDelete")!=null){
                  Query query = em.createQuery("select U from User U where U.username=:username").setParameter("username", request.getParameter("ChoosenUserNameDelete"));
                  User user = (User) query.getSingleResult();
                  em.remove(user);
                }
                else{
                    Query query = em.createQuery("select U from User U where U.username=:username").setParameter("username", request.getSession().getAttribute("ChoosenUserNameEdit"));
                    request.getSession().removeAttribute("ChoosenUserNameEdit");
                    User user = (User) query.getSingleResult();
                    user.setAdress(request.getParameter("inputAdress"));
                    user.setName(request.getParameter("inputName"));
                    user.setSex(request.getParameter("sex"));
                    user.setBirth(new Date(request.getParameter("inputbirth")));
                    user.setEmail(request.getParameter("inputEmail"));
                    user.setSurname(request.getParameter("inputSurname"));
                    Part filePart = request.getPart("inputAvatar");

                    InputStream is = null;
                     if (filePart != null) {
                         is = filePart.getInputStream();
                         user.setIcon( FileIO.getBytesFromInputStream(is, (int) filePart.getSize()));
                     }
                   // byte[] bytes = IOUtils.readFully(is, 1, true);

                  em.persist(user);
                }      
                em.getTransaction()
            .commit();
        }
        catch(Exception ex){
            request.getRequestDispatcher("EditDeleteUserList.jsp").forward(request, response);
        }
        
        finally{
            em.close();
            DatabaseConnection.getEntityManager().close(); 
        }
        
        if(redirect){
            request.getRequestDispatcher("EditDeleteUserList.jsp").forward(request, response);
        }
    }


}
