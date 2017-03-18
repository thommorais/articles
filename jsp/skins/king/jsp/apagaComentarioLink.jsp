<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%

            String id = request.getParameter("id");
            try{
            br.com.maven.flip.javasql.FlipMensagemTbl msg = new br.com.maven.flip.javasql.FlipMensagemTbl();            
            br.com.maven.flip.javasql.dao.FlipMensagemDAO.deleteComentarioPorLink(Integer.parseInt(id));
%>
<h3> Nota removida com sucesso! </h3>

<% } catch(Exception e){
    br.com.maven.flip.Logger.logStackTrace(e);
    %>
    <h3> Erro ao remover nota. Tente novamente mais tarde. </h3>
<% } %>