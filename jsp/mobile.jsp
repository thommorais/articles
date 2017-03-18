<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - Mavenflip Mobile</title>
        <link href="<%= base%>flip/jornal/css/mobilesmart.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%= base%>flip/jornal/js/mobile.js?1=1" charset="utf-8"></script>
        <script type="text/javascript">
            pagenr = <c:out value="${pagenr}"/>
        </script>
        <style type="text/css">
            body{
                margin: 1 auto;
                padding: 0 auto;
                background: #<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.background}"/> <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.backgroundImageCss && 'NULO' ne page.flipModeloPublicacaoidid_modelo.prefs.backgroundImageCss}">url(<%= base%><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.backgroundImageCss}"/>) repeat fixed</c:if>;
                font-family:<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.fonte}"/>;
                color: #<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.dataColorCorpo}"/>;
            }
        </style>
    </head>
    <body>
        <form name="form1" method="post" action="index.jsp" id="form1">
            <input type="hidden" name="mobile" value="S"/>
            <input type="hidden" name="texto" value="<c:out value='${param.texto}'/>"/>
            <input type="hidden" name="zoom" value="<c:out value='${param.zoom}'/>"/>
            <input type="hidden" name="pages" value="N"/>
            <input type="hidden" name="page" value="<c:out value='${pagenr}'/>"/>            
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                    <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
            </c:if>
            <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="Clique para visitar o site" height="40px" align="center" border="0"/>
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                </a>
            </c:if>
        </c:if>
        <br/>

        <c:forEach var="banner" items="${BANNERS}">
            <c:if test="${banner.tipoBanner eq 'SMART1'}">
                <a href="<c:out value='${banner.linkPublico}'/>" target="_blank">
                    <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" class="horizontal"/>
            </a> 
            <br/>
        </c:if>
    </c:forEach>            

    <map id="imgmap2011420105050" name="imgmap2011420105050">
        <area shape="rect" alt="Página anterior" title="" coords="2,6,130,39" href="javascript:previous();" target="" />
        <area shape="rect" alt="Todas as páginas" title="" coords="152,6,287,38" href="javascript:showSummary();" target="" />
        <area shape="rect" alt="Próxima página" title="" coords="309,7,439,38" href="javascript:next();" target="" />
    </map>
    <img src="<%= base%>flip/jornal/skins/mobile/menu.gif" usemap="#imgmap2011420105050" align="center" border="0"/>
    <br/>
    <div id="corpo"  <c:choose><c:when test="${!empty paginaslist}">style="display:none"</c:when><c:otherwise>style="display:block"</c:otherwise></c:choose>>
        <c:choose>
            <c:when test="${param.zoom eq 'S' || zoom eq 'S'}">
                <a href="javascript:zoomOut();">
                    <img src="<%= base%><c:out value='${pagina.pathImage}'/>" border="1" id="page_img" alt="Carregando página" usemap="#mapa" title="Clque para desfazer o zoom"/>
                </a>
            </c:when>
            <c:otherwise>
                <a href="javascript:zoomIn();">
                    <img src="<%= base%><c:out value='${pagina.pathNormal}'/>" border="1" id="page_img" alt="Carregando página" title="Clique para fazer o zoom"/>
                </a>
            </c:otherwise>
        </c:choose>
        <map name="mapa">
            <c:if test="${pagenr>1}">
                <area shape="rect" coords="0,0,170,1579" href="javascript:previous();" alt="Voltar" title="Voltar"    />
            </c:if>
            <c:if test="${paginas>1 && pagenr<paginas}">
                <area shape="rect" coords="989,0,1183,1579" href="javascript:next();" alt="Avançar" title="Avançar"    />
            </c:if>
        </map>
        <br/>
        <img src="<%= base%>flip/jornal/skins/mobile/menu.gif" usemap="#imgmap2011420105050" align="center" border="0"/>
    </div>
        <c:forEach var="banner" items="${BANNERS}">
            <c:if test="${banner.tipoBanner eq 'SMART2'}">
                <a href="<c:out value='${banner.linkPublico}'/>" target="_blank">
                    <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" class="horizontal"/>
            </a> 
            <br/>
        </c:if>
    </c:forEach>    
    <div id="sumario" <c:choose><c:when test="${!empty paginaslist}">style="display:block"</c:when><c:otherwise>style="display:none"</c:otherwise></c:choose>>
        <c:forEach var="pag" items="${paginaslist}" varStatus="i">
            <div id="sumario_item">
                <a href="javascript:trocaPagina(<c:out value='${i.index+1}'/>);">
                    <img src="<%= base%><c:out value='${pag.pathThumb}'/>" border="1" width="180px"/>
                </a>
            </div>
        </c:forEach>
    </div>
                
                
</form>
</body>
</html>