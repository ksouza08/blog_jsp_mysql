package com.blog.dao;

import com.blog.entidades.Postagem;
import com.blog.entidades.Usuario;
import com.blog.utils.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUsuario {

    public static Usuario buscarUsuario(int idUsuario){
        Connection con = Conexao.conectar();
        String sql = " select * from usuarios where idUsuario = ?";

        Usuario u = new Usuario();

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setInt(1,idUsuario);

                ResultSet rs = stm.executeQuery();

                while(rs.next()) {
                    u.setNome(rs.getString("nome"));
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setEmail(rs.getString("email"));
                    u.setSenha(rs.getString("senha"));
                    u.setPerfil(rs.getInt("idPerfil"));
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return u;
    }

    public static Usuario buscarUsuario(String email){
        Connection con = Conexao.conectar();
        String sql = " select * from usuarios where email = ?";

        Usuario u = new Usuario();

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setString(1,email);

                ResultSet rs = stm.executeQuery();

                while(rs.next()) {
                    u.setNome(rs.getString("nome"));
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setEmail(rs.getString("email"));
                    u.setSenha(rs.getString("senha"));
                    u.setPerfil(rs.getInt("idPerfil"));
                }

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return u;
    }

    public static boolean inserir(Usuario u){
        Connection con = Conexao.conectar();
        String sql = "insert into usuarios (nome, email, senha, idPerfil) " +
                " values ( ?, ? , ? , ? )";
        int res = 0;

        if(con != null){
            try {
                PreparedStatement stm = con.prepareStatement(sql);

                stm.setString(1,u.getNome());
                stm.setString(2,u.getEmail());
                stm.setString(3,u.getSenha());
                stm.setInt(4,u.getPerfil());

                res = stm.executeUpdate();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return res > 0;
    }

}
