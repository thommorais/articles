<%
            String base = request.getParameter("base");
            Integer idForm = ((br.com.maven.flip.javasql.FlipEdicaoTbl) request.getAttribute("page")).getId();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<!-- carregando -->
<div id="loading" style="display:none">Carregando... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="Carregando, aguarde ..."/></div>


<div id="topnav">
    <div id="tabs">
        <jsp:include page="icones.jsp" flush="true">
            <jsp:param name="base" value="<%= base %>"/>
            <jsp:param name="width" value="25"/>
        </jsp:include>
    </div>
    <div id="nav">
        <div id="navcenter">
            <div id="capa">
                <a href="javascript:MegaZine.firstPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_capa.gif" alt="Ir para a capa" title="Ir para a capa"/></a> Capa
            </div>
            <div id="paginas">

                <!-- paginas antes -->
                <div style="float:left; display:inline;">
                    <a href="javascript:MegaZine.firstPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_first.gif" alt="Primeira página" title="Primeira página"/></a>
                    <a href="javascript:MegaZine.prevPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_back.gif" alt="Página anterior" title="Página anterior "style="margin-left:3px"/></a>
                </div>
                <!-- contador -->
                <div style="float:left; display:inline; width:155px;" id="page_layer">

                </div>
                <!-- paginas depois -->
                <div style="float:right;display:inline;">
                    <a href="javascript:MegaZine.nextPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_next.gif" alt="Próxima página" title="Próxima página"/></a>
                    <a href="javascript:MegaZine.lastPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_last.gif" alt="Ir para última página" title="Ir para a última página" style="margin-left:3px"/></a>
                </div>
            </div>
            <div id="saltar">
                Ir para
                <input name="page" id="page" type="text" class="saltar" maxlength="3" onkeypress="if(verificaEnter(event)){ MegaZine.gotoPage($('page').value); }"/>
                <a href="javascript:MegaZine.gotoPage($('page').value);"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_saltar.gif" alt="Ir para" title="Ir para"/></a>
            </div>
        </div>
    </div>
    <div id="tabs2">


    </div>
</div>

<div id="corpo">
    <table width="100%">
        <tr>
            <td id="menu" width="180px" valign="top">
                <jsp:include page="jsp/indice.jsp" flush="true">
                    <jsp:param name="base" value="<%= base %>"/>
                    <jsp:param name="idForm" value="<%= idForm %>"/>
                </jsp:include>

            </td>
            <td width="1100px" valign="top">
                <div id="jornal" >
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
            </td>
        </tr>
    </table>
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
