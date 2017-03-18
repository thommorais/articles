<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = request.getParameter("base");
            Integer edicao = Integer.parseInt(request.getParameter("edicao"));
            br.com.maven.flip.javasql.FlipEnqueteTbl enquete = br.com.maven.flip.javasql.dao.FlipEnqueteDAO.getEnquete(edicao);
            if (enquete != null) {
                request.setAttribute("enquete", enquete);
%>
        <script type="text/javascript" src="<%= base%>flip/jornal/skins/common/js/pool.js" charset="utf-8"></script>
<div style='float: right; margin: 5px 12px 10px 10px'>
    <a href="#" onclick="$('pool_itens').appear();">
        <span id="pool">
            Enquete: <c:out value="${enquete.pergunta}"/>
        </span>
    </a>
    <div id="pool_itens" style="display:none">
        <span >
            Enquete: <c:out value="${enquete.pergunta}"/>
        </span>
        <br/>
        <form action="" method="post" id="pool_form">
            <c:forEach var="opcao" items="${enquete.opcoes}" varStatus="i">
                <input type="radio" name="opcao" id="rdo-poll<c:out value='${i.index}'/>" class="chk-rdo-replace" value="<c:out value='${opcao.id}'/>" />
                <label for="rdo-poll<c:out value='${i.index}'/>"><c:out value="${opcao.opcao}"/></label>
                <br/>
            </c:forEach>
                <br/>
            <input type="button" class="BotaoBranco" value="Votar" onclick="votar();"/>
            <input type="button" class="BotaoBranco" value="Cancelar" onclick="Effect.SwitchOff('pool_itens')"/>
        </form>
    </div>
</div>


<%}%>