package com.blog.dao;

import com.blog.entidades.Comentario;
import com.blog.entidades.Usuario;
import com.blog.utils.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoComentario {

    public static Boolean inserir(Comentario c){
        Connection con = Conexao.conectar();
        String sql = "insert into comentarios (status, mensagem, idPostagem, idUsuario) " +
                " values ( ? , ? , ? , ? )";
        int res = 0;
        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,c.getStatus());
                stm.setString(2,c.getMensagem());
                stm.setInt(3,c.getIdPostagem());
                stm.setInt(4,c.getUsuario().getIdUsuario());

                res = stm.executeUpdate();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return res > 0;
    }

    public static Boolean remover(int idComentario){
        Connection con = Conexao.conectar();
        String sql = "delete from comentarios where idComentario = ?";
        int res = 0;
        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idComentario);

                res = stm.executeUpdate();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return res > 0;
    }

    public static Boolean removerTodos(int idPostagem){
        Connection con = Conexao.conectar();
        String sql = "delete from comentarios where idPostagem = ?";
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

    public static Comentario buscar(int idComentario){
        Connection con = Conexao.conectar();
        Comentario c = new Comentario();
        String sql = " select * from comentarios where idComentario = ?";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setInt(1,idComentario);

                ResultSet res = stm.executeQuery();

                while (res.next()){
                    Usuario u = DaoUsuario.buscarUsuario(res.getInt("idUsuario"));

                    c.setIdComentario(res.getInt("idComentario"));
                    c.setStatus(res.getInt("status"));
                    c.setMensagem(res.getString("mensagem"));
                    c.setIdPostagem(res.getInt("idPostagem"));
                    c.setUsuario(u);

                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return c;
    }

    public static List<Comentario> buscarComentarios(int idPostagem){
        Connection con = Conexao.conectar();
        List<Comentario> lista = new ArrayList<Comentario>();
        String sql = "select * from comentarios where idPostagem = ?";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idPostagem);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Comentario c = new Comentario();
                    Usuario u = DaoUsuario.buscarUsuario(res.getInt("idUsuario"));

                    c.setIdComentario(res.getInt("idComentario"));
                    c.setStatus(res.getInt("status"));
                    c.setMensagem(res.getString("mensagem"));
                    c.setIdPostagem(res.getInt("idPostagem"));
                    c.setUsuario(u);

                    lista.add(c);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static List<Comentario> buscarComentariosLiberados(int idPostagem){
        Connection con = Conexao.conectar();
        List<Comentario> lista = new ArrayList<Comentario>();
        String sql = "select * from comentarios where idPostagem = ? and status = 1";

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idPostagem);

                ResultSet res = stm.executeQuery();

                while (res.next()){

                    Comentario c = new Comentario();
                    Usuario u = DaoUsuario.buscarUsuario(res.getInt("idUsuario"));

                    c.setIdComentario(res.getInt("idComentario"));
                    c.setStatus(res.getInt("status"));
                    c.setMensagem(res.getString("mensagem"));
                    c.setIdPostagem(res.getInt("idPostagem"));
                    c.setUsuario(u);

                    lista.add(c);

                }


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return lista;
    }

    public static boolean alterarStatus(int idComentario){
        Connection con = Conexao.conectar();
        Comentario c = buscar(idComentario);
        int status = (c.getStatus() == 1)? 0 : 1;
        String sql = "update comentarios set status = ? where idComentario = ?";

        int res = 0;
        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.setInt(1,status);
                stm.setInt(2,idComentario);
                res = stm.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return res > 0;
    }

}
