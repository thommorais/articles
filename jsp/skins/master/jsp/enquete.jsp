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
<script type="text/javascript" src="<%= base%>flip/jornal/skins/master/js/pool.js" charset="utf-8"></script>    

<div id="enquete" class="modal modal-texto" title="<c:out value='${enquete.perguntaReduzida}'/>">
    <div class="modal-bg"></div>
    <div class="padding"> <a class="btn-fechar" href="javascript:void(0);" onClick="fecharEnquete()"><i class="icon-remove"></i></a>
        <p class="titulo">ENQUETE</p>
        <p class="pergunta"><c:out value="${enquete.pergunta}"/></p>
        <form action="" method="post" id="pool_form" class="pool_itens">
            <ul>
                <c:forEach var="opcao" items="${enquete.opcoes}" varStatus="i">
                    <li>
                        <p class="custom">
                            <input type="radio" name="opcao" id="rdo-poll<c:out value='${i.index}'/>"  value="<c:out value='${opcao.id}'/>" />
                            <label for="rdo-poll<c:out value='${i.index}'/>"><c:out value="${opcao.opcao}"/></label>
                        </p>
                    </li>
                </c:forEach>            
            </ul>
            <a class="btn-modal" href="#" onclick="votar();">Responder</a> 
            <a class="btn-modal" href="javascript:void(0);" onClick="fecharEnquete()">Sair</a> 
        </form>
    </div>
</div>
<%}%>