package com.blog.entidades;

public class Comentario {

    private int idComentario;
    private int status;
    private String mensagem;
    private int idPostagem;
    private Usuario usuario;

    public Comentario(int status, String mensagem, int idPostagem, Usuario usuario) {
        this.status = status;
        this.mensagem = mensagem;
        this.idPostagem = idPostagem;
        this.usuario = usuario;
    }

    public Comentario() {
    }

    public int getIdComentario() {
        return idComentario;
    }

    public void setIdComentario(int idComentario) {
        this.idComentario = idComentario;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public int getIdPostagem() {
        return idPostagem;
    }

    public void setIdPostagem(int idPostagem) {
        this.idPostagem = idPostagem;
    }
}
