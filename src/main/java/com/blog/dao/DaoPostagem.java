package com.blog.dao;

import com.blog.entidades.Postagem;
import com.blog.utils.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoPostagem {

    public static List<Postagem> listarTotal(){
        Connection con = Conexao.conectar();
        List<Postagem> lista = new ArrayList<Postagem>();
        String sql = "select * from postagens";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Postagem p = new Postagem();

                    p.setIdPostagem(res.getInt("idPostagem"));
                    p.setPostagem(res.getString("postagem"));
                    p.setTitulo(res.getString("titulo"));
                    p.setIdUsuario(res.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentarios(p.getIdPostagem()));

                    lista.add(p);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static List<Postagem> listarTop10Total(){
        Connection con = Conexao.conectar();
        List<Postagem> lista = new ArrayList<Postagem>();
        String sql = "select * from postagens order by idPostagem desc limit 10";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Postagem p = new Postagem();

                    p.setIdPostagem(res.getInt("idPostagem"));
                    p.setPostagem(res.getString("postagem"));
                    p.setTitulo(res.getString("titulo"));
                    p.setIdUsuario(res.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentarios(p.getIdPostagem()));

                    lista.add(p);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static Postagem buscarPostagemTotal(int idPostagem){
        Connection con = Conexao.conectar();
        String sql = " select * from postagens where idPostagem = ?";

        Postagem p = new Postagem();

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idPostagem);

                ResultSet rs = stm.executeQuery();

                while(rs.next()) {
                    p.setIdPostagem(rs.getInt("idPostagem"));
                    p.setPostagem(rs.getString("postagem"));
                    p.setTitulo(rs.getString("titulo"));
                    p.setIdUsuario(rs.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentarios(idPostagem));
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return p;
    }

    public static Postagem buscarUltimaPostagem(){
        Connection con = Conexao.conectar();
        Postagem p = new Postagem();
        String sql = "select * from postagens order by idPostagem desc limit 1";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                ResultSet res = stm.executeQuery();
                while (res.next()){
                    p.setIdPostagem(res.getInt("idPostagem"));
                    p.setPostagem(res.getString("postagem"));
                    p.setTitulo(res.getString("titulo"));
                    p.setIdUsuario(res.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentarios(p.getIdPostagem()));
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return p;
    }

    public static List<Postagem> listar(){
        Connection con = Conexao.conectar();
        List<Postagem> lista = new ArrayList<Postagem>();
        String sql = "select * from postagens";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Postagem p = new Postagem();

                    p.setIdPostagem(res.getInt("idPostagem"));
                    p.setPostagem(res.getString("postagem"));
                    p.setTitulo(res.getString("titulo"));
                    p.setIdUsuario(res.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentarios(p.getIdPostagem()));

                    lista.add(p);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static List<Postagem> listarPendentes(){
        Connection con = Conexao.conectar();
        List<Postagem> lista = new ArrayList<Postagem>();
        String sql = "select * from postagens " +
                            " where idPostagem in (select distinct(idPostagem) " +
                                        "from comentarios c where c.status = 0)";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Postagem p = new Postagem();

                    p.setIdPostagem(res.getInt("idPostagem"));
                    p.setPostagem(res.getString("postagem"));
                    p.setTitulo(res.getString("titulo"));
                    p.setIdUsuario(res.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentarios(p.getIdPostagem()));

                    lista.add(p);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static List<Postagem> listarTop10(){
        Connection con = Conexao.conectar();
        List<Postagem> lista = new ArrayList<Postagem>();
        String sql = "select * from postagens order by idPostagem desc limit 10";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Postagem p = new Postagem();

                    p.setIdPostagem(res.getInt("idPostagem"));
                    p.setPostagem(res.getString("postagem"));
                    p.setTitulo(res.getString("titulo"));
                    p.setIdUsuario(res.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentariosLiberados(p.getIdPostagem()));

                    lista.add(p);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static Postagem buscarPostagem(int idPostagem){
        Connection con = Conexao.conectar();
        String sql = " select * from postagens where idPostagem = ?";

        Postagem p = new Postagem();

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idPostagem);

                ResultSet rs = stm.executeQuery();

                while(rs.next()) {
                    p.setIdPostagem(rs.getInt("idPostagem"));
                    p.setPostagem(rs.getString("postagem"));
                    p.setTitulo(rs.getString("titulo"));
                    p.setIdUsuario(rs.getInt("idUsuario"));
                    p.setComentarios(DaoComentario.buscarComentariosLiberados(idPostagem));
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return p;
    }

    public static boolean inserir(Postagem p){
        Connection con = Conexao.conectar();
        String sql = "insert into postagens (postagem, titulo, idUsuario) " +
                        " values ( ? , ? , ? )";
        int res = 0;

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setString(1,p.getPostagem());
                stm.setString(2,p.getTitulo());
                stm.setInt(3,p.getIdUsuario());

                res = stm.executeUpdate();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return res > 0;
    }

    public static boolean excluir(int idPostagem){
        Connection con = Conexao.conectar();
        String sql = " delete from postagens where idPostagem = ?";
        DaoComentario.removerTodos(idPostagem);
        int res = 0;

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idPostagem);

                res = stm.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return res > 0;
    }

    public static boolean alterar(Postagem p){
        Connection con = Conexao.conectar();
        String sql = " update postagens set " +
                        " postagem = ?, titulo = ? where idPostagem = ?";

        int res = 0;

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setString(1,p.getPostagem());
                stm.setString(2,p.getTitulo());
                stm.setInt(3,p.getIdPostagem());

                res = stm.executeUpdate();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return res > 0;
    }



}
