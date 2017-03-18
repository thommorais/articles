<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = request.getParameter("base");
            String edicaoId = "" + request.getAttribute("edicaoId");
            session.setAttribute("myLink",request.getRequestURL());            
%>

<script type="text/javascript">
    var index = 0, indexmedia = 0, indexpic = 0, indextemplinks = 0;
    var pageslist = new Array();
    var pfmedias = new Array();
    var pfmediaspics = new Array();
    var pftemplinks = new Array();
    var iconVideo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.iconVideo}"/>;

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
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar || page.flipModeloPublicacaoidid_modelo.prefs.modoTexto || page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
    <div id="share" class="modal modal-texto sharecontent">
        <div class="modal-bg"></div>
        <div class="padding"> <a class="btn-fechar" href="javascript:void(0);" onClick="fecharShare()"><i class="icon-remove"></i></a>
            <p class="titulo">COMPARTILHAR</p>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                <div class="share-this"> <span class='st_facebook_large' displayText='Facebook'></span> <span class='st_twitter_large' displayText='Tweet'></span> <span class='st_email_large' displayText='Email'></span> <span class='st_pinterest_large' displayText='Pinterest'></span> <span class='st_linkedin_large' displayText='LinkedIn'></span> <span class='st_googleplus_large' displayText='Google +'></span> </div>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar || page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                <p class="titulo">EXPORTAR</p>
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
        <div class="padding" id="edicoescontent"> 

        </div>
    </div>
</c:if>                                
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">                                
    <div id="indice" class="modal modal-texto">
        <div class="modal-bg"></div>
        <div class="padding" id="indicecontent"> 

        </div>
    </div>
</c:if>

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">    
    <div id="paginas" class="modal modal-texto">
        <div class="modal-bg"></div>
        <div class="padding" id="paginascontent">                 
        </div>    
    </div>
</c:if>    

<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
    <div id="exportar" class="modal modal-texto">
        <div class="modal-bg"></div>
        <div class="padding" id="exportarcontent"> 

        </div>       
        <!-- end .padding--> 
    </div>
</c:if>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">                                
    <div id="pesquisa" class="modal modal-texto pesquisacontent" style="display:none;">

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
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">        
    <header id="header" class="bg-geral">
        <div class="icones-esquerda">
            <ul>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
                    <li><a id="btn-todas-edicoes" class="btn" href="javascript:void(0);" onClick="abrirTodasEdicoes()"><i class="icon-book"></i></a></li>
                    <li class="separador"></li>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">    
                    <li><a id="btn-indice" class="btn" href="javascript:void(0);" onClick="abrirIndice();"><i class="icon-list-ul"></i></a></li>
                    <li class="separador"></li>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">    
                    <li><a id="btn-paginas" class="btn" href="javascript:void(0);" onClick="abrirPaginas()"><i class="icon-th-large"></i></a></li>
                    <li class="separador"></li>
                </c:if>
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
            <c:out value="${dataEdicao}"/>
        </div>
        <div class="icones-direita">
            <ul>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas && page.visitas > 0}">
                    <li class="views cor-disabled" title="<fmt:message key='site.visitas'/>"><a class="btn" href="javascript:void(0)"><span><c:out value="${page.visitas}"/></span><i class="icon-eye-open"></i></a></li>
                    <li class="separador"></li>
                </c:if>
                <li><a id="btn-fullscreen" class="btn" href="javascript:void(0);" title="Fullscreen" onclick="openFullScreen();"><i class="icon-fullscreen"></i></a></li>    
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">    
                    <li><a id="btn-pesquisa" class="btn" href="javascript:void(0);" title="<fmt:message key='site.procurar'/>" onclick="abrirPesquisa();"><i class="icon-search"></i></a></li>
                    <li class="separador"></li>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">    
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                        <li class="comentarios"><a id="btn-comentar" class="btn" href="javascript:void(0);" onclick="abrirComentar();"><i class="icon-comment"></i><span id="comment_count">0</span></a></li>
                        <li class="separador"></li>
                    </c:if>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar || page.flipModeloPublicacaoidid_modelo.prefs.modoTexto || page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                    <li><a id="btn-exportar" class="btn" href="javascript:void(0);" onclick="abrirShare();"><i class="icon-share"></i></a></li>
                    <li class="separador"></li>
                </c:if>
            </ul>
        </div>
    </header>
</c:if>
                    <div id="fullscreenid" style="background-color:white">
<section id="content">

    <c:choose>
        <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.tema}">
            <div id="background" style="background-color:green">            
                <img src="<%= br.com.maven.flip.Environment.SITE%>flip/jornal/skins/king/img/temas/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.tema}'/>/fundo.jpg" class="stretch" alt="" />            
            </div>        
        </c:when>
        <c:otherwise>                    
            <c:if test="${!empty KEY_BACKGROUND && !KEY_BACKGROUND.repetirX && !KEY_BACKGROUND.repetirY}">
                <div id="background" <c:if test="${!empty KEY_BACKGROUND.corFundo}">style="background-color:#<c:out value='${KEY_BACKGROUND.corFundo}'/>"</c:if>>
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

        <div id="flip">
            <div id="jornal">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.effects && page.flipModeloPublicacaoidid_modelo.prefs.effects eq 'daynight'}">
                    <div id="sky"></div><div id="sun_yellow"></div><div id="sun_red"></div><div id="clouds"></div><div id="ground"></div><div id="night"></div><div id="stars"></div>        <div id="sstar"></div><div id="moon"></div>   
                </c:if>                       
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.recomendaFacebook}">
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
                <div id="megazine">
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
            <span class="zoomless" ><img src="<%=base%>flip/jornal/skins/html5full/pics/zoomless.png" ></span>
            <span class="zoommore" ><img src="<%=base%>flip/jornal/skins/html5full/pics/zoommore.png" ></span>            
            <span class="closeicon"><img src="<%=base%>flip/jornal/skins/html5full/pics/close.png"></span>
        </div>
    </div>             
    <script type="text/javascript">
        function loadApp() {
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
                    },
                    turned: function (event, page, view) {
                        disableControls(page);
                         <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.alinhamentoZoom eq 'true' && empty page.prepage.banner && empty page.postpage.banner}">
                          jQuery(this).turn('center');
                         </c:if>
                        // if (page==1) {
                        // jQuery(this).turn('peel', 'br');
                        //}
                    },
                    missing: function (event, pages) {
                        for (var i = 0; i<pages.length; i++){
                            addPage(pages[i], jQuery(this));
                        }
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
                        if (scale==1){
                            loadSmallPage(page, pageElement);
                        }else{
                            loadLargePage(page, pageElement);
                        }
                    },
                    zoomIn: function () {
                        if (flipenabled==false) {
                            checkLogged();
                        } else {
                            zoommode = true;
                            executeListener('ZOOM_IN_PAGE');
                            jQuery('.linkimg').hide();
                            jQuery('.thumbnails').hide();
                            jQuery('.made').hide();
                            if (jQuery("#banner_lateral")) {
                                jQuery("#banner_lateral").hide();
                            }
                             if (jQuery("#s2bannerdiv")) {
                                jQuery("#s2bannerdiv").hide();
                            }
                            
                            jQuery("#top").hide();
                            jQuery("#tab_left").hide();
                            jQuery(".zoomtools").show();
                            jQuery('.magazine').removeClass('zoom-out').addClass('zoom-in');
                            calculaAlturaZoom();
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
                        jQuery('.esc').hide();
                        jQuery('.thumbnails').fadeIn();
                        jQuery('.made').fadeIn();
                        if (jQuery("#banner_lateral")) {
                            jQuery("#banner_lateral").fadeIn();
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
            jQuery('.page').bind('mousewheel', wheelFunction);
            jQuery('.magazine').click(regionClick);
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
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
            reload_comments();
            </c:if>
        }
        jQuery('#all').hide();
        yepnope({
            test: Modernizr.csstransforms,
            yep: ['<%= base %>flip/jornal/skins/html5full/lib/turn.min.js'],
            nope: ['<%= base %>flip/jornal/skins/html5full/lib/turn.html4.min.js'],
            both: ['<%= base %>flip/jornal/skins/html5full/lib/zoom.min.js'],
            complete: function () {
                jQuery(document).ready(function () {
                    
                    setTimeout(loadApp, 100);
                });
            }
        });</script>
            </div>
            </div>                        
        </div>        
    </article>
</section>
<footer id="footer">
    <ul class="paginacao bg-geral">
        <li><a class="btn duplo multimidia_fr" href="#"><i class="primeiro icon-chevron-left"></i><i class="segundo icon-chevron-left"></i></a></li>
        <li><a class="btn multimidia_prev" href="#"><i class="icon-chevron-left"></i></a></li>
        <li>
            <input type="text" name="" id="" value="1" maxlength="5" class="multimidia_textfield" />
        </li>
        <li><a class="btn multimidia_next" href="#"><i class="icon-chevron-right"></i></a></li>
        <li><a class="btn duplo multimidia_ff" href="#"><i class="primeiro icon-chevron-right"></i><i class="segundo icon-chevron-right"></i></a></li>
    </ul>
    <c:if test="${!empty logado && logado eq 'true' && !empty username && username ne 'DEMO'}">
        <ul class="sair bg-geral">
            <li>          
            <c:choose>
                <c:when test="${!empty sessionScope['backlink']}">
                    <a class="btn btn-sair" href="<%= base%><c:out value='${backlink}'/>"><i class="icon-signout"></i><span class="sair"><fmt:message key="site.logout"/></span></a>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-sair" href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>login.jsp"><i class="icon-signout"></i><span class="sair"><fmt:message key="site.logout"/></span></a>                
                </c:otherwise>
            </c:choose>
            </li>
        </ul>
    </c:if>  
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.logomaven}">            
        <a href="http://www.maven.com.br/#produtos" target="_blank" class="logo-maven" alt="<fmt:message key='site.conheca'/>" title="<fmt:message key='site.conheca'/>"></a> 
    </c:if>
</footer>
</div>
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