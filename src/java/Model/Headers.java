/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Quchi
 */
@Entity
@Table(name = "headers")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Headers.findAll", query = "SELECT h FROM Headers h")
    , @NamedQuery(name = "Headers.findByIdHeaders", query = "SELECT h FROM Headers h WHERE h.idHeaders = :idHeaders")
    , @NamedQuery(name = "Headers.findByHeaderscol", query = "SELECT h FROM Headers h WHERE h.headerscol = :headerscol")
    , @NamedQuery(name = "Headers.findByTitle", query = "SELECT h FROM Headers h WHERE h.title = :title")
    , @NamedQuery(name = "Headers.findByDescription", query = "SELECT h FROM Headers h WHERE h.description = :description")
    , @NamedQuery(name = "Headers.findByArticle", query = "SELECT h FROM Headers h WHERE h.article = :article")
    , @NamedQuery(name = "Headers.findByYoutubeLinks", query = "SELECT h FROM Headers h WHERE h.youtubeLinks = :youtubeLinks")})
public class Headers implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idHeaders")
    private Integer idHeaders;
    @Column(name = "Headerscol")
    private String headerscol;
    @Column(name = "Title")
    private String title;
    @Column(name = "Description")
    private String description;
    @Lob
    @Column(name = "Picture")
    private byte[] picture;
    @Column(name = "Article")
    private String article;
    @Column(name = "YoutubeLinks")
    private String youtubeLinks;
    @JoinColumn(name = "ArticleHeader_idArticleHeader", referencedColumnName = "idArticleHeader")
    @ManyToOne
    private Articleheader articleHeaderidArticleHeader;

    public Headers() {
    }

    public Headers(Integer idHeaders) {
        this.idHeaders = idHeaders;
    }

    public Integer getIdHeaders() {
        return idHeaders;
    }

    public void setIdHeaders(Integer idHeaders) {
        this.idHeaders = idHeaders;
    }

    public String getHeaderscol() {
        return headerscol;
    }

    public void setHeaderscol(String headerscol) {
        this.headerscol = headerscol;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte[] getPicture() {
        return picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    public String getArticle() {
        return article;
    }

    public void setArticle(String article) {
        this.article = article;
    }

    public String getYoutubeLinks() {
        return youtubeLinks;
    }

    public void setYoutubeLinks(String youtubeLinks) {
        this.youtubeLinks = youtubeLinks;
    }

    public Articleheader getArticleHeaderidArticleHeader() {
        return articleHeaderidArticleHeader;
    }

    public void setArticleHeaderidArticleHeader(Articleheader articleHeaderidArticleHeader) {
        this.articleHeaderidArticleHeader = articleHeaderidArticleHeader;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idHeaders != null ? idHeaders.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Headers)) {
            return false;
        }
        Headers other = (Headers) object;
        if ((this.idHeaders == null && other.idHeaders != null) || (this.idHeaders != null && !this.idHeaders.equals(other.idHeaders))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Model.Headers[ idHeaders=" + idHeaders + " ]";
    }
    
}
