<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
String cd=request.getParameter("cd");
String text=br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.getHtml5Content(cd);
if(text == null){
%>
<h1>CONTE�DO N�O CARREGADO</h1>
<% } else{
request.setAttribute("text",text);
%>
<c:out value="${text}" escapeXml="false"/>
<% } %>
