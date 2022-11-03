<%
    String lastPage = (String)session.getAttribute("lastPage");
    session.invalidate();
    response.sendRedirect(lastPage);
%>