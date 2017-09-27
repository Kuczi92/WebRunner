/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import Model.Role;
import Model.User;
import java.util.Collection;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author Quchi
 */
public class UserService {
    public User GetUserParameters(User Loadeduser){
         User user = new User();
               user.setUsername(Loadeduser.getUsername());
               user.setName(Loadeduser.getName());
               user.setAdress(Loadeduser.getAdress());
               user.setBirth(Loadeduser.getBirth());
               user.setIcon(Loadeduser.getIcon());
               user.setSex(Loadeduser.getSex());
               user.setEmail(Loadeduser.getEmail());
               user.setSurname(Loadeduser.getSurname());
        
        return user;
    }
    public  User GetUserByUsername(String username) {
    User user;          
        EntityManager em = DatabaseConnection.getEntityManager();
        em.getTransaction()
            //rozpoczęcie tranzakcji    
               .begin();
              Query query =  em.createQuery("select u from User u where u.username=:username")
                        .setParameter("username", username);
               User Loadeduser = (User) query.getSingleResult();
               user = new User();
               user.setUsername(Loadeduser.getUsername());
               user.setName(Loadeduser.getName());
               user.setAdress(Loadeduser.getAdress());
               user.setBirth(Loadeduser.getBirth());
               user.setIcon(Loadeduser.getIcon());
               user.setSex(Loadeduser.getSex());
               user.setEmail(Loadeduser.getEmail());
               user.setSurname(Loadeduser.getSurname());
               List <Role > Roles = (List <Role >)Loadeduser.getRoleCollection();
               
               user.addToRoleCollection(new Role(Roles.get(0).getRole(),Roles.get(0).getDescription()));
               
               em.getTransaction()
            .commit();
            //zakończenie tranzakcji   
        //zakończenie tranzakcji       
        em.close();
        
       return user;
    }
}
