<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = request.getParameter("base");
    String edicaoId = "" + request.getAttribute("edicaoId");
%>
<script type="text/javascript">    
    zoomenabled=false;
    var index=0,indexmedia=0,indexpic=0,indextemplinks=0;
    var pageslist=new Array();                
    var pfmedias=new Array();
    var pfmediaspics=new Array();
    var pftemplinks=new Array();
        <c:forEach var="pag" items="${paginaslist}" varStatus="i">
        pageslist[index++]=["<c:out value='${pag.id}'/>","<c:out value='${pag.pathImage}'/>","<c:out value='${pag.pathNormal}'/>","<c:out value='${pag.pathThumb}'/>"]                
        <c:if test="${!empty pag.links}"><c:forEach var="link" items="${pag.links}">
        pfmedias[indexmedia++]=['link',"<c:out value='${i.index+1}'/>","<c:out value="${link.x}"/>","<c:out value="${link.y}"/>","<c:out value="${link.width}"/>","<c:out value="${link.height}"/>",<c:choose><c:when test="${!link.anchor}">base+"flip/jornal/link.jsp?id=<c:out value="${link.id}"/>"</c:when><c:otherwise>"<c:out value="${link.link}"/>"</c:otherwise></c:choose>,"<c:out value="${link.percentualX}"/>","<c:out value="${link.percentualY}"/>","<c:out value="${link.id}"/>","<c:out value="${link.pagina.width}"/>","<c:out value="${link.pagina.height}"/>","<c:out value='${link.label}'/>"];        
        </c:forEach></c:if>                
        <c:if test="${!empty pag.videos}">
        <c:forEach var="link" items="${pag.videos}"><c:if test="${!link.flash}">
        pfmedias[indexmedia++]=['video',"<c:out value='${i.index+1}'/>","<c:out value="${link.x}"/>","<c:out value="${link.y}"/>","<c:out value="${link.width}"/>","<c:out value="${link.height}"/>","<c:out value="${link.video.video}"/>","<c:out value="${link.percentualX}"/>","<c:out value="${link.percentualY}"/>","<c:out value="${link.id}"/>","<c:out value="${link.pagina.width}"/>","<c:out value="${link.pagina.height}"/>","<c:out value='${link.label}'/>"];
        </c:if></c:forEach></c:if>       
        <c:if test="${!empty pag.galerias}"><c:forEach var="link" items="${pag.galerias}">
        <c:if test="${!empty link.galeria.galeria}">
        pfmedias[indexmedia++]=['gallery',"<c:out value='${i.index+1}'/>","<c:out value="${link.x}"/>","<c:out value="${link.y}"/>","<c:out value="${link.width}"/>","<c:out value="${link.height}"/>","<c:out value='${link.galeria.id}'/>","<c:out value="${link.percentualX}"/>","<c:out value="${link.percentualY}"/>","<c:out value="${link.id}"/>","<c:out value="${link.pagina.width}"/>","<c:out value="${link.pagina.height}"/>","<c:out value='${link.galeria.nome}'/>"];  
        <c:forEach var="pic" items="${link.galeria.galeria}">
        pfmediaspics[indexpic++]=['pic','<c:out value="${link.galeria.id}"/>','<c:out value="${pic.media}"/>','<c:out value="${pic.nome}"/>']
        </c:forEach>
        </c:if>
        </c:forEach></c:if>        
        </c:forEach>
        var htm='tela.html?1=1'    
    pageslist[1]=["999",htm,htm,htm];
    htm='tela2.html?1=1'    
    pageslist[2]=["998",htm,htm,htm];
</script>    

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">
    <div id="top">
        <div id="top_logotipo">
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="<fmt:message key='site.cliquevisita'/>" target="_blank">
                </c:if>
                <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>"/>
                     <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    </a>
                </c:if>
            </c:if>
        </div>
        <div id="top_middle">
            <div id="multimidia_middle">
                <div id="multimidia_corner_left"> </div>
                <div id="multimidia_nav">
                    <div id="multimidia_box">
                        <input name="" type="button" class="multimidia_fr" title="<fmt:message key="site.primeira"/>" />
                               <input name="" type="button" class="multimidia_prev" title="<fmt:message key="site.anterior"/>" />
                    </div>
                    <div id="multimidia_box">
                        <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield" value="" />
                    </div>
                    <div id="multimidia_box">

                        <input name="" type="button" class="multimidia_next" title="<fmt:message key="site.proxima"/>" />
                               <input name="" type="button" class="multimidia_ff" title="<fmt:message key="site.ultima"/>" />
                    </div>
                </div>
                <div id="multimidia_corner_right"> </div>
            </div>            
        </div>
        <div id="top_right">
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                <c:choose>
                    <c:when test="${empty page.flipModeloPublicacaoidid_modelo.prefs.htmlAddThis}">
                        <div id="social-links" class="addthis_toolbox addthis_default_style">
                            <a class="addthis_button_facebook_like" fb:like:layout="button_count" <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}">fb:like:href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}'/>"</c:if>></a>                        
                            <a class="addthis_button_tweet" tw:via='Mavenflip'/></a>                                                
                            <a class="addthis_counter addthis_pill_style" addthis:ui_hover_direction="-1"></a>
                        </div>
                        <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4fd26041763aff66"></script>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAddThis}" escapeXml="false"/>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>

    </div> <!-- fecha TOP -->
</c:if>

<div id="content">


    <div id="tab_right">
        <ul id="dock_right">   
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado && logado eq 'true' && !empty username}">
                <li id="anotacoes_barra" title="<fmt:message key="site.postit"/>">
                    <ul class="free" ></ul>
                </li>    
            </c:if>
        </ul>
    </div>               

    <div id="tab_left">
        <ul id="dock">    
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
                <li id="edicoes_barra" title="<fmt:message key="site.outras"/>">
                    <ul class="free" ></ul>
                </li>    
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">
                <li id="indice_barra" title="<fmt:message key="site.indice"/>">
                    <ul class="free"></ul>
                </li>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">
                <li id="sumario_barra" title="<fmt:message key="site.sumario"/>">
                    <ul class="free" ></ul>
                </li>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos}">
                <li id="produtos_barra" title="<fmt:message key="site.produto"/>">
                    <ul class="free" ></ul>
                </li>  
            </c:if>        
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaPromocao}">
                <%
                            br.com.maven.flip.javasql.FlipPromocaoTbl promocao = br.com.maven.flip.javasql.dao.FlipPromocaoDAO.getPromocao(Integer.parseInt(edicaoId));
                            if (promocao != null) {
                %>
                <script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/promotion.js?1=1" charset="utf-8"></script>            
                <li>
                    <a href="javascript:openPromocao(<%= edicaoId%>);">
                        <img src="<%= base + promocao.getBanner().getMedia()%>" alt="Participe da promoção" title="Participe da promoção" width="150px"/>
                    </a>
                </li>            
                <%}%>
            </c:if>
        </ul>                    
    </div>

    <div id="searchinstant" style="display:none">
        Pesquisa instantânea habilitada! Para procurar por várias palavras separe-as com vírgula.         
        <input type="text" name="keywordbody" id="keywordbody" class="CampoTexto"/>
        <input type="button" value="Pesquisar" class="BotaoBranco" onclick="atualizaPesquisa();"/>
        <input type="button" value="Cancelar" class="BotaoBranco" onclick="cancelaPesquisa();"/>
    </div>                    

    <div class="magazine-viewport">                
        <div class="container">
            <div class="magazine">                    
                <div ignore="1" class="next-button"></div>            
                <div ignore="1" class="previous-button"></div>
            </div>
        </div>
    </div>          

    <div class="zoomtools">
        <div>
            <span class="zoomless" ><img src="<%=base%>flip/jornal/skins/html5full/pics/zoomless.png" alt="Reduzir zoom da página"/></span>
            <span class="zoommore" ><img src="<%=base%>flip/jornal/skins/html5full/pics/zoommore.png" alt="Ampliar zoom na página"/></span>
            <span class="rotateicon" ><img src="<%=base%>flip/jornal/skins/html5full/pics/rotate.png" alt="Rotaciona a página"/></span>
            <span class="texticon" ><img src="<%=base%>flip/jornal/skins/html5full/pics/text.png" alt="Seleciona texto"/></span>
            <span class="closeicon"><img src="<%=base%>flip/jornal/skins/html5full/pics/close.png" alta="Fechar modo de zoom"/></span>

        </div>
    </div>             

    <script type="text/javascript">
        function loadApp() {                                                               
            $('#all').fadeIn(2000);	
            $(".zoomtools").hide();
            $('.magazine').turn({                        
                elevation: 50,		
                acceleration: !isChrome(),
                gradients: false,
                keyboard:false,
                autoCenter: true,
                pages: <c:out value='${paginas}'/>,
                when: {
                    turning: function(event, page, view) {				
                        var book = $(this),
                        currentPage = book.turn('page'),
                        pages = book.turn('pages');	
                        // Update the current URI
                        Hash.go('page/' + page).update();
                        disableControls(page);				
                        /*$('.thumbnails .page-'+currentPage).parent().removeClass('current');
                        $('.thumbnails .page-'+page).parent().addClass('current');                    */
                        playsound();
                    },
                    turned: function(event, page, view) {
                        disableControls(page);
                        $(this).turn('center');
                        if (page==1) { 
                            $(this).turn('peel', 'br');
                        }
                    },
                    missing: function (event, pages) {	                                                
                        for (var i = 0; i < pages.length; i++){
                            addPage(pages[i], $(this));
                        }
                    }
                }

            });                                        
                              
            Hash.on('^page\/([0-9]*)$', {
                yep: function(path, parts) {
                    var page = parts[1];
                    if (page!==undefined) {
                        if ($('.magazine').turn('is'))
                            $('.magazine').turn('page', page);
                    }
                },
                nop: function(path) {
                    if ($('.magazine').turn('is'))
                        $('.magazine').turn('page', 1);
                }
            });
            $(window).resize(function() {                                                                
                resizeViewport();
                
            }).bind('orientationchange', function() {                                        
                resizeViewport();                
            });
                                                         
            //$('.page').bind('mousewheel', wheelFunction);
                    
           /* if ($.isTouch) {
                $('.magazine').bind('touchstart', regionClick);
            } else {
                $('.magazine').click(regionClick);
            }*/                       
            $('.next-button').bind($.mouseEvents.over, function() {	
                $(this).addClass('next-button-hover');

            }).bind($.mouseEvents.out, function() {
		
                $(this).removeClass('next-button-hover');

            }).bind($.mouseEvents.down, function() {
		
                $(this).addClass('next-button-down');

            }).bind($.mouseEvents.up, function() {
		
                $(this).removeClass('next-button-down');

            }).click(function() {
		
                jQuery('.multimidia_next').click();

            });

            // Events for the next button
	
            $('.previous-button').bind($.mouseEvents.over, function() {
		
                $(this).addClass('previous-button-hover');

            }).bind($.mouseEvents.out, function() {
		
                $(this).removeClass('previous-button-hover');

            }).bind($.mouseEvents.down, function() {	
                $(this).addClass('previous-button-down');
            }).bind($.mouseEvents.up, function() {		
                $(this).removeClass('previous-button-down');
            }).click(function() {	
                jQuery('.multimidia_prev').click();
            });
            resizeViewport();
            //$('.magazine').addClass('animated').addClass('zoom-out');            
            jQuery('#all').hide();
            //jQuery("#loading").hide();
        }                                        
        yepnope({
            test : Modernizr.csstransforms,
            yep: ['<%= base%>flip/jornal/skins/html5full/lib/turn.min.js'],
            nope: ['<%= base%>flip/jornal/skins/html5full/lib/turn.html4.min.js'],            
            complete: function(){                
                jQuery(document).ready(function(){                   
                    setTimeout(loadApp,100);                                         
                });
            }                    
        });

    </script>

    <jsp:include page="../common/windowBanner.jsp" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
    </jsp:include>
    <jsp:include page="../common/sideBanner.jsp" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
    </jsp:include>

    <c:if test="${!empty MESSAGE}">
        <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>'); </script>
        <%session.removeAttribute("MESSAGE");%>
    </c:if>
    <c:if test="${!empty logado && logado eq 'true' && !empty username && DEMO ne 'S' && username ne 'DEMO'}">
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