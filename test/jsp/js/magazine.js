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
var fullscreen = false;

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
    //console.log('wheel '+e);


    if(ARTICLE_OPENED == true){
        var delta = extractDelta(e);
        $('#wrapper').animate( { scrollLeft: '-='+delta }, 50, 'easeOutQuad' );
        if (e.preventDefault) e.preventDefault();
        return false;
    }

    if (scrollenabled == true && selectTextMode == false) {
        var delta = extractDelta(e);
        //console.log('delta = '+delta);

        var frm = $('.framepageimg');
        //console.log($(frm).scrollLeft());

        if (pageWheel == true && zoommode == false) {

            console.log('scrollenabled')

            if (delta / 120 > 0) {
                setTimeout(function () {
                    $('.multimidia_prev').click();
                }, 200);
            } else {
                setTimeout(function () {
                    $('.multimidia_next').click();
                }, 200);
            }
            if (e.preventDefault) { /* Chrome, Safari, Firefox */
                e.preventDefault();
            }
            return false;
        } else {
            if (zoommode == true) {
                disabledEventPropagation(e);
                if (delta / 120 > 0) {
                    setTimeout(function () {
                        increaseZoom(e);
                    }, 50);

                } else {
                    setTimeout(function () {
                        decreaseZoom(e);
                    }, 50);
                }
                if (e.preventDefault) { /* Chrome, Safari, Firefox */
                   e.preventDefault();
                }
                return false;
            }
        }
    }
    return true;
};
//$('.speed').hide();
var previous = 37, next = 39, esc = 27, up = 38, down = 40;
teclas = function (e) {
    var source = e.target || e.srcElement;
    switch (e.keyCode) {
        case previous:
            if ($(source).is("input") == false && flipenabled == true) {
                $('.multimidia_prev').click();
            }
            break;
        case next:
            if ($(source).is("input") == false && flipenabled == true) {
                $('.multimidia_next').click();
            }
            break;
        case esc:
            if ($(source).is("input") == false) {
                closeZoom();
            }
            break;
        case up:
            if (zoommode == true) {
                $(window).scrollTop($(window).scrollTop() - 20);
            }
            break;
        case down:
            if (zoommode == true) {
                $(window).scrollTop($(window).scrollTop() + 20);
            }
            break;
    }
};

function attachTouchMovements() {

    var element = $('.page_left>.pageimg,.page_right>.pageimg');
    element.hammer({
        recognizers: [
            [Hammer.Pinch, {enable: true}],
            [Hammer.Swipe, {direction: Hammer.DIRECTION_HORIZONTAL}]
        ]
    }).on('pinchout swipeleft swiperight', function (ev) {
        var type = ev.type;
        console.log('event  type = '+type);
        switch (type) {
            case 'swipeleft':
                $('.multimidia_next').click();
                break;
            case 'swiperight':
                $('.multimidia_prev').click();
                break;
            case 'pinchout':
                var pageIndex = $(this).attr('page-index');
                showZoom(pageArray[parseInt(pageIndex)]);
                break;
        }
    });
    element = $('#readerzoom');
    element.hammer({
        recognizers: [
            [Hammer.Pinch, {enable: true}],
            [Hammer.Swipe, {direction: Hammer.DIRECTION_HORIZONTAL}]
        ]
    }).on('pinchin pinchout swipeleft swiperight', function (ev) {
        var type = ev.type;
        console.log('event zoom type = '+type);
        switch (type) {
            case 'swipeleft':
                $('.multimidia_next').click();
                break;
            case 'swiperight':
                $('.multimidia_prev').click();
                break;
            case 'pinchout':
                increaseZoom(ev);
                break;
            case 'pinchin':
                if (zoomScale <= 1) {
                   // closeZoom();
                } else {
                    decreaseZoom(ev);
                }
                break;
        }
    });

    //$('.multimidia_next').click();

}

function onOrientationChanged() {
    setTimeout(function () {
        console.log('orientation - ' + fullscreen);
    }, 200);
}

function loadMagazineApp() {
    $.ajaxSetup({
        async: false,
        beforeSend: function (jqXHR) {
            jqXHR.overrideMimeType('text/html; charset=iso-8859-1')
            jqXHR.setRequestHeader('Accept', 'text/html; charset=iso-8859-1');
        }
    });

    $(window).bind('orientationchange', function (e, onready) {
        onOrientationChanged();
    });
    $(document).on('webkitfullscreenchange mozfullscreenchange fullscreenchange MSFullscreenChange', function () {
        fullscreen = !fullscreen;
    });
    $(window).bind('resize', function (e, onready) {
        onOrientationChanged();
    });
    $('.imprimir').click(function (e) {
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
            scrollenabled = false;
            $.fn.modalBox({
                directCall: {
                    source: getPrintLink()
                }
            });
        }
        return false;
    });
    $('.procurar').click(function (e) {
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
            scrollenabled = false;
            $.fn.modalBox({
                setWidthOfModalLayer: 600,
                positionTop: "20",
                directCall: {
                    source: getSearchLink()
                }
            });
        }
        return false;
    });
    $('#basic-modal .recomendar').click(function (e) {
        scrollenabled = false;
        $.fn.modalBox({
            setWidthOfModalLayer: 600,
            directCall: {
                source: getRecommentLink()
            }
        });
        return false;
    });
    $('#basic-modal .comentar').click(function (e) {
        openCommentMode();
        return false;
    });
    $('#basic-modal .contato').click(function (e) {
        openContactMode();
        return false;
    });
    $('#basic-modal .texto').click(function (e) {
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
            $.getScript(base + 'flip/jornal/skins/king/js/jquery.copy.min.js');
            scrollenabled = false;
            $.fn.modalBox({
                setWidthOfModalLayer: 680,
                directCall: {
                    source: getTextLink()
                }
            });
        }
        return false;
    });
    $('#basic-modal .pdf').click(function (e) {
        if (flipenabled == false) {
            checkLogged();
        }
        if (flipenabled == true) {
            var id = this.id;
            getPDFLink(id);
        }
        return false;
    });
    $('#basic-modal .basic').click(function (e) {
        $('#basic-modal-content').modal();
        return false;
    });
    $('.menu_home').click(function () {
        window.location.href = base + linkedicao;
    });
    $('.multimidia_fr').click(function () {
        turn("page", 1);
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Primeira Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    $('.multimidia_prev').click(function () {
        turn('previous');
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Retornou Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    $('.multimidia_next').click(function () {
        turn('next');
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Avancou Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    $('.multimidia_ff').click(function () {
        var amount = turn("pages");
        turn("page", amount);
        if (dataLayer != null) {
            dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Ultima Pagina', 'eventLabel': dataAnalytics});
        }
        return false;
    });
    $('.multimidia_textfield').focus(function () {
        return toogleTextField();
    });
    $('.multimidia_textfield').blur(function () {
        updatePageChange();
        editingText = '';
    });
    $('.multimidia_textfield').keyup(function (e) {
        if (e.keyCode == 13) {
            return toogleTextField();
        }
    });

    $(".closeicon").click(function (e) {
        closeZoom();
    });
    $('.tooltip').click(function (e) {
        openCommentModeMarkup();
        return false;
    });
    shortcut.add("Ctrl+Right", function () {
        $('.multimidia_ff').trigger("click");
    });
    shortcut.add("Ctrl+Left", function () {
        $('.multimidia_fr').trigger("click");
    });
    shortcut.add("Ctrl+K", function () {
        var amount = turn("pages");
        turn("page", amount);
        turn('zoom', 'in');
    });
    shortcut.add("Ctrl+A", function () {
        closeZoom();
    });
    $(window).mousewheel(wheelFunction);
    $(window).keydown(teclas);

    if (ipg != null || typeof pg !== 'undefined') {
        if (ipg != null) {
            ipg = ipg.trim().replace("id", "");
            $(document).ready(function () {
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
                    turn("page", pg);
                }, 500);
            }
        }
    }
    //attachTouchMovements();
}

function applyZoomOutListener() {
    $('.zoom-out').click(function (event) {
        var origin = $(event.target).attr('class');
        if (origin != undefined && (origin.indexOf("mejs") != -1 || origin.indexOf("audiopicture") != -1 || origin.indexOf("link") != -1 || origin.indexOf("video") != -1 || origin.indexOf("gallery") != -1 || origin.indexOf("icon") != -1)) {
            return regionClick(event);
        } else {
            if (doubleClickZoom == false) {
                if (flipenabled == false) {
                    checkLogged();
                } else {
                    turn('zoom', 'in');
                }
            }
        }
    });
}

function getRecommentLink() {
    var edition = getCurrentEdition();
    var url = getPagesLink('recomendacao') + '?idForm=' + edition;
    return url;
}

function recomendaAmigo() {
    $('#pagina_anchor').val(getCurrentAnchor());
    var frm = $('#faleConoscoForm');

    var link = $(location).attr('href');
    if (link.indexOf('?') == -1) {
        link = link + '?'
    } else {
        link = link + '&';
    }
    link = link + 'ipg=' + getCurrentAnchor();
    $("#link").val(link);

    if ($("#nomeId").val() == "") {
        alert("Informe o seu nome.");
        return false;
    }
    if ($("#emailId").val() == "") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!$.validateEmail($("#emailId").val())) {
            alert("O seu email parece incorreto. Corrija-o.!");
            return false;
        }
    }
    if ($("#para1").val() == "" && $("#para2").val() == "" && $("#para3").val() == "" && $("#para4").val() == "") {
        alert("Você precisa informar o email de pelo menos um amigo.");
        return false;
    }
    if ($("#para1").val() != "" && !$.validateEmail($("#para1").val())) {
        alert("O  email " + $("#para1").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if ($("#para2").val() != "" && !$.validateEmail($("#para2").val())) {
        alert("O  email " + $("#para2").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if ($("#para3").val() != "" && !$.validateEmail($("#para3").val())) {
        alert("O  email " + $("#para3").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }
    if ($("#para4").val() != "" && !$.validateEmail($("#para4").val())) {
        alert("O  email " + $("#para4").val() + " parece incorreto. Corrija-o antes de enviar.");
        return false;
    }

    _gaq.push(['_trackEvent', document.title, 'Recomenda', 'Recomendacao de ' + $("#emailId").val()]);
    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();
    loading();

    $.post(url, function (message) {
        $.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    return true;
}

function entraEmContato() {
    $('#pagina_anchor').value = getCurrentAnchor();
    var frm = $('#faleConoscoForm');

    if ($("#nomeId").val() == "") {
        alert("Informe o seu nome.");
        return false;
    }
    if ($("#emailId").val() == "") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!$.validateEmail($("#emailId").val())) {
            alert("Informe um email válido!");
            return false;
        }
    }
    if ($("#assunto").val() == "") {
        alert("Informe o assunto.");
        return false;
    }
    if ($("#mensagem").val() == "") {
        alert("Informe a mensagem.");
        return false;
    }

    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();
    loading();
    $.post(url, function (message) {
        $.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    _gaq.push(['_trackEvent', document.title, 'Contato', 'Contato de ' + $("#emailId").val()]);

    return true;
}



function openContactMode() {
    var edition = getCurrentEdition();
    var url = getPagesLink('faleConosco') + '?idForm=' + edition + '&modelo=' + mid;
    $.fn.modalBox({
        setWidthOfModalLayer: 600,
        directCall: {
            source: url
        }
    });
}

function register() {
    var frm = $('#cadastroForm');

    if (validateForm(frm)) {
        var url = base + 'flip/loginEdicao.do?' + frm.serialize();
        loading();
        $.post(url, function (message) {
            $.fn.modalBox({
                setWidthOfModalLayer: 300,
                directCall: {
                    data: message
                }
            });
        }, function (error) {
            $.fn.modalBox({
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
    $.fn.modalBox('close');
    setTimeout(function () {
        var url = getPagesLink('cadastro') + '?modelo=' + mid;
        $.fn.modalBox({
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
            $('.megazine').hide();
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
    $('.megazine').hide();
    var link = "login.jsp?edicao=" + getCurrentEdition();
    window.location.href = link;
//}
}


function ajaxRegisterZoom() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    document.frm.idForm.value = pageAnchor;
    document.frm.idEdicao.value = pageEdition;
    if (pageAnchor != null) {
        var trackzoom = '/' + linkedicao + 'zoom/edicao=' + pageEdition + '/pagina=' + getCurrentPage();
        _gaq.push(['_trackPageview', trackzoom]);
        _gaq.push(['_trackEvent', document.title, 'Zoom', 'Zoom na pagina ' + getCurrentPage()]);
        $.post(base + 'flip/jornal/jsp/registraZoom.jsp', $('#frm').serialize());
    }
}

function abrePesquisa(url, link, anchor, soessa, keyword) {
    currentKeyword = keyword;
    //anchor=anchor;
    var params = '?pagina=' + anchor + '&keyword=' + keyword
    pftemplinks = new Array();
    indextemplinks = 0;
    $.post(base + 'flip/jornal/jsp/searchText.jsp' + params, params, function (data) {
        if (data.indexOf(";") != -1) {
            var results = data.split(";");
            var page = turn("page");
            for (var i = 0; i < results.length; i++) {
                var word = results[i].split(",");
                pftemplinks[indextemplinks++] = ['search', page, word[0], word[1], word[2], word[3], '#', word[4], word[5], 'X', word[6], word[7], 'Pesquisa por ' + keyword];
            }
            var element = $("div[page=" + page + "]");
            loadTempRegions(page, element);
            if (zoomenabled == true) {
                turn('zoom', 'in');
            }
        }
    });
    gotoAnchor("anch" + anchor);
    fechaJanela();
    return false;
}

function atualizaPesquisa() {
    var value = $("#keywordbody").val();
    searchWord(value);
}

function cancelaPesquisa() {
    searchWord("");
    $("#searchinstant").slideUp("slow");
    currentKeyword = null;
}
var currentKeyword = "";
function selectcurrentword() {
    if (currentKeyword != null && currentKeyword != "") {
        $("#keywordbody").val(currentKeyword);
        $("#searchinstant").slideDown("slow");
        searchWord(currentKeyword);
        currentKeyword = null;
    }
}

function fechaJanela() {
    //$.fn.modalBox('close');
    fecharOutros();
}

function getPagesLink(sector) {
    return base + 'flip/jornal/skins/article/jsp/' + sector + '.jsp';
}

function getPrintLink() {
    $.getScript(base + 'flip/jornal/skins/king/js/printPDF.js');
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
        editingText = $('.multimidia_textfield').val();
        $('.multimidia_textfield').val("");
        $(".multimidia_textfield").ForceNumericOnly();
        return false;
    } else {
        var number = $('.multimidia_textfield').val();
        $('.multimidia_textfield').unbind("keydown");
        if (number <= 0 || number > pageArray.length) {
            return false;
        } else {
            turn("page", number);
            editingText = '';
            $('.multimidia_textfield').trigger("blur");
            return true;
        }
    }
}

function updateZoomChange(state, page) {
    if (state == 'zoom_status_open') {
        if (!verifyBlockedPages(page)) {
            return false;
        }
        ajaxRegisterZoom();
        if ($('#zoom_layer')) {
            $('#zoom_layer').show();
        }
        return true;
    } else {
        if ($('#zoom_layer')) {
            $('#zoom_layer').hide();
        }
        return true;
    }
}

function updatePageChange() {
    var current = parseInt(turn("page"));
    var total = turn("pages");
    var text = '';
    var zoomEnabled = isZoomEnabled();
    //  console.log('current is '+current);
    if (singlePageOn == true || zoomEnabled == true || current == 0 || current == total || current == null || current == 1) {
        if (current == 0 || current == null) {
            current = 1;
        }
        text = current + ' de ' + total;
    } else {
        if (current % 2 != 0)
            current++;
        var pages = current + ' e ' + (current + 1);
        text = pages + ' de ' + total;
    }
    $('.multimidia_textfield').val(unescape(text));
    //pageNumber = current;
    var pageEdition = getCurrentEdition();

    if ($('#banner_lateral').length) { //se possui banner na lateral,verifica
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
    }
    executeListener('UPDATE_PAGE');
    validateRecommend(current, total);
    if (jQuery('#comment_count').length) {
        reload_comments();
    }
}


function getCurrentAnchor() {
    return getCurrentPageObject().id;
}

function customForward(page, frmName) {
    var frm = $("#" + frmName);
    var url = base + 'flip/jornal/jsp/customs/' + page;
    $.post(url, frm.serialize(), function (message) {
        $.fn.modalBox({
            directCall: {
                data: message
            }
        });
    });
}


function validateComentario(frm) {
    return true;
}

function disableControls(page) {
    if (page == 0) {
        $('.previous-button').hide();
    } else {
        $('.previous-button').show();
    }
    if (page == turn('pages') - 1) {
        $('.next-button').hide();
    } else {
        $('.next-button').show();
    }
    updatePageChange();
}

function decodeParams(data) {
    var parts = data.split('&'), d, obj = {};
    for (var i = 0; i < parts.length; i++) {
        d = parts[i].split('=');
        obj[decodeURIComponent(d[0])] = decodeURIComponent(d[1]);
    }
    return obj;
}


function loading() {
    $.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            data: '<p align=center>' + $('#loading').html() + '</p>'
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
    if (!page || page == undefined) {
        page = 0;
    }
    var url = getPagesLink('produtos') + '?idForm=' + pageAnchor + '&linkedicao=' + linkedicao + '&pagina=' + page;
    $.post(url, function (data) {
        $('#produtos_barra .free').html(html + data);
    });
}

function playSound(id) {
    var url = getPagesLink('audioLink') + '?audio=' + id;
    $.fn.modalBox({
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
    $("#facerecomenda").hide("slow", function () {
        $("#facerecomenda").remove();
        updatePageChange();
    });
}
function hideRecommendArea() {
    if ($("#facerecomenda").length) {
        $("#facerecomenda").hide("slow");
    }
}
function showRecommendArea() {
    if ($("#facerecomenda").length) {
        $("#facerecomenda").show("slow");
    }
}
function fixedEncodeURIComponent(str) {
    return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
}
function validateRecommend(current, total) {
    if ($("#facerecomenda").length) {
        var faceurltemplate = "http://www.facebook.com/plugins/like.php?href=$URL&;layout=standard&show_faces=false&width=380&action=recommend&colorscheme=light&height=30&locale=pt_BR";
        var width = $(".megazine").css('width');
        if (!width || width == null) {
            return;
        }
        if (current > 0 && current % 2 == 0) {
            current--;
        }
        var anchor = getPageAnchor(current);
        var link = base + 'pub/' + folder + '/?ipg=' + anchor;
        var url = faceurltemplate.replace("$URL", link);
        $("#faceframeleft").attr('src', url);
        if (current == 0 || current == total || current == null) {
            width = parseInt(width.replace("px", "")) / 3;
            $("#faceright").hide();
            $("#facerecomenda").css("width", width + "px");
            $("#faceleft").css("width", "100%");
            $(".closeleft").show();
        } else {
            $(".closeleft").hide();
            width = parseInt(width.replace("px", "")) / 2;
            width = width + 150;
            $("#facerecomenda").css("width", width + "px");
            $("#faceleft").css("width", "50%");
            $("#faceright").css("width", "50%");
            $("#faceright").show();
            anchor = getPageAnchor(current + 1);
            link = base + 'pub/' + folder + '/?ipg=' + anchor;
            url = faceurltemplate.replace("$URL", link);
            $("#faceframeright").attr('src', url);

        }
    }
}

$.fn.ForceNumericOnly =
        function ()
        {
            return this.each(function ()
            {
                $(this).keydown(function (e)
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



$.maxZIndex = $.fn.maxZIndex = function (opt) {
    var def = {
        inc: 10,
        group: "*"
    };
    $.extend(def, opt);
    var zmax = 0;
    $(def.group).each(function () {
        var cur = parseInt($(this).css('z-index'));
        zmax = cur > zmax ? cur : zmax;
    });
    if (!this.jquery)
        return zmax;

    return this.each(function () {
        zmax += def.inc;
        $(this).css("z-index", zmax);
    });
}

$.validateEmail = function (email) {
    er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;
    if (er.exec(email))
        return true;
    else
        return false;
};

function getPageAnchor(page) {
    return pageArray[pageNumber - 1].id;
}
function getCurrentPage() {
    return turn("page");
}
function searchWord(w) {
    alert('Procurando por ' + w);
}
function getPageCount() {
    return turn("pages");
}
function gotoAnchor(anchor) {
    anchor = anchor.replace("anch", "");

    console.log('procurando'+anchor);

    for (var i = 0; i < pageArray.length; i++) {
        if (pageArray[i].id == anchor) {
            turn("page", pageArray[i].num);
            break;
        }
    }
}
function disabledEventPropagation(event)
{
    if (event.stopPropagation) {
        event.stopPropagation();
    } else if (window.event) {
        window.event.cancelBubble = true;
    }
}
function getPage(index) {
    return  pageArray[index - 1];
}


function toggleFullScreen() {
  if (!document.fullscreenElement &&    // alternative standard method
      !document.mozFullScreenElement && !document.webkitFullscreenElement && !document.msFullscreenElement ) {  // current working methods
    if (document.documentElement.requestFullscreen) {
      document.documentElement.requestFullscreen();
    } else if (document.documentElement.msRequestFullscreen) {
      document.documentElement.msRequestFullscreen();
    } else if (document.documentElement.mozRequestFullScreen) {
      document.documentElement.mozRequestFullScreen();
    } else if (document.documentElement.webkitRequestFullscreen) {
      document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
    }

    $('#btn-fullscreen').addClass('full');

  } else {
    if (document.exitFullscreen) {
      document.exitFullscreen();
    } else if (document.msExitFullscreen) {
      document.msExitFullscreen();
    } else if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) {
      document.webkitExitFullscreen();
    }

    $('#btn-fullscreen').removeClass('full');


  }
}

function openFullScreen() {
  // $('#btn-fullscreen').toggleClass('full');
  // $('html').fullscreen();

  toggleFullScreen()
}

function adjustMediaSize(pageElement) {
    if (!pageElement) {
        $('.video').each(function () {
            var width = $(this).css('width');
            var height = $(this).css('height');
            $('iframe,.mejs-video', $(this)).each(function () {
                $(this).css('width', width).css("height", height);
            });
        });
    }
}

function loadTempRegions(page, element) {
    var was = false;
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

function openGalleryHtml5(cd, text, skin) {

    if (skin == 'default') {
        var url = base + 'flip/jornal/plugin/gallery.jsp?cd=' + cd;
        var html5lightbox_options = {
            watermark: "",
            watermarklink: ""
        };
        html5Lightbox.showLightbox(7, url, text, 850, 480);
    } else {
        $("#darkbox").remove();
        $('.gallery-dark-box').remove();
        var html = $('<div/>', {
            'position': 'relative',
            'class': 'gallery-dark-box',
            'id': 'gallery' + cd
        });
        var first = null;
        for (var i = 0; i < pfmediaspics.length; i++) {
            if (pfmediaspics[i][1] == cd) {
                var img = $('<img/>', {
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
        $("body").append(html);
        loadDarkBox();
        $(first).click();
    }
    if (dataLayer != null) {
        dataLayer.push({'event': 'eventTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu galeria', 'eventLabel': dataAnalytics});
    }
}
