<%
            String base = request.getParameter("base");
            Integer idForm = ((br.com.maven.flip.javasql.FlipEdicaoTbl) request.getAttribute("page")).getId();
            String linkedicao = request.getAttribute("edicao_dia").toString();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<!-- carregando -->
<div id="loading" style="display:none">Carregando... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="Carregando, aguarde ..."/></div>

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" >  
    <tr>
        <td width="170" height="100%" valign="top" class="full left">
        
            <div id="dateContainer">
                <div id="datepicker"></div>
            </div>
            <c:choose>
                <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Esquerda'}">
                    <h1> Ferramentas</h1>
                    <div id="info">
                        <jsp:include page="icones_left.jsp" flush="true">
                            <jsp:param name="base" value="<%= base %>"/>
                            <jsp:param name="width" value="50"/>
                        </jsp:include>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas && empty page.flipModeloPublicacaoidid_modelo.prefs.rodape}">
                            <div id="contador">
                                <b>Visitas</b>
                                <c:out value="${page.visitas}"/>
                            </div>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas && empty page.flipModeloPublicacaoidid_modelo.prefs.rodape}">
                        <div id="contador">
                            <h1><c:out value="${page.visitas}"/> pessoas já leram.</h1>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <div id="sliderContainer">
                <h1> Últimas edições</h1>
                <div class="separator"></div>
                <div id="slider">
                    <ul>
                        <jsp:include page="jsp/edicoes.jsp" flush="true">
                            <jsp:param name="base" value="<%= base %>"/>
                            <jsp:param name="idForm" value="<%= idForm %>"/>
                            <jsp:param name="linkedicao" value="<%= linkedicao%>"/>
                        </jsp:include>
                    </ul>
                </div>
                <div class="separatorbottom"></div>
                <br class="clear" />
            </div>
        </td>
        <td width="90%" height="100%" valign="top" class="right">
            <table width="100%" align="center" >
                <tr style="height:42px">
                    <td align="center" width="100%">
                        <c:choose>
                            <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Topo'}">
                                <jsp:include page="icones.jsp" flush="true">
                                    <jsp:param name="base" value="<%= base %>"/>
                                    <jsp:param name="width" value="35"/>
                                </jsp:include>
                            </c:when>
                            <c:otherwise>
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
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr id="jornal">
                    <td class="full"  >
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
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

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
            xmlFile : "<%= base%><c:out value='${HASH_MZ_KEY_REQ}'/>?c=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}'/>",
            </c:otherwise>
            </c:choose>                    
        </c:when>
        <c:otherwise>
                    xmlFile : "<%= base%>flip/jornal/megazinexml.jsp?c=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}'/>",
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
<jsp:include page="../common/earBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base %>"/>
</jsp:include>
<jsp:include page="../common/windowBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base %>"/>
</jsp:include>
<jsp:include page="../common/sideBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base %>"/>
</jsp:include>

<form action="#" method="post" name="frm" id="frm">
    <div>
        <input type="hidden" name="idForm" id="idForm" value="-1"/>
        <input type="hidden" name="idEdicao" id="idEdicao" value="-1"/>
        <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>"/>
        <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value="${edicao_dia}"/>"/>
    </div>
</form>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.logomaven}">
    <div id="credit">
        <a href="http://www.mavenflip.com.br">
            <img src="<%= base%>flip/jornal/images/maven_flip.png" alt="Clique aqui e conheça o sistema" title="Clique aqui e conheça o sistema" height="41px" />
        </a>

    </div>
</c:if>
<div id="logotipo">
    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
            <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
            </c:if>
            <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="Clique para visitar o site" height="40px"/>
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
            </a>
        </c:if>
    </c:if>
</div>
