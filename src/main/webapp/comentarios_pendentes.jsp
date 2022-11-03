<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.*"%>
<%@page import="com.blog.entidades.*"%>
<%@page import="java.util.*"%>
<% 
    session.setAttribute("lastPage",request.getRequestURI());
    Usuario u = (Usuario)session.getAttribute("user");
    u = (u == null) ? new Usuario() : u ;

    List<Postagem> lista = DaoPostagem.listarPendentes();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pendentes</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
      
</head>
<body>

    <div class="container vh-100">

        <div class="row" style="height: 15%;">
            <div class="">
                <h1>Blog - Postagens</h1>
            </div>

            <nav class="navbar navbar-expand-lg bg-light">
                <div class="container-fluid">
                  <a class="navbar-brand" href="index.jsp">Inicio</a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="consulta.jsp">Postagens</a>
                        </li>
                        <%
                            if(u.getPerfil() == 1){
                                out.write("<li class='nav-item'>");
                                out.write("     <a class='nav-link' href='nova_postagem.jsp'>Nova Postagem</a>");
                                out.write("</li>");
                                out.write("<li class='nav-item'>");
                                out.write("    <a class='nav-link' href='comentarios_pendentes.jsp'>Comentarios Pendentes</a>");
                                out.write("</li>");
                            }
                        %>    
                    </ul>
                    <div class="d-flex">
                    <%
                        String usuarioLogado = (u.getNome() == null) ? "Não autenticado" : u.getNome();
                        out.write("<span class='btn' id='user'>" + usuarioLogado + "</span>");
                        if(u.getNome() == null){
                            out.write("<a class='btn' href='login.jsp'>Login</a>");                        
                        }else{
                            out.write("<a class='btn' href='logout.jsp?sair=1'>Sair</a>");
                        }
                    %>
                    </div>
                  </div>
                </div>
              </nav>

        </div>
        <div class="row mt-4">
            <% out.write("<p> Mostrando " + lista.size() + " postagens pendentes de revisão!</p>"); %>
        </div>

        <div class="row mb-4 d-flex">
               
            <table class="table">
                <%
                    for(Postagem p: lista){
                        out.write("<tr>");
                        out.write("<td><a  href='postagem.jsp?id=" + p.getIdPostagem() + "' class='btn btn-outline-secondary'>Ver Postagem</a></td>");
                        out.write("<td class='fs-5 align-bottom'><span class='fs-4 fw-semibold'>" + p.getTitulo() + " - </span>" + p.getPostagem().substring(0,15) + "...</td>");
                        out.write("<td class='fs-5 align-bottom'>" + p.getComentarios().size() + " comentarios</td>");
                        out.write("</tr>");
                    }
                
                %>   
            </table>     

        </div>    
           
    </div>
    
</body>
</html>
