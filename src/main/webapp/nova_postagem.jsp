<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.*"%>
<%@page import="com.blog.entidades.*"%>
<%@page import="java.util.List"%>
<% 
    session.setAttribute("lastPage",request.getRequestURI());
    Usuario u = (Usuario)session.getAttribute("user");
    u = (u == null) ? new Usuario() : u ;

    if(u.getPerfil() != 1){
        response.sendRedirect("index.jsp");
    }

    String texto = request.getParameter("texto");
    String titulo = request.getParameter("titulo");

    if(texto != null && !texto.isEmpty()
        && titulo != null && !titulo.isEmpty()){

        Postagem p = new Postagem(texto,titulo,u.getIdUsuario());

        if(DaoPostagem.inserir(p)){
            p = DaoPostagem.buscarUltimaPostagem();
            response.sendRedirect("postagem.jsp?id=" + p.getIdPostagem());
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
                <h1>Blog - Nova Postagem</h1>
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
                        <li class="nav-item">
                            <a class="nav-link" href="nova_postagem.jsp">Nova Postagem</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="comentarios_pendentes.jsp">Comentarios Pendentes</a>
                        </li> 
                    </ul>
                    <div class="d-flex">
                    <%
                        String usuarioLogado = (u.getNome() == null) ? "N??o autenticado" : u.getNome();
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

        <div class="row mt-4 mb-3">
            <h4>Novo Post</h4>
        </div>

        <div class="row mb-4 d-flex">            
            <form action="nova_postagem.jsp" method="POST">                
             
                <div class="mb-3">
                    <label for="titulo" class="form-label fw-semibold fs-6">T??tulo:</label>
                    <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Meu t??tulo!">
                </div>
             
                <div class="mb-3">
                    <label for="texto" class="form-label fw-semibold fs-6">Texto:</label>
                    <textarea class="form-control" id="texto" name="texto" rows="10"></textarea>
                </div>
                <div class="d-flex flex-row-reverse">
                    <div class="mb-3">
                        <a class="btn btn-outline-danger" href="index.jsp">Cancelar</a>
                    </div>
                    <div class="mb-3">
                        <button class="btn btn-outline-secondary me-3">Publicar</button>
                    </div>
                </div>

            </form>
        </div>      
           
    </div>
    
</body>
</html>
