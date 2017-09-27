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
import javax.persistence.Lob;
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
@Table(name = "picture")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Picture.findAll", query = "SELECT p FROM Picture p")
    , @NamedQuery(name = "Picture.findByIdpicture", query = "SELECT p FROM Picture p WHERE p.picturePK.idpicture = :idpicture")
    , @NamedQuery(name = "Picture.findByNumbersOnPicture", query = "SELECT p FROM Picture p WHERE p.numbersOnPicture = :numbersOnPicture")
    , @NamedQuery(name = "Picture.findByEventIdevent", query = "SELECT p FROM Picture p WHERE p.picturePK.eventIdevent = :eventIdevent")})
public class Picture implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected PicturePK picturePK;
    @Basic(optional = false)
    @Column(name = "numbersOnPicture")
    private String numbersOnPicture;
    @Basic(optional = false)
    @Lob
    @Column(name = "picture")
    private byte[] picture;
    @ManyToMany(mappedBy = "pictureList")
    private List<Number> numberList;
    @JoinColumn(name = "event_idevent", referencedColumnName = "idevent", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Event event;

    public Picture() {
    }

    public Picture(PicturePK picturePK) {
        this.picturePK = picturePK;
    }

    public Picture(PicturePK picturePK, String numbersOnPicture, byte[] picture) {
        this.picturePK = picturePK;
        this.numbersOnPicture = numbersOnPicture;
        this.picture = picture;
    }

    public Picture(int idpicture, int eventIdevent) {
        this.picturePK = new PicturePK(idpicture, eventIdevent);
    }

    public PicturePK getPicturePK() {
        return picturePK;
    }

    public void setPicturePK(PicturePK picturePK) {
        this.picturePK = picturePK;
    }

    public String getNumbersOnPicture() {
        return numbersOnPicture;
    }

    public void setNumbersOnPicture(String numbersOnPicture) {
        this.numbersOnPicture = numbersOnPicture;
    }

    public byte[] getPicture() {
        return picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    @XmlTransient
    public List<Number> getNumberList() {
        return numberList;
    }

    public void setNumberList(List<Number> numberList) {
        this.numberList = numberList;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (picturePK != null ? picturePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Picture)) {
            return false;
        }
        Picture other = (Picture) object;
        if ((this.picturePK == null && other.picturePK != null) || (this.picturePK != null && !this.picturePK.equals(other.picturePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Model.Picture[ picturePK=" + picturePK + " ]";
    }

   
     public void AddNumber(Number CurrentNumber) {
        if(numberList==null){
            numberList = new ArrayList<>();
        } 
       this.numberList.add(CurrentNumber);
    }
}
