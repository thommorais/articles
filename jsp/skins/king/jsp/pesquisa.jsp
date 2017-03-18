<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String keyw=request.getParameter("keywords");
            String acervo=request.getParameter("acervo");
            
            String keyword = keyw!= null ? keyw: ""; //new String(keyw.getBytes("ISO-8859-1"), "UTF-8"):"";
            if(keyword != null){
                keyword=keyword.replaceAll("'","");  
                request.getSession().setAttribute("KEYWORD_SEARCH",keyword);
            }
%>
<c:choose>
    <c:when test="${param.search ne 'true'}">
        
        <div class='modalboxheader'><fmt:message key="site.pesquisar"/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>                    
        
        <div id="box650_440">
            <form method="POST" action="#" name="faleConoscoForm" id="faleConoscoForm" accept-charset="ISO-8859-1">
                <div style="padding:5px;" class="TextoPreto">
                    <input type="hidden" name="edicao" id="edicao"/>
                    <input type="hidden" name="search"  value="true"/>
                    <input type="hidden" name="linkedicao"  value="<%= request.getParameter("linkedicao")%>"/>
                    <c:choose>
                        <c:when test="${!empty param.acervo && param.acervo eq 'false'}">
                            <input type="hidden" name="apenasEssa" value="true"/>
                            <h3 class='TextoRequired'><fmt:message key='site.pesquisa.warning'/></h3>
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" name="apenasEssa" id="apenasEssa" value="true" checked title="<fmt:message key='site.apenasessa'/>"/> <fmt:message key="site.apenasessa1"/>
                        </c:otherwise>
                    </c:choose>
                    <br/>
                    <br/>
                    <span id="areabotoes">
                        <fmt:message key="site.pesquisarpor"/>: <br>
                        <input type="text" name="keywords" id="keywords" value="<%= keyword %>" size="40" class="CampoTexto" title="<fmt:message key="site.informetermos"/>" onkeypress="if(event.keyCode == 13) { pesquisa(); return false; }" />
                        &nbsp;
                        <input type="button" value="<fmt:message key='site.pesquisar'/>" class="BotaoBranco" onclick="pesquisa();"/>                        
                               <br/><br/>
                        <div class='TextoRequired'>       
                            <fmt:message key="site.pesquisa.label"/>.
                        </div>
                    </span>
                    <span id="aguarde" style="display:none">

                    </span>

                </div>
            </form>
            <br>
            <div id="result" style="display: none;overflow:auto" class="TextoPreto"></div>
        </div>
        <script type="text/javascript">
            loadDataPesquisaResult();
        </script>                        
    </c:when>
    <c:otherwise>
        <%        
        String edicao = request.getParameter("edicao");
        String link = request.getParameter("linkedicao");
        String apenasEssa = request.getParameter("apenasEssa");        
        if(apenasEssa == null){
            apenasEssa="false";
        }
        java.util.List<br.com.maven.flip.javasql.view.PesquisaResultBean> list = br.com.maven.flip.javasql.dao.FlipPesquisaDAO.pesquisa(keyword, Integer.parseInt(edicao), "true".equals(apenasEssa), request, null, null,null);
        if (list.size() == 0) {
        %>
        <fmt:message key="site.nenhumregistro"/> '<%= keyword %>'.
        <% } else {
            request.setAttribute("list", list);
        %>

        <div id="pesquisa_div" >
            <c:forEach var="item" items="${list}">
                <div id="item_pesquisa" onclick="abrePesquisa('<%= link%>','index.jsp?edicao=<c:out value="${item.edicaoId}"/>&ipg=<c:out value="${item.pagina}"/>&keyword=<c:out value="${param.keywords}"/>',<c:out value="${item.pagina}"/>,<%= apenasEssa %>,'<%= keyword %>')" title="<fmt:message key="site.cliquevisualizar"/>">

                    <div id="item_pesquisa_conteudo">
                        <div id="item_pesquisa_header">
                            <strong> <fmt:message key="site.edicaonumero"/> <c:out value="${item.edicaoNr}"/> </strong>
                            <br/>
                            <c:out value="${item.edicaoData}"/> - <c:out value="${item.caderno}"/>
                        </div>
                        <div id="item_pesquisa_texto">
                            <div id="item_pesquisa_foto">
                                <img src="<%= base %><c:out value='${item.imagem}'/>" border="1"  width="60px" height="70px"/>
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