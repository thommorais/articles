<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String keyw = request.getParameter("keywords");
    String acervo = request.getParameter("acervo");

    String keyword = keyw != null ? keyw : ""; //new String(keyw.getBytes("ISO-8859-1"), "UTF-8"):"";
    if (keyword != null) {
        keyword = keyword.replaceAll("'", "");
        request.getSession().setAttribute("KEYWORD_SEARCH", keyword);
    }
%>

<c:choose>
    <c:when test="${param.search ne 'true'}">
        <form method="POST" action="#" name="pesquisaForm" id="pesquisaForm" accept-charset="ISO-8859-1">
            <input type="hidden" name="edicao" id="edicao"/>
            <input type="hidden" name="search"  value="true"/>
            <input type="hidden" name="linkedicao"  value="<%= request.getParameter("linkedicao")%>"/>
            <div class="modal-bg"></div>
            <div class="padding"> <a class="btn-fechar" href="javascript:void(0);" onClick="fecharPesquisa()"><i class="icon-remove"></i></a>
                <p class="titulo"><fmt:message key="site.pesquisar"/></p>
                <div id="scrollbar4" class="tiny-scrollbar-v">
                    <div class="scrollbar">
                        <div class="track">
                            <div class="thumb">
                                <div class="end"></div>
                            </div>
                        </div>
                    </div>
                    <div class="viewport">
                        <div class="overview">
                            <span id="aguarde" style="display:none">

                            </span>                            
                            <div class="busca" id="areabotoes">
                                <p class="pesquisar-por"><fmt:message key="site.pesquisarpor"/></p>
                                <p class="input-text">

                                    <input type="text" name="keywords" id="keywords" placeholder="<fmt:message key="site.informetermos"/>" value="<%= keyword%>" size="40" class="CampoTexto"  title="<fmt:message key="site.informetermos"/>" onkeypress="if(event.keyCode == 13) { pesquisa(); return false; }" />                                    
                                           <a class="btn-modal" href="javascript:pesquisa();"><fmt:message key='site.pesquisar'/></a> </p>
                                <p class="custom">

                                <c:choose>
                                    <c:when test="${!empty param.acervo && param.acervo eq 'false'}">
                                        <input type="hidden" name="apenasEssa" value="true"/>
                                        <span><fmt:message key='site.pesquisa.warning'/></span>
                                    </c:when>
                                    <c:otherwise>
                                        <input class="check" type="checkbox" name="apenasEssa" id="apenasEssa" value="true" checked title="<fmt:message key='site.apenasessa'/>"/>
                                        <label for="apenasEssa"><fmt:message key="site.apenasessa1"/></label>                        
                                    </c:otherwise>
                                </c:choose>                                                                        
                                </p>
                                <p class="dica"><fmt:message key="site.pesquisa.label"/>.</p>
                            </div>
                            <div class="clear"></div>
                            <div class="edicoes" id="result"> 

                            </div>
                        </div>
                    </div>
                </div>
            </div>                
        </form>                

        <script type="text/javascript">
            loadDataPesquisaResult();
        </script>                        
    </c:when>
    <c:otherwise>
        <%
            String edicao = request.getParameter("edicao");
            String link = request.getParameter("linkedicao");
            String apenasEssa = request.getParameter("apenasEssa");
            if (apenasEssa == null) {
                apenasEssa = "false";
            }
            java.util.List<br.com.maven.flip.javasql.view.PesquisaResultBean> list = br.com.maven.flip.javasql.dao.FlipPesquisaDAO.pesquisa(keyword, Integer.parseInt(edicao), "true".equals(apenasEssa), request, null, null);
            if (list.size() == 0) {
        %>
        <fmt:message key="site.nenhumregistro"/> '<%= keyword%>'.
        <% } else {
            request.setAttribute("list", list);
        %>
        <c:forEach var="item" items="${list}">
            <a class="btn edicao" href="javascript:void(0);" onclick="abrePesquisa('<%= link%>','index.jsp?edicao=<c:out value="${item.edicaoId}"/>&ipg=<c:out value="${item.pagina}"/>&keyword=<c:out value="${param.keywords}"/>',<c:out value="${item.pagina}"/>,<%= apenasEssa%>,'<%= keyword%>')" title="<fmt:message key="site.cliquevisualizar"/>"> 
                <span class="esquerda">
                    <img src="<%= base%><c:out value='${item.imagem}'/>" border="1" title="<fmt:message key="site.cliquevisualizar"/>" width="68px" height="93px"/>                                        
                </span>
                <span class="direita">
                    <span class="numero"><fmt:message key="site.edicaonumero"/> <c:out value="${item.edicaoNr}"/></span> 
                    <span class="data"><c:out value="${item.edicaoData}"/> - <c:out value="${item.caderno}"/></span> 
                    <span class="texto"><c:out value="${item.texto}" escapeXml="false"/></span> 
                </span> 
            </a>
            <div class="clear"></div>                                
        </c:forEach>
        <% }%>
    </c:otherwise>
</c:choose>    