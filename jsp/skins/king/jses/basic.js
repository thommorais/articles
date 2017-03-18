var freePagesList = new Array();
var isIE = navigator.appVersion.indexOf('MSIE') > 0;
var isMozilla = document.getElementById && !isIE;
var isNetscape4 = document.layers ? true : false;
var searchResult = null;
var startTime = new Date().getTime();
var lastPageTracking = 0;

function trackTimePage(pagina) {
    if (lastPageTracking == 0) {
        lastPageTracking = 1;
    }
    var endTime = new Date().getTime();
    var timeSpent = endTime - startTime;
    var hourInMillis = 1000 * 60 * 60;    
    if (0 < timeSpent && timeSpent < hourInMillis) {        
        startTime = new Date().getTime();
        _gaq.push([gaPrefix + '_trackTiming', linkedicao, 'Ed' + getCurrentEdition(), timeSpent, 'Pagina' + lastPageTracking, 100]);        
        if(gaPrefix!='' && typeof ga !== 'undefined'){            
            ga.send('timing', linkedicao, 'Ed' + getCurrentEdition(), timeSpent, 'Pagina' + lastPageTracking, 100);            
        }
    }
    lastPageTracking = pagina;
}
function updateZoomChange(state, page) {
    if (state == 'zoom_status_open') {
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
    var current = MegaZine.getCurrentPage();
    var total = MegaZine.getPageCount();
    var text = '';
    if (current == 0 || current == total || current == null) {
        if (current == 0 || current == null) {
            current = 1;
        }
        text = current + ' de ' + total;
    } else {
        var pages = current + ' e ' + (current + 1);
        text = pages + ' de ' + total;
    }
    jQuery('.multimidia_textfield').val(unescape(text));
    trackTimePage(current);
    var pageEdition = getCurrentEdition();
    var trackzoom = '/' + linkedicao + 'edicao=' + pageEdition + '/pagina=' + current;
    _gaq.push([gaPrefix + '_trackPageview', trackzoom]);
    _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Folhear', 'Página ' + current]);
    if(gaPrefix!='' && typeof ga !== 'undefined'){        
        ga('send','pageview', trackzoom);
        ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Folhear', 'Página ' + current);        
    }    
    validateRecommend(MegaZine.getCurrentPage(), total);
    if (jQuery('#comment_count').length) {
        reload_comments();
    }
    if (jQuery('#banner_lateral').length) { //se possui banner na lateral,verifica        
        updateSideBanner(current);
    }

}

function verifyBlockedPages(page) {
    if (zoomBlocked == true) {
        var anchor = MegaZine.getPageAnchor(page);
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
            jQuery('#megazineScript').hide();
            verifyOnlineMode();
            return false;
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function verifyOnlineMode() {
    //if(!online){
    jQuery('#megazineScript').hide();
    var link = "login.jsp?edicao=" + getCurrentEdition();
    window.location.href = link;
//}
}

function refreshPage() {
    var anchor = MegaZine.getCurrentAnchor();
    var link = base + 'pub/' + folder + '/?ipg=' + anchor;
    window.location.href = link;
}

function ajaxRegisterZoom() {
    var pageAnchor = MegaZine.getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    document.frm.idForm.value = pageAnchor;
    document.frm.idEdicao.value = pageEdition;
    if (pageAnchor != null) {
        var trackzoom = '/' + linkedicao + 'zoom/edicao=' + pageEdition + '/pagina=' + MegaZine.getCurrentPage();
        _gaq.push([gaPrefix + '_trackPageview', trackzoom]);
        _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Zoom', 'Zoom na pagina ' + current]);
        if(gaPrefix!='' && typeof ga !== 'undefined'){
            ga('send','pageview', trackzoom);
            ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Zoom', 'Zoom na pagina ' + current);                            
        }
        jQuery.post(base + 'flip/jornal/jsp/registraZoom.jsp', jQuery('#frm').serialize());
    }
}

function abreNovaPesquisa(anchor) {
    anchor = 'anch' + anchor;
    MegaZine.gotoAnchor(anchor, false);
    fechaJanela();
    return false;
}

var currentKeyword = "";
var redirecting = false;
function abrePesquisa(url, linkPesquisa, anchor, soessa, keyword) {
    //console.log('abrePesquisa '+url+' - '+linkPesquisa+' - '+anchor+' - '+soessa+' - '+keyword);
    //;
    if (redirecting == true) {
        return;
    }
    if (flashbased == false) {
        if (soessa == true) {
            currentKeyword = keyword;
            anchor = 'anch' + anchor;
            MegaZine.gotoAnchor(anchor, false);
            fechaJanela();
            return false;
        } else {
            redirecting = true;
            linkPesquisa = linkPesquisa.replace("keyword", "keywords");
            //console.log("Indo para"+linkPesquisa);
            window.location.href = linkPesquisa;
            return false;
        }
    } else {
        if (soessa == true) {
            currentKeyword = keyword;
            anchor = 'anch' + anchor;
            MegaZine.gotoAnchor(anchor, false);
            setTimeout("selectcurrentword()", 800);
            fechaJanela();
            return false;
        } else {
            redirecting = true;
            linkPesquisa = linkPesquisa.replace("keyword", "keywords");
            //console.log("Indo para"+linkPesquisa);
            window.location.href = linkPesquisa;
            return false;
        }
    }
}

function selectcurrentword() {
    if (currentKeyword != null && currentKeyword != "") {
        jQuery("#keywordbody").val(currentKeyword);
        jQuery("#searchinstant").slideDown("slow");
        MegaZine.searchWord(currentKeyword);
        currentKeyword = null;
    }
}

function threatStatus(status) {
    if (status == 'status_ready') {
        if (ipg != null) {
            ipg = ipg.trim().replace("id", "");
            jQuery(document).ready(function() {
                setTimeout(function() {
                    MegaZine.gotoAnchor(ipg, true);
                }, 1000);
            });
            if (keywords != null && keywords != "") {
                currentKeyword = keywords;
                setTimeout("selectcurrentword()", 800);
            }
        } else {
            if (currentKeyword != null && currentKeyword != "") {
                setTimeout("selectcurrentword()", 800);
            } else {
                if (keywords != null && keywords != "") {
                    currentKeyword = keywords;
                    setTimeout("selectcurrentword()", 800);
                }
            }
        }
    }
}

function atualizaPesquisa() {
    var value = jQuery("#keywordbody").val();
    MegaZine.searchWord(value);
}

function cancelaPesquisa() {
    MegaZine.searchWord("");
    jQuery("#searchinstant").slideUp("slow");
    currentKeyword = null;
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
    var pageAnchor = MegaZine.getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('imprimir') + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;
    return url;
}

function getTextLink() {
    var pageAnchor = MegaZine.getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('texto') + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;
    return url;
}

function getPDFLink(todos) {
    var pageAnchor = MegaZine.getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var page = 'exportar';
    if (todos == 'Z' || todos == 'P') {
        //page=page+'Todos';
        page = 'mavenflip';
    } else {
        if (todos == 'S') {
            page = page + 'Sumario';
        }
    }
    var url = getPagesLink(page) + '?idForm=' + pageAnchor;
    url = url + '&idEdicao=' + pageEdition;
    if (todos == 'Z' || todos == 'P') {
        _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Exportar PDF', 'Exportar PDF da edição ' + pageEdition]);
        if(gaPrefix!='' && typeof ga !== 'undefined'){            
            ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Exportar PDF', 'Exportar PDF da edição ' + pageEdition);            
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

function exportaMarcadas() {
    var url = getPagesLink('mavenflip') + '?' + jQuery('#exporta_form').serialize();
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            data: '<p>Aguarde, estamos gerando o arquivo ... </p>'
        }
    });
    window.location.href = url;
    window.setTimeout("fechaJanela()", 3000);
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
        alert('Deve informar uma palavra com pelo menos 4 caracteres');
        jQuery('#keywords').focus();
    } else {
        var url = getSearchLink();
        var frm = jQuery('#faleConoscoForm');
        jQuery("#areabotoes").hide();
        jQuery("#aguarde").html("Aguarde, pesquisando...");
        jQuery("#aguarde").show();
        jQuery('#edicao').val(getCurrentEdition());
        var dados = frm.serialize();
        jQuery.post(url, dados, function(data) {
            jQuery('#result').html(data);
            jQuery('#result').show();
            jQuery("#aguarde").hide();
            jQuery("#areabotoes").show();
            searchResult = data;
            _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Pesquisa', 'Pesquisa por ' + object.value]);
            if(gaPrefix!='' && typeof ga !== 'undefined'){
                //_gaq.push(['_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Pesquisa', 'Pesquisa por ' + object.value]);
                ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Pesquisa', 'Pesquisa por' + object.value);
            }
        });
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

function getRecommentLink() {
    var edition = getCurrentEdition();
    var url = getPagesLink('recomendacao') + '?idForm=' + edition;
    return url;
}

function recomendaAmigo() {
    jQuery('#pagina_anchor').val(MegaZine.getCurrentAnchor());
    var frm = jQuery('#faleConoscoForm');

    var link = jQuery(location).attr('href');
    if (link.indexOf('?') == -1) {
        link = link + '?'
    } else {
        link = link + '&';
    }
    link = link + 'ipg=' + MegaZine.getCurrentAnchor();
    jQuery("#link").val(link);

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o seu nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O seu email parece incorreto. Corrija-o.!");
            return false;
        }
    }
    if (jQuery("#para1").val() == "" && jQuery("#para2").val() == "" && jQuery("#para3").val() == "" && jQuery("#para4").val() == "") {
        alert("Você precisa informar o email de pelo menos um amigo.");
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
    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();
    loading();
    jQuery.post(url, function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });
    _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Recomenda', 'Recomendação de ' + jQuery("#emailId").val()]);
    if(gaPrefix!='' && typeof ga !== 'undefined'){        
        ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Recomenda', 'Recomendação de' +jQuery("#emailId").val());
    }
    return true;
}

function entraEmContato() {
    jQuery('#pagina_anchor').value = MegaZine.getCurrentAnchor();
    var frm = jQuery('#faleConoscoForm');

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o seu nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("Informe um email válido!");
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
    jQuery.post(url, function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Contato', 'Contato de ' + jQuery("#emailId").val()]);
    if(gaPrefix!='' && typeof ga !== 'undefined'){        
        ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Contato', 'Contato de '+jQuery("#emailId").val());
    }
    return true;
}

function comentaPagina() {
    var frm = jQuery('#faleConoscoForm');
    var url = base + 'flip/enviaEmailSites.do?' + frm.serialize();

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o seu nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O seu email parece incorreto. Corrija-o.!");
            return false;
        }
    }
    if (jQuery("#mensagem").val() == "") {
        alert("Informe a mensagem.");
        return false;
    }

    loading();
    jQuery.post(url, function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 300,
            directCall: {
                data: message
            }
        });
    });

    _gaq.push([gaPrefix + '_trackEvent', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Comentário', 'Comentário de ' + jQuery("#emailId").val()]);
    if(gaPrefix!='' && typeof ga !== 'undefined'){        
        ga('send','event', linkedicao + 'edicao=' + getCurrentEditionNumber(), 'Comentário', 'Comentário de '+jQuery("#emailId").val());
    }
    return true;
}

function comentaPaginaMarkup() {
    var frm = jQuery('#faleConoscoForm');

    if (jQuery("#nomeId").val() == "") {
        alert("Informe o seu nome.");
        return false;
    }
    if (jQuery("#emailId").val() == "") {
        alert("Informe o seu email.");
        return false;
    } else {
        if (!jQuery.validateEmail(jQuery("#emailId").val())) {
            alert("O seu email parece incorreto. Corrija-o.!");
            return false;
        }
    }

    var url = base + 'flip/enviaEmailSites.do?comentario=true&' + frm.serialize();
    loading();
    jQuery.post(url, function(message) {
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
    var pageAnchor = MegaZine.getCurrentAnchor();
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
    var pageAnchor = MegaZine.getCurrentAnchor();
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
        jQuery.post(url, function(message) {
            jQuery.fn.modalBox({
                setWidthOfModalLayer: 300,
                directCall: {
                    data: message
                }
            });
        }, function(error) {
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
    setTimeout(function() {
        var url = getPagesLink('cadastro') + '?modelo=' + mid;
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 1024,
            directCall: {
                source: url
            }
        });
    }, 1000);
}


function adjustHeight() {
    var height = jQuery(window).height() - 40;
    jQuery('#content').css('height', height);
}

jQuery(function($) {

    adjustHeight();

    jQuery(window).resize(function() {
        adjustHeight();
        validateRecommend();
    });

    jQuery('#basic-modal .imprimir').click(function(e) {
        jQuery.fn.modalBox({
            directCall: {
                source: getPrintLink()
            }
        });
        return false;
    });

    jQuery('#basic-modal .texto').click(function(e) {
        jQuery.getScript(base + 'flip/jornal/skins/king/js/jquery.copy.min.js');
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 680,
            directCall: {
                source: getTextLink()
            }
        });
        return false;
    });

    jQuery('#basic-modal .pdf').click(function(e) {
        var id = this.id;
        getPDFLink(id);
        return false;
    });

    jQuery('#basic-modal .procurar').click(function(e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 600,
            positionTop: "20",
            directCall: {
                source: getSearchLink()
            }
        });

        return false;
    });

    jQuery('#basic-modal .recomendar').click(function(e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer: 600,
            directCall: {
                source: getRecommentLink()
            }
        });
        return false;
    });

    jQuery('#basic-modal .comentar').click(function(e) {
        openCommentMode();

        return false;
    });

    jQuery('#basic-modal .contato').click(function(e) {
        openContactMode();

        return false;
    });

    jQuery('#basic-modal .basic').click(function(e) {
        jQuery('#basic-modal-content').modal();
        return false;
    });

    jQuery('.menu_home').click(function() {
        window.location.href = base + linkedicao;
    });

    jQuery('.multimidia_fr').click(function() {
        MegaZine.firstPage();
    });

    jQuery('.multimidia_prev').click(function() {
        MegaZine.prevPage();
    });

    jQuery('.multimidia_next').click(function() {
        MegaZine.nextPage();
    });

    jQuery('.multimidia_ff').click(function() {
        MegaZine.lastPage();
    });

    jQuery('.multimidia_textfield').focus(function() {
        toogleTextField();
    });

    jQuery('.multimidia_textfield').blur(function() {
        updatePageChange();
        editingText = '';
    });

    jQuery('.multimidia_textfield').keyup(function(e) {
        if (e.keyCode == 13) {
            toogleTextField();
        }
    });

    jQuery('.tooltip').click(function(e) {
        openCommentModeMarkup();
        return false;
    });

    jQuery(document).keyup(function(e) {
        var object = document.activeElement;
        if (object instanceof HTMLBodyElement) {
            if (e.keyCode == 39) {
                jQuery('.multimidia_next').trigger("click");
            } else {
                if (e.keyCode == 37) {
                    jQuery('.multimidia_prev').trigger("click");
                }
            }
        }
    });

    if (isIE) {
        var ver = getInternetExplorerVersion();
        if (ver > -1 && ver <= 6.0) {
            alert('Recomendamos que atualize seu navegador para uma versão mais recente ou utilize o Google Chrome');
        }
    }

});

var editingText = '';
function toogleTextField() {
    if (editingText == '') {
        editingText = jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').val("");
        jQuery(".multimidia_textfield").ForceNumericOnly();
    } else {
        var number = jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').unbind("keydown");
        if(number>1 && number%2!=0){
            number--;
        }
        MegaZine.gotoPage(number);
        editingText = '';
        jQuery('.multimidia_textfield').trigger("blur");
    }
}


function loading() {
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            data: '<p align=center>' + jQuery('#loading').html() + '</p>'
        }
    });
}
function customForward(page, frmName) {
    var frm = jQuery("#" + frmName);
    var url = base + 'flip/jornal/jsp/customs/' + page;
    jQuery.post(url, frm.serialize(), function(message) {
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
    return (campo == null || campo.value == null || campo.value == '');
}

var page = 0;
function openEditionMode() {
    openEditionMode(0);
}
function openEditionMode(p) {


    var html = '<div id="header"><li class="header">Edicões anteriores</li></div>';
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
    jQuery('.dockedicao').html("<img src='" + base + "flip/jornal/images/loading_bar.gif' align='center' style='margin-top:100px'/>");
    jQuery.post(url, function(data) {
        jQuery('#edicoes_barra .free').html(html + data);
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
    jQuery.post(url, function(data) {
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
    jQuery.post(url, function(data) {
        jQuery('#volume_barra .free').html(html + data);
    });
}

jQuery.fn.ForceNumericOnly =
        function()
        {
            return this.each(function()
            {
                jQuery(this).keydown(function(e)
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

function playSound(id) {
    var url = getPagesLink('audioLink') + '?audio=' + id;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 300,
        directCall: {
            source: url
        }
    });
}

function validateRecommend() {
    validateRecommend(MegaZine.getCurrentPage(), MegaZine.getPageCount());
}

function closeRecommendArea() {
    jQuery("#facerecomenda").hide("slow");
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
        var width = jQuery("#megazineScript").css('width');
        if (current > 0 && current % 2 == 0) {
            current--;
        }
        var anchor = MegaZine.getPageAnchor(current);
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
            anchor = MegaZine.getPageAnchor(current + 1);
            anchor = anchor.replace('anch', '');
            link = base + linkedicao + '?edicao=' + getCurrentEdition() + '&ipg=' + anchor;
            link = fixedEncodeURIComponent(link);
            url = faceurltemplate.replace("$URL", link);
            jQuery("#faceframeright").attr('src', url);

        }
    }
}

function getInternetExplorerVersion() {
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer')
    {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}

jQuery.maxZIndex = jQuery.fn.maxZIndex = function(opt) {
    var def = {
        inc: 10,
        group: "*"
    };
    jQuery.extend(def, opt);
    var zmax = 0;
    jQuery(def.group).each(function() {
        var cur = parseInt(jQuery(this).css('z-index'));
        zmax = cur > zmax ? cur : zmax;
    });
    if (!this.jquery)
        return zmax;

    return this.each(function() {
        zmax += def.inc;
        jQuery(this).css("z-index", zmax);
    });
}

jQuery.validateEmail = function(email) {
    er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;
    if (er.exec(email))
        return true;
    else
        return false;
};

function abrePdf(link) {
    if (isIE) {
        var wnd = window.open();
        wnd.location.href = link + '&ie=S';
    } else {
        var wnd = window.open();
        wnd.location.href = link;
    }
}
var products = new Array();
function shopping(code) {
    if (window.confirm("Confirma o pedido do produto codigo " + code)) {
        products.push(code);
    }
}
function abreIndice(anchor,editoria){
    gotoAnchor(anchor);
    if(kiss != null){
      kiss.visitouEditoria(editoria);
     }
}

function gotoAnchor(anchor) {
    MegaZine.gotoAnchor(anchor, false);
}