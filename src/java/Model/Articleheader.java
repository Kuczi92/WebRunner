/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Quchi
 */
@Entity
@Table(name = "articleheader")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Articleheader.findAll", query = "SELECT a FROM Articleheader a")
    , @NamedQuery(name = "Articleheader.findByIdArticleHeader", query = "SELECT a FROM Articleheader a WHERE a.idArticleHeader = :idArticleHeader")
    , @NamedQuery(name = "Articleheader.findByHeader", query = "SELECT a FROM Articleheader a WHERE a.header = :header")
    , @NamedQuery(name = "Articleheader.findByAutor", query = "SELECT a FROM Articleheader a WHERE a.autor = :autor")
    , @NamedQuery(name = "Articleheader.findByDate", query = "SELECT a FROM Articleheader a WHERE a.date = :date")
    , @NamedQuery(name = "Articleheader.findByDescription", query = "SELECT a FROM Articleheader a WHERE a.description = :description")})
public class Articleheader implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idArticleHeader")
    private Integer idArticleHeader;
    @Basic(optional = false)
    @Column(name = "Header")
    private String header;
    @Basic(optional = false)
    @Column(name = "Autor")
    private String autor;
    @Basic(optional = false)
    @Column(name = "Date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Basic(optional = false)
    @Lob
    @Column(name = "Picture")
    private byte[] picture;
    @Basic(optional = false)
    @Column(name = "Description")
    private String description;
    @OneToMany(mappedBy = "articleHeaderidArticleHeader")

    private List<Headers> headersList;

    public Articleheader() {
    }

    public Articleheader(Integer idArticleHeader) {
        this.idArticleHeader = idArticleHeader;
    }

    public Articleheader(Integer idArticleHeader, String header, String autor, Date date, byte[] picture, String description) {
        this.idArticleHeader = idArticleHeader;
        this.header = header;
        this.autor = autor;
        this.date = date;
        this.picture = picture;
        this.description = description;
    }

    public Integer getIdArticleHeader() {
        return idArticleHeader;
    }

    public void setIdArticleHeader(Integer idArticleHeader) {
        this.idArticleHeader = idArticleHeader;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public byte[] getPicture() {
        return picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlTransient
    public List<Headers> getHeadersList() {
        return headersList;
    }

    public void setHeadersList(List<Headers> headersList) {
        this.headersList = headersList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idArticleHeader != null ? idArticleHeader.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Articleheader)) {
            return false;
        }
        Articleheader other = (Articleheader) object;
        if ((this.idArticleHeader == null && other.idArticleHeader != null) || (this.idArticleHeader != null && !this.idArticleHeader.equals(other.idArticleHeader))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Model.Articleheader[ idArticleHeader=" + idArticleHeader + " ]";
    }
    
}
