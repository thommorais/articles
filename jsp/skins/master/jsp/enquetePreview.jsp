<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean" %>
<%
    String base = request.getParameter("base");
    Integer edicao = Integer.parseInt(request.getParameter("edicao"));
    br.com.maven.flip.javasql.FlipEnqueteTbl enquete = br.com.maven.flip.javasql.dao.FlipEnqueteDAO.getEnquete(edicao);
    if (enquete != null) {
        request.setAttribute("enquete", enquete);
%>            
<div class="enquete bg-geral">
    <div id="container" class="left">
        <div id="balance" class="valign"></div>
        <div class="valign"><i class="icon-question-sign"></i></div>
    </div>                
    <div id="container" class="left">
        <div id="balance" class="valign"></div>
        <div class="valign"> <a href="javascript:void(0);" onclick="abrirEnquete();"><c:out value="${enquete.perguntaReduzida}"/></a> </div>
    </div>
    <div class="right separador"></div>
    <div id="container" class="right fechar">
        <div id="balance" class="valign"></div>
        <div  class="valign"><a href="javascript:void(0);" onclick="removerEnquete();"><i class="icon-remove"></i></a></div>
    </div>
</div>
<%}%>