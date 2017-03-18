var isIE = navigator.appVersion.indexOf('MSIE') > 0;
var isMozilla = document.getElementById && !isIE;
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
var calc = false;
var fullscreen = false;
var isDebug = false;
var currentKeywordHighlight=keywords;
var currentKeywordAnchor=null;

function debug(msg) {
    if (isDebug)
        console.log(msg);
}

var nDivPage = null;

function onOrientationChanged() {
    setTimeout(function () {
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
    jQuery(window).bind('resize', function (e, onready) {
        onOrientationChanged();
    });
    jQuery(document).on('webkitfullscreenchange mozfullscreenchange fullscreenchange MSFullscreenChange', function () {
        fullscreen = !fullscreen;
    });
    jQuery('.imprimir').click(function (e) {
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
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
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
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
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
            jQuery.getScript(basestatic + 'flip/jornal/skins/king/js/jquery.copy.min.js');
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
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
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
        window.location.href = base + linkedicao;
    });
    jQuery('.multimidia_fr').click(function () {
        jQuery(".magazine").turn("page", 1);
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Primeira Pagina', 'eventLabel': dataAnalytics});
        }
    });
    jQuery('.multimidia_prev').click(function () {
        jQuery('.magazine').turn('previous');
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Retornou Pagina', 'eventLabel': dataAnalytics});
        }
    });
    jQuery('.multimidia_next').click(function () {
        jQuery('.magazine').turn('next');
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Avancou Pagina', 'eventLabel': dataAnalytics});
        }
    });
    jQuery('.multimidia_ff').click(function () {
        var amount = jQuery(".magazine").turn("pages");
        jQuery(".magazine").turn("page", amount);
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Ultima Pagina', 'eventLabel': dataAnalytics});
        }
    });
    jQuery('.multimidia_textfield').focus(function () {
        toogleTextField();
    });
    jQuery('.multimidia_textfield').blur(function () {
        updatePageChange();
        editingText = '';
    });
    jQuery('.multimidia_textfield').keyup(function (e) {
        if (e.keyCode == 13) {
            toogleTextField();
        }
    });
    jQuery(".zoomless").click(function (e) {
        setTimeout(function () {
            if (jQuery('.zoomless img').attr('src').indexOf("disabled") == -1) {
                var zoom = jQuery(".magazine").turn("zoom");
                if (zoom > 3) {
                    jQuery(".magazine").turn("zoom", zoom - 1);
                    resizeViewport();
                    jQuery(".magazine-viewport").css("height", jQuery(this).height() + "px");
                } else {
                    jQuery('.magazine-viewport').zoom('zoomOut');
                }
            }
        }, 100);
    });
    jQuery(".zoommore").click(function (e) {
        if (jQuery('.zoommore img').attr('src').indexOf("disabled") == -1) {

            if (flipenabled == false) {
                checkLogged();
            }
            if (flipenabled == true) {
                setTimeout(function () {
                    var zoom = jQuery(".magazine").turn("zoom");
                    jQuery(".magazine").turn("zoom", zoom + 1);
                    resizeViewport();
                    jQuery(".magazine-viewport").css("height", jQuery(this).height() + "px");
                }, 100);
            }
        }
    });

    jQuery(".closeicon").click(function (e) {
        jQuery('.magazine-viewport').zoom('zoomOut');
    });
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
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
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
    if (soundEnabled == true && (!isIE || IEV >= 9)) {
        var soundbase = basestatic + 'flip/jornal/player/snd/turn';
        for (var i = 0; i < 5; i++) {
            var url = soundbase + i + '.mp3';
            jQuery("body").append("<audio src='" + url + "' id='turn" + (i + 1) + "'/>");
        }
    }

    addListener(ajaxRegisterZoom, 'ZOOM_IN_PAGE');
    addListener(highlightSearch,'UPDATE_PAGE');
        
    jQuery(".magazine").bind("turned", function(event, page, view) {        
        executeListener('UPDATE_PAGE');
    });    
    
    if (ipg != null || typeof pg !== 'undefined') {
        if (ipg != null) {
            ipg = ipg.trim().replace("id", "");
            jQuery(document).ready(function () {
                setTimeout(function () {
                    gotoAnchor(ipg, true);
                }, 1500);
            });
        } else if (typeof pg !== 'undefined') {
            if (pg != null) {
                pg = pg.trim();
                if (parseInt(pg) % 2 != 0)
                    pg = pg - 1;
                setTimeout(function () {
                    jQuery(".magazine").turn("page", pg)
                }, 500);
            }
        }
    }    
}

function trackTimePage(pagina) {
    lastPageTracking = pagina;
    var endTime = new Date().getTime();
    var timeSpent = endTime - startTime;
    var hourInMillis = 1000 * 60 * 60;
    if (0 < timeSpent && timeSpent < hourInMillis) {
        startTime = new Date().getTime();
        if (_gaq) {
            _gaq.push([gaPrefix + '_trackTiming', linkedicao, 'Ed' + getCurrentEdition(), timeSpent, 'Pagina' + lastPageTracking, 100]);
            if (gaPrefix != '' && typeof ga !== 'undefined') {
                ga.send('timing', linkedicao, 'Ed' + getCurrentEdition(), timeSpent, 'Pagina' + lastPageTracking, 100);
            }
        }
    }
}

function extractDelta(e) {
    if (e.wheelDelta) {
        return e.wheelDelta;
    }
    if (e.originalEvent.detail) {
        return e.originalEvent.detail * -40;
    }
    if (e.originalEvent && e.originalEvent.wheelDelta) {
        return e.originalEvent.wheelDelta;
    }
}
var wheelFunction = function (e) {
    if (scrollenabled == true && selectTextMode == false) {
        var delta = extractDelta(e);
        if (pageWheel == true && zoommode == false) {
            if (delta / 120 > 0) {
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
            if (zoommode == true) {
                disabledEventPropagation(e);
                if (delta / 120 > 0) {
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
    var source = e.target || e.srcElement;
    switch (e.keyCode) {
        case previous:
            if (jQuery(source).is("input") == false && flipenabled == true) {
                jQuery('.multimidia_prev').click();
                break;
            }
        case next:
            if (jQuery(source).is("input") == false && flipenabled == true) {
                jQuery('.multimidia_next').click();
                break;
            }
        case esc:
            if (jQuery(source).is("input") == false) {
                jQuery('.magazine-viewport').zoom('zoomOut');
                break;
            }
    }
};
function calculaAlturaZoom(zoomDuplo, direction, zoomInicial) {
    var height = jQuery(window).height();
    height = height - 50;
    var newx = (doc_x * height) / doc_y;
    var zoomFactor = zoomInicial !== undefined ? (zoomInicial * 0.1) + 1.0 : 1.0;

    debug("calculaAlturaZoom(): direction: " + direction +
            ", zoomDuplo: " + zoomDuplo + ", zoomInicial: " + zoomInicial + ", zoomFactor: " + zoomFactor +
            ", height: " + height + ", newx: " + newx);

    if (zoomDuplo === false && direction === 'in')
        newx = newx / 2;

    height *= zoomFactor;
    newx *= zoomFactor;
    debug("calculaAlturaZoom(): height: " + height + ", newx: " + newx);

    jQuery(".magazine-viewport").css("height", height + "px");
    jQuery(".magazine-viewport .magazine").css("height", height + "px");
    jQuery(".magazine-viewport .magazine").css("width", newx * 2 + "px");
    if (jQuery("iframe.framepageimg")) {
        jQuery("iframe.framepageimg").css("height", height + "px");
        jQuery("iframe.framepageimg").parent().css("position", "absolute").css("top", "180px");
    }
    //calc = false;    
}
function calculaAltura() {
    if (calc === false) {
        var height = jQuery(window).height();
        height = height - (fullscreen == true ? 30 : 80);
        if (jQuery("#s2bannerdiv").length) {
            height = height - 40 - pageHeightSpace;
        }
        if (parseInt(doc_x) > parseInt(doc_y)) {
            height = height - 200;
        }
        var newx = (doc_x * height) / doc_y;
        var top = height / 2;
        jQuery(".magazine-viewport").css("height", height + "px");
        jQuery(".magazine-viewport .magazine").css("height", height + "px");
        jQuery(".magazine-viewport .magazine").css("width", newx * 2 + "px");
        jQuery(".magazine-viewport .container").css("top", top + "px");
        calc = true;

    }
    if (jQuery("iframe.framepageimg")) {
        jQuery("iframe.framepageimg").css("height", "100%");
        jQuery("iframe.framepageimg").parent().css("position", "").css("top", "");
    }


}

function recordLastDivClick() {
    var divLastClick = jQuery(this).parent().parent();
    var page = jQuery(divLastClick).attr('page');
    nDivPage = parseInt(page);
    debug("parse: " + nDivPage);

    if (!(Number(nDivPage) === nDivPage && nDivPage % 1 === 0))
        nDivPage = null;

    debug('divLastClick: ' + nDivPage);
}

function registerPageClick() {
    debug('registerPageClick');
    jQuery('.page').click(recordLastDivClick);
}

function checkDoublePageZoom(zoomDuplo, direction) {
    debug("checkDoublePageZoom: zoomDuplo: " + zoomDuplo);

    if (zoomDuplo === false) {
        debug('checkDoublePageZoom, dir: ' + direction);
        var npage = 1;
        var nTurnPage = jQuery('.magazine').turn('page');

        debug("check nTurnPage: " + nTurnPage + ", nDivPage: " + nDivPage);

        if (direction === 'in') {
            opt = 'single';
            npage = nDivPage !== null ? nDivPage : nTurnPage;
        } else {
            opt = 'double';
            npage = nTurnPage;
        }

        // zera para garantir que novo uso tenha sido de um novo clique
        nDivPage = null;

        jQuery(".magazine").turn('display', opt);
        jQuery(".magazine").turn('page', npage);
        Hash.go('page/' + npage).update();

        debug('checkDoublePageZoom, npage: ' + npage);
    }
}

function applyZoomOutListener() {
    jQuery('.zoom-out').click(function (event) {
        var origin = jQuery(event.target).attr('class');

        if (origin != undefined && (origin.indexOf("mejs") != -1 || origin.indexOf("audiopicture") != -1 || origin.indexOf("link") != -1 || origin.indexOf("video") != -1 || origin.indexOf("gallery") != -1 || origin.indexOf("icon") != -1)) {
            return regionClick(event);
        } else {
            if (doubleClickZoom == false) {
                if (flipenabled == false) {
                    checkLogged();
                } else {
                    jQuery('.magazine').removeClass('animated').addClass('zoom-in');
                    jQuery('.magazine-viewport').zoom('zoomIn');

                }
            }
        }

    });
}

function getSearchLink() {
    var pageAnchor = getCurrentEdition();
    var url = getPagesLink('pesquisa') + '?idForm=' + pageAnchor + '&acervo=' + acervo;
    url = url + '&linkedicao=' + linkedicao;
    return url;
}

function pesquisa() {
    var object = document.faleConoscoForm.keywords;
    if (object.value.length < 4) {
        alert('Deve informar um termo com pelo menos 4 caracteres');
        jQuery('#keywords').focus();
    } else {
        var url = getSearchLink();
        var frm = jQuery('#faleConoscoForm');
        jQuery("#areabotoes").hide();
        jQuery("#aguarde").html("Aguarde, pesquisando...");
        jQuery("#aguarde").show();
        jQuery('#edicao').val(getCurrentEdition());
        var dados = frm.serialize();

        jQuery.post(url, dados, function (data) {
            searchResult = data;
            jQuery('#result').html(data);
            jQuery('#result').show();
            jQuery("#aguarde").hide();
            jQuery("#areabotoes").show();
            if (_gaq) {
                _gaq.push(['_trackEvent', document.title, 'Pesquisa', 'Pesquisa por ' + object.value]);
            }
        });
    }
}

function getRecommentLink() {
    var edition = getCurrentEdition();
    var url = getPagesLink('recomendacao') + '?idForm=' + edition;
    return url;
}

function recomendaAmigo() {
    jQuery('#pagina_anchor').val(getCurrentAnchor());
    var frm = jQuery('#faleConoscoForm');

    var link = jQuery(location).attr('href');
    var indexPage=link.indexOf("#page");
    if(indexPage != -1){
        link=link.substring(0,indexPage);
    }
    if(link.indexOf("?pg")==-1){
        var cPage=getCurrentPage();
        if(cPage>1){
            link = link + '?pg=' + cPage;
        }
    }   
    jQuery("#link").val(link);

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o  nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o  email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O email parece incorreto. Corrija-o.!");
            return false;
        }
    }
    if (jQuery("#para1").val() == "" && jQuery("#para2").val() == "" && jQuery("#para3").val() == "" && jQuery("#para4").val() == "") {
        alert("Informe o email de pelo menos um amigo.");
        return false;
    }
    if (jQuery("#para1").val() != "" && !jQuery.validateEmail(jQuery("#para1").val())) {
        alert("O  email " + jQuery("#para1").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if (jQuery("#para2").val() != "" && !jQuery.validateEmail(jQuery("#para2").val())) {
        alert("O  email " + jQuery("#para2").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if (jQuery("#para3").val() != "" && !jQuery.validateEmail(jQuery("#para3").val())) {
        alert("O  email " + jQuery("#para3").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if (jQuery("#para4").val() != "" && !jQuery.validateEmail(jQuery("#para4").val())) {
        alert("O  email " + jQuery("#para4").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }

    if (_gaq) {
        _gaq.push(['_trackEvent', document.title, 'Recomenda', 'Recomendacao de ' + jQuery("#emailId").val()]);
    }
    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();
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

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("Informe um email correto!");
            return false;
        }
    }
    if (jQuery("#assunto").val() == "") {
        alert("Informe o assunto.");
        return false;
    }
    if (jQuery("#mensagem").val() == "") {
        alert("Informe a mensagem.");
        return false;
    }

    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();
    loading();
    jQuery.post(url, function (message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    if (_gaq) {
        _gaq.push(['_trackEvent', document.title, 'Contato', 'Contato de ' + jQuery("#emailId").val()]);
    }

    return true;
}

function comentaPagina() {
    var frm = jQuery('#faleConoscoForm');
    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o  nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o  email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O email parece incorreto. Corrija-o.!");
            return false;
        }
    }
    if (jQuery("#mensagem").val() == "") {
        alert("Informe a mensagem.");
        return false;
    }
    loading();
    jQuery.post(url, function (message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });
    if (_gaq) {
        _gaq.push(['_trackEvent', document.title, 'Comentario', 'Comentario de ' + jQuery("#emailId").val()]);
    }

    return true;
}

function comentaPaginaMarkup() {
    var frm = jQuery('#faleConoscoForm');

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O email parece incorreto. Corrija-o.!");
            return false;
        }
    }

    var url = base + 'flip/enviaEmailSites.do?comentario=true&' + frm.serialize();
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
function mostraComentario(id) {
    var url = getPagesLink('mostraComentario') + '?id=' + id;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 600,
        directCall: {
            source: url
        }
    });
}
function apagaComentario(id) {
    var url = getPagesLink('apagaComentario') + '?id=' + id;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 600,
        directCall: {
            source: url
        }
    });
}
function openCommentModeMarkup() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('comentar') + '?markup=true&idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;

    jQuery.fn.modalBox({
        setWidthOfModalLayer: 600,
        directCall: {
            source: url
        }
    });
}

function openCommentMode() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('comentar') + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;

    jQuery.fn.modalBox({
        setWidthOfModalLayer: 700,
        directCall: {
            source: url
        }
    });
}

function openCommentStep2Mode(pagina) {
    var edition = getCurrentEdition();
    var url = getPagesLink('comentarStep2') + '?idForm=' + edition;
    url = url + '&pagina=' + pagina;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 700,
        directCall: {
            source: url
        }
    });
}

function openCommentStep2ModeMarkup(pagina) {
    var edition = getCurrentEdition();
    var url = getPagesLink('comentarMarkup') + '?idForm=' + edition;
    url = url + '&pagina=' + pagina;

    jQuery.fn.modalBox({
        setWidthOfModalLayer: 600,
        directCall: {
            source: url
        }
    });
}

function openContactMode() {
    var edition = getCurrentEdition();
    var url = getPagesLink('faleConosco') + '?idForm=' + edition + '&modelo=' + mid;
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
        var url = base + 'flip/loginEdicao.do?' + frm.serialize();
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
        var url = getPagesLink('cadastro') + '?modelo=' + mid;
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
    var url = getPagesLink('texto') + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;
    return url;
}

function getPDFLink(todos) {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var page = 'exportar';
    if (todos == 'Z' || todos == 'P') {
        page = 'mavenflip';
    } else {
        if (todos == 'S') {
            page = page + 'Sumario';
        }
    }
    var url = getPagesLink(page) + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;
    if (todos == 'Z' || todos == 'P') {
        if (_gaq) {
            _gaq.push(['_trackEvent', document.title, 'Exportar PDF', 'Exportar PDF da edicao ' + pageEdition]);
        }
        window.location.href = url;
    } else {
        var size = (todos == 'S' ? 900 : 600);
        jQuery.fn.modalBox({
            setWidthOfModalLayer: size,
            directCall: {
                source: url
            }
        });
    }
}
function verifyBlockedPages(page) {
    if (zoomBlocked == true) {
        var anchor = getPageAnchor(page);
        var freePass = false;
        if (freePagesList.length > 0) {
            for (var i = 0; i < freePagesList.length; i++) {
                if (freePagesList[i] == anchor) {
                    freePass = true;
                    break;
                }
            }
        }
        if (freePass == false) {
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
    var link = base + 'pub/' + folder + '/?ipg=' + anchor;
    window.location.href = link;
}

function verifyOnlineMode() {
    //if(!online){
    jQuery('.megazine').hide();
    var link = "login.jsp?edicao=" + getCurrentEdition();
    window.location.href = link;
//}
}

function exportaMarcadas() {
    var url = getPagesLink('mavenflip') + '?' + jQuery('#exporta_form').serialize();
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            data: '<p>Aguarde, estamos gerando o arquivo ... </p>'
        }
    });
    window.open(url, '_blank');
    window.setTimeout("fechaJanela()", 3000);
}

function ajaxRegisterZoom() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    document.frm.idForm.value = pageAnchor;
    document.frm.idEdicao.value = pageEdition;
    if (pageAnchor != null) {
        var trackzoom = '/' + linkedicao + 'zoom/edicao=' + pageEdition + '/pagina=' + getCurrentPage();
        if (_gaq) {
            _gaq.push(['_trackPageview', trackzoom]);
            _gaq.push(['_trackEvent', document.title, 'Zoom', 'Zoom na pagina ' + getCurrentPage()]);
        }
        jQuery.post(base + 'flip/jornal/jsp/registraZoom.jsp', jQuery('#frm').serialize());
    }
}

function highlightSearch(){       
       if(currentKeywordHighlight != null && currentKeywordHighlight != "" && currentKeywordHighlight!=undefined){                    
                    var anchor=currentKeywordAnchor;                    
                    if(anchor == null){
                        anchor=ipg;
                    }
                    if(anchor == null){
                        anchor=getCurrentAnchor();
                    }                                 
                    var pnumber=getPageByAnchor(anchor);                            
                    try{anchor = anchor.replace("anch", "");}catch(e){}                                                            
                    pftemplinks = new Array();
                    indextemplinks = 0;
                    
                    var pageElement = jQuery("div[page=" + pnumber + "] .page");
                    if(jQuery(pageElement).html()==undefined){
                        return;
                    }                                        
                    jQuery.post(base + 'flip/jornal/jsp/getAllText.jsp?pagina=' + anchor + '&keyword=' + currentKeywordHighlight, function (data) {
                        if (data.indexOf(";") != -1) {                                        
                            var results = data.split(";");
                            for (var i = 0; i < results.length; i++) {
                                var word = results[i].split(",");                                
                                pftemplinks[indextemplinks++] = ['search', pnumber, word[0], word[1], word[2], word[3], '#', word[4], word[5], 'X', word[6], word[7], 'Pesquisa por ' + currentKeywordHighlight];
                            }                                     
                            loadTempRegions(pnumber, pageElement);
                        }
                        currentKeywordHighlight=null;
                    });                    
                }
}

function abrePesquisa(url, link, anchor, soessa, keyword) {
    if (!soessa) {
        var destiny = base + url + link + '&keyword=' + keyword;
        window.location.href = destiny;
        return;
    }
    currentKeyword = keyword;
    jQuery(".search").remove();
    currentKeywordHighlight=keyword;;       
    var currentAnchor=getCurrentAnchor();        
    if(currentAnchor == anchor){
        highlightSearch(); 
    }else{
        currentKeywordAnchor=anchor;
        gotoAnchor("anch" + anchor);        
    }    
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
    if (currentKeyword != null && currentKeyword != "") {
        jQuery("#keywordbody").val(currentKeyword);
        jQuery("#searchinstant").slideDown("slow");
        searchWord(currentKeyword);
        currentKeyword = null;
    }
}

function fechaJanela() {
    jQuery.fn.modalBox('close');
}

function getPagesLink(sector) {
    return base + 'flip/jornal/skins/king/jsp/' + sector + '.jsp';
}

function getPrintLink() {
    jQuery.getScript(base + 'flip/jornal/skins/king/js/printPDF.js');
    flag = 0;
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('imprimir') + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;
    return url;
}
var editingText = '';
function toogleTextField() {
    if (editingText == '') {
        editingText = jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').val("");
        jQuery(".multimidia_textfield").ForceNumericOnly();
    } else {
        var number = jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').unbind("keydown");
        jQuery(".magazine").turn("page", number);
        editingText = '';
        jQuery('.multimidia_textfield').trigger("blur");
    }
}


function updatePageChange() {
    var current = jQuery(".magazine").turn("page");
    var total = jQuery(".magazine").turn("pages");
    var text = '';
    if (current == 0 || current == total || current == null || current == 1) {
        if (current == 0 || current == null) {
            current = 1;
        }
        text = current + ' de ' + total;
    } else {
        var n = current % 2 === 0 ? current : current - 1;
        var pages = n + ' e ' + (n + 1);
        text = pages + ' de ' + total;
    }
    jQuery('.multimidia_textfield').val(unescape(text));
    pageNumber = current;
    var pageEdition = getCurrentEdition();

    if (jQuery('#banner_lateral').length) { //se possui banner na lateral,verifica        
        updateSideBanner(current);
    }
    trackTimePage(current);
    if (current > 1) {
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageviewTracking', 'screenName': dataAnalytics + ' - pagina ' + current});
        } else {
            var trackzoom = '/' + linkedicao + 'edicao=' + pageEdition + '/pagina=' + current;
            if (_gaq) {
                _gaq.push(['_trackPageview', trackzoom]);
                _gaq.push(['_trackEvent', document.title, 'Folhear', 'Pagina ' + current]);
            }
        }
        if (kiss != null) {
            kiss.visitouConteudo();
        }
    } else {
        if (kiss != null) {
            kiss.visitouCapa();
        }
    }
    calculaAltura();    
    validateRecommend(current, total);
    if (jQuery('#comment_count').length) {
        reload_comments();
    }    
}

function getCurrentAnchor() {
    var page = jQuery(".magazine").turn("page");
    return jQuery(".page-" + page).attr('id');
}
function addPage(page, book) {
    var id, pages = book.turn('pages');
    var element = jQuery('<div />', {});
    if (book.turn('addPage', element, page)) {
        element.html('<div class="loader"></div>');
        loadPage(page, element);
    }
}
function loadPage(page, pageElement) {
    if (pageslist[page - 1][2] == 'HTML5') {
        var img = jQuery('<div class="htmlcontent"/>');
        var id = pageslist[page - 1][0];
        jQuery(img).html(jQuery("#html5-" + id).html());
        jQuery(img).appendTo(pageElement);
        jQuery(img).css("width", "100%").css("height", "100%");
        pageElement.find('.loader').remove();
        img.css("z-index", "999999999999999999999");
        calculaAltura();
    } else {
        if (pageslist[page - 1][2].indexOf(".html") != -1 || pageslist[page - 1][2].indexOf(".zip") != -1) {
            var img = jQuery('<div class="htmlcontent"/>');
            var url = pageslist[page - 1][2];
            if (pageslist[page - 1][2].indexOf(".zip")) {
                url = 'html5.jsp?path=' + url;
            }
            if (url.indexOf("http") == -1) {
                url = base + url;
            }
            url = url.replace('&amp', '&');
            var height = jQuery(window).height() - 80;
            var newx = (doc_x * height) / doc_y;
            jQuery('<iframe>', {
                src: url,
                id: 'frame' + page,
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
            });
            var url = pageslist[page - 1][2];
            if (url.indexOf("http") == -1) {
                url = base + url;
            }
            url = url.replace('&amp;', '&');
            img.attr('src', url).attr('class', 'pageimg');

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
    options = jQuery('.magazine').turn('options'), imageWidth = options.width / 2, imageHeight = options.height;
    for (var i = 0; i < pftemplinks.length; i++) {        
        if (pftemplinks[i][1] == page) {            
            was = true;
            x = parseInt(pftemplinks[i][2]);
            y = parseInt(pftemplinks[i][3]);
            w = parseInt(pftemplinks[i][4]);
            h = parseInt(pftemplinks[i][5]);
            px = parseInt(pftemplinks[i][7]);
            py = parseInt(pftemplinks[i][8]);
            var newx = parseFloat(imageWidth) / (100 / px);
            var newy = parseFloat(imageHeight) / (100 / py);
            var neww = (w * parseFloat(imageWidth)) / pftemplinks[i][10];
            var newh = (h * parseFloat(imageHeight)) / pftemplinks[i][11];
            var region = {
                "x": newx,
                "y": newy,
                "percX": pftemplinks[i][7],
                "percY": pftemplinks[i][8],
                "width": neww,
                "height": newh,
                "class": pftemplinks[i][0],
                "data": {
                    "index": pftemplinks[i][1],
                    "url": pftemplinks[i][6],
                    "text": pftemplinks[i][12],
                    "width": neww,
                    "height": newh,
                    "id": pftemplinks[i][9]
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
    options = jQuery('.magazine').turn('options'),
                    imageWidth = options.width / 2,
                    imageHeight = options.height;
            
    for (var i = 0; i < pfmedias.length; i++) {
        if (pfmedias[i][1] == page) {
            was = true;
            x = parseInt(pfmedias[i][2]);
            y = parseInt(pfmedias[i][3]);
            w = parseInt(pfmedias[i][4]);
            h = parseInt(pfmedias[i][5]);
            px = parseInt(pfmedias[i][7]);
            py = parseInt(pfmedias[i][8]);
            var newx = parseFloat(imageWidth) / (100 / px);
            var newy = parseFloat(imageHeight) / (100 / py);
            var neww = (w * parseFloat(imageWidth)) / pfmedias[i][10];
            var newh = (h * parseFloat(imageHeight)) / pfmedias[i][11];

            var texticon = "";
            if (pfmedias[i][12]) {
                texticon = pfmedias[i][12];
                pfmedias[i][12] = pfmedias[i][12].split(" ").join("%_%");
            }
            var skin = "default";
            if (pfmedias[i][15]) {
                skin = pfmedias[i][15];
            }

            if (newh <= 0) {
                newh = 15;
            }            
            var region = {
                "x": newx,
                "y": newy,
                "percX": pfmedias[i][7],
                "percY": pfmedias[i][8],
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
    var tooltip = region.data.url.indexOf("anch") == -1 ? region.data.texticon : "Clique aqui";
    var reg = jQuery('<div />', {
        'class': 'region  ' + region['class'],
        'alt': tooltip,
        'title': tooltip
    });
    var height = Math.round(region.height / pageHeight * 100);
    if (parseInt(height) == 0) {
        height = region.height;
    }
    reg.css({
        top: region.percY + '%',
        left: region.percX + '%',
        width: Math.round(region.width / pageWidth * 100) + '%',
        height: height + '%'
    }).attr('region-data', jQuery.param(region.data || ''));
    
    if (region['class'] != 'search') {
        if (region['class'] == 'video' && iconVideo == false) {
            if (region.data.url.indexOf("youtube") != -1) {
                var url = region.data.url;
                if (url.indexOf("https://") != -1) {
                    url = url.replace("https://", "http://");
                }
                var index = region.data.index;
                url = YouTubeUrlNormalize(url) + "?showinfo=0";
                var html = '<div id="player' + index + '">';
                html = html + '<iframe width="' + region.width + '" height="' + region.height + '" style="width:"' + region.width + '";height:"' + region.height + ';" src="' + url + '" frameborder="0" allowfullscreen></iframe>';
                html = html + '</div>';
                jQuery(reg).append(html);
            } else {
                var url = region.data.url;
                var index = region.data.index;
                var video = '<video width="' + region.width + '" height="' + region.height + '"  style="width: 100%; height: 100%;"  id="player' + index + '" preload="none" controls autoplay>';
                video = video + '<source type="video/mp4" src="' + url + '" codecs="avc1.42E01E, mp4a.40.2"/>';
                video = video + '</video>';
                jQuery(reg).append(video);
            }
        } else {
            if (region.data.icon != '' && region.data.icon != undefined) {
                if (region.data.tipo == 'I') {
                    var img = jQuery('<img/>', {
                        'src': base + region.data.url,
                        'class': 'regionImage'
                    });
                    jQuery(img).css('left', "0px").css('top', "0px").css('max-height', "100%");
                    img.appendTo(reg);
                } else {
                    var img = jQuery('<img/>', {
                        'class': 'iconimg',
                        'src': base + region.data.icon
                    });
                    jQuery(img).css('left', "0px").css('top', "0px");
                    if(typeof manterProporcao !== "undefined"){
                        if(manterProporcao){
                            jQuery(img).css('height', "100%");
                            jQuery(img).css('max-height', "100%");
                        } else {
                            jQuery(img).css('max-height', region.height + "px");
                        }
                    } else {
                        jQuery(img).css('max-height', region.height + "px");
                    }
                    
                    img.appendTo(reg);
                }
            } else {
                var icon = jQuery('<div/>', {
                    'class': region['class'] + 'img'
                });
                icon.appendTo(reg);
            }
        }
    }
    reg.appendTo(pageElement);    
}

function regionClick(event) {

    var region = jQuery(event.target);
    if (region.hasClass('linkimg') || region.hasClass('videoimg') || region.hasClass('galleryimg') || region.hasClass('iconimg')) {
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
            if (data.url.indexOf("anch") != -1) {
                gotoAnchor(data.url);
            } else {
                if (data.tipo == 'V') {
                    var url = data.url;
                    Videobox.leiaMais(url, data.text);
                } else {
                    window.open(data.url);
                }
            }
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu link', 'eventLabel': dataAnalytics});
            }
            break;
        case 'icon' :
            if (data.url.indexOf("anch") != -1) {
                gotoAnchor(data.url);
            } else {
                if (data.tipo == 'V') {
                    var url = data.url;
                    Videobox.leiaMais(url, data.text);
                } else {
                    window.open(data.url);
                }
            }
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu link', 'eventLabel': dataAnalytics});
            }
            break;
        case 'zoom' :
            var regionOffset = region.offset(),
                    viewportOffset = jQuery('.magazine-viewport').offset(),
                    pos = {
                        x: regionOffset.left - viewportOffset.left,
                        y: regionOffset.top - viewportOffset.top
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
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu Video', 'eventLabel': dataAnalytics});
            }
            break;
        case 'gallery':
            openGalleryHtml5(data.url, data.text, data.skin);
            break;
        case 'search':
            var regionOffset = region.offset(),
                    viewportOffset = jQuery('.magazine-viewport').offset(),
                    pos = {
                        x: regionOffset.left - viewportOffset.left,
                        y: regionOffset.top - viewportOffset.top
                    };
            jQuery('.magazine-viewport').zoom('zoomIn', pos);
            break;
        case 'audiopicture':
            var url = window.location.origin + "/" + data.url;
            window.open(window.location.origin + "/flip/jornal/skins/html5full/jsp/audioLink.jsp?audiourl=" + url, "_blank", "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300, left=500, width=350,height=40");
            break;
    }
}

function openGalleryHtml5(cd, text, skin) {

    if (skin == 'default') {
        var url = base + '/flip/jornal/plugin/gallery.jsp?cd=' + cd;
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
            'id': 'gallery' + cd
        });
        var first = null;
        for (var i = 0; i < pfmediaspics.length; i++) {
            if (pfmediaspics[i][1] == cd) {
                var img = jQuery('<img/>', {
                    'src': base + pfmediaspics[i][2],
                    'data-darkbox': base + pfmediaspics[i][2],
                    'data-darkbox-description': pfmediaspics[i][3],
                    'alt': pfmediaspics[i][3]
                });
                img.appendTo(html);
                if (first == null) {
                    first = img;
                }
            }
        }
        jQuery("body").append(html);
        loadDarkBox();
        jQuery(first).click();
    }
    if (dataLayer != null) {
        dataLayer.push({'event': 'eventTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu galeria', 'eventLabel': dataAnalytics});
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
    var url = pageslist[page - 1][1];
    if (url.indexOf("http") == -1) {
        url = base + url;
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
    var url = base + pageslist[page - 1][2];
    img.attr('src', url);
    img.attr('class', 'pageimg');
}

function customForward(page, frmName) {
    var frm = jQuery("#" + frmName);
    var url = base + 'flip/jornal/jsp/customs/' + page;
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

// verifica se um campo esta vazio ou nï¿½o existe
function isEmpty(campo) {
    return (campo == null || campo.value == null || campo.value == '');
}


var page = 0;
function openEditionMode() {
    openEditionMode(0);
}
function openEditionMode(p) {
    var html = '<div id="header"><li class="header">EDIÇÕES</li></div>';
    var pageAnchor = getCurrentEdition();
    page = p;
    if (!page || page == undefined) {
        page = 0;
    }
    var nr = jQuery("#numero") != null ? jQuery("#numero").val() : null;
    var di = jQuery("#dataInicial") != null ? jQuery("#dataInicial").val() : null;
    var df = jQuery("#dataFinal") != null ? jQuery("#dataFinal").val() : null;
    var tx = jQuery("#texto") != null ? jQuery("#texto").val() : null;
    var url = getPagesLink('edicoes') + '?idForm=' + pageAnchor + '&linkedicao=' + linkedicao + '&pagina=' + page;
    if (nr != null && nr != undefined) {
        url = url + "&nr=" + nr;
    }
    if (di != null && di != undefined) {
        url = url + "&di=" + di;
    }
    if (df != null && df != undefined) {
        url = url + "&df=" + df;
    }
    if (tx != null && tx != undefined) {
        url = url + "&tx=" + tx;
    }

    //marison - troquei includes para indexof
    if (url.indexOf("pub/senai") != -1)
        html = '<div id="header"><li class="header">Livros do curso</li></div>';

    jQuery('.dockedicao').html("<img src='" + basestatic + "flip/jornal/images/loading_bar.gif' align='center' style='margin-top:100px'/>");
    jQuery.post(url, function (data) {
        jQuery('#edicoes_barra .free').html(html + data);
    });

    if (kiss != null) {
        kiss.visitouGaleria();
    }
}


function isChrome() {
    return navigator.userAgent.indexOf('Chrome') != -1;
}
function getInternetExplorerVersion() {
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}
var IEV = getInternetExplorerVersion();

function disableControls(page) {
    if (page == 1)
        jQuery('.previous-button').hide();
    else
        jQuery('.previous-button').show();

    if (page == jQuery('.magazine').turn('pages'))
        jQuery('.next-button').hide();
    else
        jQuery('.next-button').show();

    updatePageChange();
}

function playsound() {
    if (soundEnabled == true && (!isIE || IEV >= 9)) {
        jQuery('#turn' + (Math.floor((Math.random() * 5) + 1))).get(0).play();
    }
}
// Set the width and height for the viewport
var oldOptionsX = 0;
var oldOptionsY = 0;
function resizeViewport() {
    var width = jQuery(window).width(), height = jQuery(window).height(), options = jQuery('.magazine').turn('options');
    var display = jQuery('.magazine').turn('display');
    var posH = jQuery('.magazine').turn('zoom') == 1 ? height : height - 50;
    jQuery('.magazine').removeClass('animated');
    jQuery('.magazine-viewport').css({
        width: width,
        height: posH//-100      
    }).zoom('resize');
    if (jQuery('.magazine').turn('zoom') == 1) {
        $(".zoomtools .zoom").css("opacity", .9);
        
        var newy = posH - 50;
        var newx = ((doc_x * newy) / doc_y) * 2;

        var ox = options.width;
        var oy = options.height;
        if (fullscreen == true) {
            oldOptionsX = options.width;
            oldOptionsY = options.height;
        } else {
            if (oldOptionsX > 0) {
                options.width = oldOptionsX;
                ox = oldOptionsX;
                oldOptionsX = 0;
            }
            if (oldOptionsY > 0) {
                options.height = oldOptionsY;
                oy = oldOptionsY;
                oldOptionsY = 0;
            }
        }        
        var bound = calculateBound({
            width: fullscreen == true ? newx : ox,
            height: fullscreen == true ? newy : oy,
            boundWidth: fullscreen == true ? Math.max(ox, newx) : Math.min(ox, width),
            boundHeight: fullscreen == true ? Math.max(oy, newy) : Math.min(oy, height)
        });
        if (bound.width % 2 !== 0)
            bound.width -= 1;
        if (bound.width != jQuery('.magazine').width() || bound.height != jQuery('.magazine').height()) {
            jQuery('.magazine').turn('size', bound.width, bound.height);
            jQuery('.next-button').css({
                height: bound.height,
                backgroundPosition: '-38px ' + (bound.height / 2 - 32 / 2) + 'px'
            });
            jQuery('.previous-button').css({
                height: bound.height,
                backgroundPosition: '-4px ' + (bound.height / 2 - 32 / 2) + 'px'
            });
        }

        jQuery('.magazine').css({
            top: -bound.height / 2,
            left: -bound.width / 2
        });

    } else {
        setTimeout(function(){
            $(".zoomtools .zoom").css("opacity", .2);
        }, 1000);
    }
    jQuery('.magazine').addClass('animated');
}
function largeMagazineWidth() {
    return jQuery(window).width() * 1.2;
}
function decodeParams(data) {
    var parts = data.split('&'), d, obj = {};
    for (var i = 0; i < parts.length; i++) {
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
    if (bound.width > d.boundWidth || bound.height > d.boundHeight) {
        var rel = bound.width / bound.height;
        if (d.boundWidth / rel > d.boundHeight && d.boundHeight * rel <= d.boundWidth) {
            bound.width = Math.round(d.boundHeight * rel);
            bound.height = d.boundHeight;
        } else {
            bound.width = d.boundWidth;
            bound.height = Math.round(d.boundWidth / rel);
        }
    }
    return bound;
}

function loading() {
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            data: '<p align=center>' + jQuery('#loading').html() + '</p>'
        }
    });
}
function openProdutosMode() {
    openProdutosMode(0);
}
function openProdutosMode(p) {
    var html = '<div id="header"><li class="header">' + tituloAbaProdutos + '</li></div>';

    var pageAnchor = getCurrentEdition();
    page = p;
    if (!page || page == undefined) {
        page = 0;
    }
    var url = getPagesLink('produtos') + '?idForm=' + pageAnchor + '&linkedicao=' + linkedicao + '&pagina=' + page;
    jQuery.post(url, function (data) {
        jQuery('#produtos_barra .free').html(html + data);
    });
}

function openVolumesMode() {
    openVolumesMode(0);
}
function openVolumesMode(p) {
    var html = '<div id="header"><li class="header">Volumes</li></div>';
    var pageAnchor = getCurrentEdition();
    page = p;
    if (!page || page == undefined) {
        page = 0;
    }
    var url = getPagesLink('volumes') + '?idForm=' + pageAnchor + '&linkedicao=' + linkedicao + '&pagina=' + page;
    jQuery.post(url, function (data) {
        jQuery('#volume_barra .free').html(html + data);
    });
}


function playSound(id) {
    var url = getPagesLink('audioLink') + '?audio=' + id;
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
    if (jQuery("#facerecomenda"))
        jQuery("#facerecomenda").hide("slow");
}
function showRecommendArea() {
    if (jQuery("#facerecomenda"))
        jQuery("#facerecomenda").show("slow");
}
function fixedEncodeURIComponent(str) {
    return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
}

function validateRecommend(current, total) {
    if (jQuery("#facerecomenda")) {
        var faceurltemplate = "";
        if (facebookshare == true) {
            faceurltemplate = "http://www.facebook.com/plugins/like.php?href=$URL&;layout=standard&show_faces=false&width=380&action=like&colorscheme=light&height=30&locale=pt_BR&share=true";
        } else {
            faceurltemplate = "http://www.facebook.com/plugins/like.php?href=$URL&;layout=standard&show_faces=false&width=380&action=recommend&colorscheme=light&height=30&locale=pt_BR";
        }
        var width = jQuery(".magazine-viewport").css('width');
        if (current > 0 && current % 2 == 0) {
            current--;
        }
        var anchor = getPageAnchor(current);
        anchor = anchor.replace('anch', '');
        var link = base + linkedicao + '?edicao=' + getCurrentEdition() + '&ipg=' + anchor;
        link = fixedEncodeURIComponent(link);

        var url = faceurltemplate.replace("$URL", link);
        jQuery("#faceframeleft").attr('src', url);
        if (current == 0 || current == total || current == null) {
            width = parseInt(width.replace("px", "")) / 3;
            jQuery("#faceright").hide();
            jQuery("#facerecomenda").css("width", width + "px");
            jQuery("#faceleft").css("width", "100%");
            jQuery(".closeleft").show();
        } else {
            jQuery(".closeleft").hide();
            width = parseInt(width.replace("px", "")) / 2;
            width = width + 150;
            jQuery("#facerecomenda").css("width", width + "px");
            jQuery("#faceleft").css("width", "50%");
            jQuery("#faceright").css("width", "50%");
            jQuery("#faceright").show();
            anchor = getPageAnchor(current + 1);
            anchor = anchor.replace('anch', '');
            link = base + linkedicao + '?edicao=' + getCurrentEdition() + '&ipg=' + anchor;
            link = fixedEncodeURIComponent(link);
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
                    var key = e.charCode || e.keyCode || 0;
                    // allow backspace, tab, delete, arrows, numbers and keypad numbers ONLY
                    return (
                            key == 8 ||
                            key == 9 ||
                            key == 46 ||
                            (key >= 37 && key <= 40) ||
                            (key >= 48 && key <= 57) ||
                            (key >= 96 && key <= 105));
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
        zmax = cur > zmax ? cur : zmax;
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
    return pageslist[page - 1][0];
}

function getCurrentAnchor() {
    var page = jQuery(".magazine").turn("page");
    return pageslist[page - 1][0];
}
function getCurrentPage() {
    return jQuery(".magazine").turn("page");
}
function searchWord(w) {
    //console.log('Procurando por '+w);
}
function getPageCount() {
    return jQuery(".magazine").turn("pages");
}
function abreIndice(anchor, editoria) {
    gotoAnchor(anchor, false);
    if (kiss != null) {
        kiss.visitouEditoria(editoria);
    }
}
function gotoAnchor(anchor) {
    anchor = anchor.replace("anch", "");
    if (anchor.indexOf("product:") != -1) {
        anchor = anchor.replace("product:", "");
        window.location.href = base + 'pub/' + anchor;
    } else {
        for (var i = 0; i < pageslist.length; i++) {
            if (pageslist[i][0] == anchor) {
                jQuery(".magazine").turn("page", (i + 1));                
                return i + 1;
            }
        }
    }
    return null;
}

function getPageByAnchor(anchor){
    for (var i = 0; i < pageslist.length; i++) {
            if (pageslist[i][0] == anchor||'anch'+pageslist[i][0] == anchor) {
                jQuery(".magazine").turn("page", (i + 1));                
                return i + 1;
            }
    }
    return 1;
}

function disabledEventPropagation(event)
{
    if (event.stopPropagation) {
        event.stopPropagation();
    } else if (window.event) {
        window.event.cancelBubble = true;
    }
}
function loadDataPesquisaResult() {
    if (searchResult != null) {
        jQuery('#result').html(searchResult);
        jQuery('#result').show();
        jQuery("#aguarde").hide();
        jQuery("#areabotoes").show();
    }
}

function abrePdf(link) {
    if (isIE) {
        var wnd = window.open();
        wnd.location.href = link + '&ie=S';
    } else {
        var wnd = window.open();
        wnd.location.href = link;
    }
}

function getOriginalWidthOfImg(img_element) {
    var t = new Image();
    t.src = (img_element.getAttribute ? img_element.getAttribute("src") : false) || img_element.src;
    return t.width;
}
function getOriginalHeightOfImg(img_element) {
    var t = new Image();
    t.src = (img_element.getAttribute ? img_element.getAttribute("src") : false) || img_element.src;
    return t.height;
}

function openFullScreen() {
    $('#megazine').fullscreen();
}
