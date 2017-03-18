var freePagesList=new Array();
var isIE = navigator.appVersion.indexOf('MSIE') > 0;
var isMozilla = document.getElementById && !isIE;
var isNetscape4 = document.layers ? true : false;
var page = 0;

function updateZoomChange(state, page){    
    if(state == 'zoom_status_open'){          
        if(!verifyBlockedPages(page)){
            return false;
        }
        ajaxRegisterZoom();              
        return true;
    }else{       
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
    $('.multimidia_textfield').html(unescape(text));
 
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


function adjustHeight(){
    var height=$(window).height()-50;
    $('#corpo').css('height',height);
}

jQuery(function ($) {

    adjustHeight();

    $(window).resize(function(){
        adjustHeight();
    });

    $('.imprimir').click(function (e) {      
        jQuery.fn.modalBox({
            directCall : {
                source : getPrintLink()
            }
        });
        return false;
    });

    $('.botaofechar').click(function(){
        window.parent.fechar();
    });

    $('.multimidia_prev').click(function(){
        MegaZine.prevPage();
    });

    $('.multimidia_next').click(function(){
        MegaZine.nextPage();
    });
  $('.multimidia_fr,.multimidia_fr_label').click(function(){
        MegaZine.firstPage();
    });

    $('.multimidia_ff,.multimidia_ff_label').click(function(){
        MegaZine.lastPage();
    });    

});

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


// verifica se um campo esta vazio ou n�o existe
function isEmpty(campo) {
    return (campo==null || campo.value==null || campo.value=='');
}