<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = request.getParameter("base");
    String baseweb = request.getParameter("baseweb");
    String edicaoId = "" + request.getAttribute("edicaoId");
%>

<script type="text/javascript">
    var hoverspeed = 200;
    var manterProporcao = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.manterProporcaoIcones}"/>;
    var index = 0, indexmedia = 0, indexpic = 0, indextemplinks = 0;
    var pageslist = new Array();
    var pfmedias = new Array();
    var pfmediaspics = new Array();
    var pftemplinks = new Array();
    var iconVideo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.iconVideo}"/>;
    var zoomDuplo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.zoomDuplo}"/>;
    var zoomInicial = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.zoomInicial}"/>;

    <c:forEach var = "pag" items = "${paginaslist}" varStatus = "i">
        <c:choose>
            <c:when test = "${pag.app}">
                <c:choose>
                    <c:when test="${!empty pag.html5Zip}">
    pageslist[index++] = ["<c:out value='${pag.id}'/>", "<c:out value='${pag.html5}'/>", "<c:out value='${pag.html5Zip}'/>", "<c:out value='${pag.html5Zip}'/>"];
                    </c:when>
                    <c:otherwise>
    pageslist[index++] = ["<c:out value='${pag.id}'/>", "HTML5", "HTML5", "HTML5"];
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
    pageslist[index++] = ["<c:out value='${pag.id}'/>", "<c:out value='${pag.pathImage}'/>", "<c:out value='${pag.pathNormal}'/>", "<c:out value='${pag.pathThumb}'/>"];
            </c:otherwise>
        </c:choose>
        <c:if test = "${!empty pag.links}"><c:forEach var = "link" items = "${pag.links}">
    pfmedias[indexmedia++] = ['link', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", <c:choose><c:when test = "${!link.anchor}">base+"flip/jornal/link.jsp?id=<c:out value="${link.id}"/>"</c:when><c:otherwise>"<c:out value="${link.link}"/>"</c:otherwise></c:choose>, "<c:out value = "${link.percentualX}"/>", "<c:out value = "${link.percentualY}"/>", "<c:out value = "${link.id}"/>", "<c:out value = "${link.pagina.width}"/>", "<c:out value = "${link.pagina.height}"/>", "<c:out value = '${link.label}'/>", "<c:choose><c:when test = '${link.popupWeb}'>V</c:when><c:otherwise><c:out value='${link.tipo}'/></c:otherwise></c:choose>", "<c:if test = '${link.iconeWeb}'><c:out value = '${link.icone}'/></c:if>"];
            </c:forEach></c:if>
        <c:if test = "${!empty pag.videos}">
            <c:forEach var = "link" items = "${pag.videos}"><c:if test = "${!link.flash}">
        pfmedias[indexmedia++] = ['video', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.video.video}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.label}' escapeXml='true'/>", "V", "<c:out value='${link.icone}'/>"];
                </c:if></c:forEach></c:if>
        <c:if test = "${!empty pag.medias}">
            <c:forEach var = "link" items = "${pag.medias}">
        pfmedias[indexmedia++] = ['audiopicture', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.media.media}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.label}'/>", "<c:out value='${link.media.tipo}'/>", "<c:out value='${link.icone}'/>"];
            </c:forEach></c:if>
        <c:if test = "${!empty pag.galerias}"><c:forEach var = "link" items = "${pag.galerias}">
                <c:if test = "${!empty link.galeria.galeria}">
        pfmedias[indexmedia++] = ['gallery', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value='${link.galeria.cd}'/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.galeria.nome}'/>", "G", "<c:out value='${link.icone}'/>","<c:out value='${link.galeria.skin}'/>"];
                    <c:forEach var = "pic" items = "${link.galeria.galeria}">
        pfmediaspics[indexpic++] = ['pic', '<c:out value="${link.galeria.cd}"/>', '<c:out value="${pic.media}"/>', '<c:out value="${pic.nome}"/>']
                    </c:forEach>
                </c:if>
            </c:forEach></c:if>

    </c:forEach>
</script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">
    <c:if test="${param.embed ne 'yes'}">
     <div id="top">
        <div id="top_logotipo">
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}'/>" title="<fmt:message key='site.cliquevisita'/>" target="_blank">
                    </c:if>
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  title="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    </a>
                </c:if>
            </c:if>
        </div>
        <div id="top_right">
            <c:choose>
                <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                    <c:if test="${!empty page.orelha.nome}">
                        <style type="text/css">
                            #social-links{
                                margin-right:120px;
                            }
                            #twitter-widget-0{
                                max-width: 80px;
                                width: 80px;
                            }
                        </style>
                    </c:if>
                    <c:if test="${empty permissions or permissions.redes}">    
                        <c:choose>
                            <c:when test="${empty page.flipModeloPublicacaoidid_modelo.prefs.htmlAddThis}">
<!--                                <div id="social-links" class="addthis_toolbox addthis_default_style">
                                    <a class="addthis_button_facebook_like" fb:like:layout="button_count" <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}">fb:like:href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}'/>"</c:if>></a>                        
                                        <a class="addthis_button_tweet" tw:via='Mavenflip'></a>                                                
                                        <a class="addthis_counter addthis_pill_style" addthis:ui_hover_direction="-1"></a>                                
                                    </div>                                                            -->
                                    <!--<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=xa-529fe7e849b8a504"></script>-->
                                    <!-- Go to www.addthis.com/dashboard to customize your tools --> 
                                    <div style="margin-top: 5px;" class="addthis_inline_share_toolbox"></div>
                                    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-55b0f788e61a564f"></script>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAddThis}" escapeXml="false"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <c:if test="${(!empty user_nome||!empty username) }">
                        <div class='central'>
                            <span class='logout_cumprimento'>
                                Olá                                
                            </span>                            
                            <span class='logout_nome'>
                                <c:choose>
                                    <c:when test="${!empty user_nome}">
                                        <c:out value='${user_nome}'/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value='${username}'/>
                                    </c:otherwise>
                                </c:choose>                                
                            </span>
                            <span class='logout_icone'>
                                <c:choose>
                                    <c:when test="${!empty sessionScope['backlink']}">
                                        <c:choose>
                                            <c:when test="${wizard eq 'true' && !page.publico}">
                                                <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>index.jsp<c:if test='${!empty numero && numero ne "null"}'>?numero=<c:out value='${numero}'/></c:if>">
                                                    <img src='<%= baseweb %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>                    
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="<%= base%><c:out value='${backlink}'/>">
                                                    <img src='<%= baseweb %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${wizard eq 'true' && !page.publico}">
                                                <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>index.jsp<c:if test='${!empty numero && numero ne "null"}'>?numero=<c:out value='${numero}'/></c:if>">
                                                    <img src='<%= baseweb %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>                    
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>login.jsp<c:if test='${!empty numero && numero ne "null"}'>?numero=<c:out value='${numero}'/></c:if>">
                                                    <img src='<%= baseweb %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>                    
                                                </a>    
                                            </c:otherwise>
                                        </c:choose>                                        
                                    </c:otherwise>
                                </c:choose>                                                        
                            </span>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>                    
        <div id="top_middle">
            <c:set var="icons" value="1"/>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.impressao && DEMO ne 'S'}">
                <c:if test="${empty permissions or permissions.print}">
                    <c:set var="icons" value="${icons+1}"/>    
                </c:if>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                <c:set var="icons" value="${icons+1}"/>    
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
                <c:if test="${empty permissions or permissions.pdf}">
                    <c:set var="icons" value="${icons+1}"/>
                </c:if>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
                <c:set var="icons" value="${icons+1}"/>    
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaRecomenda}">
                <c:if test="${empty permissions or permissions.recomenda}">
                    <c:set var="icons" value="${icons+1}"/>   
                </c:if>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
                <c:set var="icons" value="${icons+1}"/>    
            </c:if>   
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.faleConosco}">
                <c:set var="icons" value="${icons+1}"/>    
            </c:if>
            <div id="basic-modal" class="central size<c:out value='${icons}'/>">
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
                    <span class="menu_home" id="tooltip"> <a href="#"><span class="tool"><fmt:message key="site.edicaoatual"/></span></a></span>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.impressao && DEMO ne 'S'}">
                            <c:if test="${empty permissions or permissions.print}">
                        <span class="menu_imprimir" id="tooltip"> <a href="#" class="imprimir"><span class="tool"><fmt:message key="site.imprimir"/></span></a></span>
                            </c:if>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto && DEMO ne 'S'}">
                    <span class="menu_texto" id="tooltip"> <a href="#" class="texto"><span class="tool"><fmt:message key="site.texto"/></span></a></span>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar && DEMO ne 'S'}">
                            <c:if test="${empty permissions or permissions.pdf}">
                        <span class="menu_pdf" id="tooltip"> <a href="#" class="pdf" id="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.exportarTodos}'/>"><span class="tool"><fmt:message key="site.pdf"/></span></a></span>
                            </c:if>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
                            
                    <c:choose>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.sigla eq 'SANT' && (page.flipModeloPublicacaoidid_modelo.id == 351 || page.flipModeloPublicacaoidid_modelo.id == 352 || page.flipModeloPublicacaoidid_modelo.id == 456)}">
                            <span class="menu_procurar" id="tooltip"> <a href="http://www.mflip.com.br/pub/santuarionacional/?flip=collection" class="procurar_santuario"><span class="tool"><fmt:message key="site.procurar"/></span></a></span>
                        </c:when>
                        <c:otherwise>
                            <span class="menu_procurar" id="tooltip"> <a href="#" class="procurar"><span class="tool"><fmt:message key="site.procurar"/></span></a></span>
                        </c:otherwise>
                    </c:choose>                                                
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.fullscreen}">
                            <c:choose>
                                <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeFullscreen}">
                                    <span class="menu_fullscreen" id="tooltip"> <a href="#" onClick="openFullScreen();" class="fullscreen" style="background-image: url('<%=base %><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeFullscreen}'/>')"><span class="tool"><fmt:message key="site.fullscreen"/></span></a></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="menu_fullscreen" id="tooltip"> <a href="#" onClick="openFullScreen();" class="fullscreen"><span class="tool"><fmt:message key="site.fullscreen"/></span></a></span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaRecomenda}">
                            <c:if test="${empty permissions or permissions.recomenda}">
                        <span class="menu_recomendar" id="tooltip"> <a href="#" class="recomendar"><span class="tool"><fmt:message key="site.recomendar"/></span></a></span>
                            </c:if>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
                    <span class="menu_comentar" id="tooltip"> <a href="#" class="comentar"><span class="tool"><fmt:message key="site.comentar"/></span></a></span>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.faleConosco}">
                    <span class="menu_contato" id="tooltip"> <a href="#" class="contato"><span class="tool"><fmt:message key="site.contato"/></span></a></span>
                        </c:if>
                        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado && logado eq 'true' && !empty username}">
                    <span class="menu_postit" id="tooltip">
                        <c:choose><c:when test="${empty page.flipModeloPublicacaoidid_modelo.prefs.iconeComentar}"><a href="#" class="tooltip"><span class="tool"><fmt:message key="site.postit"/></span></a></c:when><c:otherwise><img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeComentar}'/>" title="<fmt:message key="zsite.postit"/>"  class="tooltip"  width="25px"/></c:otherwise></c:choose>
                            </span>
                        </c:if>
                        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeIdioma}">
                            <link href="<%= baseweb%>flip/jornal/skins/king/css/flags.css" rel="stylesheet" type="text/css" media="screen" />
                            <a href="?lang=<fmt:message key='site.idiomaReverse'/>">
                                <img src="<%= baseweb%>flip/jornal/skins/king/img/blank.gif" class="flag flag-<fmt:message key='site.idiomaReverse'/>"  />
                            </a>
                        </c:if>
                            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.acervoPath}">
                            <span class="menu_acervo" id="tooltip"> 
                                <a href="<%= base %>pub/<c:choose><c:when test='${!empty page.flipModeloPublicacaoidid_modelo.folderAdicional}'><c:out value='${page.flipModeloPublicacaoidid_modelo.folderAdicional}'/></c:when><c:otherwise><c:out value='${page.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta}'/>/<c:if test='${page.flipModeloPublicacaoidid_modelo.index > 1}'>index<c:out value='${page.flipModeloPublicacaoidid_modelo.index}'/></c:if></c:otherwise></c:choose>/?flip=acervo" target="_blank">
                                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.acervoPath}'/>"/>
                                </a>
                            </span>
                        </c:if>
            </div> <!-- fecha div basic-modal -->
        </div>


    </div> <!-- fecha TOP -->
</c:if>
</c:if>
<div id="multimidia">
    <div id="multimidia_left">
        <c:if test="${param.embed eq 'yes'}">
            <div style="float:left; valign:middle;">                            
                <input type="text" name="campoPesquisa" id="campoPesquisa" style="width:130px;height:16px;" placeholder="  Pesquisar na edição"/>
            </div>
            <div style="float:left;valign:middle;margin-top:2px">
                <img src="<%= base %>flip/jornal/skins/html5/pics/buttonPesquisa.png" class="buttonPesquisa" height="19px" alt="Clique para pesquisa" title="Clique para pesquisar"/>
            </div>
        </c:if>
        <div class="multimidia_left_inner_content">
            <c:out value="${dataEdicao}"/>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                &nbsp;&nbsp;&nbsp;&nbsp;                
                <a href="javascript:showComments();" title="Veja os comentários e comente também!">
                    <span id="comment_count">
                        0 <fmt:message key="site.comments"/>
                    </span>
                </a>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas && page.visitas > 0}">                
                &nbsp;&nbsp;&nbsp;&nbsp;
                <c:out value="${page.visitas}"/> <fmt:message key="site.visitas"/>                
            </c:if>
            &nbsp;
        </div>
    </div>
    <div id="multimidia_middle">
        <div id="multimidia_corner_left"> </div>
        <div id="multimidia_nav">
            <div id="multimidia_box">
                <c:choose>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'correiodopovo'}">
                        <input name="" type="button" style="background-image: url(/flip/jornal/skins/king/img/multimidia_fr_2.png); background-position-x: right;" class="multimidia_fr" title="<fmt:message key='site.ultima'/>" >
                        <input name="" type="button" style="background-image: url(/flip/jornal/skins/king/img/prev.png);" class="multimidia_prev" title="<fmt:message key='site.anterior'/>" >
                    </c:when>
                    <c:otherwise>
                        <input name="" type="button" class="multimidia_fr" title="<fmt:message key='site.primeira'/>" >
                        <input name="" type="button" class="multimidia_prev" title="<fmt:message key='site.anterior'/>">
                    </c:otherwise>
                </c:choose>
            </div>
            <div id="multimidia_box">
                <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield" value="" >
            </div>
            <div id="multimidia_box">
                <c:choose>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'correiodopovo'}">
                        <input name="" type="button" style="background-image: url(/flip/jornal/skins/king/img/next.png);" class="multimidia_next" title="<fmt:message key='site.proxima'/>" >
                        <input name="" type="button" style="background-image: url(/flip/jornal/skins/king/img/multimidia_ff_2.png);" class="multimidia_ff" title="<fmt:message key='site.ultima'/>" >
                    </c:when>
                    <c:otherwise>
                        <input name="" type="button" class="multimidia_next" title="<fmt:message key='site.proxima'/>" >
                        <input name="" type="button" class="multimidia_ff" title="<fmt:message key='site.ultima'/>" >
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div id="multimidia_corner_right"> </div>
    </div>
    <div id="multimidia_right">
        <c:if test="${param.embed eq 'yes'}">
        <div style="float:left;margin-right: 10px;margin-top:-2px;">
            <img src="<%= base %>flip/jornal/skins/html5/pics/icon-fullscreen.png" class="telacheia" height="21px" title="Clique para abrir a versão completa"/>
        </div>
        </c:if>
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete}">
            <jsp:include page="../king/jsp/enquete.jsp" flush="true">
                <jsp:param name="base" value="<%= base%>"/>
                <jsp:param name="edicao" value="<%= edicaoId%>"/>
            </jsp:include>
        </c:if>
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.logomaven && page.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta ne 'shoppinganaliafranco'}">
            <div style="width:100%">
                <a href="http://www.maven.com.br/#produtos" target="_blank" class='logomaven'><img src="<%= base%>flip/jornal/skins/king/img/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/>/mavenflip.gif" title="<fmt:message key='site.conheca'/>" height="25px" /></a>
            </div>
        </c:if>
        <c:if test="${page.flipModeloPublicacaoidid_modelo.sigla eq 'ZH'||page.flipModeloPublicacaoidid_modelo.sigla eq 'DC'}">
            <!-- exclusivo rbs -->
            <div class="multimidia_right_inner_content">
                <a href="http://www.clicrbs.com.br/zerohora/jsp/default2.jsp?uf=1&local=1&section=capa_offline" class="versao_acessivel_link">
                    VERSÃO ACESSÍVEL
                </a>                
            </div>
        </c:if>            
    </div>
</div>

<div id="content">
    
    
    <c:choose>
        <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.tema}">
            <div id="background" style="background-color:green">            
                <img src="<%= br.com.maven.flip.Environment.SITE%>flip/jornal/skins/king/img/temas/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.tema}'/>/fundo.jpg" class="stretch">            
            </div>        
        </c:when>
        <c:otherwise>                    
            <c:if test="${!empty KEY_BACKGROUND && !KEY_BACKGROUND.repetirX && !KEY_BACKGROUND.repetirY}">
                <div id="background" <c:if test="${!empty KEY_BACKGROUND.corFundo}">style="background-color:#<c:out value='${KEY_BACKGROUND.corFundo}'/>"</c:if>>
                    <c:if test="${!empty KEY_BACKGROUND.background}">
                        <img src="<%= br.com.maven.flip.Environment.SITE%><c:out value='${KEY_BACKGROUND.background}'/>" class="stretch"/>
                    </c:if>
                </div>        
            </c:if>
        </c:otherwise>
    </c:choose>            

            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.recomendaFacebook}">
                <c:if test="${empty permissions or permissions.redes}">
                    <c:if test="${param.embed ne 'yes'}">
                        <div id="facerecomenda">
                            <div  id="faceleft">
                                <iframe id="faceframeleft" src="" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
                                <img src="<%= base %>flip/jornal/images/fechar.png" class="closeleft" onclick="closeRecommendArea()"/>
                            </div>
                            <div id="faceright">
                                <iframe id="faceframeright" src="" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
                                <img src="<%= base %>flip/jornal/images/fechar.png" class="closeright" onclick="closeRecommendArea()"/>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:if>                    
    <c:if test="${page.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta ne 'shoppinganaliafranco'}">
    <div id="tab_right">
        <ul id="dock_right">   
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado && logado eq 'true' && !empty username}">
                <li id="anotacoes_barra" title="<fmt:message key='site.postit'/>"  class="dock_tab_hover_right">
                    <ul class="free" ></ul>
                </li>    
            </c:if>
        </ul>
    </div>               
    <div id="tab_left">
        <ul id="dock">
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && (empty DEMO or DEMO ne 'S')}">
                <c:if test="${empty permissions or permissions.acervo}">
                    <c:choose>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'senai'}">
                            <li id="edicoes_barra" style="background-image: url(/flip/jornal/skins/king/img/pretobranco/livros.png);" title="Livros do curso"  class="dock_tab_hover">
                                <ul class="free" ></ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li id="edicoes_barra" title="<fmt:message key='site.outras'/>" class="dock_tab_hover">
                                <ul class="free" ></ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice  && (empty DEMO or DEMO ne 'S')}">
                <li id="indice_barra" title="<fmt:message key='site.indice'/>" class="dock_tab_hover">
                    <ul class="free"></ul>
                </li>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">
                <li id="sumario_barra" title="<fmt:message key='site.sumario'/>" class="dock_tab_hover">
                    <ul class="free" ></ul>
                </li>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos}">
                <c:choose>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.tipoProduto eq 'P' && page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'acriticaam'}">
                        <li id="produtos_barra" style="background-image: url(/flip/jornal/skins/king/img/azul/abas_cadernos.png);" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                            <ul class="free" ></ul>
                        </li>
                    </c:when>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.tipoProduto eq 'P' && page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'correiodoestado'}">
                        <li id="produtos_barra" style="background-image: url(/flip/jornal/skins/king/img/azul/abas_suplementos.png);" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                            <ul class="free" ></ul>
                        </li>
                    </c:when>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.tipoProduto eq 'P' && page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'oliberaldigital'}">
                        <li id="produtos_barra" style="background-image: url(/flip/jornal/skins/king/img/azul/abas_especiais.png);" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                            <ul class="free" ></ul>
                        </li>
                    </c:when>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.tipoProduto eq 'P'}">
                        <li id="produtos_barra" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                            <ul class="free" ></ul>
                        </li>          
                    </c:when>
                    
                    <c:otherwise>
                        <li id="volume_barra" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                            <ul class="free" ></ul>
                        </li>  
                    </c:otherwise>
                </c:choose>
            </c:if>            
        </ul>                    
    </div>
    </c:if>
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaPromocao}">
        <%
                    br.com.maven.flip.javasql.FlipPromocaoTbl promocao = br.com.maven.flip.javasql.dao.FlipPromocaoDAO.getPromocao(Integer.parseInt(edicaoId));
                    if (promocao != null) {
        %>
        <script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/promotion.js" charset="utf-8"></script>            
        <div class="promo-class" style="position: absolute; float: left; z-index: 9999; margin-left: 5%; margin-top: 1%;">
            <ul style="position: relative; float: left; list-style-type: none;">
                <li id="promocao_barra">
                    <a href="javascript:openPromocao(<%= edicaoId%>);">
                        <img src="<%= base + promocao.getBanner().getMedia()%>" title="Participe da promoção" width="150px"/>
                    </a>
                </li>  
            </ul>
        </div>
        <%}%>
    </c:if>

    <div id="searchinstant" style="display:none">
        Pesquisa instantânea habilitada! Para procurar por várias palavras separe-as com vírgula.         
        <input type="text" name="keywordbody" id="keywordbody" class="CampoTexto">
        <input type="button" value="Pesquisar" class="BotaoBranco" onclick="atualizaPesquisa();">
        <input type="button" value="Cancelar" class="BotaoBranco" onclick="cancelaPesquisa();">
    </div>                    

    <c:if test="${!empty page.prepage.banner}">
        <jsp:include page="../common/prepage.jsp" flush="true">
            <jsp:param name="base" value="<%= base%>"/>
        </jsp:include>            
    </c:if>
        <style>
            .sideways {
                margin-top: 48px;
            }
            .sideways a{
                float: left;
                max-width: 100px;
            }
            .sideways span{
                max-width: 100%;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                max-height: 70px;
                -webkit-line-clamp: 1;
                -webkit-box-orient: vertical;
                /*text-align: left;*/
            }
            .sideways>li {
                font-size: 11px;
                height: 5px;
                width: 120px;
                margin-bottom: 80px;
                margin-left: -94px;
            }
        </style>
        <div id="megazine">
    <div class="magazine-viewport">                
        <div class="container">
            <div class="magazine">
                <c:choose>
                    <c:when test="${!empty abasList}">
                        <div ignore="1" class="tabsright" style="display:none">
                            <div class="col-xs-3">
                                <ul class="nav nav-tabs tabs-right sideways">
                                  <c:forEach var="aba" items="${abasList}" varStatus="i">
                                    <li class="active">
                                        <c:choose>
                                            <c:when test="${aba.product}">
                                                <a href="<%= br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request) %>/<c:out value='${aba.anchor}'/>" data-toggle="tab" style="background-color: #<c:out value='${aba.tabColorBg}'/>;cursor:pointer;" target="_blank" title="<c:out value="${aba.nome}"/>">
                                                    <span style="color: #<c:out value='${aba.tabColor}'/>;font-weight: bold;width: 85px;"><c:out value="${aba.nome}"/></span>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" data-toggle="tab" style="background-color: #<c:out value='${aba.tabColorBg}'/>" onclick="gotoAnchor('<c:out value='${aba.anchor}'/>',false);fechaJanela(); return false;" title="<c:out value="${aba.nome}"/>">
                                                    <span style="color: #<c:out value='${aba.tabColor}'/>;font-weight: bold;width: 85px;"><c:out value="${aba.nome}"/></span>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                  </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div ignore="1" class="next-button"></div>
                        <div ignore="1" class="previous-button"></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>          
    <div class="zoomtools">
        <div class="">
            <span class="zoomless" ><img src="<%=base%>flip/jornal/skins/html5full/pics/zoomless.png" ></span>
            <span class="zoommore" ><img src="<%=base%>flip/jornal/skins/html5full/pics/zoommore.png" ></span>            
            <span class="closeicon"><img src="<%=base%>flip/jornal/skins/html5full/pics/close.png"></span>
        </div>
    </div>             
    <script type="text/javascript">
        function loadApp() {
            var lastPage = false;
            loadMagazineApp();
            jQuery('#all').fadeIn(1200);
            jQuery(".zoomtools").hide();
            $.isTouch=false;
            jQuery('.magazine').turn({
                elevation: 50,
                acceleration: !isChrome(),
                gradients: false,
                keyboard: true,
                autoCenter: <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.alinhamentoZoom && empty page.prepage.banner && empty page.postpage.banner}"/>,
                pages:<c:out value = '${paginas}'/>,
                when: {
                    turning: function (event, page, view) {
                        var book = jQuery(this),
                                currentPage = book.turn('page'),
                                pages = book.turn('pages');
                        // Update the current URI
                        Hash.go('page/'+page).update();
                        disableControls(page);
                        playsound();
                        lastPage = false;
                    },
                    turned: function (event, page, view) {
                        disableControls(page);
                         <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.alinhamentoZoom eq 'true' && empty page.prepage.banner && empty page.postpage.banner}">
                          jQuery(this).turn('center');
                         </c:if>
                        if(lastPage) {
                            var tabPos = jQuery('.page-wrapper').width();
                            jQuery('.tabsright').css('left', tabPos + 'px');
                        } else {
                            jQuery('.tabsright').hide();
                            jQuery('.tabsright').removeAttr('style');
                        }
                        jQuery('.tabsright').fadeIn();
                    },
                    missing: function (event, pages) {
                        for (var i = 0; i<pages.length; i++){
                            addPage(pages[i], jQuery(this));
                            registerPageClick();
                        }
                    },
                    last: function (event) {
                        lastPage = true;
                        jQuery('.tabsright').fadeOut();
                    },
                    first: function (event) {
                        jQuery('.tabsright').fadeOut();
                    }
                }

            });
            
            jQuery('.magazine-viewport').zoom({
                flipbook: jQuery('.magazine'),
                max: function () {
                    return largeMagazineWidth()/jQuery('.magazine').width();
                },
                when: {
                    tap: function (event) {
                        
                        var origin = jQuery(event.target).attr('class');
                        if (origin!=undefined&&(origin.indexOf("mejs")!=-1||origin.indexOf("audiopicture")!=-1||origin.indexOf("link")!=-1||origin.indexOf("video")!=-1||origin.indexOf("gallery")!=-1||origin.indexOf("icon")!=-1)) {
                            event.preventDefault();
                            return;
                        }       
                        if(doubleClickZoom == false){
                            if (flipenabled==false) {
                            checkLogged();
                           } else {
                              if (jQuery(this).zoom('value')==1) {
                                  jQuery('.magazine').removeClass('animated').addClass('zoom-in');
                                  jQuery(this).zoom('zoomIn', event);
                              } else {
                                  jQuery(this).zoom('zoomOut');
                              }
                           }
                         }
        
        
                    },
                    doubleTap: function(event){                        
                        if(doubleClickZoom == true){
                         if (flipenabled==false) {
                            checkLogged();
                         } else {
                            if (jQuery(this).zoom('value')==1) {
                                jQuery('.magazine').removeClass('animated').addClass('zoom-in');
                                jQuery(this).zoom('zoomIn', event);
                            } else {
                                jQuery(this).zoom('zoomOut');
                            }
                        }
                      }
                    },
                    resize: function (event, scale, page, pageElement) {
                        if (scale==1)
                            loadSmallPage(page, pageElement);
                        else
                            loadLargePage(page, pageElement);
                    },
                    zoomIn: function () {
                        if (flipenabled==false) {
                            checkLogged();
                        } else {
                            zoommode = true;
                            registerPageClick();
                            checkDoublePageZoom(zoomDuplo, 'in');
                            executeListener('ZOOM_IN_PAGE');
                            jQuery('.linkimg').hide();
                            jQuery('.thumbnails').hide();
                            jQuery('.made').hide();
                            if (jQuery("#banner_lateral")) {
                                jQuery("#banner_lateral").hide();
                            }
                            if (jQuery("#banner_lateral_esquerda")) {
                                jQuery("#banner_lateral_esquerda").hide();
                            }
                             if (jQuery("#s2bannerdiv")) {
                                jQuery("#s2bannerdiv").hide();
                            }
                            
                            jQuery("#top").hide();
                            jQuery("#tab_left").hide();
                            jQuery(".zoomtools").show();
                            jQuery('.magazine').removeClass('zoom-out').addClass('zoom-in');
                            calculaAlturaZoom(zoomDuplo, 'in', zoomInicial);
                            setTimeout(adjustMediaSize, 300);
                            setTimeout(resizeViewport, 200);
                            hideRecommendArea();
                            if (!window.escTip) {
                                escTip = true;
                                jQuery('<div/>', {'class': 'esc'}).
                                        html('<div>ESC para fechar</div>').
                                        appendTo(jQuery('body')).
                                        delay(2000).
                                        animate({opacity: 0}, 500, function () {
                                            jQuery(this).remove();
                                        });
                            }
                        }
                    },
                    zoomOut: function () {
                        zoommode = false;
                        registerPageClick();
                        checkDoublePageZoom(zoomDuplo,'out');
                        jQuery('.esc').hide();
                        jQuery('.thumbnails').fadeIn();
                        jQuery('.made').fadeIn();
                        if (jQuery("#banner_lateral")) {
                            jQuery("#banner_lateral").fadeIn();
                        }
                        if (jQuery("#banner_lateral_esquerda")) {
                            jQuery("#banner_lateral_esquerda").fadeIn();
                        }
                          if (jQuery("#s2bannerdiv")) {
                                jQuery("#s2bannerdiv").fadeIn();
                            }
                            
                        jQuery("#top").slideDown();
                        jQuery("#tab_left").fadeIn('slow');
                        executeListener('ZOOM_OUT_PAGE');
                        //jQuery(".rotateicon img, .zoommore img, .zoomless img, .texticon img").each(function(){
                        //    jQuery(this).attr('src', this.src.replace("_disabled.png", ".png"));
                        //});
                        //jQuery(".TEXTPAGE").remove();
                        jQuery(".magazine").turn("disable", false);
                        calculaAltura();
                        jQuery("#multimidia").show();
                        jQuery('.linkimg').show();
                        setTimeout(adjustMediaSize, 300);
                        if (grau!=90) {
                            jQuery(".magazine-viewport").rotate({
                                animateTo: 0
                            });
                            jQuery(".magazine-viewport").css("height", "100%");
                            jQuery(".magazine-viewport").css("width", "100%");
                            jQuery(".magazine-viewport").css("left", "0");
                            grau = 90;
                            lado1 = false;
                        }

                        setTimeout(function () {
                            jQuery('.magazine').addClass('animated').removeClass('zoom-in').addClass('zoom-out');
                            resizeViewport();
                        }, 0);
                        jQuery(".zoomtools").hide();
                        showRecommendArea();
                    },
                    swipeLeft: function () {
                        jQuery('.multimidia_next').click();
                    },
                    swipeRight: function () {
                        jQuery('.multimidia_prev').click();
                    }
                }
            });
            Hash.on('^page\/([0-9]*)$', {
                yep: function (path, parts) {
                    var page = parts[1];
                    if (page!==undefined) {
                        if (jQuery('.magazine').turn('is'))
                            jQuery('.magazine').turn('page', page);
                    }
                },
                nop: function (path) {
                    if (jQuery('.magazine').turn('is'))
                        jQuery('.magazine').turn('page', 1);
                }
            });
            jQuery(window).resize(function () {
                resizeViewport();
            }).bind('orientationchange', function () {
                resizeViewport();
            });
            jQuery('.page').bind('mousewheel', wheelFunction);
            jQuery('.page').bind('click', recordLastDivClick);
           // if ($.isTouch) {
           //     jQuery('.magazine').bind('touchstart', regionClick);
          ////  } else {
               jQuery('.magazine').click(regionClick);
           // }
            jQuery('.next-button').bind($.mouseEvents.over, function () {

                jQuery(this).addClass('next-button-hover');
            }).bind($.mouseEvents.out, function () {

                jQuery(this).removeClass('next-button-hover');
            }).bind($.mouseEvents.down, function () {

                jQuery(this).addClass('next-button-down');
            }).bind($.mouseEvents.up, function () {

                jQuery(this).removeClass('next-button-down');
            }).click(function () {

                jQuery('.multimidia_next').click();
            });
            // Events for the next button
            jQuery('.previous-button').bind($.mouseEvents.over, function () {
                jQuery(this).addClass('previous-button-hover');
            }).bind($.mouseEvents.out, function () {

                jQuery(this).removeClass('previous-button-hover');
            }).bind($.mouseEvents.down, function () {

                jQuery(this).addClass('previous-button-down');
            }).bind($.mouseEvents.up, function () {

                jQuery(this).removeClass('previous-button-down');
            }).click(function () {
                jQuery('.multimidia_prev').click();
            });            
            resizeViewport();
            jQuery('.magazine').addClass('animated').addClass('zoom-out');
            jQuery(".magazine-viewport .zoom-out").css("z-index", "100");
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
            reload_comments();
            </c:if>
            jQuery(".zoomtools .zoom").mouseover(function(){
                jQuery(this).css("opacity", .9);
            });
            jQuery(".zoomtools .zoom").mouseout(function(){
                jQuery(this).css("opacity", .2);
            });
        }
        jQuery('#all').hide();
        yepnope({
            test: Modernizr.csstransforms,
            yep: ['<%= base %>flip/jornal/skins/html5full/lib/turn.min.js?flip=mavenflip'],
            nope: ['<%= base %>flip/jornal/skins/html5full/lib/turn.html4.min.js'],
            both: ['<%= base %>flip/jornal/skins/html5full/lib/zoom.min.js?flip=mavenflip'],
            complete: function () {
                jQuery(document).ready(function () {
                    
                    setTimeout(loadApp, 100);
                });
            }
        });
        
</script>
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
    <c:if test="${!empty logado && logado eq 'true' && !empty username && DEMO ne 'S' && username ne 'DEMO'}">
        <div id="logout_button">
            <c:choose>
                <c:when test="${!empty sessionScope['backlink']}">
                    <a href="<%= base%><c:out value='${backlink}'/>">
                        <c:choose>
                            <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeSair}">
                                <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeSair}'/>" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                            </c:when>
                            <c:otherwise>
                                <img src="<%= base%>flip/jornal/images/sair.png" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${wizard eq 'true' && !page.publico}">
                            <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>index.jsp<c:if test='${!empty numero && numero ne "null"}'>?numero=<c:out value='${numero}'/></c:if>">
                                <c:choose>
                                    <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeSair}">
                                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeSair}'/>" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="<%= base%>flip/jornal/images/sair.png" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<%= base%><c:out value="${edicao_dia}"/>login.jsp">
                                <c:choose>
                                    <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.iconeSair}">
                                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeSair}'/>" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="<%= base%>flip/jornal/images/sair.png" alt="<fmt:message key="site.logout"/>" title="<fmt:message key="site.logout"/>"/>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <c:forEach var = "pag" items = "${paginaslist}" varStatus = "i">
        <c:if test = "${pag.app && empty pag.html5Zip}">
            <div id="html5-<c:out value='${pag.id}'/>" class="html5hidecontent">
                <c:out value="${pag.html5}" escapeXml="false"/>
            </div>
        </c:if>
    </c:forEach>                    

    <form action="#" method="post" name="frm" id="frm">
        <div>
            <input type="hidden" name="idForm" id="idForm" value="-1">
            <input type="hidden" name="idEdicao" id="idEdicao" value="-1">
            <input type="hidden" name="pagina" id="pagina" value="-1">
            <input type="hidden" name="coord" id="coord" value="-1">
            <input type="hidden" name="msg" id="msg" value="">
            <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>">
            <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value="${edicao_dia}"/>">
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
</div>
<%if(br.com.maven.flip.Environment.isDemo()){%>
<script type="text/javascript">
    jQuery(document).ready(function () {
        Videobox.leiaMais('flip/jornal/jsp/demoAviso.jsp', 'Bem vindo ao Mavenflip!', 'vidbox 700 550');
    });
</script>    
<%}%>        
