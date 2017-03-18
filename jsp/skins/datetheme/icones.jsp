<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = request.getParameter("base");
            String width = request.getParameter("width");
%>

<table>
    <tr>
        <td id="zoom_layer" style="display:none">
            <a href="#" onclick="MegaZine.zoomIn();return false;">
                <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeZoomInSite}'/>" alt="Ampliar" title="Ampliar zoom" width="<%= width%>"/>
            </a>
            <a href="#" onclick="MegaZine.zoomOut(); return false;">
                <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeZoomOutSite}'/>" alt="Reduzir" title="Reduzir zoom" width="<%= width%>" />
            </a>
        </td>
        <td id="buttons_layer">
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.impressao}">
                <a href="javascript:openPrintMode();">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeImprimirSite}'/>" alt="Imprimir a p�gina" title="Imprimir a p�gina" width="<%= width%>" />
                </a>
            </c:if>

            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
                <a href="javascript:openSearchMode();">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconePesquisarSite}'/>" alt="Pesquisar conte�do" title="Pesquisar conte�do" width="<%= width%>" />
                </a>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
                <a href="javascript:openPDFMode('<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.exportarTodos}'/>');">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeExportarPdfSite}'/>" alt="Exportar p�gina em PDF" title="Exportar p�gina em pdf" width="<%= width%>" />
                </a>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                <a href="javascript:openTextMode();">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeTextoSite}'/>" alt="Exibir p�ginas em modo texto" title="Exibir p�ginas em modo texto" width="<%= width%>" />
                </a>
            </c:if>
            <a href="javascript:openRecomendMode();">
                <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeRecomendarSite}'/>" alt="Recomendar p�gina para amigo" title="Recomendar p�gina para amigo" width="<%= width%>" />
            </a>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
                <a href="javascript:openCommentMode();"   title="Clique aqui para criar um coment�rio nessa p�gina" >
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeComentar}'/>"  alt="Clique aqui para criar um coment�rio nessa p�gina" width="<%= width%>"/>
                </a>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.faleConosco}">
                <a href="javascript:openContactMode();"   title="Clique aqui e entre em contato" >
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeContato}'/>"  alt="Clique aqui e entre em contato" width="<%= width%>"/>
                </a>
            </c:if>
        </td>
    </tr>
</table>