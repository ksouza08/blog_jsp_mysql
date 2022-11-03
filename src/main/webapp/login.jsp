<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.*"%>
<%@page import="com.blog.enums.*"%>
<%@page import="com.blog.entidades.*"%>
<%@page import="java.util.*"%>
<%
    String user = request.getParameter("user");
    String pwd = request.getParameter("pwd");
    String erro = request.getParameter("erro");

    Usuario u;

    if(user != null && !user.isEmpty() 
            && pwd != null && !pwd.isEmpty()){

        u = DaoUsuario.buscarUsuario(user);
        
        if(u.getPerfil() != 0 && u.getSenha().equals(pwd)){
            session.setAttribute("user",u);     
            String lastPage = (String)session.getAttribute("lastPage");
            response.sendRedirect(lastPage);            
        }else{
            response.sendRedirect("login.jsp?erro=1");            
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
                <form action="login.jsp" method="POST">
                    <label class="form-label" for="xUser">
                        Usuário:   
                    </label>
                    <input type="text" class="form-control" id = "xUser" name="user">
                    
                    <div class="mt-3">
                        <label class="form-label" for="xPwd">
                            Senha:   
                        </label>
                        <input type="password" class="form-control" id = "xPwd" name="pwd">
                    </div>
                    <div class="d-flex flex-row">    
                        <div class="mt-3">
                            <button class="btn btn-primary"> Login </button>
                        </div>
                        <div class="mt-3 ms-3">
                            <a class="btn btn-outline-secondary" href="cadastro_usuario.jsp">Cadastrar</a>
                        </div>
                    </div>
                </form>

                
            </div>
        </div>    
        <div class="text-danger mt-5">
            <% 
                    if(erro != null){
                        if(erro.equals("1")){
                            out.write("Usuario ou senha incorreta!");
                        }else {
                            out.write("Campos Vazios!");
                        }
                    } 
                
            %>    
        </div>
    </div>
</body>
</html>