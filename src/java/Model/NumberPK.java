/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author Quchi
 */
@Embeddable
public class NumberPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "user_username")
    private String userUsername;
    @Basic(optional = false)
    @Column(name = "event_idevent")
    private int eventIdevent;

    public NumberPK() {
    }

    public NumberPK(String userUsername, int eventIdevent) {
        this.userUsername = userUsername;
        this.eventIdevent = eventIdevent;
    }

    public String getUserUsername() {
        return userUsername;
    }

    public void setUserUsername(String userUsername) {
        this.userUsername = userUsername;
    }

    public int getEventIdevent() {
        return eventIdevent;
    }

    public void setEventIdevent(int eventIdevent) {
        this.eventIdevent = eventIdevent;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userUsername != null ? userUsername.hashCode() : 0);
        hash += (int) eventIdevent;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof NumberPK)) {
            return false;
        }
        NumberPK other = (NumberPK) object;
        if ((this.userUsername == null && other.userUsername != null) || (this.userUsername != null && !this.userUsername.equals(other.userUsername))) {
            return false;
        }
        if (this.eventIdevent != other.eventIdevent) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Model.NumberPK[ userUsername=" + userUsername + ", eventIdevent=" + eventIdevent + " ]";
    }
    
}
