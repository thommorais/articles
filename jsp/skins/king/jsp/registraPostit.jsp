<%
String coord=request.getParameter("coord");
String msg=request.getParameter("msg");
String pagina=request.getParameter("pagina");
String edicao=request.getParameter("edicao");   
br.com.maven.flip.javasql.dao.FlipLinkDAO.cadastraLink(coord, msg, edicao, pagina,"","",request);
%>