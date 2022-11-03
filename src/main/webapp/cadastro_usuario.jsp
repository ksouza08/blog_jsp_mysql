<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.*"%>
<%@page import="com.blog.enums.*"%>
<%@page import="com.blog.entidades.*"%>
<%
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String pwd = request.getParameter("pwd");
    String erro = request.getParameter("erro");
    Usuario u;
    if(nome != null && !nome.isEmpty()
        && email != null && !email.isEmpty()
        && pwd != null && !pwd.isEmpty()){
        
        u = DaoUsuario.buscarUsuario(email);

        if(u.getPerfil() == 0){
            u = new Usuario(nome,email,pwd,1);        
            if(DaoUsuario.inserir(u)){
                response.sendRedirect("login.jsp");
            }else{
                response.sendRedirect("cadastro_usuario.jsp?erro=1");
            }

        }else{

            response.sendRedirect("cadastro_usuario.jsp?erro=2");
        }

    }

%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
           
        <div class="row mt-3" >
            <div class="col">
                <form action="cadastro_usuario.jsp" method="POST">
                    <label class="form-label" for="xNome">
                        Nome:   
                    </label>
                    <input type="text" class="form-control" id = "xNome" name="nome">
                    
                    <label class="form-label" for="xUser">
                        Email:   
                    </label>
                    <input type="text" class="form-control" id = "xUser" name="email">
                    
                    <label class="form-label" for="xPwd">
                        Senha:   
                    </label>
                    <input type="password" class="form-control" id = "xPwd" name="pwd">
                                       
                    <div class="mt-3">
                        <button class="btn btn-primary"> Cadastrar </button>
                    </div>
                </form>
            </div>
        </div>
        <div>
            <% 
                if(erro != null){
                    if(erro.equals("1")){
                        out.write("Não foi possivel criar o usuário");
                    }else if(erro.equals("2")){
                        out.write("Usuario ja existe!");
                    }else if(erro.equals("3")){
                        out.write("Campos Vazios!");
                    }
                } 
            
            %>
        </div>    
    </div>
</body>
</html>