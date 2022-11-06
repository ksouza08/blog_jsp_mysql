<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.*"%>
<%@page import="com.blog.enums.*"%>
<%@page import="com.blog.entidades.*"%>
<%@page import="java.util.*"%>
<% 
    
    String btnStatus = request.getParameter("changeStatusComentario");   
    String btnRemoverC = request.getParameter("removerComentario");
    String btnRemoverP = request.getParameter("removerPostagem");  
    String idPostagem = request.getParameter("id");
    String strIdComentario = null;

    if(btnStatus != null && !btnStatus.isEmpty()){
        idPostagem = btnStatus.split(";")[0];
        strIdComentario = btnStatus.split(";")[1];
    }

    if(btnRemoverC != null && !btnRemoverC.isEmpty()){
        idPostagem = btnRemoverC.split(";")[0];
        strIdComentario = btnRemoverC.split(";")[1];
    }

    if(btnRemoverP != null && !btnRemoverP.isEmpty()){
        idPostagem = btnRemoverP;
    }


    session.setAttribute("lastPage",request.getRequestURI() + "?id=" + idPostagem);
    Usuario u = (Usuario)session.getAttribute("user");
    u = (u == null) ? new Usuario() : u ;

    Postagem p;

    if(u.getPerfil() > 0){
        p = DaoPostagem.buscarPostagemTotal(Integer.parseInt(idPostagem));
    }else{
        p = DaoPostagem.buscarPostagem(Integer.parseInt(idPostagem));
    }

    if(btnStatus != null && !btnStatus.isEmpty()){
        if(DaoComentario.alterarStatus(Integer.parseInt(strIdComentario))){
            response.sendRedirect("postagem.jsp?id=" + p.getIdPostagem());
        }else{
            response.sendRedirect("erro.jsp?erro=comentario_nao_inserido");
        }
    }

    if(btnRemoverC != null && !btnRemoverC.isEmpty()){
        if(DaoComentario.remover(Integer.parseInt(strIdComentario))){
            response.sendRedirect("postagem.jsp?id=" + p.getIdPostagem());
        }else{
            response.sendRedirect("erro.jsp?erro=comentario_nao_inserido");
        }
    }

    if(btnRemoverP != null && !btnRemoverP.isEmpty()){
        if(DaoPostagem.excluir(Integer.parseInt(idPostagem))){
            response.sendRedirect("consulta.jsp");
        }else{
            response.sendRedirect("erro.jsp?erro=comentario_nao_inserido");
        }
    }

    
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
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
                <h1>Blog - Inicio</h1>
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
                            out.write("<a class='btn' href='logout.jsp?id=" + idPostagem + "'>Sair</a>");
                        }
                    %>
                    </div>
                  </div>
                </div>
              </nav>

            </div>
    

            <div class="row mt-4 mb-4">               
                
                <%
                    out.write("<div class='fs-2 fw-semibold mb-3'>" + p.getTitulo() + "</div>");
                    out.write("<div class='fs-4 mb-3'>" + p.getPostagem() + "</div>");

                    if(u.getPerfil() == 1){        
                        out.write("<div class='d-flex flex-row-reverse'>");
                        out.write("<form action='postagem.jsp' method='POST'><button class='btn btn-outline-secondary' name='removerPostagem' value='" + p.getIdPostagem() + "' >Remover Postagem</button></form>");                    
                        out.write("<form action='editar_postagem.jsp' method='POST' class='me-3'><button class='btn btn-outline-secondary' name='id' value='" + p.getIdPostagem() + "' >Editar Postagem</button></form>");
                        out.write("</div>");
                    }
                    
                %>    
        

            </div>
            
            <div class="row mt-4">
                <h5><% out.write("" + p.getComentarios().size()); %> COMENTARIOS</h5>
                <div>
                    <%
                        List<Comentario> lista = p.getComentarios();
                        String btn = "";
                        if(lista.size() > 0){
                            for(Comentario c: lista){
                                
                                if(u.getPerfil() == 1  
                                        || c.getStatus() == 1 
                                        || (c.getStatus() == 0 && c.getUsuario().getIdUsuario() == u.getIdUsuario())){                                    
                                    
                                    out.write("<div class='p-3 mt-3 mb-2 border-bottom border-end bg-light'>");
                                    out.write("<div class='mt-2 border-bottom pb-1'> <span class='fw-semibold'>Por: </span>" + c.getUsuario().getNome() + " </div>");
                                    out.write("<div class='mt-2 mb-5'>" + c.getMensagem() + " </div>");
                                    if(c.getStatus() == 0){
                                        out.write("<div class='text-success'>Pendente de aprovação!</div>");
                                    }
                                    out.write("</div>");
                                }                             

                                if(u.getPerfil() == 1){
                                    btn = (c.getStatus()==0)?"Liberar":"Bloquear";
                                    out.write("<div class='d-flex flex-row-reverse'>");
                                    out.write("<form action='postagem.jsp' method='POST'><button name='removerComentario' class='btn btn-outline-danger' value='" + p.getIdPostagem() + ";" + c.getIdComentario() + "'>Remover</button></form>");
                                    out.write("<form action='postagem.jsp' method='POST'class='me-3'><button name='changeStatusComentario' class='btn btn-outline-secondary' value='" + p.getIdPostagem() + ";" + c.getIdComentario() + "'>" + btn + "</button></form>");                                    
                                    out.write("</div>");
                                }

                            }
                        }

                        String txtSemLogin = (u.getPerfil() != 0)?"":"Efetue o login para inserir comentarios!";
                        String disabled = (u.getPerfil() != 0)?"":"disabled";

                        out.write("<div class='mt-5'>");
                        out.write("    <form action='postagem.jsp' method='POST'>");
                        out.write("     <div class='mb-3'>");
                        out.write("        <label for='comentario' class='form-label'>Novo comentario:</label>");
                        out.write("            <textarea class='form-control' id='comentario' name='comentario' rows='3' " + disabled + ">" + txtSemLogin + "</textarea>");
                        out.write("        </div>");
                        
                        if(u.getPerfil() != 0){
                            out.write("        <div>");
                            out.write("            <button type='submit' name='id' value='" + p.getIdPostagem() + "' class='btn btn-outline-secondary'>Enviar</button>");
                            out.write("        </div>");
                        }

                        out.write("    </form>");
                        out.write("</div>");


                    
                    %>
                    </div>

                

            </div>

            <%
                String strComentario = request.getParameter("comentario");
                if(strComentario != null && !strComentario.isEmpty()){
                    Comentario c = new Comentario(0,strComentario,p.getIdPostagem(), u);
                    if(DaoComentario.inserir(c)){
                        response.sendRedirect("postagem.jsp?id=" + p.getIdPostagem());
                    }else{
                        response.sendRedirect("erro.jsp?erro=comentario_nao_inserido");
                    }
                }
                
                
            
            %>
           
    </div>
    
</body>
</html>
