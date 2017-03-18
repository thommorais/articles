<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = request.getParameter("base");
    String edicaoId = "" + request.getAttribute("edicaoId");
    StringBuffer url=request.getRequestURL();    
    session.setAttribute("myLink",url);
    
%>
<script type="text/javascript">    
    var index=0;
    
    var pageslist=new Array();                
        <c:forEach var="pag" items="${paginaslist}" varStatus="i">
        pageslist[index++]=["<c:out value='${pag.id}'/>","<c:out value='${pag.pathImage}'/>","<c:out value='${pag.pathNormal}'/>","<c:out value='${pag.pathThumb}'/>"]
        </c:forEach>
</script>    

<div id="multimidia">
    <div id="multimidia_left">   
        <c:if test="${empty param.versao}">
            <div style="float:left;valign:middle;">                            
                <input type="text" name="campoPesquisa" id="campoPesquisa" style="width:130px;height:16px;" placeholder="  Pesquisar na edição"/>
            </div>
            <div style="float:left;valign:middle;margin-top:2px">
                <img src="<%= base %>flip/jornal/skins/html5/pics/buttonPesquisa.png" class="buttonPesquisa" height="19px" alt="Clique para pesquisa" title="Clique para pesquisar"/>
            </div>
        </c:if>
    </div>

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
    <div id="multimidia_right">
        <c:choose>
            <c:when test="${!empty param.versao}">            
        <div style="float:left;margin-right: 10px;margin-top:2px;">
            <img src="<%= base %>flip/jornal/skins/html5/pics/archive.png" class="edicoes" height="21px" alt="Clique para ver edições" title="Clique para ver edições"/>
        </div>                   
        <div style="float:left;margin-right: 10px;margin-top:2px;">
            <img src="<%= base %>flip/jornal/skins/html5/pics/print.png" class="imprimir" height="21px" alt="Clique para imprimir" title="Clique para imprimir"/>
        </div>            
        <div style="float:left;margin-right: 10px;margin-top:2px;">
            <img src="<%= base %>flip/jornal/skins/html5/pics/search.png"  class="procurar" height="21px" alt="Clique para pesquisar" title="Clique para pesquisar"/>
        </div>            
        </c:when>
        <c:when test="${!empty param.embed}">            
            <div style="float:left;margin-right: 10px;margin-top:2px;">
            <img src="<%= base %>flip/jornal/skins/html5/pics/icon-fullscreen.png" class="telacheia" height="21px" title="Clique para abrir a versão completa"/>
        </div>                    
        </c:when>
            <c:otherwise>                
        <div style="float:left;margin-right: 10px;margin-top:2px;">
            <img src="<%= base %>flip/jornal/skins/html5/pics/print2.png" class="imprimir" height="21px" alt="Clique para imprimir" title="Clique para imprimir"/>
        </div>                    
            </c:otherwise>
        </c:choose>
        
    </div>
</div>

<div class="magazine-viewport" id="megazine">
    <div class="container">
        <div class="magazine">            
            <div ignore="1" class="next-button"></div>            
            <div ignore="1" class="previous-button"></div>
        </div>
    </div>
</div>

<div class="thumbnails">
    <div>
        <ul>
            <c:forEach var="pag" items="${paginaslist}" varStatus="i">
                <c:choose>
                    <c:when test="${i.index ==0 || i.index==paginas-1}">
                        <c:choose>
                            <c:when test="${i.index == 0 || i.index%2!=0}">
                                <li class="i">
                                <img src="<%= base %><c:out value='${pag.pathThumb}'/>" width="76" height="100" class="page-<c:out value="${i.index+1}"/>" id="<c:out value="${pag.id}"/>">
                                <span><c:out value="${i.index+1}"/></span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <img src="<%= base %><c:out value='${pag.pathThumb}'/>" width="76" height="100" class="page-<c:out value="${i.index+1}"/>" id="<c:out value="${pag.id}"/>">
                                <span><c:out value="${i.index}"/>-<c:out value="${i.index+1}"/></span>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${i.index%2!=0}">
                                <li class="d">
                                <img src="<%= base %><c:out value='${pag.pathThumb}'/>" width="76" height="100" class="page-<c:out value="${i.index+1}"/>" id="<c:out value="${pag.id}"/>">                                
                            </c:when>
                            <c:otherwise>
                                <img src="<%= base %><c:out value='${pag.pathThumb}'/>" width="76" height="100" class="page-<c:out value="${i.index+1}"/>" id="<c:out value="${pag.id}"/>">
                                <span><c:out value="${i.index}"/>-<c:out value="${i.index+1}"/></span>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>                        
            </c:forEach>
        </ul>
    </div>	
</div>       




<script type="text/javascript">
    function loadApp() {
        $('#all').fadeIn(1000);	
        $('.magazine').turn({
            width: 922,
            height: 600,
            elevation: 50,		
            acceleration: !isChrome(),
            gradients: true,
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
                    $('.thumbnails .page-'+currentPage).
                        parent().
                        removeClass('current');
                    $('.thumbnails .page-'+page).parent().addClass('current');                    
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
                    for (var i = 0; i < pages.length; i++)
                        addPage(pages[i], $(this));

                }
            }

        });

        $('.magazine-viewport').zoom({
            flipbook: $('.magazine'),
            max: function() { 			
                return largeMagazineWidth()/$('.magazine').width();
            }, 
            when: {
                tap: function(event) {
                    if ($(this).zoom('value')==1) {
                        $('.magazine').
                            removeClass('animated').
                            addClass('zoom-in');
                        $(this).zoom('zoomIn', event);
                    } else {
                        $(this).zoom('zoomOut');
                    }
                },

                resize: function(event, scale, page, pageElement) {
                    if (scale==1)
                        loadSmallPage(page, pageElement);
                    else
                        loadLargePage(page, pageElement);
                },

                zoomIn: function () {				
                    $('.thumbnails').hide();
                    $('.made').hide();
                    $('.magazine').addClass('zoom-in');

                    if (!window.escTip && !$.isTouch) {
                        escTip = true;

                        $('<div />', {'class': 'esc'}).
                            html('<div>ESC para fechar</div>').
                            appendTo($('body')).
                            delay(2000).
                            animate({opacity:0}, 500, function() {
                            $(this).remove();
                        });
                    }
                },

                zoomOut: function () {
                    $('.esc').hide();
                    $('.thumbnails').fadeIn();
                    $('.made').fadeIn();
                    setTimeout(function(){
                        $('.magazine').addClass('animated').removeClass('zoom-in');
                        resizeViewport();
                    }, 0);

                },
                swipeLeft: function() {
                    $('.magazine').turn('next');
                },

                swipeRight: function() {			
                    $('.magazine').turn('previous');
                }
            }
        });	
        $(document).keydown(function(e){
            var previous = 37, next = 39, esc = 27;
            switch (e.keyCode) {
                case previous:
                    $('.magazine').turn('previous');
                    e.preventDefault();

                    break;
                case next:
                    $('.magazine').turn('next');
                    e.preventDefault();

                    break;
                case esc:				
                    $('.magazine-viewport').zoom('zoomOut');	
                    e.preventDefault();

                    break;
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
        $('.thumbnails').click(function(event) {		
            var page;
            if (event.target && (page=/page-([0-9]+)/.exec($(event.target).attr('class'))) ) {		
                $('.magazine').turn('page', page[1]);
            }
        });
        $('.thumbnails li').
            bind($.mouseEvents.over, function() {			
            $(this).addClass('thumb-hover');
        }).bind($.mouseEvents.out, function() {			
            $(this).removeClass('thumb-hover');
        });
        if ($.isTouch) {	
            $('.thumbnails').
                addClass('thumbanils-touch').
                bind($.mouseEvents.move, function(event) {
                event.preventDefault();
            });
        } else {
            $('.thumbnails ul').mouseover(function() {
                $('.thumbnails').addClass('thumbnails-hover');
            }).mousedown(function() {
                return false;
            }).mouseout(function() {
                $('.thumbnails').removeClass('thumbnails-hover');
            });
        }
        if ($.isTouch) {
            $('.magazine').bind('touchstart', regionClick);
        } else {
            $('.magazine').click(regionClick);
        }                       
        $('.next-button').bind($.mouseEvents.over, function() {
		
            $(this).addClass('next-button-hover');

        }).bind($.mouseEvents.out, function() {
		
            $(this).removeClass('next-button-hover');

        }).bind($.mouseEvents.down, function() {
		
            $(this).addClass('next-button-down');

        }).bind($.mouseEvents.up, function() {
		
            $(this).removeClass('next-button-down');

        }).click(function() {
		
            $('.magazine').turn('next');

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
		
            $('.magazine').turn('previous');

        });
        resizeViewport();
        $('.magazine').addClass('animated');
    }
    $('#all').hide();    
</script>

<script type="text/javascript">
    function loadXmlData(){
        try{                            
            swfobject.embedSWF("<%= base%>flip/jornal/player/mavenflip.swf",
            "megazine",
            "100%",
            "86%",
            "9.0.115",
            "<%= base%>flip/jornal/swfobject/expressInstall.swf",
            {
                xmlFile : "<%= base%>flip/jornal/megazinedata.jsp?ed=<c:out value='${HASH_MZ_KEY_REQ}'/>&c=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}'/>",        
                top: "0"
            },
            {
                wmode : "transparent",
                allowFullscreen : "true",
                bgColor : "#333333",
                allowscriptaccess:"always"
            },
            {id : "megazineScript"},
            function(e){                   
                if (!e.success){                    
                    flash=false;                    
                    jQuery(".thumbnails").show();
                    yepnope({
                        test : Modernizr.csstransforms,
                        yep: ['<%= base %>flip/jornal/skins/html5/lib/turn.min.js'],
                        nope: ['<%= base %>flip/jornal/skins/html5/lib/turn.html4.min.js'],
                        both: ['<%= base %>flip/jornal/skins/html5/lib/zoom.min.js'],
                        complete: loadApp
                    });
                }else{
                    flash=true;                    
                    jQuery(".thumbnails").hide(); 
                    atualizaPesquisa();
                }
            }
        );
        }catch(ex){            
            alert(ex);
        }
    }    
    $(document).ready(function(){
        jQuery(".thumbnails").hide();        
        loadXmlData();
        
                    jQuery('.telacheia').click(function (e) {      
                window.open(base+linkedicao+'?numero='+getCurrentEditionNumber());
            });
            jQuery('.buttonPesquisa').click(function (e) {
                    pesquisaUnique($("#campoPesquisa").val());
            });   
            jQuery('#campoPesquisa').keyup(function(e){
                if(e.keyCode == 13) {
                    jQuery('.buttonPesquisa').click();
                }
            });
            function selectcurrentword(){    
                if(currentKeyword != null && currentKeyword != ""){                
                    //jQuery("#keywordbody").val(currentKeyword);
                    //jQuery("#searchinstant").slideDown("slow");                        
                    jQuery("#campoPesquisa").val(currentKeyword);
                    MegaZine.searchWord(currentKeyword);
                    currentKeyword=null;
                }
            }

            function pesquisaUnique(keyword){    
                if(keyword.length < 4 ){
                    alert('Deve informar uma palavra com pelo menos 4 caracteres');        
                }else{        
                    jQuery("#campoPesquisa").val(keyword);
                    var url=getSearchLinkUnique(keyword);
                    jQuery.fn.modalBox({
                        setWidthOfModalLayer : 500,
                        positionTop : "20",
                        directCall : {
                            source : url
                        }
                    });
                    _gaq.push(['_trackEvent', 'Flip', 'Pesquisa', 'Pesquisa por '+keyword]);
                }
            }
            function getSearchLinkUnique(keywords){
                var pageAnchor=getCurrentEdition();
                var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo=false&apenasEssa=true&keywords='+keywords+'&search=true&edicao='+getCurrentEdition();
                url=url+'&linkedicao='+linkedicao;    
                return url;
            }
        
        
    });
    
</script>

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
