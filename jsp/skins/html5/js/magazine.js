var isIE = navigator.appVersion.indexOf('MSIE') > 0;
var isMozilla = document.getElementById && !isIE;
var isNetscape4 = document.layers ? true : false;
var flash=true;
var currentKeyword='';

jQuery(function ($) {
   
    jQuery('.telacheia').click(function (e) {      
        window.open(base+linkedicao+'?numero='+getCurrentEditionNumber());
    });   
       
   
    jQuery('.imprimir').click(function (e) {      
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 500,
            directCall : {
                source : getPrintLink()
            }
        });
        return false;
    });   
    
    jQuery('.edicoes').click(function (e) {        
        openEditionMode(0);
        return false;
    });       
    
    jQuery('.procurar').click(function (e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 500,
            positionTop : "20",
            directCall : {
                source : getSearchLink()
            }
        });

        return false;
    });  
    
    jQuery('.buttonPesquisa').click(function (e) {
        pesquisaUnique($("#campoPesquisa").val());
    });      
    
    jQuery('.multimidia_fr').click(function(){
        if(flash==true){
            MegaZine.firstPage();
        }else{
            $(".magazine").turn("page", 1);
        }
    });

    jQuery('.multimidia_prev').click(function(){
        if(flash==true){
            MegaZine.prevPage();
        }else{
            $('.magazine').turn('previous');
        }
    });

    jQuery('.multimidia_next').click(function(){
        if(flash == true){
            MegaZine.nextPage();
        }else{
            $('.magazine').turn('next');
        }
    });

    jQuery('.multimidia_ff').click(function(){
        if(flash == true){
            MegaZine.lastPage();
        }else{
            var amount=$(".magazine").turn("pages");
            $(".magazine").turn("page", amount);        
        }
    });

    jQuery('.multimidia_textfield').focus(function(){
        toogleTextField();
    });

    jQuery('.multimidia_textfield').blur(function(){
        updatePageChange();
        editingText='';
    });

    jQuery('.multimidia_textfield').keyup(function(e){
        if(e.keyCode == 13) {
            toogleTextField();
        }
    }); 
    
    jQuery('#campoPesquisa').keyup(function(e){
        if(e.keyCode == 13) {
            jQuery('.buttonPesquisa').click();
        }
    });
    
    if(!isIE || IEV>=9 ){
        var soundbase=base+'flip/jornal/megazine2/snd/turn';
        for(var i=0;i<5;i++){
            var url=soundbase+i+'.mp3';
            $("body").append("<audio src='"+url+"' id='turn"+(i+1)+"'/>");
        }
    }
    executeCommand(command,param);
    
});

function threatStatus(status){ 
    
    if(status=='status_ready'){
        if(ipg != null){
            ipg=ipg.trim().replace("id","");
            MegaZine.gotoAnchor(ipg,false);
            if(keywords!=null && keywords!=""){
                currentKeyword=keywords;
                setTimeout("selectcurrentword()",800);            
            }
        }else{
            if(currentKeyword != null && currentKeyword!=""){
                setTimeout("selectcurrentword()",800); 
            }else{
                if(keywords!=null && keywords!=""){                    
                    currentKeyword=keywords;
                    jQuery("#campoPesquisa").val(keywords);
                    setTimeout("selectcurrentword()",800);                
                }
            } 
        }    
    }
}

function atualizaPesquisa(){ 
    if(currentKeyword != null && currentKeyword!=""){
        setTimeout("selectcurrentword()",800); 
    }else{
        if(keywords!=null && keywords!=""){                    
            currentKeyword=keywords;
            setTimeout("selectcurrentword()",800);                
        }
    } 
}

function getSearchLink(){
    var pageAnchor=getCurrentEdition();
    var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo='+acervo;
    url=url+'&linkedicao='+linkedicao;    
    return url;
}

function getSearchLinkAll(keywords){
    var pageAnchor=getCurrentEdition();
    var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo=true&keywords='+keywords+'&search=true&edicao='+getCurrentEdition();
    url=url+'&linkedicao='+linkedicao;    
    return url;
}
function getSearchLinkUnique(keywords){
    var pageAnchor=getCurrentEdition();
    var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo=false&apenasEssa=true&keywords='+keywords+'&search=true&edicao='+getCurrentEdition();
    url=url+'&linkedicao='+linkedicao;    
    return url;
}

function openEditionModeAll(tx){        
    var pageAnchor=getCurrentEdition();
    page=0;    
    var url=getPagesLink('edicoesCapas')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;    
    if(tx!=null && tx!=undefined){
        url=url+"&tx="+tx;
    }         
    //jQuery.post(url,function(data){        
    //        return data;
    //    });        
    var retorno = jQuery.ajax({
        type: 'POST',
        url: url,          
        dataType: 'text/html',
        async:false
    }).responseText;
    
    return retorno;
    
}


function openEditionMode(p){    
    var html='';
    var pageAnchor=getCurrentEdition();
    page=p;
    if(!page || page == undefined){
        page=0;
    }
    var nr=jQuery("#numero")!=null?jQuery("#numero").val():null;
    var di=jQuery("#dataInicial")!=null?jQuery("#dataInicial").val():null;
    var df=jQuery("#dataFinal")!=null?jQuery("#dataFinal").val():null;
    var tx=jQuery("#texto")!=null?jQuery("#texto").val():null;            
    var url=getPagesLink('edicoes')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;
    if(nr!=null && nr!=undefined){
        url=url+"&nr="+nr;
    }
    if(di!=null && di!=undefined){
        url=url+"&di="+di;
    }
    if(df!=null && df!=undefined){
        url=url+"&df="+df;
    }
    if(tx!=null && tx!=undefined){
        url=url+"&tx="+tx;
    }            
    jQuery.post(url,function(data){                        
        data=data.replace("<div class=\"filter_fields\">","<div class=\"filter_fields\" style=\"display:none\">");
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 730,
            directCall : {                                                
                data : '<div style="width:650px;height:500px;">'+html+data+'</div>'
            }
        });                
    });                                
}

function pesquisa(){
    var object=document.faleConoscoForm.keywords;
    if(object.value.length < 5 ){
        alert('Deve informar uma palavra com pelo menos 5 caracteres');
        jQuery('#keywords').focus();
        try{
            MegaZine.searchWord("");
        }catch(e){}        
    }else{        
        var url=getSearchLink();
        var frm=jQuery('#faleConoscoForm');                     
        jQuery("#areabotoes").hide();
        jQuery("#aguarde").html("Aguarde, pesquisando...");
        jQuery("#aguarde").show();
        jQuery('#edicao').val(getCurrentEdition());            
        var dados=frm.serialize();   
        
        jQuery.post(url, dados,function(data) {  
            jQuery('#result').html(data);
            jQuery('#result').show();            
            jQuery("#aguarde").hide();
            jQuery("#areabotoes").show();
            _gaq.push(['_trackEvent', 'Flip', 'Pesquisa', 'Pesquisa por '+object.value]);
        });      
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

function pesquisaAll(keyword){    
    if(keyword.length < 5 ){
        alert('Deve informar uma palavra com pelo menos 5 caracteres');        
    }else{        
        jQuery("#campoPesquisa").val(keyword);
        var url=getSearchLinkAll(keyword);
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


function abrePesquisa(url,link,anchor,soessa,keyword){       
    if(soessa == null){
        var src=base+url+link;
        src=src+'&ipg='+anchor+'&keywords='+keyword;        
        window.location.href=src;
        return true;
    }else{
        currentKeyword=keyword;        
        if(flash==true){
            var anch=""+anchor;
            if(anch.indexOf("anch")==-1){
                anchor="anch"+anchor;
            }
            MegaZine.gotoAnchor(anchor,false); 
            setTimeout("selectcurrentword()",800);
        }else{
            var page=$("#"+anchor).attr('class').replace('page-','');
            $('.magazine').turn('page',page);
        }
        //MegaZine.gotoAnchor(anchor,false); 
        fechaJanela();
        return false;    
    }
}

function selectcurrentword(){    
    if(currentKeyword != null && currentKeyword != ""){                
        //jQuery("#keywordbody").val(currentKeyword);
        //jQuery("#searchinstant").slideDown("slow");                        
        jQuery("#campoPesquisa").val(currentKeyword);
        MegaZine.searchWord(currentKeyword);
        currentKeyword=null;
    }
}

function fechaJanela(){
    jQuery.fn.modalBox('close');
}

function getPagesLink(sector){
    return base+'flip/jornal/skins/king/jsp/'+sector+'.jsp';
}

function getPrintLink(){
    jQuery.getScript(base+'flip/jornal/skins/king/js/printPDF.js');
    flag=0;
    var pageAnchor=getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('imprimir')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    return url;
}
function getEdicoesLink(){    
    var pageAnchor=getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('edicoes')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    return url;
}
function getEdicoesCapasLink(keyword){
    var pageAnchor=getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('edicoesCapas')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition+'&kw='+keyword;
    return url;    
}

var editingText='';
function toogleTextField(){
    if(editingText == ''){
        editingText= jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').val("");
        jQuery(".multimidia_textfield").ForceNumericOnly();
    }else{
        var number=jQuery('.multimidia_textfield').val();
        jQuery('.multimidia_textfield').unbind("keydown");
        if(flash==true){
            MegaZine.gotoPage(number);
        }else{
            $(".magazine").turn("page", number);        
        }
        editingText='';
        jQuery('.multimidia_textfield').trigger("blur");
    }
}

function updateZoomChange(state, page){    
    if(state == 'zoom_status_open'){          
        
        ajaxRegisterZoom();
        if(jQuery('#zoom_layer')){
            jQuery('#zoom_layer').show();
        }    
        
        return true;
    }else{
        if(jQuery('#zoom_layer')){
            jQuery('#zoom_layer').hide();
        }
        return true;
    }
}

function ajaxRegisterZoom(){    
    var pageAnchor=MegaZine.getCurrentAnchor();        
    var pageEdition=getCurrentEdition();                
    document.frm.idForm.value=pageAnchor;
    document.frm.idEdicao.value=pageEdition;                  
    if(pageAnchor != null){
        var trackzoom='/'+linkedicao+'zoom/edicao='+pageEdition+'/pagina='+MegaZine.getCurrentPage();
        _gaq.push(['_trackPageview', trackzoom]);
        _gaq.push(['_trackEvent',document.title, 'Zoom', 'Zoom na página '+MegaZine.getCurrentPage()]);
        jQuery.post(base+'flip/jornal/jsp/registraZoom.jsp', jQuery('#frm').serialize());        
    }    
}

function updatePageChange(){                          
    if(flash == true){
        current=MegaZine.getCurrentPage();
        try{
            total = MegaZine.getPageCount();
        }catch(e){
            total=pageslist.length;
        }
    }else{
        current=$(".magazine").turn("page");
        ;
        total=$(".magazine").turn("pages");;
    }
    
    var text='';        
    if(current == 0 || current == total || current == null){
        if(current == 0 || current == null){
            current = 1;
        }
        text=current+' de '+total;
    }else{
        var pages=current+' e '+(current+1);
        text=pages+' de '+total;
    }       
    jQuery('.multimidia_textfield').val(unescape(text));   
    
    var pageEdition=getCurrentEdition();    
    var trackzoom='/'+linkedicao+'edicao='+pageEdition+'/pagina='+current;
    _gaq.push(['_trackPageview', trackzoom]);
    _gaq.push(['_trackEvent',document.title, 'Folhear', 'Página '+current]);    
    
}

function getCurrentAnchor(){
    if(flash == true){
        return MegaZine.getCurrentAnchor();
    }else{
        var page=$(".magazine").turn("page");    
        return $(".page-"+page).attr('id');    
    }
}

function addPage(page, book) {
    var id, pages = book.turn('pages');
    var element = $('<div />', {});
    if (book.turn('addPage', element, page)) {		
        element.html('<div class="gradient"></div><div class="loader"></div>');
        loadPage(page, element);
    }
}

function loadPage(page, pageElement) {
    var img = $('<img />');
    img.mousedown(function(e) {
        e.preventDefault();
    });
    img.load(function() {		
        $(this).css({
            width: '100%', 
            height: '100%'
        });		
        $(this).appendTo(pageElement);				
        pageElement.find('.loader').remove();
    });
    var url=base+'/'+pageslist[page-1][2];
    img.attr('src', url);
    loadRegions(page, pageElement);
}

function loadRegions(page, element) {
/*$.getJSON('pages/'+page+'-regions.json').
		done(function(data) {

			$.each(data, function(key, region) {
				addRegion(region, element);
			});
		});*/
}

// Add region

function addRegion(region, pageElement) {	
    var reg = $('<div />', {
        'class': 'region  ' + region['class']
    }),
    options = $('.magazine').turn('options'),
    pageWidth = options.width/2,
    pageHeight = options.height;

    reg.css({
        top: Math.round(region.y/pageHeight*100)+'%',
        left: Math.round(region.x/pageWidth*100)+'%',
        width: Math.round(region.width/pageWidth*100)+'%',
        height: Math.round(region.height/pageHeight*100)+'%'
    }).attr('region-data', $.param(region.data||''));


    reg.appendTo(pageElement);
}

function regionClick(event) {
    var region = $(event.target);
    if (region.hasClass('region')) {		
        var regionType = $.trim(region.attr('class').replace('region', ''));
        return processRegion(region, regionType);
    }
}

function processRegion(region, regionType) {
    data = decodeParams(region.attr('region-data'));
    switch (regionType) {
        case 'link' :
            window.open(data.url);

            break;
        case 'zoom' :
            var regionOffset = region.offset(),
            viewportOffset = $('.magazine-viewport').offset(),
            pos = {
                x: regionOffset.left-viewportOffset.left,
                y: regionOffset.top-viewportOffset.top
            };
            $('.magazine-viewport').zoom('zoomIn', pos);

            break;
        case 'to-page' :
            $('.magazine').turn('page', data.page);

            break;
    }

}
function loadLargePage(page, pageElement) {	
    var img = $('<img />');
    img.load(function() {

        var prevImg = pageElement.find('img');
        $(this).css({
            width: '100%', 
            height: '100%'
        });
        $(this).appendTo(pageElement);
        prevImg.remove();
		
    });
    var url=base+'/'+pageslist[page-1][1];
    img.attr('src', url);
}

function loadSmallPage(page, pageElement) {	
    var img = pageElement.find('img');
    img.css({
        width: '100%', 
        height: '100%'
    });
    img.unbind('load');	
    var url=base+'/'+pageslist[page-1][2];
    img.attr('src', url);
}

function isChrome() {
    return navigator.userAgent.indexOf('Chrome')!=-1;
}
function getInternetExplorerVersion(){
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer'){
        var ua = navigator.userAgent;
        var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat( RegExp.$1 );
    }
    return rv;
}
var IEV=getInternetExplorerVersion();

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



function playsound(){    
    if(!isIE || IEV>=9 ){
        $('#turn'+(Math.floor((Math.random()*5)+1))).get(0).play();
    }
    
}

// Set the width and height for the viewport

function resizeViewport() {
    var width = $(window).width(),
    height = $(window).height(),
    options = $('.magazine').turn('options');

    $('.magazine').removeClass('animated');

    $('.magazine-viewport').css({
        width: width,
        height: height-100
    }).
    zoom('resize');


    if ($('.magazine').turn('zoom')==1) {
        var bound = calculateBound({
            width: options.width,
            height: options.height,
            boundWidth: Math.min(options.width, width),
            boundHeight: Math.min(options.height, height)
        });

        if (bound.width%2!==0)
            bound.width-=1;

			
        if (bound.width!=$('.magazine').width() || bound.height!=$('.magazine').height()) {

            $('.magazine').turn('size', bound.width, bound.height);

            if ($('.magazine').turn('page')==1)
                $('.magazine').turn('peel', 'br');

            $('.next-button').css({
                height: bound.height, 
                backgroundPosition: '-38px '+(bound.height/2-32/2)+'px'
            });
            $('.previous-button').css({
                height: bound.height, 
                backgroundPosition: '-4px '+(bound.height/2-32/2)+'px'
            });
        }

        $('.magazine').css({
            top: -bound.height/2, 
            left: -bound.width/2
        });
    }

    var magazineOffset = $('.magazine').offset(),
    boundH = height - magazineOffset.top - $('.magazine').height(),
    marginTop = (boundH - $('.thumbnails > div').height()) / 2;

    if (marginTop<0) {
        $('.thumbnails').css({
            height:1
        });
    } else {
        $('.thumbnails').css({
            height: boundH
        });
        $('.thumbnails > div').css({
            marginTop: marginTop
        });
    }

    $('.magazine').addClass('animated');
	
}

// Width of the flipbook when zoomed in

function largeMagazineWidth() {
	
    return 2214;

}

// decode URL Parameters

function decodeParams(data) {

    var parts = data.split('&'), d, obj = {};

    for (var i =0; i<parts.length; i++) {
        d = parts[i].split('=');
        obj[decodeURIComponent(d[0])] = decodeURIComponent(d[1]);
    }

    return obj;
}

// Calculate the width and height of a square within another square

function calculateBound(d) {
	
    var bound = {
        width: d.width, 
        height: d.height
    };

    if (bound.width>d.boundWidth || bound.height>d.boundHeight) {
		
        var rel = bound.width/bound.height;

        if (d.boundWidth/rel>d.boundHeight && d.boundHeight*rel<=d.boundWidth) {
			
            bound.width = Math.round(d.boundHeight*rel);
            bound.height = d.boundHeight;

        } else {
			
            bound.width = d.boundWidth;
            bound.height = Math.round(d.boundWidth/rel);
		
        }
    }
		
    return bound;
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

