<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = request.getParameter("base");
            String width = request.getParameter("width");
%>

<div id="zoom_layer" style="display:none">
    <a href="#" onclick="MegaZine.zoomIn();return false;">
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeZoomInSite}'/>" alt="Ampliar" title="Ampliar zoom" width="<%= width %>" height="65" />
    </a><br />
    <a href="#" onclick="MegaZine.zoomOut(); return false;">
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeZoomOutSite}'/>" alt="Reduzir" title="Reduzir zoom" width="<%= width %>" height="65" />
    </a><br />
</div>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
    <a href="javascript:openSearchMode();">
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconePesquisarSite}'/>" alt="Pesquisar conteúdo" title="Pesquisar conteúdo" width="<%= width %>" height="65" />
    </a><br/>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.impressao}">
    <a href="javascript:openPrintMode();">
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeImprimirSite}'/>" alt="Imprimir a página" title="Imprimir a página" width="<%= width %>" height="65" />
    </a><br/>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
    <a href="javascript:openPDFMode('<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.exportarTodos}'/>');">
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeExportarPdfSite}'/>" alt="Exportar página em PDF" title="Exportar página em pdf" width="<%= width %>" height="65" />
    </a><br/>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
    <a href="javascript:openTextMode();">
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeTextoSite}'/>" alt="Exibir páginas em modo texto" title="Exibir páginas em modo texto" width="<%= width %>" height="65" />
    </a><br/>
</c:if>
<a href="javascript:openRecomendMode();">
    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeRecomendarSite}'/>" alt="Recomendar página para amigo" title="Recomendar página para amigo" width="<%= width %>" height="65" />
</a>