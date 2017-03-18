<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<% String message = br.com.maven.flip.javasql.dao.FlipPromocaoDAO.participa(request);
request.setAttribute("message",message);
%><c:out value="${message}"/>