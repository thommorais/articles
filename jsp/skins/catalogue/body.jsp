<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = request.getParameter("base");
            String edicaoId = "" + request.getAttribute("edicaoId");
%>
<div id="loading" style="display:none"><fmt:message key="site.loading"/>... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="<fmt:message key="site.loading"/>"/></div>


<div id="tudo">
    <div class="header" style="display:none">
        <div class="titulo">
            <!-- <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> -->
        </div>
        <div class="fechar">
            <a href="" class="botaofechar">FECHAR <img src="<%= base%>flip/jornal/skins/catalogue/img/fechar.gif"/></a>
        </div>
    </div>
    <div class="corpo">
        <div class="left">
            <img src="<%= base%>flip/jornal/skins/catalogue/img/left.gif" class="multimidia_prev" alt="<fmt:message key="site.anterior"/>"/>
        </div>
        <div class="center">
            <div id="flip">
                <div id="jornal">
                    <div id="megazine" style="height:<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageHeight}'/>px">
                <c:out value="${page.textoPagina}"/>
                <h2><b><fmt:message key="site.flash"/></b></h2>
                <br/>
                <p>
                <fmt:message key="site.download"/>.
                </p>
                <p>
		    <a href="https://get.adobe.com/flashplayer/">
                        -  Clique aqui para baixar o plugin Flash - Mavenflip
                    </a>
                </p>
                <c:if test="${empty logado or logado eq 'false' or empty username}">
                    <p> Navegue pelas páginas dessa edição </p>
                    <c:forEach var="pagina" items="${page.textoPaginaNumeros}">
                        <a href="<%= base%><c:out value="${edicao_dia}"/>index.jsp?ipg=<c:out value='${pagina}'/>">
                            Página <c:out value="${pagina}"/>
                        </a>
                    </c:forEach>
                    <p>
                        powered by <a href="http://www.mavenflip.com.br" target="_blank" title="Mavenflip, publicações digitais">MavenFlip</a>, publique seus jornais e revistas online.
                    </p>
                </c:if>
            </div>
                </div>
            </div>			
        </div>
        <div class="right">
            <img src="<%= base%>flip/jornal/skins/catalogue/img/right.gif" class="multimidia_next" alt="<fmt:message key="site.proxima"/>"/>
        </div>
    </div>
    <div class="footer">
        <div class="page">
            <span class="multimidia_textfield" id="multimidia_textfield">
                &nbsp;
            </span>
        </div>
        <div class="ftools">
            <a href="#" class="multimidia_fr_label">Primeira página</a>
            <span></span>
            <img src="<%= base%>flip/jornal/skins/catalogue/img/first.gif" class="multimidia_fr" alt="<fmt:message key="site.primeira"/>"/>
            <span></span>
            <img src="<%= base%>flip/jornal/skins/catalogue/img/last.gif" class="multimidia_ff" alt="<fmt:message key="site.ultima"/>"/>
            <span></span>
            <a href="#" class="multimidia_ff_label">Última página</a>
        </div>
        <div class="imprimir">
            <a href="#"><fmt:message key="site.imprimir"/><span></span><img src="<%= base%>flip/jornal/skins/catalogue/img/print.gif"/></a>
        </div>	
    </div>
</div>


<script type="text/javascript">
    try{ 
        swfobject.embedSWF("<%= base%>flip/jornal/megazine<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}">2</c:if>/megazine.swf",
        "megazine",
        "100%",
        "<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageHeight}'/>",
        "9.0.115",
        "<%= base%>flip/jornal/swfobject/expressInstall.swf",
        {   <c:choose>
        <c:when test="${!empty HASH_MZ_KEY_REQ}">
            <c:choose>
            <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}">
            xmlFile : "<%= base%>flip/jornal/megazinedata.jsp?ed=<c:out value='${HASH_MZ_KEY_REQ}'/>&c=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}'/>",
            </c:when>
            <c:otherwise>
            xmlFile : "<%= base%><c:out value='${HASH_MZ_KEY_REQ}'/>",
            </c:otherwise>
            </c:choose>                    
        </c:when>
        <c:otherwise>
                    xmlFile : "<%= base%>flip/jornal/megazinexml.jsp",
        </c:otherwise>
    </c:choose>
                top: "0"
            },
            {
                wmode : "transparent",
                allowFullscreen : "true",
                bgcolor: "#333333"
            },
            {id : "megazineScript"});
        }catch(e){}


</script>

<c:if test="${!empty MESSAGE}">
    <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>'); </script>
    <%session.removeAttribute("MESSAGE");%>
</c:if>
<c:if test="${!empty logado && logado eq 'true' && !empty username}">
    <div id="logout_button">
        <c:choose>
            <c:when test="${!empty sessionScope['backlink']}">
                <a href="<%= base%><c:out value='${backlink}'/>">
                    <img src="<%= base%>flip/jornal/images/sair.png" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                </a>
            </c:when>
            <c:otherwise>
                <a href="<%= base%><c:out value="${edicao_dia}"/>login.jsp">
                   <img src="<%= base%>flip/jornal/images/sair.png" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</c:if>

<form action="#" method="post" name="frm" id="frm">
    <div>
        <input type="hidden" name="idForm" id="idForm" value="-1"/>
        <input type="hidden" name="idEdicao" id="idEdicao" value="-1"/>
        <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>"/>
               <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value="${edicao_dia}"/>"/>
    </div>
</form>
