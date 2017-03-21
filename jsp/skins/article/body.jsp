<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = request.getParameter("base");
            String edicaoId = "" + request.getAttribute("edicaoId");
            session.setAttribute("myLink",request.getRequestURL());
%>

<script type="text/javascript">
    var index = 0, iconVideo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.iconVideo}" /> ;
    <c:forEach var = "pag" items = "${paginaslist}" varStatus = "i" >
            <c:choose>
            <c:when test = "${pag.app}" >
            <c:choose>
            <c:when test = "${!empty pag.html5Zip}" >
            addPage(index++, ["<c:out value='${pag.id}'/>", "<c:out value='${pag.html5}'/>", "<c:out value='${pag.html5Zip}'/>", "<c:out value='${pag.html5Zip}'/>", null]);
    </c:when>
            <c:otherwise>
            addPage(index++, ["<c:out value='${pag.cd}'/>", "HTML5", "HTML5", "HTML5", "HTML5"]);
    </c:otherwise>
            </c:choose>
            </c:when>
            <c:otherwise>
            addPage(index++, ["<c:out value='${pag.id}'/>", "<c:out value='${pag.pathImage}'/>", "<c:out value='${pag.pathNormal}'/>", "<c:out value='${pag.pathThumb}'/>", "<c:out value='${pag.pdfPath}'/>"]);
    </c:otherwise>
            </c:choose>
            <c:if test = "${!empty pag.links}" > <c:forEach var = "link" items = "${pag.links}" >
            addPageMedia(index - 1, ['link', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", <c:choose > <c:when test = "${!link.anchor}" > base + "flip/jornal/link.jsp?id=<c:out value="${link.id}"/>" </c:when><c:otherwise>'<c:out value="${link.link}"/>'</c:otherwise></c:choose>,"<c:out value = "${link.percentualX}" />", "<c:out value = "${link.percentualY}" />", "<c:out value = "${link.id}" />", "<c:out value = "${link.pagina.width}" />", "<c:out value = "${link.pagina.height}" />", "<c:out value = '${link.label}' />", "<c:choose><c:when test = '${link.popupWeb}' >V</c:when><c:otherwise><c:out value='${link.tipo}'/></c:otherwise></c:choose>", "<c:if test = '${link.iconeWeb}' > <c:out value = '${link.icone}' /> </c:if>"]);
                    </c:forEach>
                    </c:if>
                    <c:if test = "${!empty pag.videos}" >
                    <c:forEach var = "link" items = "${pag.videos}" > <c:if test = "${!link.flash}" >
                    addPageMedia(index - 1, ['video', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.video.video}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.label}' escapeXml='true'/>", "V", "<c:out value='${link.icone}'/>"]);
            </c:if></c:forEach > </c:if>
                    <c:if test = "${!empty pag.medias}" >
                    <c:forEach var = "link" items = "${pag.medias}" >
                    addPageMedia(index - 1, ['audiopicture', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.media.media}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.label}'/>", "<c:out value='${link.media.tipo}'/>", "<c:out value='${link.icone}'/>"]);
            </c:forEach></c:if>
                    <c:if test = "${!empty pag.galerias}" > <c:forEach var = "link" items = "${pag.galerias}" >
                    <c:if test = "${!empty link.galeria.galeria}" >
                    addPageMedia(index - 1, ['gallery', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value='${link.galeria.cd}'/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.galeria.nome}'/>", "G", "<c:out value='${link.icone}'/>", "<c:out value='${link.galeria.skin}'/>"]);
            <c:forEach var = "pic" items = "${link.galeria.galeria}" >
                    addPageMediaPic(index - 1, "<c:out value="${link.id}"/>", [ '<c:out value = "${link.galeria.cd}" />', '<c:out value = "${pic.media}" />', '<c:out value = "${pic.nome}" />']);
                            </c:forEach>
                            </c:if>
                            </c:forEach></c:if>
                            </c:forEach>
</script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar || page.flipModeloPublicacaoidid_modelo.prefs.modoTexto || page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
    <div id="share" class="modal modal-texto sharecontent">
        <div class="modal-bg"></div>
        <div class="padding"> <a class="btn-fechar" href="javascript:void(0);" onClick="fecharShare()"><i aria-hidden="true" class="fa fa-times"></i></a>
            <p class="titulo"><fmt:message key="site.compartilhar"/></p>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                <div class="share-this"> <span class='st_facebook_large' displayText='Facebook'></span> <span class='st_twitter_large' displayText='Tweet'></span> <span class='st_email_large' displayText='Email'></span> <span class='st_pinterest_large' displayText='Pinterest'></span> <span class='st_linkedin_large' displayText='LinkedIn'></span> <span class='st_googleplus_large' displayText='Google +'></span> </div>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar || page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                <p class="titulo"><fmt:message key="site.exportar"/></p>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
                    <a class="btn-exportar pdf" href="javascript:void(0);" onclick="abrirExportar('<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.exportarTodos}'/>');"><img src="<%= base%>flip/jornal/skins/master/img/exportar-pdf.png" width="32" height="32"> PDF</a>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                    <a class="btn-exportar texto" href="javascript:void(0);" onclick="abrirTexto();" ><img src="<%= base%>flip/jornal/skins/master/img/exportar-texto.png" width="32" height="32"> Texto</a>
                </c:if>
            </c:if>
            <div class="clear"></div>
        </div>
    </div>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete}">
    <jsp:include page="jsp/enquete.jsp" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
        <jsp:param name="edicao" value="<%= edicaoId%>"/>
    </jsp:include>
</c:if>

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
    <div id="todas-edicoes" class="modal modal-texto">
        <div class="modal-bg"></div>
        <div class="padding" id="edicoescontent"></div>
    </div>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">
    <div id="indice" class="modal modal-texto" title="Índice">
        <div class="modal-bg"></div>
        <div class="padding" id="indicecontent"></div>
    </div>
</c:if>

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">
    <div id="paginas" class="modal modal-texto" title="Sumário">
        <div class="modal-bg"></div>
        <div class="padding" id="paginascontent"></div>
    </div>
</c:if>

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
    <div id="exportar" class="modal modal-texto" title="Exportar">
        <div class="modal-bg"></div>
        <div class="padding" id="exportarcontent">

        </div>
        <!-- end .padding-->
    </div>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
    <div id="pesquisa" class="modal modal-texto pesquisacontent" style="display:none;" title="Pesquisa">

    </div>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
    <div id="texto" class="modal modal-texto textocontent" style="display:none;">
    </div>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
    <div id="comentar" class="modal modal-texto comentacontent">

    </div>
</c:if>

<svg style="display: none">

  <symbol id="folder" viewBox="0 0 50 50">
    <path d="M47,8c0,0-27.648,0-29,0  c-1.469,0-2.484-4-4-4H3C1.896,4,1,4.896,1,6v4v30v4c0,1.104,0.896,2,2,2h44c1.104,0,2-0.896,2-2V10C49,8.896,48.104,8,47,8z" fill="none" stroke="#000000" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"/>
    <path d="M1,27V16  c0-1.104,0.896-2,2-2h44c1.104,0,2,0.896,2,2v11" fill="none" stroke="#000000" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"/>
  </symbol>

</svg>

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">
    <header id="header" class="bg-geral">
        <div id="header-line-1">
            <div class="icones-esquerda">
                <ul>

                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
                        <li><a id="btn-todas-edicoes" href="javascript:void(0);" onClick="abrirTodasEdicoes()" title="<fmt:message key='site.outras'/>"><i aria-hidden="true" class="fa fa-book"></i></a></li>
                    </c:if>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">
                        <li><a title="<fmt:message key='site.indice'/>" id="btn-indice" href="javascript:void(0);" onClick="abrirIndice();"><i aria-hidden="true" class="fa fa-list-ul"></i></a></li>
                    </c:if>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">
                        <li><a title="<fmt:message key='site.sumario'/>"  id="btn-paginas" href="javascript:void(0);" onClick="abrirPaginas()"><i aria-hidden="true" class="fa fa-th-large"></i></a></li>
                    </c:if>
                    <c:if test="${!empty page.articles}">
                        <li><a title="Artigos desta edição" id="btn-artigos" href="javascript:void(0);" onClick="abrirArtigos()"><i aria-hidden="true" class="fa fa-newspaper-o"></i></a></li>
                    </c:if>

                    <li><a title="Multimidia" id="mdl-multimidia" href="javascript:void(0);" class="menu-item new-menu"><i class="fa fa-film" aria-hidden="true"></i></a></li>
                    <li><a title="Meus Favoritos" id="mdl-favoritos" href="javascript:void(0);" class="menu-item new-menu" ><i class="fa fa-star" aria-hidden="true"></i></a></li>

                </ul>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete}">
                    <jsp:include page="jsp/enquetePreview.jsp" flush="true">
                        <jsp:param name="base" value="<%= base%>"/>
                        <jsp:param name="edicao" value="<%= edicaoId%>"/>
                    </jsp:include>
                </c:if>
            </div>

            <div class="centro cor-texto">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                        <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="<fmt:message key='site.cliquevisita'/>" target="_blank">
                    </c:if>
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  title="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>" class="logotipo"/>
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                        </a>
                    </c:if>
                </c:if>
            </div>

            <div class="icones-direita">
                <ul>
                    <%-- <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas && page.visitas > 0}">
                        <li class="views cor-disabled" title="<fmt:message key='site.visitas'/>"><a href="javascript:void(0)"><span><c:out value="${page.visitas}"/></span><i class="fa fa-eye" aria-hidden="true"></i></a></li>
                    </c:if> --%>
                    <%-- <li><a id="btn-fullscreen" href="javascript:void(0);" title="Fullscreen" onclick="openFullScreen();"><i class="fa fa-arrows-alt" aria-hidden="true"></i></a></li> --%>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
                        <li><a id="btn-pesquisa" href="javascript:void(0);" title="<fmt:message key='site.procurar'/>" onclick="abrirPesquisa();"><i class="fa fa-search" aria-hidden="true"></i></a></li>
                    </c:if>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                            <li class="comentarios"><a title="<fmt:message key='text.report.comentarios.title'/>" id="btn-comentar" href="javascript:void(0);" onclick="abrirComentar();"><i class="fa fa-comment" aria-hidden="true"></i><span id="comment_count">0</span></a></li>
                        </c:if>
                    </c:if>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar || page.flipModeloPublicacaoidid_modelo.prefs.modoTexto || page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                        <li><a id="btn-exportar" href="javascript:void(0);" onclick="abrirShare();" title="<fmt:message key='site.compartilhar.exportar'/>"><i aria-hidden="true" class="fa fa-share-alt"></i></a></li>
                    </c:if>
                </ul>
            </div>
            <c:if test="${!empty dataEdicao}">
                <div id="header-line-2">
                    <time ><c:out value="${dataEdicao}"/></time>
                </div>
            </c:if>
        </div>
    </header>
</c:if>

<div id="fullscreenid">
    <section id="content">

        <c:choose>
            <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.tema}">
                <div id="background" style="background-color:green">
                    <img src="<%= br.com.maven.flip.Environment.SITE%>flip/jornal/skins/king/img/temas/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.tema}'/>/fundo.jpg" class="stretch" alt="" />
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${!empty KEY_BACKGROUND && !KEY_BACKGROUND.repetirX && !KEY_BACKGROUND.repetirY}">
                    <div id="background"<c:if test="${!empty KEY_BACKGROUND.corFundo}">style="background-color:#<c:out value='${KEY_BACKGROUND.corFundo}'/>"</c:if>>
                        <c:if test="${!empty KEY_BACKGROUND.background}">
                            <img src="<%= br.com.maven.flip.Environment.SITE%><c:out value='${KEY_BACKGROUND.background}'/>" class="stretch" alt="" />
                        </c:if>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>

        <article id="interna">

            <div id="searchinstant" style="display:none">
                Pesquisa instantânea habilitada! Para procurar por várias palavras separe-as com vírgula.
                <input type="text" name="keywordbody" id="keywordbody" class="CampoTexto"/>
                <input type="button" value="Pesquisar" class="BotaoBranco" onclick="atualizaPesquisa();"/>
                <input type="button" value="Cancelar" class="BotaoBranco" onclick="cancelaPesquisa();"/>
            </div>

            <div id="reader" class="magazine-viewport stage">

                <!-- overlay -->
                <div id="readerloading">
                    <i class="fa fa-spinner" aria-hidden="true" aria-hidden="true"></i>
                </div>

                <!-- leitor -->
                <div id="readercontainer" class="magazine">
                    <div class="page page_left">
                        <div class="pageimg">
                        </div>
                    </div>
                    <div class="page page_right">
                        <div class="pageimg">
                        </div>
                    </div>
                    <div class="page page_html5">

                    </div>
                </div>
                <!-- area de zoom -->
                <div id="readerzoom">
                    <div id="reader-flow" class="magazine">

                    </div>
                </div>
                <!-- area de setas -->
                <div id="readerarrows">
                    <div class="arrow-navigate arrow-navigate-left previous-button" title="P?gina anterior">
                        <i class="fa fa-arrow-left" aria-hidden="true" aria-hidden="true"></i>
                    </div>
                    <div class="arrow-navigate arrow-navigate-right next-button" title="Próxima página">
                        <i class="fa fa-arrow-right" aria-hidden="true" aria-hidden="true"></i>
                    </div>
                </div>
            </div>

        <c:if test="${!empty page.articles}">
        <link rel="stylesheet" href="<%= base %>flip/jornal/skins/article/css/article-horizontal.css">
        <script type="text/javascript" src="<%= base%>flip/jornal/skins/article/js/jquery.columnizer.js" ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/skins/article/js/article-horizontal.js" ></script>

        <div id="article-reader">
            <div id="wrapper">
                <div class="wide">
                    <c:forEach var="article" items="${page.articles}">
                       <h1 class="wide-title"><c:out value="${article.titulo}"/></h1>
                       <c:if test="${!empty article.miniatura}">
                        <div class="wide-image">
                            <img src="<%= base%><c:out value='${article.miniatura}'/>" title="<c:out value='${article.titulo}'/>"  alt="<c:out value='${article.titulo}'/>"/>
                        </div>
                       </c:if>
                       <c:if test="${!empty article.video}">
                        <div class="wide-video">
                            <div class="video-container">
                                <iframe width="853" height="480" src="https://www.youtube.com/embed/<c:out value='${article.videoFormatado}'/>" frameborder="0" allowfullscreen></iframe>
                            </div>
                        </div>
                </c:if>
                    <h2><c:out value="${article.chamada}"/></h2>
                    <p>
                        <c:out value="${article.textoResumo}" escapeXml="false"/><br/>
                        <a href="javascript:abreArtigo('<c:out value='${article.cd}'/>');" class="btn btn-block btn-primary btn-primary leiamais columnbreak">Leia essa matéria <span class="glyphicon glyphicon-arrow-right"></span></a>
                    </p>
                    </c:forEach>
                 </div>
            </div>
        </div>
            </c:if>
            <c:if test="${false && !empty page.articles}">
                <style type="text/css">
                    #article-reader{
                        width:100%;
                        display:table;
                    }
                    .article-item{
                        display:inline-table;
                        width:30%;
                        min-height:500px;
                        float:left;
                        margin:2%;
                        position:relative;
                        cursor:pointer;
                        *cursor:pointer;
                    }
                    .article-image{
                         display:inline-table;
                         height:200px;
                    }
                    .article-image img{
                            width:100%;
                            height:auto;
                    }
                    .article-title h2{
                            font-size:22px;
                    }
                    .article-title h2 a{
                            color:black;
                    }
                </style>
                <div id="article-reader">
                    <c:forEach var="article" items="${page.articles}">
                        <div class="article-item" onclick="abreArtigo('<c:out value='${article.cd}'/>');">
                            <div class="article-image">
                                <img src="<%= base%><c:out value='${article.miniatura}'/>" title="<c:out value='${article.titulo}'/>"  alt="<c:out value='${article.titulo}'/>"/>
                            </div>
                            <div class="article-title">
                                <h2><a href="javascript:abreArtigo('<c:out value='${article.cd}'/>');"><c:out value="${article.titulo}"/></a></h2>
                                <p><c:out value="${article.chamada}"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

        </article>
    </section>



    <footer id="footer">

        <nav>
          <ul class="paginacao bg-geral">
              <li><a class="btn duplo multimidia_fr" href="#"><i class="primeiro fa fa-chevron-left" aria-hidden="true"></i><i class="segundo fa fa-chevron-left" aria-hidden="true"></i></a></li>
              <li><a class="btn multimidia_prev" href="#"><i class="fa fa-chevron-left" aria-hidden="true"></i></a></li>
              <li>
                  <input type="text" name="" id="" value="1" maxlength="5" class="multimidia_textfield" />
              </li>
              <li><a class="btn multimidia_next" href="#"><i class="fa fa-chevron-right" aria-hidden="true"></i></a></li>
              <li><a class="btn duplo multimidia_ff" href="#"><i class="primeiro fa fa-chevron-right" aria-hidden="true"></i><i class="segundo fa fa-chevron-right" aria-hidden="true"></i></a></li>
          </ul>

          <button type="button" onclick="addtoFavorite();">
            <i class="fa fa-star" aria-hidden="true"></i>
          </button>

          <button type="button" onclick="newNote();">
            <i class="fa fa-sticky-note" aria-hidden="true"></i>
          </button>

          <a id="btn-fullscreen" class="fullscreen" href="javascript:void(0);" title="Fullscreen" onclick="openFullScreen();">
            <i class="fa fa-arrows-alt" aria-hidden="true"></i>
          </a>

          <c:if test="${!empty logado && logado eq 'true' && !empty username && username ne 'DEMO'}">
              <ul class="sair bg-geral">
                  <li>
                  <c:choose>
                      <c:when test="${!empty sessionScope['backlink']}">
                          <a class="btn btn-sair" href="<%= base%><c:out value='${backlink}'/>"><i class="fa fa-sign-out" aria-hidden="true"></i><span class="sair"><fmt:message key="site.logout"/></span></a>
                      </c:when>
                      <c:otherwise>
                          <a class="btn btn-sair" href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>login.jsp"><i class="fa fa-sign-out" aria-hidden="true"></i><span class="sair"><fmt:message key="site.logout"/></span></a>
                      </c:otherwise>
                  </c:choose>
                  </li>
              </ul>
          </c:if>

        </nav>

        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.logomaven}">
            <a href="http://www.maven.com.br/#produtos" target="_blank" class="logo-maven" alt="<fmt:message key='site.conheca'/>" title="<fmt:message key='site.conheca'/>"></a>
        </c:if>
    </footer>

    <section data-overlay="mdl-favoritos" class="favorites overlay-content">
      <h2>Meus Favoritos</h2>
      <button type="button" class="close"></button>

      <div class="favorites-folders">

        <span id="folders">

          <a class="file favorited drag" data-folder="false" data-name="name of the file" href="https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ5Njk1Mjc5N15BMl5BanBnXkFtZTgwNDQ5NTc4MDE@._V1_SY1000_SX1500_AL_.jpg" class="multimidia-item">
            <figure><img class="img-responsive" src="https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ5Njk1Mjc5N15BMl5BanBnXkFtZTgwNDQ5NTc4MDE@._V1_SY1000_SX1500_AL_.jpg"></figure>
          </a>

          <a href="paginas.html" class="folder drag" data-folder="true" data-name="politica" draggable="true">
            <svg class="svg folder-svg" role="img" title="Folder">
              <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#folder"></use>
            </svg>
            <span>Politica</span>
          </a>

          <a href="paginas.html" class="folder drag" data-folder="true" data-name="esportes" draggable="true">
            <svg class="svg folder-svg" role="img" title="Folder">
              <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#folder"></use>
            </svg>
            <span>Esportes</span>
          </a>

        </span>

        <a href="#" class="folder new">
          <svg class="svg folder-svg" role="img" title="Folder">
            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#folder"></use>
          </svg>
          <span>Nova Pasta</span>
        </a>

      </div>

      <div class="md-modal md-effect-1" id="new-favorite-folder">

        <div class="md-content">
          <div>
            <h3>Nova pasta</h3>

            <form id="new-folder-form">

              <div class="field">
                <input type="text" id="name-of-folder" placeholder="Nome da nova pasta" autocomplete="off" />
              </div>

              <button type="submit" class="save">salvar</button>
            </form>

            <button class="md-close close"></button>
          </div>
        </div>

      </div>
    </section>

    <section data-overlay="mdl-multimidia" class="multimidia overlay-content ">

      <header>
        <h2>Multimídia</h2>
        <%-- <span>Filtrar por:
          <select>
            <option value="">Video</option>
            <option value="">Fotos</option>
          </select>
        </span> --%>
      </header>

      <button type="button" class="close"></button>

      <div id="lightgallery">

        <a href="https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ5Njk1Mjc5N15BMl5BanBnXkFtZTgwNDQ5NTc4MDE@._V1_SY1000_SX1500_AL_.jpg" class="multimidia-item">
          <figure><img class="img-responsive" src="https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ5Njk1Mjc5N15BMl5BanBnXkFtZTgwNDQ5NTc4MDE@._V1_SY1000_SX1500_AL_.jpg"></figure>
          <h3>Whiplash</h3>
          <h4>2014 - Andrew</h4>
        </a>

        <a href="https://images-na.ssl-images-amazon.com/images/M/MV5BMjE2NTQ4NTY0MF5BMl5BanBnXkFtZTgwMDQ0NzQ5MTE@._V1_SX1500_CR0,0,1500,999_AL_.jpg" class="multimidia-item">
          <figure><img class="img-responsive" src="https://images-na.ssl-images-amazon.com/images/M/MV5BMjE2NTQ4NTY0MF5BMl5BanBnXkFtZTgwMDQ0NzQ5MTE@._V1_SX1500_CR0,0,1500,999_AL_.jpg"></figure>
          <h3>Whiplash</h3>
          <h4>2014 - Andrew</h4>
        </a>

        <a href="https://www.youtube.com/watch?v=meBbDqAXago"  class="multimidia-item video">
          <figure><img class="img-responsive" src="https://images-na.ssl-images-amazon.com/images/M/MV5BMTY3NjMxNzQ0Ml5BMl5BanBnXkFtZTgwNzQ5NTc4MDE@._V1_SY1000_SX1500_AL_.jpg"></figure>
          <h3>Whiplash</h3>
          <h4>2014 - Andrew</h4>
        </a>

      </div>
    </section>

    <div class="md-modal md-effect-1" id="notes">

      <div class="md-content">
        <div>
          <h3>Nova Nota</h3>

          <form id="notes-form">

            <div class="field">
              <textarea type="text" id="note" placeholder="Nota" /></textarea>
            </div>

            <button type="submit" class="save">salvar</button>
          </form>

          <button class="md-close close"></button>
        </div>
      </div>

    </div>


</div>
<jsp:include page="../common/windowBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base%>"/>
</jsp:include>
<jsp:include page="../common/sideBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base%>"/>
</jsp:include>

<c:if test="${!empty MESSAGE}">
    <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>');</script>
    <%session.removeAttribute("MESSAGE");%>
</c:if>

<form action="#" method="post" name="frm" id="frm">
    <div>
        <input type="hidden" name="idForm" id="idForm" value="-1"/>
        <input type="hidden" name="idEdicao" id="idEdicao" value="-1"/>
        <input type="hidden" name="pagina" id="pagina" value="-1"/>
        <input type="hidden" name="coord" id="coord" value="-1"/>
        <input type="hidden" name="msg" id="msg" value=""/>
        <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>"/>
        <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value="${edicao_dia}"/>"/>
    </div>
</form>
<jsp:include page="../common/earBanner.jsp" flush="true">
    <jsp:param name="base" value="<%= base%>"/>
</jsp:include>
<c:if test="${DEMO eq 'S' or username eq 'DEMO'}">
    <c:remove var="username"/>
    <c:remove var="logado"/>
</c:if>
<c:set value="N" var="DEMO" scope="session"/>
