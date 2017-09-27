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
public class PicturePK implements Serializable {

    @Basic(optional = false)
    @Column(name = "idpicture")
    private int idpicture;
    @Basic(optional = false)
    @Column(name = "event_idevent")
    private int eventIdevent;

    public PicturePK() {
    }

    public PicturePK(int idpicture, int eventIdevent) {
        this.idpicture = idpicture;
        this.eventIdevent = eventIdevent;
    }

    public int getIdpicture() {
        return idpicture;
    }

    public void setIdpicture(int idpicture) {
        this.idpicture = idpicture;
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
        hash += (int) idpicture;
        hash += (int) eventIdevent;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PicturePK)) {
            return false;
        }
        PicturePK other = (PicturePK) object;
        if (this.idpicture != other.idpicture) {
            return false;
        }
        if (this.eventIdevent != other.eventIdevent) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Model.PicturePK[ idpicture=" + idpicture + ", eventIdevent=" + eventIdevent + " ]";
    }
    
}
