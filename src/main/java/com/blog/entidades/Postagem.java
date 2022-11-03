package com.blog.entidades;

import java.util.List;

public class Postagem {
    private int idPostagem;
    private String postagem;
    private String titulo;
    private int idUsuario;
    private List<Comentario> comentarios;

    public Postagem(String postagem, String titulo, int idUsuario) {
        this.postagem = postagem;
        this.titulo = titulo;
        this.idUsuario = idUsuario;

    }

    public Postagem() {
    }

    public int getIdPostagem() {
        return idPostagem;
    }

    public void setIdPostagem(int idPostagem) {
        this.idPostagem = idPostagem;
    }

    public String getPostagem() {
        return postagem;
    }

    public void setPostagem(String postagem) {
        this.postagem = postagem;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public List<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<Comentario> comentarios) {
        this.comentarios = comentarios;
    }
}
