var freePagesList=new Array();
var isIE = navigator.appVersion.indexOf('MSIE') > 0;
var isMozilla = document.getElementById && !isIE;
var isNetscape4 = document.layers ? true : false;

function updateZoomChange(state, page){    
    if(state == 'zoom_status_open'){          
        if(!verifyBlockedPages(page)){
            return false;
        }
        ajaxRegisterZoom();
        if($('#zoom_layer')){
            $('#zoom_layer').show();
        }       
        return true;
    }else{
        if($('#zoom_layer')){
            $('#zoom_layer').hide();
        }
        return true;
    }
}

function updatePageChange(){    
    var current = MegaZine.getCurrentPage();
    var total = MegaZine.getPageCount();
    var text='';    
    if(current > 0 && !zoomBlocked){
        verifyOnlineMode();
    }
    if(current == 0 || current == total || current == null){
        if(current == 0 || current == null){
            current = 1;
        }
        text=current+' de '+total;
    }else{
        var pages=current+' e '+(current+1);
        text=pages+' de '+total;
    }   
    $('.multimidia_textfield').val(unescape(text));
    if($('#comment_count').length){
        reload_comments();
    }

    if($('#banner_lateral').length){ //se possui banner na lateral,verifica        
        updateSideBanner(current);
    }        
}

function verifyBlockedPages(page){    
    if(zoomBlocked == true && online == false){
        var anchor = MegaZine.getPageAnchor(page);
        var freePass = false;        
        if(freePagesList.length >0){
            for (var i = 0; i < freePagesList.length; i++) {
                if(freePagesList[i] == anchor){                    
                    freePass=true;
                    break;
                }
            }
        }        
        if(freePass == false){
            $('#megazineScript').hide();
            verifyOnlineMode();
            return false;
        }else{
            return true;
        }
    }else{
        return true;
    }
}

function verifyOnlineMode(){
    if(!online){
        $('#megazineScript').hide();
        var link = "";
        if (!isIE){
            //link='pub/'+folder+'/login.jsp?edicao='+getCurrentEdition();
            link="login.jsp?edicao="+getCurrentEdition();
        }else{
            link="login.jsp?edicao="+getCurrentEdition();            
        }
        window.location.href=link;
    }
}

function refreshPage(){
    var anchor = MegaZine.getCurrentAnchor();
    var link = base+'pub/'+folder+'/?ipg='+anchor;
    window.location.href=link;
}

function ajaxRegisterZoom(){
    var pageAnchor=MegaZine.getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var frm = $('#frm');
    frm.idForm.value = pageAnchor;
    frm.idEdicao.value = pageEdition;    
    if(pageAnchor != null){
        $.post(base+'flip/jornal/jsp/registraZoom.jsp', frm.serialize());
    }
}

function threatStatus(status){    
    if(status=='status_ready' && ipg != null){
        // ipg=ipg.trim();
        MegaZine.gotoAnchor(ipg,false);
    }    
}

function abreNovaPesquisa(anchor){
    anchor='anch'+anchor;
    MegaZine.gotoAnchor(anchor,false);
    fechaJanela();
    return false;
}

function abrePesquisa(url,link,anchor,soessa){
    window.location.href=link;    
// anchor='anch'+anchor;
// MegaZine.gotoAnchor(anchor,false);
// fechaJanela();
// return false;
}


function fechaJanela(){
    jQuery.fn.modalBox('close');
}

function getPagesLink(sector){
    return base+'flip/jornal/skins/king/jsp/'+sector+'.jsp';
}

function getPrintLink(){
    $.getScript(base+'flip/jornal/skins/king/js/printPDF.js');
    flag=0;
    var pageAnchor=MegaZine.getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('imprimir')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    return url;
}

function getTextLink(){
    var pageAnchor=MegaZine.getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('texto')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    return url;
}

function getPDFLink(todos){
    var pageAnchor=MegaZine.getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var page = 'exportar';
    if(todos == 'Z' || todos == 'P'){
        page=page+'Todos';
    }else{
        if(todos == 'S'){
            page=page+'Sumario';
        }
    }
    var url=getPagesLink(page)+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    if(todos == 'Z' || todos == 'P'){
        window.location.href=url;
    }else{
        var size =  (todos == 'S' ? 900 : 600);        
        jQuery.fn.modalBox({
            setWidthOfModalLayer : size,
            directCall : {
                source : url                
            }
        });
    }
}

function exportaMarcadas(){     
    var url=getPagesLink('mavenflip')+'?'+$('#exporta_form').serialize();
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 300,
        directCall : {
            data : '<p>Aguarde, estamos gerando o arquivo ... </p>'
        }
    });
    window.location.href=url;
    window.setTimeout("fechaJanela()",3000);
}

function getSearchLink(){
    var pageAnchor=getCurrentEdition();
    var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor;
    url=url+'&linkedicao='+linkedicao;
    return url;
}

function pesquisa(){
    var object=document.faleConoscoForm.keywords;
    if(object.value.length < 4 ){
        alert('Deve informar uma palavra com pelo menos 4 caracteres');
        $('#keywords').focus();
    }else{        
        var frm=$('#faleConoscoForm');
        $('#edicao').val(getCurrentEdition());
        var url=getSearchLink();        
        $.post(url, frm.serialize(),function(data) {  
            $('#result').html(data);
            $('#result').show();
        });      
    }
}

function getRecommentLink(){
    var edition=getCurrentEdition();
    var url=getPagesLink('recomendacao')+'?idForm='+edition;
    return url;
}

function recomendaAmigo(){
    $('#pagina_anchor').value=MegaZine.getCurrentAnchor();
    var frm = $('#faleConoscoForm');    
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();
    loading();
   
    $.post(url,function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 300,
            directCall : {
                data : message
            }
        });
    });
}

function entraEmContato(){
    $('#pagina_anchor').value=MegaZine.getCurrentAnchor();
    var frm = $('#faleConoscoForm');    
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();

    loading();
    $.post(url,function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 300,
            directCall : {
                data : message
            }
        });
    });
}

function comentaPagina(){
    var frm = $('#faleConoscoForm');
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();

    if(validateComentario(frm)){       
        loading();        
        $.post(url,function(message) {
            jQuery.fn.modalBox({
                setWidthOfModalLayer : 300,
                directCall : {
                    data : message
                }
            });
        });
    }
}

function comentaPaginaMarkup(){
    var frm = $('#faleConoscoForm');
    if(validateComentario(frm)){
        var url=base+'flip/enviaEmailSites.do?comentario=true&'+frm.serialize();
        loading();
        $.post(url,function(message) {
            jQuery.fn.modalBox({
                setWidthOfModalLayer : 300,
                directCall : {
                    data : message
                }
            });
        });
    }
}


function mostraComentario(id){
    var url=getPagesLink('mostraComentario')+'?id='+id;
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 600,
        directCall : {
            source : url
        }
    });
}

function apagaComentario(id){
    var url=getPagesLink('apagaComentario')+'?id='+id;
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 600,
        directCall : {
            source : url
        }
    });
}

function openCommentModeMarkup(){
    var pageAnchor=MegaZine.getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('comentar')+'?markup=true&idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;

    jQuery.fn.modalBox({
        setWidthOfModalLayer : 600,
        directCall : {
            source : url
        }
    });

}

function openCommentMode(){
    var pageAnchor=MegaZine.getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('comentar')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;

    jQuery.fn.modalBox({
        setWidthOfModalLayer : 700,
        directCall : {
            source : url
        }
    });
}

function openCommentStep2Mode(pagina){
    var edition=getCurrentEdition();
    var url=getPagesLink('comentarStep2')+'?idForm='+edition;
    url=url+'&pagina='+pagina;
    

    jQuery.fn.modalBox({
        setWidthOfModalLayer : 700,
        directCall : {
            source : url
        }
    });
}

function openCommentStep2ModeMarkup(pagina){
    var edition=getCurrentEdition();
    var url=getPagesLink('comentarMarkup')+'?idForm='+edition;
    url=url+'&pagina='+pagina;

    jQuery.fn.modalBox({
        setWidthOfModalLayer : 600,
        directCall : {
            source : url
        }
    });
}

function openContactMode(){
    var edition=getCurrentEdition();
    var url=getPagesLink('faleConosco')+'?idForm='+edition;
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 700,
        directCall : {
            source : url
        }
    });
}

function adjustHeight(){
    var height=$(window).height()-50;
    $('#content').css('height',height);
}

jQuery(function ($) {

    adjustHeight();

    $(window).resize(function(){
        adjustHeight();
    });

    $('#basic-modal .imprimir').click(function (e) {      
        jQuery.fn.modalBox({
            directCall : {
                source : getPrintLink()
            }
        });
        return false;
    });

    $('#basic-modal .texto').click(function (e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 680,
            directCall : {
                source : getTextLink()
            }
        });
        return false;  
    });
	
    $('#basic-modal .pdf').click(function (e) {
        var id=this.id;
        getPDFLink(id);
        return false;
    });
	
    $('#basic-modal .procurar').click(function (e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 750,
            positionTop : "20",
            directCall : {
                source : getSearchLink()
            }
        });

        return false;
    });
	
    $('#basic-modal .recomendar').click(function (e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 750,          
            directCall : {
                source : getRecommentLink()
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
	
    $('#basic-modal .basic').click(function (e) {
        $('#basic-modal-content').modal();

        return false;
    });

    $('.menu_home').click(function(){
        window.location.href=base+linkedicao;
    });

    $('.multimidia_fr').click(function(){
        MegaZine.firstPage();
    });

    $('.multimidia_prev').click(function(){
        MegaZine.prevPage();
    });

    $('.multimidia_next').click(function(){
        MegaZine.nextPage();
    });

    $('.multimidia_ff').click(function(){
        MegaZine.lastPage();
    });

    $('.multimidia_textfield').focus(function(){
        toogleTextField();
    });

    $('.multimidia_textfield').blur(function(){
        updatePageChange();
        editingText='';
    });

    $('.multimidia_textfield').keyup(function(e){
        if(e.keyCode == 13) {
            toogleTextField();
        }
    });

    $(document).keyup(function(e){
        if(e.keyCode  == 39){
            $('.multimidia_next').trigger("click");
        }else{
            if(e.keyCode == 37){
                $('.multimidia_prev').trigger("click");
            }
        }
    });
});

var editingText='';
function toogleTextField(){
    if(editingText == ''){
        editingText= $('.multimidia_textfield').val();
        $('.multimidia_textfield').val("");
        $(".multimidia_textfield").ForceNumericOnly();
    }else{
        var number=$('.multimidia_textfield').val();
        $('.multimidia_textfield').unbind("keydown");
        MegaZine.gotoPage(number);
        editingText='';
        $('.multimidia_textfield').trigger("blur");
    }
}


function loading(){
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 300,
        directCall : {
            data : '<p align=center>'+$('#loading').html()+'</p>'
        }
    });
}
function customForward(page,frmName){
    var frm = $("#"+frmName);
    var url=base+'flip/jornal/jsp/customs/'+page;
    $.post(url, frm.serialize(),function(message) {
        jQuery.fn.modalBox({
            directCall : {
                data :message
            }
        });
    });
}

function validateComentario(frm){    
    return true;
}

// verifica se um campo esta vazio ou n�o existe
function isEmpty(campo) {
    return (campo==null || campo.value==null || campo.value=='');
}

var page = 0;
function openEditionMode(){
    openEditionMode(0);
}
function openEditionMode(p){
    var html='<div id="header"><li class="header">Edicões anteriores</li></div>';
    var pageAnchor=getCurrentEdition();
    page=p;
    if(!page || page == undefined){
        page=0;
    }
    var url=getPagesLink('edicoes')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;
    $.post(url,function(data){
        $('#edicoes_barra .free').html(html+data);
    });
}

function openProdutosMode(){
    openProdutosMode(0);
}
function openProdutosMode(p){
    var html='<div id="header"><li class="header">Cadernos e Produtos</li></div>';
    var pageAnchor=getCurrentEdition();
    page=p;
    if(!page || page == undefined){
        page=0;
    }
    var url=getPagesLink('produtos')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;
    $.post(url,function(data){
        $('#produtos_barra .free').html(html+data);
    });
}

jQuery.fn.ForceNumericOnly =
    function()
    {
        return this.each(function()
        {
            $(this).keydown(function(e)
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
