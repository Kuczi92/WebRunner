/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Quchi
 */

public class DatabaseConnection {
  private static EntityManagerFactory emFactory = null;

  private DatabaseConnection (){
      emFactory = Persistence.createEntityManagerFactory("WebowaAplikacjaRunnerPU");
  }
   public static EntityManager getEntityManager() {
    DatabaseConnection d = null;
    if(emFactory==null){
      d=   new DatabaseConnection();
    }   
    return DatabaseConnection.emFactory.createEntityManager();
  }

}
