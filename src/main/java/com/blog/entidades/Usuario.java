package com.blog.entidades;

public class Usuario {
    private int idUsuario;
    private String nome;
    private String email;
    private String senha;
    private int perfil;

    public Usuario(String nome, String email, String senha, int perfil) {
        this.email = email;
        this.senha = senha;
        this.perfil = perfil;
        this.nome = nome;
    }

    public Usuario() {
        this.perfil = 0;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public int getPerfil() {
        return perfil;
    }

    public void setPerfil(int perfil) {
        this.perfil = perfil;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
