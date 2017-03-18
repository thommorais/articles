<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<c:choose>
    <c:when test="${param.search ne 'true'}">
        <div id="box650_440">
            <form method="POST" action="#" name="faleConoscoForm" id="faleConoscoForm" accept-charset="ISO-8859-1">
                <div style="padding:5px;" class="TextoPreto">
                    <input type="hidden" name="edicao" id="edicao"/>
                    <input type="hidden" name="search"  value="true"/>
                    <input type="hidden" name="linkedicao"  value="<%= request.getParameter("linkedicao")%>"/>
                    <input type="checkbox" name="apenasEssa" value="true" checked title="<fmt:message key="site.apenasessa"/>"/> <fmt:message key="site.apenasessa1"/>
                    <br/>
                    <br/>
                    <span>
                        <fmt:message key="site.pesquisarpor"/>: <br>
                        <input type="text" name="keywords" id="keywords" value="" size="40" class="CampoTexto" alt="<fmt:message key="site.informetermos"/>" title="<fmt:message key="site.informetermos"/>" onkeypress="if(event.keyCode == 13) { pesquisa(); return false; }" />
                        &nbsp;
                        <input type="button" value="<fmt:message key="site.pesquisar"/>" class="BotaoBranco" onclick="pesquisa();"/>
                        <input type="button" value="<fmt:message key="site.fechar"/>" class="BotaoBranco" onclick="fechaJanela();"/>
                    </span>
                </div>
            </form>
            <br>
            <div id="result" style="display: none;overflow:auto" class="TextoPreto"></div>

        </div>

    </c:when>
    <c:otherwise>
        <%        
        String edicao = request.getParameter("edicao");
        String link = request.getParameter("linkedicao");
        String apenasEssa = request.getParameter("apenasEssa");
        String keyword = new String(request.getParameter("keywords").getBytes("ISO-8859-1"), "UTF-8");
        
        java.util.List<br.com.maven.flip.javasql.view.PesquisaResultBean> list = br.com.maven.flip.javasql.dao.FlipPesquisaDAO.pesquisa(keyword, Integer.parseInt(edicao), "true".equals(apenasEssa), request, null, null);
        if (list.size() == 0) {
        %>
        <fmt:message key="site.nenhumregistro"/> '<%= keyword %>'.
        <% } else {
            request.setAttribute("list", list);
        %>

        <div id="pesquisa_div" >
            <c:forEach var="item" items="${list}">
                <div id="item_pesquisa" onclick="abrePesquisa(<c:out value="${item.pagina}"/>)" title="<fmt:message key="site.cliquevisualizar"/>">

                    <div id="item_pesquisa_conteudo">
                        <div id="item_pesquisa_header">
                            <strong> <fmt:message key="site.edicaonumero"/> <c:out value="${item.edicaoNr}"/> </strong>
                            <br/>
                            <c:out value="${item.edicaoData}"/> - <c:out value="${item.caderno}"/>
                        </div>
                        <div id="item_pesquisa_texto">
                            <div id="item_pesquisa_foto">
                                <img src="<%= base %><c:out value='${item.imagem}'/>" border="1" alt="<fmt:message key="site.cliquevisualizar"/>" width="60px" height="70px"/>
                            </div>
                            <c:out value="${item.texto}" escapeXml="false"/>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <% }%>
    </c:otherwise>
</c:choose>