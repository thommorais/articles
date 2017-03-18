var isIE = navigator.appVersion.indexOf('MSIE')>0;
var isMozilla = document.getElementById&&!isIE;
var isNetscape4 = document.layers ? true : false;
var data = null;
var grau = 90;
var lado1 = false;
var zoomenabled = true;
var zoommode = false;
var scrollenabled = true;
var paginaInteira = false;
var selectTextMode = false;
var pageNumber = 1;
var magazinewidth = 0;
var searchResult = null;
var startTime = new Date().getTime();
var lastPageTracking = 0;

function trackTimePage(pagina) {
    lastPageTracking = pagina;
    var endTime = new Date().getTime();
    var timeSpent = endTime-startTime;
    var hourInMillis = 1000*60*60;
    if (0<timeSpent&&timeSpent<hourInMillis) {
        startTime = new Date().getTime();
        if (_gaq) {
            _gaq.push([gaPrefix+'_trackTiming', linkedicao, 'Ed'+getCurrentEdition(), timeSpent, 'Pagina'+lastPageTracking, 100]);
            if (gaPrefix!=''&&typeof ga!=='undefined') {
                ga.send('timing', linkedicao, 'Ed'+getCurrentEdition(), timeSpent, 'Pagina'+lastPageTracking, 100);
            }
        }
    }
}


function extractDelta(e) {
    if (e.wheelDelta) {
        return e.wheelDelta;
    }
    if (e.originalEvent.detail) {
        return e.originalEvent.detail*-40;
    }
    if (e.originalEvent&&e.originalEvent.wheelDelta) {
        return e.originalEvent.wheelDelta;
    }
}
var wheelFunction = function (e) {
    if (scrollenabled==true&&selectTextMode==false) {
        var delta = extractDelta(e);
        if (pageWheel==true&&zoommode==false) {
            if (delta/120>0) {
                setTimeout(function () {
                    jQuery('.multimidia_prev').click();
                }, 200);
            } else {
                setTimeout(function () {
                    jQuery('.multimidia_next').click();
                }, 200);
            }
            if (e.preventDefault) { /* Chrome, Safari, Firefox */
                e.preventDefault();
            }
        } else {
            if (zoommode==true) {
                disabledEventPropagation(e);
                if (delta/120>0) {
                    setTimeout(function () {
                        jQuery(".zoommore").click();
                    }, 50);

                } else {
                    setTimeout(function () {
                        jQuery(".zoomless").click();
                    }, 50);
                }
            }
        }
    }
    return false;
};
//jQuery('.speed').hide();           
var previous = 37, next = 39, esc = 27;
teclas = function (e) {
    var source = e.target||e.srcElement;
    switch (e.keyCode) {
        case previous:
            if (jQuery(source).is("input")==false&&flipenabled==true) {
                jQuery('.multimidia_prev').click();
                break;
            }
        case next:
            if (jQuery(source).is("input")==false&&flipenabled==true) {
                jQuery('.multimidia_next').click();
                break;
            }
        case esc:
            if (jQuery(source).is("input")==false) {
                jQuery('.magazine-viewport').zoom('zoomOut');
                break;
            }
    }
};
function calculaAlturaZoom() {
    var height = jQuery(window).height();
    height = height-(fullscreen==true ? 0 : 50);
    var newx = (doc_x*height)/doc_y;
    jQuery(".magazine-viewport").css("height", height+"px");
    jQuery(".magazine-viewport .magazine").css("height", height+"px");
    jQuery(".magazine-viewport .magazine").css("width", newx*2+"px");
    if (jQuery("iframe.framepageimg")) {
        jQuery("iframe.framepageimg").css("height", height+"px");
        jQuery("iframe.framepageimg").parent().css("position", "absolute").css("top", "180px");
    }
    //calc = false;    
}
var calc = false;
var fullscreen = false;
function calculaAltura() {
    if (calc===false) {
        var height = jQuery(window).height();
        height = height-(fullscreen==true ? 30 : 80);
        if (parseInt(doc_x)>parseInt(doc_y)) {
            height = height-200;
        }
        var newx = (doc_x*height)/doc_y;
        var top = height/2;
        jQuery(".magazine-viewport").css("height", height+"px");
        jQuery(".magazine-viewport .magazine").css("height", height+"px");
        jQuery(".magazine-viewport .magazine").css("width", newx*2+"px");
        jQuery(".magazine-viewport .container").css("top", top+"px");
        calc = true;
    }
    if (jQuery("iframe.framepageimg")) {
        jQuery("iframe.framepageimg").css("height", "100%");
        jQuery("iframe.framepageimg").parent().css("position", "").css("top", "");
    }
}

function onOrientationChanged() {
    setTimeout(function () {
        //console.log('orientation - '+fullscreen);
        calc = false;
        calculaAltura();
        resizeViewport();
    }, 200);
}

function loadMagazineApp() {
    jQuery.ajaxSetup({
        async: false
    });
    calculaAltura();
    jQuery(window).bind('orientationchange', function (e, onready) {
        onOrientationChanged();
    });
    jQuery(document).on('webkitfullscreenchange mozfullscreenchange fullscreenchange MSFullscreenChange', function () {
        fullscreen = !fullscreen;
    });
    jQuery(window).bind('resize', function (e, onready) {
        onOrientationChanged();
    });
    jQuery('.imprimir').click(function (e) {
        if (flipenabled==false) {
            checkLogged();
        }
        if (flipenabled==true) {
            scrollenabled = false;
            jQuery.fn.modalBox({
                directCall: {
                    source: getPrintLink()
                }
            });
        }
        return false;
    });
    jQuery('.procurar').click(function (e) {
        if (flipenabled==false) {
            checkLogged();
        }
        if (flipenabled==true) {
            scrollenabled = false;
            jQuery.fn.modalBox({
                setWidthOfModalLayer: 600,
                positionTop: "20",
                directCall: {
                    source: getSearchLink()
                }
            });
        }
        return false;
    });
    jQuery('#basic-modal .recomendar').click(function (e) {
        scrollenabled = false;
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 600,
            directCall: {
                source: getRecommentLink()
            }
        });
        return false;
    });
    jQuery('#basic-modal .comentar').click(function (e) {
        openCommentMode();
        return false;
    });
    jQuery('#basic-modal .contato').click(function (e) {
        openContactMode();
        return false;
    });
    jQuery('#basic-modal .texto').click(function (e) {
        if (flipenabled==false) {
            checkLogged();
        }
        if (flipenabled==true) {
            jQuery.getScript(base+'flip/jornal/skins/king/js/jquery.copy.min.js');
            scrollenabled = false;
            jQuery.fn.modalBox({
                setWidthOfModalLayer: 680,
                directCall: {
                    source: getTextLink()
                }
            });
        }
        return false;
    });
    jQuery('#basic-modal .pdf').click(function (e) {
        if (flipenabled==false) {
            checkLogged();
        }
        if (flipenabled==true) {
            var id = this.id;
            getPDFLink(id);
        }
        return false;
    });
    jQuery('#basic-modal .basic').click(function (e) {
        jQuery('#basic-modal-content').modal();
        return false;
    });
    jQuery('.menu_home').click(function () {
        window.location.href = base+linkedicao;
    });
    jQuery('.multimidia_fr').click(function () {
        jQuery(".magazine").turn("page", 1);
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Primeira Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    jQuery('.multimidia_prev').click(function () {
        jQuery('.magazine').turn('previous');
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Retornou Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    jQuery('.multimidia_next').click(function () {
        jQuery('.magazine').turn('next');
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Avancou Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    jQuery('.multimidia_ff').click(function () {
        var amount = jQuery(".magazine").turn("pages");
        jQuery(".magazine").turn("page", amount);
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Ultima Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    jQuery('.multimidia_textfield').focus(function () {
        toogleTextField();
    });
    jQuery('.multimidia_textfield').blur(function () {
        updatePageChange();
        editingText = '';
    });
    jQuery('.multimidia_textfield').keyup(function (e) {
        if (e.keyCode==13) {
            toogleTextField();
        }
    });
    jQuery(".zoomless").click(function (e) {
        setTimeout(function () {
            if (jQuery('.zoomless img').attr('src').indexOf("disabled")==-1) {
                var zoom = jQuery(".magazine").turn("zoom");
                if (zoom>3) {
                    jQuery(".magazine").turn("zoom", zoom-1);
                    resizeViewport();
                    jQuery(".magazine-viewport").css("height", jQuery(this).height()+"px");

                    //if (jQuery('.rotateicon img').attr('src').indexOf('disabled')==-1) {
//                        jQuery('.rotateicon img').attr('src', jQuery('.rotateicon img').attr('src').replace('.png', '_disabled.png'));
                    //                  }
                    //                if (jQuery('.texticon img').length) {
                    //                  if (jQuery('.texticon img').attr('src').indexOf('removed')==-1) {
                    //                    jQuery('.texticon img').attr('src', jQuery('.texticon img').attr('src').replace('.png', '_removed.png'));
                    //              }
                    //        }
                } else {
                    jQuery('.magazine-viewport').zoom('zoomOut');
                }
                /*if (zoom<=4) {
                 if (jQuery('.rotateicon img').attr('src').indexOf('disabled')!=-1) {
                 jQuery('.rotateicon img').attr('src', jQuery('.rotateicon img').attr('src').replace('_disabled.png', '.png'));
                 }
                 if (jQuery('.texticon img').length) {
                 if (jQuery('.texticon img').attr('src').indexOf('removed')!=-1) {
                 jQuery('.texticon img').attr('src', jQuery('.texticon img').attr('src').replace('_removed.png', '.png'));
                 }
                 }
                 }*/
            }
        }, 100);
    });
    jQuery(".zoommore").click(function (e) {
        if (jQuery('.zoommore img').attr('src').indexOf("disabled")==-1) {

            if (flipenabled==false) {
                checkLogged();
            }
            if (flipenabled==true) {
                setTimeout(function () {
                    var zoom = jQuery(".magazine").turn("zoom");
                    jQuery(".magazine").turn("zoom", zoom+1);
                    resizeViewport();
                    jQuery(".magazine-viewport").css("height", jQuery(this).height()+"px");

                    /*if (jQuery('.rotateicon img').attr('src').indexOf('disabled')==-1) {
                     jQuery('.rotateicon img').attr('src', jQuery('.rotateicon img').attr('src').replace('.png', '_disabled.png'));
                     }
                     if (jQuery('.texticon img').length) {
                     if (jQuery('.texticon img').attr('src').indexOf('removed')==-1) {
                     jQuery('.texticon img').attr('src', jQuery('.texticon img').attr('src').replace('.png', '_removed.png'));
                     }
                     }*/
                }, 100);
            }
        }
    });

    /*jQuery(".rotateicon").click(function (e) {
     if (jQuery('.rotateicon img').attr('src').indexOf("disabled")==-1) {
     grau = grau+90;
     jQuery(':focus').blur();
     setTimeout(function () {
     if (pageNumber>1) {
     if (grau==0||grau%360==0||grau%180==0) {
     if (magazinewidth>0) {
     jQuery(".magazine").css("width", magazinewidth);
     }
     jQuery(".pageimg").css("height", "100%").css("width", "100%");
     jQuery(".odd > .pageimg").css("bottom", "");
     jQuery(".odd > .pageimg").css("top", "");
     jQuery(".even > .pageimg").css("bottom", "");
     jQuery(".even > .pageimg").css("top", "");
     
     } else {
     magazinewidth = jQuery(".magazine").width();
     var newwidth = jQuery(".magazine").height()*2;
     newwidth = newwidth-360;
     
     jQuery(".magazine").css("width", newwidth+"px");
     jQuery(".pageimg").css("height", "80%").css("width", "auto");
     
     jQuery(".odd > .pageimg").css("bottom", "0px");
     jQuery(".even > .pageimg").css("top", "0px");
     
     }
     }
     jQuery(".zoom-in > .page-wrapper").rotate({
     animateTo: grau
     });
     
     lado1 = !lado1;
     }, 400);
     
     if (grau==0||grau%360==0) {
     if (jQuery('.zoomless img').attr('src').indexOf('disabled')!=-1) {
     jQuery('.zoomless img').attr('src', jQuery('.zoomless img').attr('src').replace('_disabled.png', '.png'));
     }
     if (jQuery('.zoommore img').attr('src').indexOf('disabled')!=-1) {
     jQuery('.zoommore img').attr('src', jQuery('.zoommore img').attr('src').replace('_disabled.png', '.png'));
     }
     } else {
     if (jQuery('.zoomless img').attr('src').indexOf('disabled')==-1) {
     jQuery('.zoomless img').attr('src', jQuery('.zoomless img').attr('src').replace('.png', '_disabled.png'));
     }
     if (jQuery('.zoommore img').attr('src').indexOf('disabled')==-1) {
     jQuery('.zoommore img').attr('src', jQuery('.zoommore img').attr('src').replace('.png', '_disabled.png'));
     }
     }
     
     
     }
     });*/
    jQuery(".closeicon").click(function (e) {
        jQuery('.magazine-viewport').zoom('zoomOut');
    });
    if (jQuery(".texticon").length) {
        jQuery(".texticon").click(function (e) {
            if (jQuery('.texticon img').attr('src').indexOf("removed")!=-1) {
                return;
            }
            if (jQuery('.texticon img').attr('src').indexOf("disabled")!=-1) {
                selectTextMode = false;
                jQuery("#multimidia").slideDown();
                jQuery(".magazine").turn("disable", false);
                cursorMove();
                jQuery(".zoomtools img").each(function () {
                    jQuery(this).attr('src', this.src.replace("_disabled.png", ".png"));
                });
                jQuery(".TEXTPAGE").remove();
                jQuery('.region').show();
            } else {
                selectTextMode = true;
                jQuery("#multimidia").hide();
                jQuery(".magazine").turn("disable", true);
                cursorTexto();
                var page = getCurrentPage();
                var anchor = getCurrentAnchor();
                var total = jQuery(".magazine").turn("pages");
                jQuery(".zoomtools img").each(function () {
                    if (jQuery(this).attr('src').indexOf("disabled")==-1) {
                        jQuery(this).attr('src', this.src.replace(".png", "_disabled.png"));
                    }
                });
                jQuery("#loading").show();
                setTimeout(function () {
                    showTextPage(page, anchor, 1);
                    if (page>1&&page<total) {
                        page++;
                        anchor = getPageAnchor(page);
                        showTextPage(page, anchor, 1);
                    }
                    setTimeout(function () {
                        jQuery("#loading").hide();
                    }, 6000);
                }, 1000);
                jQuery('.region').hide();
            }
        });
    }
    jQuery('.tooltip').click(function (e) {
        openCommentModeMarkup();
        return false;
    });
    shortcut.add("Ctrl+Right", function () {
        jQuery('.multimidia_ff').trigger("click");
    });
    shortcut.add("Ctrl+Left", function () {
        jQuery('.multimidia_fr').trigger("click");
    });
    shortcut.add("Ctrl+Alt+S", function () {
        if (flipenabled==false) {
            checkLogged();
        }
        if (flipenabled==true) {
            jQuery('.magazine-viewport').zoom('zoomIn');
            if (jQuery(".texticon").length) {
                setTimeout(function () {
                    jQuery(".texticon").click();
                }, 1500);
            }
        }
    });
    shortcut.add("Ctrl+K", function () {
        var amount = jQuery(".magazine").turn("pages");
        jQuery(".magazine").turn("page", amount);
        jQuery('.magazine-viewport').zoom('zoomIn');
    });
    shortcut.add("Ctrl+A", function () {
        jQuery('.magazine-viewport').zoom('zoomOut');
    });
    jQuery(window).mousewheel(wheelFunction);
    jQuery(window).keydown(teclas);
    if (soundEnabled==true&&(!isIE||IEV>=9)) {
        var soundbase = basestatic+'flip/jornal/player/snd/turn';
        for (var i = 0; i<5; i++) {
            var url = soundbase+i+'.mp3';
            jQuery("body").append("<audio src='"+url+"' id='turn"+(i+1)+"'/>");
        }
    }

    if (ipg!=null||typeof pg!=='undefined') {
        if (ipg!=null) {
            ipg = ipg.trim().replace("id", "");
            jQuery(document).ready(function () {
                setTimeout(function () {
                    gotoAnchor(ipg, true);
                }, 1500);
            });
        } else if (typeof pg!=='undefined') {
            if (pg!=null) {
                pg = pg.trim();
                if (parseInt(pg)%2!=0)
                    pg = pg-1;
                setTimeout(function () {
                    jQuery(".magazine").turn("page", pg)
                }, 500);
            }
        }
    }
}

function applyZoomOutListener() {
    jQuery('.zoom-out').click(function (event) {
        var origin = jQuery(event.target).attr('class');

        if (origin!=undefined&&(origin.indexOf("mejs")!=-1||origin.indexOf("audiopicture")!=-1||origin.indexOf("link")!=-1||origin.indexOf("video")!=-1||origin.indexOf("gallery")!=-1||origin.indexOf("icon")!=-1)) {
            return regionClick(event);
        } else {
            if (doubleClickZoom==false) {
                if (flipenabled==false) {
                    checkLogged();
                } else {
                    jQuery('.magazine').removeClass('animated').addClass('zoom-in');
                    jQuery('.magazine-viewport').zoom('zoomIn');

                }
            }
        }

    });
}

function showTextPage(page, anchor) {
    jQuery.post(base+'flip/jornal/jsp/getAllText.jsp?pagina='+anchor, function (data) {
        if (data.indexOf(";")!=-1) {
            var results = data.split(";");
            var imageWidth = $('div[page='+page+'] .pageimg').css('width');
            var imageHeight = $('div[page='+page+'] .pageimg').css('height');

            imageWidth = imageWidth.replace("px", "");
            imageHeight = imageHeight.replace("px", "");

            var divText = $('<div/>', {
                'class': 'TEXTPAGE',
                'id': 'TEXTPAGE'+page
            });
            $(divText).click(function (e) {
                disabledEventPropagation(e);
                return;
            });
            $(divText).dblclick(function (e) {
                disabledEventPropagation(e);
                return;
            });
            $(divText).css("position", "absolute").css("width", imageWidth).css("height", imageHeight).css("left", 0).css("top", 0).css("z-index", "9999999999999");
            for (var i = 0; i<results.length; i++) {
                var word = results[i].split(",");
                if (word!=undefined) {
                    x = parseInt(word[0]);
                    y = parseInt(word[1]);
                    w = parseInt(word[2]);
                    h = parseInt(word[3]);
                    px = parseInt(word[4]);
                    py = parseInt(word[5]);
                    if (x==0)
                        x = 10;
                    if (y==0)
                        y = 10;
                    var newx = parseFloat(imageWidth)/(100/px);
                    var newy = parseFloat(imageHeight)/(100/py);
                    var neww = (w*parseFloat(imageWidth))/word[6];
                    var newh = (h*parseFloat(imageHeight))/word[7];
                    var span = $('<span/>', {
                        'id': 'TEXT'+anchor+'.'+i,
                        'class': 'TEXTSELECTOR',
                        'text': word[8]
                    }); //.text(word[8]);                                                                        
                    $(span).css('width', Math.round(neww/imageWidth*100)+'%').css("height", Math.round(newh/imageHeight*100)+'%').css("left", Math.round(newx/imageWidth*100)+'%').css("top", Math.round(newy/imageHeight*100)+'%');
                    span.appendTo(divText);

                    $(span).mousedown(function (e) {
                        disabledEventPropagation(e);
                        return;
                    });
                    $(span).mouseup(function (e) {
                        disabledEventPropagation(e);
                        return;
                    });
                }
            }
            $('div[page='+page+']').append(divText);
        }
    });
}


function getRecommentLink() {
    var edition = getCurrentEdition();
    var url = getPagesLink('recomendacao')+'?idForm='+edition;
    return url;
}

function recomendaAmigo() {
    jQuery('#pagina_anchor').val(getCurrentAnchor());
    var frm = jQuery('#faleConoscoForm');

    var link = jQuery(location).attr('href');
    if (link.indexOf('?')==-1) {
        link = link+'?'
    } else {
        link = link+'&';
    }
    link = link+'ipg='+getCurrentAnchor();
    jQuery("#link").val(link);

    if (jQuery("#nomeId").val()=="") {
        alert("Informe o seu nome.");
        return false;
    }
    if (jQuery("#emailId").val()=="") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O seu email parece incorreto. Corrija-o.!");
            return false;
        }
    }
    if (jQuery("#para1").val()==""&&jQuery("#para2").val()==""&&jQuery("#para3").val()==""&&jQuery("#para4").val()=="") {
        alert("Você precisa informar o email de pelo menos um amigo.");
        return false;
    }
    if (jQuery("#para1").val()!=""&&!jQuery.validateEmail(jQuery("#para1").val())) {
        alert("O  email "+jQuery("#para1").val()+" parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if (jQuery("#para2").val()!=""&&!jQuery.validateEmail(jQuery("#para2").val())) {
        alert("O  email "+jQuery("#para2").val()+" parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if (jQuery("#para3").val()!=""&&!jQuery.validateEmail(jQuery("#para3").val())) {
        alert("O  email "+jQuery("#para3").val()+" parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if (jQuery("#para4").val()!=""&&!jQuery.validateEmail(jQuery("#para4").val())) {
        alert("O  email "+jQuery("#para4").val()+" parece incorreto. Corrija-o antes de enviar.");
        return false;
    }

    _gaq.push(['_trackEvent', document.title, 'Recomenda', 'Recomendação de '+jQuery("#emailId").val()]);
    var url = base+'flip/enviaEmailSites.do?'+frm.serialize();
    loading();

    jQuery.post(url, function (message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    return true;
}

function entraEmContato() {
    jQuery('#pagina_anchor').value = getCurrentAnchor();
    var frm = jQuery('#faleConoscoForm');

    if (jQuery("#nomeId").val()=="") {
        alert("Informe o seu nome.");
        return false;
    }
    if (jQuery("#emailId").val()=="") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("Informe um email válido!");
            return false;
        }
    }
    if (jQuery("#assunto").val()=="") {
        alert("Informe o assunto.");
        return false;
    }
    if (jQuery("#mensagem").val()=="") {
        alert("Informe a mensagem.");
        return false;
    }

    var url = base+'flip/enviaEmailSites.do?'+frm.serialize();
    loading();
    jQuery.post(url, function (message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    _gaq.push(['_trackEvent', document.title, 'Contato', 'Contato de '+jQuery("#emailId").val()]);

    return true;
}



function openContactMode() {
    var edition = getCurrentEdition();
    var url = getPagesLink('faleConosco')+'?idForm='+edition+'&modelo='+mid;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 600,
        directCall: {
            source: url
        }
    });
}

function register() {
    var frm = jQuery('#cadastroForm');

    if (validateForm(frm)) {
        var url = base+'flip/loginEdicao.do?'+frm.serialize();
        loading();
        jQuery.post(url, function (message) {
            jQuery.fn.modalBox({
                setWidthOfModalLayer: 300,
                directCall: {
                    data: message
                }
            });
        }, function (error) {
            jQuery.fn.modalBox({
                setWidthOfModalLayer: 300,
                directCall: {
                    data: error
                }
            });
        });
        return true;
    } else {
        return false;
    }
}
function openRegisterMode() {
    jQuery.fn.modalBox('close');
    setTimeout(function () {
        var url = getPagesLink('cadastro')+'?modelo='+mid;
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 1024,
            directCall: {
                source: url
            }
        });
    }, 1000);
}

function getTextLink() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('texto')+'?idForm='+pageAnchor;
    url = url+'&idEdicao='+pageEdition;
    return url;
}


function verifyBlockedPages(page) {
    if (zoomBlocked==true) {
        var anchor = getPageAnchor(page);
        var freePass = false;
        if (freePagesList.length>0) {
            for (var i = 0; i<freePagesList.length; i++) {
                if (freePagesList[i]==anchor) {
                    freePass = true;
                    break;
                }
            }
        }
        if (freePass==false) {
            jQuery('.megazine').hide();
            verifyOnlineMode();
            return false;
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function refreshPage() {
    var anchor = getCurrentAnchor();
    var link = base+'pub/'+folder+'/?ipg='+anchor;
    window.location.href = link;
}

function verifyOnlineMode() {
    //if(!online){
    jQuery('.megazine').hide();
    var link = "login.jsp?edicao="+getCurrentEdition();
    window.location.href = link;
//}
}


function ajaxRegisterZoom() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    document.frm.idForm.value = pageAnchor;
    document.frm.idEdicao.value = pageEdition;
    if (pageAnchor!=null) {
        var trackzoom = '/'+linkedicao+'zoom/edicao='+pageEdition+'/pagina='+getCurrentPage();
        _gaq.push(['_trackPageview', trackzoom]);
        _gaq.push(['_trackEvent', document.title, 'Zoom', 'Zoom na página '+getCurrentPage()]);
        jQuery.post(base+'flip/jornal/jsp/registraZoom.jsp', jQuery('#frm').serialize());
    }
}

function abrePesquisa(url, link, anchor, soessa, keyword) {
    currentKeyword = keyword;
    //anchor=anchor;    
    var params = '?pagina='+anchor+'&keyword='+keyword
    pftemplinks = new Array();
    indextemplinks = 0;
    jQuery.post(base+'flip/jornal/jsp/searchText.jsp'+params, params, function (data) {
        if (data.indexOf(";")!=-1) {
            var results = data.split(";");
            var page = $(".magazine").turn("page");
            for (var i = 0; i<results.length; i++) {
                var word = results[i].split(",");
                pftemplinks[indextemplinks++] = ['search', page, word[0], word[1], word[2], word[3], '#', word[4], word[5], 'X', word[6], word[7], 'Pesquisa por '+keyword];
            }
            var element = $("div[page="+page+"]");
            loadTempRegions(page, element);
            if (zoomenabled==true) {
                $('.magazine-viewport').zoom('zoomIn');
            }
        }
    });
    gotoAnchor("anch"+anchor);
    //var page=$("#"+anchor).attr('class').replace('page-','');
    //$('.magazine').turn('page',page);    
    fechaJanela();
    return false;
}

function atualizaPesquisa() {
    var value = jQuery("#keywordbody").val();
    searchWord(value);
}

function cancelaPesquisa() {
    searchWord("");
    jQuery("#searchinstant").slideUp("slow");
    currentKeyword = null;
}
var currentKeyword = "";
function selectcurrentword() {
    if (currentKeyword!=null&&currentKeyword!="") {
        jQuery("#keywordbody").val(currentKeyword);
        jQuery("#searchinstant").slideDown("slow");
        searchWord(currentKeyword);
        currentKeyword = null;
    }
}

function fechaJanela() {
    //jQuery.fn.modalBox('close');
    fecharOutros();
}

function getPagesLink(sector) {
    return base+'flip/jornal/skins/master/jsp/'+sector+'.jsp';
}

function getPrintLink() {
    jQuery.getScript(base+'flip/jornal/skins/king/js/printPDF.js');
    flag = 0;
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('imprimir')+'?idForm='+pageAnchor;
    url = url+'&idEdicao='+pageEdition;
    return url;
}

var editingText = '';
function toogleTextField() {
    if (editingText=='') {
        editingText = jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').val("");
        jQuery(".multimidia_textfield").ForceNumericOnly();
    } else {
        var number = jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').unbind("keydown");
        $(".magazine").turn("page", number);
        editingText = '';
        jQuery('.multimidia_textfield').trigger("blur");
    }
}

function updateZoomChange(state, page) {
    if (state=='zoom_status_open') {
        if (!verifyBlockedPages(page)) {
            return false;
        }
        ajaxRegisterZoom();
        if (jQuery('#zoom_layer')) {
            jQuery('#zoom_layer').show();
        }
        return true;
    } else {
        if (jQuery('#zoom_layer')) {
            jQuery('#zoom_layer').hide();
        }
        return true;
    }
}

function updatePageChange() {
    var current = jQuery(".magazine").turn("page");
    var total = jQuery(".magazine").turn("pages");
    var text = '';
    if (current==0||current==total||current==null||current==1) {
        if (current==0||current==null) {
            current = 1;
        }
        text = current+' de '+total;
    } else {
        var pages = current+' e '+(current+1);
        text = pages+' de '+total;
    }
    jQuery('.multimidia_textfield').val(unescape(text));
    pageNumber = current;
    var pageEdition = getCurrentEdition();

    if (jQuery('#banner_lateral').length) { //se possui banner na lateral,verifica        
        updateSideBanner(current);
    }
    trackTimePage(current);
    if (current>1) {
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageviewTracking', 'screenName': dataAnalytics+' - pagina '+current});
        } else {
            var trackzoom = '/'+linkedicao+'edicao='+pageEdition+'/pagina='+current;
            if (_gaq) {
                _gaq.push(['_trackPageview', trackzoom]);
                _gaq.push(['_trackEvent', document.title, 'Folhear', 'Pagina '+current]);
            }
        }
    }
    calculaAltura();
    executeListener('UPDATE_PAGE');
    validateRecommend(current, total);
    if (jQuery('#comment_count').length) {
        reload_comments();
    }    
}


function getCurrentAnchor() {
    var page = $(".magazine").turn("page");
    return $(".page-"+page).attr('id');
}

function addPage(page, book) {
    var id, pages = book.turn('pages');
    var element = jQuery('<div class="svgloader"/>', {});
    if (book.turn('addPage', element, page)) {
        element.html('<div class="gradient"></div><div class="loader"></div>');
        setTimeout(function () {
            loadPage(page, element);
        }, 10);
    }
}

function loadPage(page, pageElement) {
    if (pageslist[page-1][2]=='HTML5') {
        var img = jQuery('<div class="htmlcontent"/>');
        var id = pageslist[page-1][0];
        jQuery(img).html(jQuery("#html5-"+id).html());
        jQuery(img).appendTo(pageElement);
        jQuery(img).css("width", "100%").css("height", "100%");
        pageElement.find('.loader').remove();
        img.css("z-index", "999999999999999999999");
        calculaAltura();
    } else {
        if (pageslist[page-1][2].indexOf(".html")!=-1||pageslist[page-1][2].indexOf(".zip")!=-1) {
            var img = jQuery('<div class="htmlcontent"/>');
            var url = pageslist[page-1][2];
            if (pageslist[page-1][2].indexOf(".zip")) {
                url = 'html5.jsp?path='+url;
            }
            if (url.indexOf("http")==-1) {
                url = base+url;
            }
            url = url.replace('&amp', '&');
            var height = jQuery(window).height()-80;
            var newx = (doc_x*height)/doc_y;
            jQuery('<iframe>', {
                src: url,
                id: 'frame'+page,
                frameborder: 0,
                scrolling: 'yes',
                width: "100%",
                height: "100%"
            }).addClass("framepageimg").appendTo(img);
            jQuery(img).appendTo(pageElement);
            jQuery(img).css("width", "100%").css("height", "100%");
            pageElement.find('.loader').remove();
            img.css("z-index", "999999999999999999999");
            calculaAltura();
        } else {
            var img = jQuery('<img />');
            img.mousedown(function (e) {
                disabledEventPropagation(e);
            });
            img.load(function () {
                jQuery(this).css({
                    width: '100%',
                    height: '100%'
                });
                jQuery(this).appendTo(pageElement);
                pageElement.find('.loader').remove();

                /*var ndoc_x = getOriginalWidthOfImg(this);
                 var ndoc_y = getOriginalHeightOfImg(this);               
                 if (ndoc_x != doc_x) {
                 doc_x = ndoc_x;
                 doc_y = ndoc_y;
                 calculaAltura();
                 }*/
            });
            var url = pageslist[page-1][2];
            if (url.indexOf("http")==-1) {
                url = base+url;
            }
            url = url.replace('&amp;', '&');
            img.attr('src', url);
            img.attr('class', 'pageimg');


            loadRegions(page, pageElement);
        }
        setTimeout(function () {
            adjustMediaSize(pageElement);
        }, 100);
    }
}
function adjustMediaSize(pageElement) {
    if (!pageElement) {
        jQuery('.video').each(function () {
            var width = jQuery(this).css('width');
            var height = jQuery(this).css('height');
            jQuery('iframe,.mejs-video', jQuery(this)).each(function () {
                jQuery(this).css('width', width).css("height", height);
            });
        });
    }
}

function loadTempRegions(page, element) {
    var was = false;
    for (var i = 0; i<pftemplinks.length; i++) {
        if (pftemplinks[i][1]==page) {
            was = true;
            x = parseInt(pftemplinks[i][2]);
            y = parseInt(pftemplinks[i][3]);
            w = parseInt(pftemplinks[i][4]);
            h = parseInt(pftemplinks[i][5]);
            px = parseInt(pftemplinks[i][7]);
            py = parseInt(pftemplinks[i][8]);
            options = jQuery('.magazine').turn('options'),
                    imageWidth = options.width/2,
                    imageHeight = options.height;
            var newx = parseFloat(imageWidth)/(100/px);
            var newy = parseFloat(imageHeight)/(100/py);
            var neww = (w*parseFloat(imageWidth))/pftemplinks[i][10];
            var newh = (h*parseFloat(imageHeight))/pftemplinks[i][11];

            var region = {
                "x": newx,
                "y": newy,
                "width": neww,
                "height": newh,
                "class": pftemplinks[i][0],
                "data": {
                    "url": pftemplinks[i][6],
                    "text": pftemplinks[i][12]
                }
            };
            addRegion(region, element, imageWidth, imageHeight);
        } else {
            if (was) {
                break;
            }
        }
    }
}
function loadRegions(page, element) {

    var was = false;
    for (var i = 0; i<pfmedias.length; i++) {
        if (pfmedias[i][1]==page) {
            was = true;
            x = parseInt(pfmedias[i][2]);
            y = parseInt(pfmedias[i][3]);
            w = parseInt(pfmedias[i][4]);
            h = parseInt(pfmedias[i][5]);
            px = parseInt(pfmedias[i][7]);
            py = parseInt(pfmedias[i][8]);
            options = jQuery('.magazine').turn('options'),
                    imageWidth = options.width/2,
                    imageHeight = options.height;
            var newx = parseFloat(imageWidth)/(100/px);
            var newy = parseFloat(imageHeight)/(100/py);
            var neww = (w*parseFloat(imageWidth))/pfmedias[i][10];
            var newh = (h*parseFloat(imageHeight))/pfmedias[i][11];

            var texticon = "";
            if (pfmedias[i][12]) {
                texticon = pfmedias[i][12];
                pfmedias[i][12] = pfmedias[i][12].split(" ").join("%_%");
            }
            var skin = "default";
            if (pfmedias[i][15]) {
                skin = pfmedias[i][15];
            }

            if (newh<=0) {
                newh = 15;
            }
            //0=class,1=page,2=x,3=y,4=w,5=h,6=cd,7=px,8=py,9=id,10=pw,11=ph,12=text,13=type,14=icon,15=skin            

            var region = {
                "x": newx,
                "y": newy,
                "width": neww,
                "height": newh,
                "class": pfmedias[i][0],
                "data": {
                    "index": pfmedias[i][1],
                    "url": pfmedias[i][6],
                    "text": pfmedias[i][12],
                    "texticon": texticon,
                    "tipo": pfmedias[i][13],
                    "icon": pfmedias[i][14],
                    "width": neww,
                    "height": newh,
                    "id": pfmedias[i][9],
                    "skin": skin
                }
            };
            addRegion(region, element, imageWidth, imageHeight);
        } else {
            if (was) {
                break;
            }
        }
    }
}

function addRegion(region, pageElement, pageWidth, pageHeight) {
    var tooltip = region.data.url.indexOf("anch")==-1 ? region.data.texticon : "Clique aqui";
    var reg = jQuery('<div />', {
        'class': 'region  '+region['class'],
        'alt': tooltip,
        'title': tooltip
    });

    var height = Math.round(region.height/pageHeight*100);
    if (parseInt(height)==0) {
        height = region.height;
    }

    reg.css({
        top: Math.round(region.y/pageHeight*100)+'%',
        left: Math.round(region.x/pageWidth*100)+'%',
        width: Math.round(region.width/pageWidth*100)+'%',
        height: height+'%'
    }).attr('region-data', jQuery.param(region.data||''));

    if (region['class']!='search') {
        if (region['class']=='video'&&iconVideo==false) {
            if (region.data.url.indexOf("youtube")!=-1) {
                var url = region.data.url;
                if (url.indexOf("https://")!=-1) {
                    url = url.replace("https://", "http://");
                }
                var index = region.data.index;
                url = YouTubeUrlNormalize(url)+"?showinfo=0";
                var html = '<div id="player'+index+'">';
                html = html+'<iframe width="'+region.width+'" height="'+region.height+'" style="width:"'+region.width+'";height:"'+region.height+';" src="'+url+'" frameborder="0" allowfullscreen></iframe>';
                html = html+'</div>';
                jQuery(reg).append(html);
            } else {
                var url = region.data.url;
                var index = region.data.index;
                var video = '<video width="'+region.width+'" height="'+region.height+'"  style="width: 100%; height: 100%;"  id="player'+index+'" preload="none" controls autoplay>';
                video = video+'<source type="video/mp4" src="'+url+'" codecs="avc1.42E01E, mp4a.40.2"/>';
                video = video+'</video>';
                jQuery(reg).append(video);
            }
        } else {
            if (region.data.icon!='') {
                if (region.data.tipo=='I') {
                    var img = jQuery('<img/>', {
                        'src': base+region.data.url,
                        'class': 'regionImage'
                    });
                    jQuery(img).css('left', "0px");
                    jQuery(img).css('top', "0px");
                    jQuery(img).css('max-height', "100%");
                    img.appendTo(reg);
                } else {
                    var img = jQuery('<img/>', {
                        'class': 'iconimg',
                        'src': base+region.data.icon
                    });
                    jQuery(img).css('left', "0px");
                    jQuery(img).css('top', "0px");
                    jQuery(img).css('max-height', region.height+"px");
                    img.appendTo(reg);
                }
            } else {
                var icon = jQuery('<div/>', {
                    'class': region['class']+'img'
                });
                icon.appendTo(reg);
            }
        }
    }
    reg.appendTo(pageElement);
}

function regionClick(event) {

    var region = jQuery(event.target);
    if (region.hasClass('linkimg')||region.hasClass('videoimg')||region.hasClass('galleryimg')||region.hasClass('iconimg')) {
        region = jQuery(region).parent();
    }
    if (region.hasClass('region')) {
        var regionType = jQuery.trim(region.attr('class').replace('region', ''));
        var action = processRegion(region, regionType);
        if (event.preventDefault) { /* Chrome, Safari, Firefox */
            event.preventDefault();
        }
        return true;
    }
}
function processRegion(region, regionType) {
    data = decodeParams(region.attr('region-data'));

    if (data.text)
        data.text = data.text.split("%_%").join(" ");

    switch (regionType) {
        case 'link' :
            if (data.url.indexOf("anch")!=-1) {
                gotoAnchor(data.url);
            } else {
                if (data.tipo=='V') {
                    var url = data.url;
                    Videobox.leiaMais(url, data.text);
                } else {
                    window.open(data.url);
                }
            }
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Abriu link', 'eventLabel': dataAnalytics});
            }
            break;
        case 'icon' :
            if (data.url.indexOf("anch")!=-1) {
                gotoAnchor(data.url);
            } else {
                if (data.tipo=='V') {
                    var url = data.url;
                    Videobox.leiaMais(url, data.text);
                } else {
                    window.open(data.url);
                }
            }
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Abriu link', 'eventLabel': dataAnalytics});
            }
            break;
        case 'zoom' :
            var regionOffset = region.offset(),
                    viewportOffset = jQuery('.magazine-viewport').offset(),
                    pos = {
                        x: regionOffset.left-viewportOffset.left,
                        y: regionOffset.top-viewportOffset.top
                    };
            jQuery('.magazine-viewport').zoom('zoomIn', pos);
            break;
        case 'to-page' :
            jQuery('.magazine').turn('page', data.page);
            break;
        case 'video':
            var url = data.url;
            Videobox.open(url, data.text);
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Abriu Video', 'eventLabel': dataAnalytics});
            }
            break;
        case 'gallery':
            openGalleryHtml5(data.url, data.text, data.skin);
            break;
        case 'search':
            var regionOffset = region.offset(),
                    viewportOffset = jQuery('.magazine-viewport').offset(),
                    pos = {
                        x: regionOffset.left-viewportOffset.left,
                        y: regionOffset.top-viewportOffset.top
                    };
            jQuery('.magazine-viewport').zoom('zoomIn', pos);
            break;
        case 'audiopicture':
            var url = window.location.origin+"/"+data.url;
            window.open(window.location.origin+"/flip/jornal/skins/html5full/jsp/audioLink.jsp?audiourl="+url, "_blank", "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300, left=500, width=350,height=40");
            break;
    }
}

function openGalleryHtml5(cd, text, skin) {

    if (skin=='default') {
        var url = base+'flip/jornal/plugin/gallery.jsp?cd='+cd;
        var html5lightbox_options = {
            watermark: "",
            watermarklink: ""
        };
        html5Lightbox.showLightbox(7, url, text, 850, 480);
    } else {
        jQuery("#darkbox").remove();
        jQuery('.gallery-dark-box').remove();
        var html = jQuery('<div/>', {
            'position': 'relative',
            'class': 'gallery-dark-box',
            'id': 'gallery'+cd
        });
        var first = null;
        for (var i = 0; i<pfmediaspics.length; i++) {
            if (pfmediaspics[i][1]==cd) {
                var img = jQuery('<img/>', {
                    'src': base+pfmediaspics[i][2],
                    'data-darkbox': base+pfmediaspics[i][2],
                    'data-darkbox-description': pfmediaspics[i][3],
                    'alt': pfmediaspics[i][3]
                });
                img.appendTo(html);
                if (first==null) {
                    first = img;
                }
            }
        }
        jQuery("body").append(html);
        loadDarkBox();
        jQuery(first).click();
    }
    if (dataLayer != null) {
        dataLayer.push({'event': 'eventTracking', 'eventCategory': 'Cliques Flip - '+sigla, 'eventAction': 'Abriu galeria', 'eventLabel': dataAnalytics});
    }
}



function loadSvgPage(page, pageElement) {

    if (pageslist[page-1][2].indexOf(".svg")!=-1) {
        var url = pageslist[page-1][2];
        if (url.indexOf("http:")==-1) {
            url = base+url;
        }
        jQuery(pageElement).load(url, function () {
            jQuery(pageElement).css("z-index", "1");
            jQuery(pageElement, "svg").css("z-index", "9999");
            //jQuery(this).attr('unselectable','on');
            //jQuery(this).trigger('onselectstart',function(){
            //    return false;
            //});            
        });
    } else {
        var img = jQuery('<img />');
        img.load(function () {
            var prevImg = pageElement.find('.pageimg');
            /*jQuery(this).css({
             width: '100%', 
             height: '100%'
             });*/
            jQuery(this).css({
                width: 'auto',
                height: '100%'
            });
            //var height=jQuery("#content").height()-90;
            jQuery(img).css("max-height", "100%");

            jQuery(this).appendTo(pageElement);
            jQuery(this).attr('unselectable', 'on');
            jQuery(this).trigger('onselectstart', function () {
                return false;
            });
            prevImg.remove();
        });
        var url = bas+getPage(page-1)[1];
        img.attr('src', url);
        img.attr('class', 'pageimg');
    }



}

function loadLargePage(page, pageElement) {
    var img = jQuery('<img />');
    img.load(function () {
        var prevImg = pageElement.find('.pageimg');
        jQuery(this).css({
            width: '100%',
            height: '100%'
        });
        jQuery(this).appendTo(pageElement);
        prevImg.remove();
    });
    var url = pageslist[page-1][1];
    if (url.indexOf("http")==-1) {
        url = base+url;
    }
    url = url.replace('&amp;', '&');
    img.attr('src', url);
    img.attr('class', 'pageimg');
}

function loadSmallPage(page, pageElement) {
    var img = pageElement.find('.pageimg');
    img.css({
        width: '100%',
        height: '100%'
    });
    img.unbind('load');
    var url = base+pageslist[page-1][2];
    img.attr('src', url);
    img.attr('class', 'pageimg');
}

function customForward(page, frmName) {
    var frm = jQuery("#"+frmName);
    var url = base+'flip/jornal/jsp/customs/'+page;
    jQuery.post(url, frm.serialize(), function (message) {
        jQuery.fn.modalBox({
            directCall: {
                data: message
            }
        });
    });
}


function validateComentario(frm) {
    return true;
}

// verifica se um campo esta vazio ou n�o existe
function isEmpty(campo) {
    return (campo==null||campo.value==null||campo.value=='');
}

function isChrome() {
    return navigator.userAgent.indexOf('Chrome')!=-1;
}
function getInternetExplorerVersion() {
    var rv = -1; // Return value assumes failure.
    if (navigator.appName=='Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua)!=null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}
var IEV = getInternetExplorerVersion();

function disableControls(page) {
    if (page==1)
        $('.previous-button').hide();
    else
        $('.previous-button').show();

    if (page==$('.magazine').turn('pages'))
        $('.next-button').hide();
    else
        $('.next-button').show();

    updatePageChange();
}

function playsound() {
    if (soundEnabled==true&&(!isIE||IEV>=9)) {
        jQuery('#turn'+(Math.floor((Math.random()*5)+1))).get(0).play();
    }
}

// Set the width and height for the viewport
var oldOptionsX = 0;
var oldOptionsY = 0;
function resizeViewport() {
    var width = jQuery(window).width(), height = jQuery(window).height(), options = jQuery('.magazine').turn('options');
    var display = jQuery('.magazine').turn('display');
    var posH = jQuery('.magazine').turn('zoom')==1 ? height : height-50;
    jQuery('.magazine').removeClass('animated');
    jQuery('.magazine-viewport').css({
        width: width,
        height: posH//-100      
    }).zoom('resize');
    if (jQuery('.magazine').turn('zoom')==1) {

        var newy = posH-50;
        var newx = ((doc_x*newy)/doc_y)*2;
        
        var ox=options.width;
        var oy=options.height;
        if (fullscreen==true) {
            oldOptionsX = options.width;
            oldOptionsY = options.height;
        } else {
            if (oldOptionsX>0) {
                options.width = oldOptionsX;
                ox=oldOptionsX;
                oldOptionsX = 0;
            }
            if (oldOptionsY>0) {
                options.height = oldOptionsY;
                oy=oldOptionsY;
                oldOptionsY = 0;
            }
        }
        //console.log(fullscreen+"x"+options.width+"x"+width+"x"+oldOptionsX);
        var bound = calculateBound({
            width: fullscreen==true ? newx : ox,
            height: fullscreen==true ? newy : oy,
            boundWidth: fullscreen==true ? Math.max(ox, newx) : Math.min(ox, width),
            boundHeight: fullscreen==true ? Math.max(oy, newy) : Math.min(oy, height)
        });
        if (bound.width%2!==0)
            bound.width -= 1;
        if (bound.width!=jQuery('.magazine').width()||bound.height!=jQuery('.magazine').height()) {
            jQuery('.magazine').turn('size', bound.width, bound.height);
            jQuery('.next-button').css({
                height: bound.height,
                backgroundPosition: '-38px '+(bound.height/2-32/2)+'px'
            });
            jQuery('.previous-button').css({
                height: bound.height,
                backgroundPosition: '-4px '+(bound.height/2-32/2)+'px'
            });
        }
        jQuery('.magazine').css({
            top: -bound.height/2,
            left: -bound.width/2
        });

    }
    jQuery('.magazine').addClass('animated');
}
function largeMagazineWidth() {
    return jQuery(window).width()*1.2;
}
function decodeParams(data) {
    var parts = data.split('&'), d, obj = {};
    for (var i = 0; i<parts.length; i++) {
        d = parts[i].split('=');
        obj[decodeURIComponent(d[0])] = decodeURIComponent(d[1]);
    }
    return obj;
}
function calculateBound(d) {
    var bound = {
        width: d.width,
        height: d.height
    };
    if (bound.width>d.boundWidth||bound.height>d.boundHeight) {
        var rel = bound.width/bound.height;
        if (d.boundWidth/rel>d.boundHeight&&d.boundHeight*rel<=d.boundWidth) {
            bound.width = Math.round(d.boundHeight*rel);
            bound.height = d.boundHeight;
        } else {
            bound.width = d.boundWidth;
            bound.height = Math.round(d.boundWidth/rel);
        }
    }
    return bound;
}

function loading() {
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            data: '<p align=center>'+jQuery('#loading').html()+'</p>'
        }
    });
}

function openProdutosMode() {
    openProdutosMode(0);
}
function openProdutosMode(p) {
    var html = '<div id="header"><li class="header">Cadernos e Produtos</li></div>';
    var pageAnchor = getCurrentEdition();
    page = p;
    if (!page||page==undefined) {
        page = 0;
    }
    var url = getPagesLink('produtos')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;
    jQuery.post(url, function (data) {
        jQuery('#produtos_barra .free').html(html+data);
    });
}

function playSound(id) {
    var url = getPagesLink('audioLink')+'?audio='+id;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            source: url
        }
    });
}

function validateRecomment() {
    validateRecommend(getCurrentPage(), getPageCount());
}
function closeRecommendArea() {
    jQuery("#facerecomenda").hide("slow", function () {
        jQuery("#facerecomenda").remove();
        updatePageChange();
    });
}
function hideRecommendArea() {
    if (jQuery("#facerecomenda").length) {
        jQuery("#facerecomenda").hide("slow");
    }
}
function showRecommendArea() {
    if (jQuery("#facerecomenda").length) {
        jQuery("#facerecomenda").show("slow");
    }
}
function fixedEncodeURIComponent(str) {
    return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
}
function validateRecommend(current, total) {
    if (jQuery("#facerecomenda").length) {
        var faceurltemplate = "http://www.facebook.com/plugins/like.php?href=$URL&;layout=standard&show_faces=false&width=380&action=recommend&colorscheme=light&height=30&locale=pt_BR";
        var width = jQuery(".megazine").css('width');
        if(!width || width==null){
            return;
        }
        if (current>0&&current%2==0) {
            current--;
        }
        var anchor = getPageAnchor(current);
        var link = base+'pub/'+folder+'/?ipg='+anchor;
        var url = faceurltemplate.replace("$URL", link);
        jQuery("#faceframeleft").attr('src', url);
        if (current==0||current==total||current==null) {
            width = parseInt(width.replace("px", ""))/3;
            jQuery("#faceright").hide();
            jQuery("#facerecomenda").css("width", width+"px");
            jQuery("#faceleft").css("width", "100%");
            jQuery(".closeleft").show();
        } else {
            jQuery(".closeleft").hide();
            width = parseInt(width.replace("px", ""))/2;
            width = width+150;
            jQuery("#facerecomenda").css("width", width+"px");
            jQuery("#faceleft").css("width", "50%");
            jQuery("#faceright").css("width", "50%");
            jQuery("#faceright").show();
            anchor = getPageAnchor(current+1);
            link = base+'pub/'+folder+'/?ipg='+anchor;
            url = faceurltemplate.replace("$URL", link);
            jQuery("#faceframeright").attr('src', url);

        }
    }
}

jQuery.fn.ForceNumericOnly =
        function ()
        {
            return this.each(function ()
            {
                jQuery(this).keydown(function (e)
                {
                    var key = e.charCode||e.keyCode||0;
                    // allow backspace, tab, delete, arrows, numbers and keypad numbers ONLY
                    return (
                            key==8||
                            key==9||
                            key==46||
                            (key>=37&&key<=40)||
                            (key>=48&&key<=57)||
                            (key>=96&&key<=105));
                })
            })
        };



jQuery.maxZIndex = jQuery.fn.maxZIndex = function (opt) {
    var def = {
        inc: 10,
        group: "*"
    };
    jQuery.extend(def, opt);
    var zmax = 0;
    jQuery(def.group).each(function () {
        var cur = parseInt(jQuery(this).css('z-index'));
        zmax = cur>zmax ? cur : zmax;
    });
    if (!this.jquery)
        return zmax;

    return this.each(function () {
        zmax += def.inc;
        jQuery(this).css("z-index", zmax);
    });
}

jQuery.validateEmail = function (email) {
    er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;
    if (er.exec(email))
        return true;
    else
        return false;
};

function getPageAnchor(page) {
    return pageslist[page-1][0];
}

function getCurrentAnchor() {
    var page = $(".magazine").turn("page");
    return pageslist[page-1][0];
}
function getCurrentPage() {
    return $(".magazine").turn("page");
}
function searchWord(w) {
    alert('Procurando por '+w);
}
function getPageCount() {
    return $(".magazine").turn("pages");
}
function gotoAnchor(anchor) {
    anchor = anchor.replace("anch", "");
    for (var i = 0; i<pageslist.length; i++) {
        if (pageslist[i][0]==anchor) {
            $(".magazine").turn("page", (i+1));
            break;
        }
    }
}
function disabledEventPropagation(event)
{
    if (event.stopPropagation) {
        event.stopPropagation();
    }
    else if (window.event) {
        window.event.cancelBubble = true;
    }
}
function getPage(index) {
    return pageslist[index];
}
function getOriginalWidthOfImg(img_element) {
    var t = new Image();
    t.src = (img_element.getAttribute ? img_element.getAttribute("src") : false)||img_element.src;
    return t.width;
}
function getOriginalHeightOfImg(img_element) {
    var t = new Image();
    t.src = (img_element.getAttribute ? img_element.getAttribute("src") : false)||img_element.src;
    return t.height;
}
function openFullScreen() {
    $('#fullscreenid').fullscreen();
}