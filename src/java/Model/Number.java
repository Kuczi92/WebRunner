/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Quchi
 */
@Entity
@Table(name = "number")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Number.findAll", query = "SELECT n FROM Number n")
    , @NamedQuery(name = "Number.findByEventNumber", query = "SELECT n FROM Number n WHERE n.eventNumber = :eventNumber")
    , @NamedQuery(name = "Number.findByUserUsername", query = "SELECT n FROM Number n WHERE n.numberPK.userUsername = :userUsername")
    , @NamedQuery(name = "Number.findByEventIdevent", query = "SELECT n FROM Number n WHERE n.numberPK.eventIdevent = :eventIdevent")})
public class Number implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected NumberPK numberPK;
    @Basic(optional = false)
    @Column(name = "EventNumber")
    private int eventNumber;
    @JoinTable(name = "number_has_picture", joinColumns = {
        @JoinColumn(name = "number_user_username", referencedColumnName = "user_username")
        , @JoinColumn(name = "number_event_idevent", referencedColumnName = "event_idevent")}, inverseJoinColumns = {
        @JoinColumn(name = "picture_idpicture", referencedColumnName = "idpicture")
        , @JoinColumn(name = "picture_event_idevent", referencedColumnName = "event_idevent")})
    @ManyToMany
    private List<Picture> pictureList;
    @JoinColumn(name = "event_idevent", referencedColumnName = "idevent", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Event event;
    @JoinColumn(name = "user_username", referencedColumnName = "username", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public Number() {
    }

    public Number(NumberPK numberPK) {
        this.numberPK = numberPK;
    }

    public Number(NumberPK numberPK, int eventNumber) {
        this.numberPK = numberPK;
        this.eventNumber = eventNumber;
    }

    public Number(String userUsername, int eventIdevent) {
        this.numberPK = new NumberPK(userUsername, eventIdevent);
    }

    public NumberPK getNumberPK() {
        return numberPK;
    }

    public void setNumberPK(NumberPK numberPK) {
        this.numberPK = numberPK;
    }

    public int getEventNumber() {
        return eventNumber;
    }

    public void setEventNumber(int eventNumber) {
        this.eventNumber = eventNumber;
    }

    @XmlTransient
    public List<Picture> getPictureList() {
        return pictureList;
    }

    public void setPictureList(List<Picture> pictureList) {
        this.pictureList = pictureList;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (numberPK != null ? numberPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Number)) {
            return false;
        }
        Number other = (Number) object;
        if ((this.numberPK == null && other.numberPK != null) || (this.numberPK != null && !this.numberPK.equals(other.numberPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Model.Number[ numberPK=" + numberPK + " ]";
    }
    
    public void AddPicture(Picture currentPic) {
        if(pictureList==null){
            pictureList = new ArrayList<>();
        } 
       this.pictureList.add(currentPic);
    }
    
    
}
