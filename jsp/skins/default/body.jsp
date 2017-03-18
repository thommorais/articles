<%String base = request.getParameter("base");
            String edicao = request.getParameter("edicao");
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<!-- carregando -->
<div id="loading" style="display:none">Carregando... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="Carregando, aguarde ..."/></div>

<div id="top">
    <div id="logocliente">
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
    <c:choose>
        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Topo'}">
            <div id="data_buttons">
                <jsp:include page="icones.jsp" flush="true">
                    <jsp:param name="base" value="<%= base %>"/>
                    <jsp:param name="width" value="35"/>
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <div id="data">
                <c:out value="${dataEdicao}"/>
            </div>
        </c:otherwise>
    </c:choose>

    <div id="logomaven">

        <a href="javascript:openEditionMode();" class="btn btn-primary">
            <c:choose>
                <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeOutrasEdicoes}">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeOutrasEdicoes}'/>" alt="Visualizar outras edições" title="Visualizar outras edições" />
                </c:when>
                <c:otherwise>
                    <img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_outrasedicoes.png" alt="Visualizar outras edições" title="Visualizar outras edições" />
                </c:otherwise>
            </c:choose>
        </a>
        <a href="javascript:window.location.href='/<c:out value="${edicao_dia}"/>'" class="btn btn-primary">
            <c:choose>
                <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeEdicaoAtual}">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeEdicaoAtual}'/>" alt="Visualizar edição atual" title="Visualizar edição atual" />
                </c:when>
                <c:otherwise>
                    <img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_edicao<c:out value="${page.flipModeloPublicacaoidid_modelo.periodicidade}"/>.png" alt="Abrir edição atual" title="Abrir edição atual" />
                </c:otherwise>
            </c:choose>
        </a>

        &nbsp;&nbsp;
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.logomaven}">

            <a href="http://www.mavenflip.com.br">
                <img src="<%= base%>flip/jornal/images/maven_flip.png" alt="Clique aqui e conheça o sistema" title="Clique aqui e conheça o sistema" height="35px" />
            </a>
        </c:if>

    </div>
</div>
<div id="topnav">
    <div id="tabs">
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">
        <c:choose>            
            <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeIndice}">
                <a href="javascript:openChapterMode();"   title="Visualizar o índice da edição" >
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeIndice}'/>"  alt="Visualizar o índice da edição" />
                </a>
            </c:when>
            <c:otherwise>
                <a href="javascript:openChapterMode();" class="tab2" title="Visualizar cadernos da edição" >
                    <br/><span><img src="<%= base%>flip/jornal/images/icon_index.gif"  alt="Visualizar cadernos da edição"/>&nbsp;<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.indiceNome}"/></span>
                </a>
            </c:otherwise>
        </c:choose>
        </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">
        <c:choose>
            <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeSumario}">
                <a href="javascript:openSumaryMode();"   title="Sumário de páginas dessa edição" >
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeSumario}'/>"  alt="Sumário de páginas dessa edição" />
                </a>
            </c:when>
            <c:otherwise>
                <a href="javascript:openSumaryMode();" class="tab2"  title="Sumário de páginas dessa edição">
                    <br/><span><img src="<%= base%>flip/jornal/images/gallery_icon.gif" alt="Sumário de páginas dessa edição"/>&nbsp;SUMÁRIO</span>
                </a>
            </c:otherwise>
        </c:choose>
                </c:if>
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
                <div style="float:left; display:inline; width:155px;font-size:10px" id="page_layer">

                </div>
                <!-- paginas depois -->
                <div style="float:right;display:inline;">
                    <a href="javascript:MegaZine.nextPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_next.gif" alt="Próxima página" title="Próxima página"/></a>
                    <a href="javascript:MegaZine.lastPage();"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_last.gif" alt="Ir para última página" title="Ir para a última página" style="margin-left:3px"/></a>
                </div>
            </div>
            <div id="saltar">
                Ir para
                <input name="page" id="page" type="text" class="saltar" maxlength="5" onkeypress="if(verificaEnter(event)){ MegaZine.gotoPage($('page').value); }"/>
                <a href="javascript:MegaZine.gotoPage($('page').value);"><img src="<%= base%>flip/jornal/images/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/b_saltar.gif" alt="Ir para" title="Ir para"/></a>
            </div>
        </div>
    </div>
    <div id="tabs2">

        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
            <c:choose>
                <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeComentar}">
                    <a href="javascript:openCommentMode();"   title="Clique aqui para criar um comentário nessa página" >
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeComentar}'/>"  alt="Clique aqui para criar um comentário nessa página" />
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:openCommentMode();" class="tab2"  title="Clique aqui para criar um comentário nessa página" >
                        <br/>
                        <span>
                            <img src="<%= base%>flip/jornal/images/commentBalloon.gif" alt="Clique aqui para criar um comentário nessa página"/>
                            &nbsp;COMENTE
                        </span>
                    </a>
                </c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.faleConosco}">
            <c:choose>
                <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeContato}">
                    <a href="javascript:openContactMode();"  title="Clique aqui e entre em contato" >
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeContato}'/>"  alt="Clique aqui para criar um comentário nessa página" />
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:openContactMode();" class="tab2"  title="Clique aqui e entre em contato" >
                        <br/>
                        <span>
                            <img src="<%= base%>flip/jornal/images/icone_email.gif" alt="Clique aqui e entre em contato"/>
                            &nbsp;CONTATO
                        </span>
                    </a>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
</div>                          
<div id="corpo">
        <div id="searchinstant" >
    Pesquisa instantânea habilitada! Para procurar por várias palavras separe-as com vírgula.         
    <input type="text" name="keywordbody" id="keywordbody" class="CampoTexto"/>
    <input type="button" value="Pesquisar" class="BotaoBranco" onclick="atualizaPesquisa();"/>
    <input type="button" value="Cancelar" class="BotaoBranco" onclick="cancelaPesquisa();"/>
    </div>  
    
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Esquerda'}">
        <div id="menu">
            <jsp:include page="icones_left.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
                <jsp:param name="edicao" value="<%= edicao %>"/>
                <jsp:param name="width" value="57"/>
            </jsp:include>

            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas && empty page.flipModeloPublicacaoidid_modelo.prefs.rodape}">
                <div id="contador">
                    <b>Visitas</b>
                    <br/>
                    <c:out value="${page.visitas}"/>
                </div>
            </c:if>
        </div>
    </c:if>

    <div id="jornal"
         <c:choose>
             <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Base'}">
                 style="width:100%"
             </c:when>
             <c:otherwise>
                 style="width:<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageWidth * 2}'/>"
             </c:otherwise>
         </c:choose>
         >
        <div id="megazine">
            <c:out value="${page.textoPagina}"/>
            <h2><b>Você precisa do FlashPlayer 10 para visualizar</b></h2>
            <br/>
            <p>
                Clique na imagem abaixo para fazer o download.
            </p>
            <p>
                <a href="<%= base%>install_flash_player.exe">
                    <img src="<%= base%>flip/jornal/images/get_flash_player.gif" alt="Clique aqui para baixar o plugin Flash" title="Clique aqui para baixar o plugin Flash" />
                </a>
            </p>
            <c:if test="${empty logado || logado eq 'false'}">
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
    try{ 
        swfobject.embedSWF("<%= base%>flip/jornal/megazine<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}">2</c:if>/megazine.swf",
        "megazine",
        "100%",
        "100%",
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

<c:if test="${!empty MESSAGE}">
    <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>'); </script>
    <%session.removeAttribute("MESSAGE");%>
</c:if>
<c:if test="${!empty logado && logado eq 'true' && !empty username}">
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