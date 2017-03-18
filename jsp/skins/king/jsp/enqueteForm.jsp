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
    <div id="pool_itens" class="TextoPreto">
        <span >
            <strong>Enquete: <c:out value="${enquete.pergunta}"/></strong>
        </span>
        <br/><br/>
        <form action="" method="post" id="pool_form">
            <c:forEach var="opcao" items="${enquete.opcoes}" varStatus="i">
                <input type="radio" name="opcao" id="rdo-poll<c:out value='${i.index}'/>" class="chk-rdo-replace" value="<c:out value='${opcao.id}'/>" />
                <label for="rdo-poll<c:out value='${i.index}'/>"><c:out value="${opcao.opcao}"/></label>
                <br/>
            </c:forEach>
                <br/>
            <input type="button" class="BotaoBranco" value="Votar" onclick="votar();"/>            
        </form>
    </div>


<%}%>