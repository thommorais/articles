<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = request.getParameter("base");
            String edicaoId = "" + request.getAttribute("edicaoId");                        
            session.setAttribute("myLink",request.getRequestURL());     

            if(edicaoId!=null){
%>
<script type='text/javascript'>  <%
            java.util.List<br.com.maven.flip.javasql.view.CadernoBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.cadernos(Integer.parseInt(edicaoId));
                if(list != null){
                for (br.com.maven.flip.javasql.view.CadernoBean bean : list) {                  
    %>
indexList[indexList.length] = [<%= bean.getIndex() %>, '<%= bean.getNome() %>'];

    <%
                }
}
    %></script><%
            }

    %>
<div id="loading" style="display:none"><fmt:message key="site.loading"/>... <br/> <img src="<%= base%>flip/jornal/loading.gif"/></div>

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">
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
                                <div id="social-links" class="addthis_toolbox addthis_default_style">
                                    <a class="addthis_button_facebook_like" fb:like:layout="button_count" <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}">fb:like:href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}'/>"</c:if>></a>                        
                                    <a class="addthis_button_tweet" tw:via='Mavenflip'/></a>                                                
                                    <a class="addthis_counter addthis_pill_style" addthis:ui_hover_direction="-1"></a>                                
                                </div>                                                            
                                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=xa-529fe7e849b8a504"></script>                            
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
                                        <a href="<%= base%><c:out value='${backlink}'/>">
                                            <img src='<%= base %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>login.jsp<c:if test='${!empty numero && numero ne "null"}'>?numero=<c:out value='${numero}'/></c:if>">
                                        <img src='<%= base %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>                    
                                        </a>
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
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
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
                    <link href="<%= base%>flip/jornal/skins/king/css/flags.css" rel="stylesheet" type="text/css" media="screen" />
                    <a href="?lang=<fmt:message key='site.idiomaReverse'/>">
                        <img src="<%= base%>flip/jornal/skins/king/img/blank.gif" class="flag flag-<fmt:message key='site.idiomaReverse'/>"  />
                    </a>
                </c:if>    
            </div> <!-- fecha div basic-modal -->
        </div>


    </div> <!-- fecha TOP -->
</c:if>
<div id="multimidia">
    <div id="multimidia_left">
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
                <input name="" type="button" class="multimidia_fr" title="<fmt:message key='site.primeira'/>" />
                <input name="" type="button" class="multimidia_prev" title="<fmt:message key='site.anterior'/>" />
            </div>
            <div id="multimidia_box">
                <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield" value="" />
            </div>
            <div id="multimidia_box">

                <input name="" type="button" class="multimidia_next" title="<fmt:message key='site.proxima'/>" />
                <input name="" type="button" class="multimidia_ff" title="<fmt:message key='site.ultima'/>" />
            </div>
        </div>
        <div id="multimidia_corner_right"> </div>
    </div>
    <div id="multimidia_right">
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete}">
            <jsp:include page="jsp/enquete.jsp" flush="true">
                <jsp:param name="base" value="<%= base%>"/>
                <jsp:param name="edicao" value="<%= edicaoId%>"/>
            </jsp:include>
        </c:if>
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.logomaven}">
            <a href="http://www.mavenapp.com.br" target="_blank" class='logomaven'><img src="<%= base%>flip/jornal/skins/king/img/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/>/mavenflip.gif" title="<fmt:message key='site.conheca'/>" height="25px" /></a>
        </c:if>        
        <c:if test="${page.flipModeloPublicacaoidid_modelo.sigla eq 'ZH'}">
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
                <img src="<%= br.com.maven.flip.Environment.SITE%>flip/jornal/skins/king/img/temas/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.tema}'/>/fundo.jpg" class="stretch"/>            
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
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
                <c:if test="${empty permissions or permissions.acervo}">
                    <li id="edicoes_barra" title="<fmt:message key='site.outras'/>" class="dock_tab_hover">
                        <ul class="free" ></ul>
                    </li>   
                </c:if>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">
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
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaPromocao}">
        <%
                    br.com.maven.flip.javasql.FlipPromocaoTbl promocao = br.com.maven.flip.javasql.dao.FlipPromocaoDAO.getPromocao(Integer.parseInt(edicaoId));
                    if (promocao != null) {
        %>
        <script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/promotion.js?1=1" charset="utf-8"></script>            
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
        <input type="text" name="keywordbody" id="keywordbody" class="CampoTexto"/>
        <input type="button" value="Pesquisar" class="BotaoBranco" onclick="atualizaPesquisa();"/>
        <input type="button" value="Cancelar" class="BotaoBranco" onclick="cancelaPesquisa();"/>
    </div>

    <div id="flip">
        <div id="jornal">
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.effects && page.flipModeloPublicacaoidid_modelo.prefs.effects eq 'daynight'}">
                <div id="sky"></div><div id="sun_yellow"></div><div id="sun_red"></div><div id="clouds"></div><div id="ground"></div><div id="night"></div><div id="stars"></div>        <div id="sstar"></div><div id="moon"></div>   
            </c:if>                       
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.recomendaFacebook}">
                <c:if test="${empty permissions or permissions.redes}">
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
            <div id="megazine" style="height:<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageHeight}'/>px">
                <div style='display:none'><c:out value="${page.textoPagina}"/></div>
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
                    <p  class='logomaven'>
                        powered by <a href="http://www.maven.com.br/#produtos" target="_blank" title="Mavenflip, publicações digitais">MavenFlip</a>, publique seus jornais e revistas online.
                    </p>
                </c:if>
            </div>
        </div>                        
    </div>
</div> 

<script type="text/javascript">
    try {
        swfobject.embedSWF("<%= base%>flip/jornal/player/mavenflip.swf",
                "megazine",
                "100%",
                "100%",
                "9.0.115",
                "<%= base%>flip/jornal/swfobject/expressInstall.swf", {
                    xmlFile : "<%= base%>flip/jornal/megazinedata.jsp?ed=<c:out value='${HASH_MZ_KEY_REQ}'/>&c=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}'/>&sp=<c:out value="${param.pg}"/>",
                            top: "0"
                }, {
            wmode: "transparent",
            allowFullscreen: "true",
            bgcolor: "#333333",
            allowscriptaccess: "always"
        }, {id: "megazineScript"});
    } catch (e) {
    }
</script>

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
<c:if test="${!empty logado && logado eq 'true' && !empty username && username ne 'DEMO'}">
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
        <div id="logout_button">
            <c:choose>
                <c:when test="${!empty sessionScope['backlink']}">
                    <a href="<%= base%><c:out value='${backlink}'/>">
                        <img src="<%= base%>flip/jornal/images/sair.png" title="<fmt:message key='site.logout'/>"/>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>login.jsp<c:if test='${!empty numero}'>?numero=<c:out value='${numero}'/></c:if>">
                    <img src="<%= base%>flip/jornal/images/sair.png"  title="<fmt:message key='site.logout'/>"/>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
</c:if>

<form action="#" method="post" name="frm" id="frm">
    <div>
        <input type="hidden" name="idForm" id="idForm" value="-1"/>
        <input type="hidden" name="idEdicao" id="idEdicao" value="-1"/>
        <input type="hidden" name="pagina" id="pagina" value="-1"/>
        <input type="hidden" name="coord" id="coord" value="-1"/>
        <input type="hidden" name="msg" id="msg" value=""/>
        <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>"/>
        <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value='${edicao_dia}'/>"/>
        <input type="hidden" name="edicaoId" id="edicaoId" value="<c:out value='${page.id}'/>"/>
        <input type="hidden" name="modelo" id="modelo" value="<c:out value='${modelo}'/>"/>
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
<%if(br.com.maven.flip.Environment.isDemo()){%>
<script type="text/javascript">
    jQuery(document).ready(function () {
        Videobox.leiaMais('flip/jornal/jsp/demoAviso.jsp', 'Bem vindo ao Mavenflip!', 'vidbox 700 550');
    });
</script>    
<%}%>
<script type="text/javascript">
    jQuery(document).ready(function () {
        var height = '<c:out value="${pageHeight}"/>';
        if (height > 0) {
            jQuery("#jornal").height(height);
        }
    });
</script>
