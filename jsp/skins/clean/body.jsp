<%
            String base = request.getParameter("base");
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<div id="corpo">
    <div id="jornal" style="width:100%;padding-top:2px">
        <div id="megazine">
            <c:out value="${page.textoPagina}"/>
            <h2><b>Você precisa do FlashPlayer 10 para visualizar</b></h2>
            <br/>
            <p>
                Clique na imagem abaixo para fazer o download.
            </p>
            <p>
		<a href="https://get.adobe.com/flashplayer/">
                    <img src="<%= base%>flip/jornal/images/get_flash_player.gif" alt="Clique aqui para baixar o plugin Flash" title="Clique aqui para baixar o plugin Flash" />
                </a>
            </p>
            <c:if test="${empty logado}">
                <p> Navegue pelas páginas dessa edição </p>
                <c:forEach var="pagina" items="${page.textoPaginaNumeros}">
                    <a href="<%= base%><c:out value="${edicao_dia}"/>index.jsp?ipg=<c:out value='${pagina}'/>">
                        Página <c:out value="${pagina}"/>
                    </a>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>
<script type="text/javascript">
    try{ swfobject.embedSWF("<%= base%>flip/jornal/player/mavenflip.swf",
        "megazine",
        "100%",
        "<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageHeight}'/>",
        "9.0.115",
        "<%= base%>flip/jornal/swfobject/expressInstall.swf",
        {
<c:choose>
            <c:when test="${!empty HASH_MZ_KEY_REQ}" >
                            xmlFile : "<%= base%>flip/jornal/megazinedata.jsp?ed=<c:out value='${HASH_MZ_KEY_REQ}'/>",
        </c:when>
            <c:otherwise>
                        xmlFile : "<%= base%>flip/jornal/megazinexml.jsp",
        </c:otherwise>
    </c:choose>
            top: "0"
        },
        {
            wmode : "transparent",
            allowFullscreen : "true"
        },
        {id : "megazineScript"});
    }catch(e){}
</script>
<jsp:include page="../common/earBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base %>"/>
</jsp:include>
<jsp:include page="../common/windowBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base %>"/>
</jsp:include>
<jsp:include page="../common/sideBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base %>"/>
</jsp:include>
<c:if test="${!empty MESSAGE}">
    <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>'); </script>
    <%session.removeAttribute("MESSAGE");%>
</c:if>
<c:if test="${!empty logado}">
    <div id="logout_button">
        <a href="<%= base%><c:out value="${edicao_dia}"/>login.jsp">
            <img src="<%= base%>flip/jornal/images/sair.png" alt="Logout de assinante" title="Logout de assinante"/>
        </a>
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

<div id="menu_side">        
    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
            <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
            </c:if>
            <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="Clique para visitar o site" height="40px"/>
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
            </a>
        </c:if>
    </c:if>
    <br/>
    <a href="#">
        <img src="<%= base%>flip/jornal/skins/clean/img/menu.png" alt="Expandir menu" id="expand_img"/>
    </a>
    <div id="itens_menu" style="display:none;" >
    <jsp:include page="icones_left.jsp" flush="true">
        <jsp:param name="base" value="<%= base %>"/>
        <jsp:param name="width" value="57"/>
    </jsp:include>
    </div>
</div>

