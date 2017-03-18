var isIE = navigator.appVersion.indexOf('MSIE') > 0;
var isMozilla = document.getElementById && !isIE;
var isNetscape4 = document.layers ? true : false;
var anoAtual = new Date().getFullYear();

jQuery(function($){
    var zoom=false;    
    jQuery(".ampliar").click(function(){		
        if(zoom == true){
            jQuery('img',this).attr('src','../../../flip/jornal/skins/static/img/ampliador.png');
            zoom=false;	
            jQuery(document).unbind('mousemove.trackmagn$ifier');            
            jQuery("body #zoomimg").remove()           
            var page = jQuery("#leitor").jCarouselLite.getCurrentPage();
            jQuery('#page'+page+'img').unbind('load');
            jQuery('body #zoomimg').css({
                cursor:'hand'
            });
        }else{       
            ddpowerzoomer.init($);
            jQuery('img',this).attr('src','../../../flip/jornal/skins/static/img/ampliador_hover.png');
            var page = jQuery("#leitor").jCarouselLite.getCurrentPage();           
            jQuery('#page'+page+'img').addpowerzoom({
                defaultpower: 2,
                powerrange: [2,5],               
                magnifiersize: [470,275]
            });	 
            jQuery('body #zoomimg').css({
                cursor:'url(../../../flip/jornal/skins/static/img/lupa.png), auto'
            });
            zoom=true;
        }
    });
    jQuery("#leitor").jCarouselLite({
        btnNext: ".multimidia_next",
        btnPrev: ".multimidia_prev",		
        visible: 1,
        circular:false,        
        speed: 600,
        afterEnd: updatePageChange
    });
  
    jQuery('.multimidia_fr').click(function(){
        jQuery("#leitor").jCarouselLite.go(0);	
        updatePageChange();		
    });    
    jQuery('.multimidia_ff').click(function(){
        var pages=jQuery("#leitor").jCarouselLite.getPages();		
        jQuery("#leitor").jCarouselLite.go(pages-1);		
        updatePageChange();
    }); 	
	 
    jQuery('#multimidia_textfield').focus(function(){
        toogleTextField();
    });
    
    jQuery('#multimidia_select').focus(function(){
        toogleYearTextField();
    });    

    jQuery('#multimidia_textfield').blur(function(){
        updatePageChange();
        editingText='';
    });
    
    jQuery('#multimidia_select').blur(function(){
        updateDate();
        editingYearText='';
    });    
    
    jQuery('#multimidia_select').keyup(function(e){
        if(e.keyCode == 13) {
            toogleYearTextField();
        }
    });    

    jQuery('#multimidia_textfield').keyup(function(e){
        if(e.keyCode == 13) {
            toogleTextField();
        }
    });
	        
    jQuery('.multimidia_ano_next').click(function(){
        if(allowNext==true){
            var ano=jQuery("#multimidia_select").val();
            ano=parseInt(ano);
            ano=ano+1;
            jQuery("#multimidia_select").val(ano);
            updateDate();
            renovaMeses();
        }
    });
	
    jQuery('.multimidia_ano_prev').click(function(){
        if(allowPrevious==true){
            var ano=jQuery("#multimidia_select").val();
            ano=parseInt(ano);
            ano=ano-1;
            jQuery("#multimidia_select").val(ano);
            updateDate();
            renovaMeses();
        }
    });	


    jQuery('.multimidia_ff_ano').click(function(){
        if(allowNext==true){
            var ano=parseInt(getMaiorAno());                        
            jQuery("#multimidia_select").val(ano);
            updateDate();
            renovaMeses();
        }
    });
	
    jQuery('.multimidia_fr_ano').click(function(){
        if(allowPrevious==true){
            var ano=parseInt(getMenorAno());            
            jQuery("#multimidia_select").val(ano);
            updateDate();
            renovaMeses();
        }
    });

    
    jQuery('.copiar').click(function (e) {
        jQuery.getScript(base+'flip/jornal/skins/king/js/jquery.copy.min.js');
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 680,
            directCall : {
                source : getTextLink()
            }
        });
        return false;  
    });    
    jQuery('.imprimir').click(function (e) {      
        jQuery.fn.modalBox({
            directCall : {
                source : getPrintLink()
            }
        });
        return false;
    });    
    jQuery('.expediente').click(function (e) {      
        jQuery.fn.modalBox({
            directCall : {
                source : getExpedienteLink()
            }
        });
        return false;
    });    
    jQuery('.faleConosco').click(function (e) {      
        jQuery.fn.modalBox({
            directCall : {
                source : getFaleconoscoLink()              
            }
        });
        return false;
    });        
    jQuery('.comentar').click(function (e) {
        openCommentMode();

        return false;
    });  
    jQuery('.indicar').click(function (e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 750,          
            directCall : {
                source : getRecommentLink()
            }
        });
        return false;
    });    
    jQuery('.pesquisar').click(function (e) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 750,
            positionTop : "20",
            directCall : {
                source : getSearchLink()
            }
        });

        return false;
    });  
    jQuery('.pdf').click(function (e) {
        var id=this.id;
        getPDFLink('P');
        return false;
    });
    jQuery('.download').click(function (e) {        
        getPDFLink('Z');
        return false;
    });	   
    jQuery('.miniatura').click(function(e){
        abreEdicaoFlip();
        return false;
    });

    updatePageChange();	

    jQuery('.itemano,.itemanolast').click(function(){

        if(!$(this).hasClass("mesinativo")){            
            jQuery('.itemano,.itemanolast').each(function(){		
                jQuery(this).removeClass("selecionado");	
                jQuery(".jcalendar",jQuery(this)).remove();
                jQuery(this).css({
                    height:'22px'
                });	
            });

            var mes=this.id;	
            jQuery(this).addClass("selecionado");			
            jQuery('fieldset.jcalendar').jcalendar();
            jQuery(this).animate({
                height:'150px'
            });
            jQuery("#mes").val(parseInt(mes));
            updateDate(parseInt(mes));
        }
    });    
    jQuery("#multimidia_select").val(yIndex);
    jQuery("#mes").val(mIndex);
    jQuery("#day").val(dIndex);  
    jQuery('#'+mIndex).click();    
    
    jQuery(".zoom img").each(function(){
        $(this).click(function(){
            abreEdicaoFlip();
        });
    });
    renovaMeses();
    jQuery("#pesquisa_textfield").val("");    
    ddpowerzoomer.init($);    
    $("#icone img").hover(function() {
        var src=$(this).attr('src');    
        if(src.indexOf("hover")==-1)
            $(this).attr("src",src.replace('.png','_hover.png'));
    }, function() {
        var src=$(this).attr('src');        
        $(this).attr("src",src.replace('_hover',''));
    });

    
    $(".zoom img").each(function(){
        var id=$(this).attr('id').replace('page','').replace('img','');                     
        $(this).attr('src',(base+pages[id]));
        $(this).load(function(){
           $(this).addClass('loadingimg');
        });
    });
	
});

function renovaMeses(){
    jQuery('.itemano,.itemanolast').each(function(){        
        var ano=jQuery("#multimidia_select").val();
        if(!existeMes(this.id,ano)){
            jQuery(this).addClass("mesinativo");
            jQuery(this).removeClass("mesativo");
        }else{
            jQuery(this).removeClass("mesinativo");
            jQuery(this).addClass("mesativo");
        }
    });    
}


function updatePageChange(){
    var page = jQuery("#leitor").jCarouselLite.getCurrentPage();        
    var total = jQuery("#leitor").jCarouselLite.getPages();  
    var text=(page+1)+' de '+total;
    jQuery('#multimidia_textfield').val(unescape(text));
    jQuery('#multimidia_textfield_2').val(unescape(text));
}
var allowNext=true;
var allowPrevious=false;
function updateDate(){            
    year=jQuery("#multimidia_select");            
    var number=year.val();
    var maior=parseInt(getMaiorAno());
    var menor=parseInt(getMenorAno());        
    if(parseInt(number)>maior || parseInt(number)<menor){
        alert('Ano incorreto. Deve ser maior do que '+menor+" e menor do que "+maior);
        jQuery('#multimidia_select').val(anoAtual);        
    }else{                         
        
        month=jQuery("#mes");
        day=jQuery("#day");
        d = new Date(number,month.val()-1, 1);
        jQuery.jcalendar.changeMonth(d, null, day, month, year);
    
        if(parseInt(anoAtual)<=parseInt(number)){
            jQuery('.multimidia_ano_next').css('background-image','url("../../flip/jornal/skins/static/img/multimidia_next.png")');
            jQuery(".multimidia_ff_ano").css('background-image','url("../../flip/jornal/skins/static/img/multimidia_ff.png")');
            allowNext=false;
        }else{
            jQuery('.multimidia_ano_next').css('background-image','url("../../flip/jornal/skins/static/img/multimidia_next_hover.png")');
            jQuery(".multimidia_ff_ano").css('background-image','url("../../flip/jornal/skins/static/img/multimidia_ff_hover.png")');
            allowNext=true;
        }
        if(!existeAnoAnterior(parseInt(number)-1)){
            jQuery('.multimidia_ano_prev').css('background-image','url("../../flip/jornal/skins/static/img/multimidia_prev.png")');
            jQuery(".multimidia_fr_ano").css('background-image','url("../../flip/jornal/skins/static/img/multimidia_fr.png")');
            allowPrevious=false;
        }else{
            jQuery('.multimidia_ano_prev').css('background-image','url("../../flip/jornal/skins/static/img/multimidia_prev_hover.png")');
            jQuery(".multimidia_fr_ano").css('background-image','url("../../flip/jornal/skins/static/img/multimidia_fr_hover.png")');
            allowPrevious=true;
        }    
    }
}

var editingText='';	
function toogleTextField(){
    if(editingText == ''){
        editingText= jQuery('#multimidia_textfield').val();
        jQuery('#multimidia_textfield').val("");
        jQuery('#multimidia_textfield_2').val("");
    }else{
        var number=jQuery('#multimidia_textfield').val();
        jQuery('#multimidia_textfield').unbind("keydown");
        var i=(parseInt(number)-1);        
        jQuery("#leitor").jCarouselLite.go(i);	
        editingText='';
        jQuery('#multimidia_textfield').trigger("blur");
    }
}

var editingYearText='';	
function toogleYearTextField(){
    if(editingYearText == ''){
        editingYearText= jQuery('#multimidia_select').val();
        jQuery('#multimidia_select').val("");        
    }else{
        var number=jQuery('#multimidia_select').val();
        jQuery('#multimidia_select').unbind("keydown");                
        
        var maior=parseInt(getMaiorAno());
        var menor=parseInt(getMenorAno());        
        if(parseInt(number)>maior || parseInt(number)<menor){
            alert('Ano inválido. Deve ser maior do que '+menor+" e menor do que "+maior);
            jQuery('#multimidia_select').val("");
            jQuery('#multimidia_select').focus();
        }else{
            jQuery('#multimidia_select').val(number);
            editingYearText='';
            jQuery('#multimidia_select').trigger("blur");
        }
    }
}

function abreEdicaoFlip(){
    var anchor = getCurrentAnchor();
    var link = base+linkedicao+'/?ipg='+anchor+'&skin=king';
    window.open(link);
}

function abreEdicao(){
    year=jQuery("#multimidia_select");
    month=jQuery("#mes");
    day=jQuery("#day");    
    var d=year.val()+'-'+month.val()+'-'+day.val();
    var link = base+linkedicao+'?date='+d;
    window.location.href=link;
}

function getPagesLink(sector){
    return base+'flip/jornal/skins/king/jsp/'+sector+'.jsp';
}
function getStaticPagesLink(sector){
    return base+'flip/jornal/skins/static/jsp/'+sector+'.jsp';
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

function getExpedienteLink(){
    return base+'flip/jornal/jsp/customs/camara/expediente.jsp';        
}
function getFaleconoscoLink(){
    return base+'flip/jornal/jsp/customs/camara/faleconosco.jsp';        
}

function getTextLink(){
    var pageAnchor=getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var url=getPagesLink('texto')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    return url;
}

function carregaLupa(){
    jQuery(".ampliar").click();  
}   

function abrePesquisa(pagina){
    var li=jQuery("#anch"+pagina);
    var pg=li.attr('class');
    pg=pg.replace('page','');     
    jQuery("#leitor").jCarouselLite.go(pg);
}

function getPDFLink(todos){
    var pageAnchor=getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var page = 'exportar';
    if(todos == 'Z' || todos == 'P'){
        if(todos == 'Z'){
            page='downloadTodos';
        }else{
            page='mavenflip';
        }
    }else{
        if(todos == 'S'){
            page=page+'Sumario';
        }
    }
    var url=getPagesLink(page)+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    if(todos == 'Z' || todos == 'P'){
        if(todos == 'Z'){  
            url=url+'&download=S';
        }
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
function getSearchLink(){
    var pageAnchor=getCurrentEdition();
    var url=getStaticPagesLink('pesquisa')+'?idForm='+pageAnchor;
    url=url+'&linkedicao='+linkedicao;
    return url;
}

function pesquisa(){
    var object=document.faleConoscoForm.keywords;
    if(object.value.length < 4 ){
        alert('Deve informar uma palavra com pelo menos 4 caracteres');
        jQuery('#keywords').focus();
    }else{        
        var frm=jQuery('#faleConoscoForm');
        jQuery('#edicao').val(getCurrentEdition());
        var url=getSearchLink();        
        jQuery.post(url, frm.serialize(),function(data) {  
            jQuery('#result').html(data);
            jQuery('#result').show();
        });      
    }
}

function getRecommentLink(){
    var edition=getCurrentEdition();
    var url=getPagesLink('recomendacao')+'?idForm='+edition;
    return url;
}

function recomendaAmigo(){
    jQuery('#pagina_anchor').value=getCurrentAnchor();
    var frm = jQuery('#faleConoscoForm');    
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();
    loading();
   
    jQuery.post(url,function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 300,
            directCall : {
                data : message
            }
        });
    });
}

function entraEmContato(){
    jQuery('#pagina_anchor').value=getCurrentAnchor();
    var frm = jQuery('#faleConoscoForm');    
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();

    loading();
    jQuery.post(url,function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 300,
            directCall : {
                data : message
            }
        });
    });
}

function comentaPagina(){
    var frm = jQuery('#faleConoscoForm');
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();

    if(validateComentario(frm)){       
        loading();        
        jQuery.post(url,function(message) {
            jQuery.fn.modalBox({
                setWidthOfModalLayer : 300,
                directCall : {
                    data : message
                }
            });
        });
    }
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
function openCommentMode(){
    var pageAnchor=getCurrentAnchor();
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
function validateComentario(frm){    
    return true;
}

// verifica se um campo esta vazio ou nï¿½o existe
function isEmpty(campo) {
    return (campo==null || campo.value==null || campo.value=='');
}


function getCurrentAnchor(){
    var page = jQuery("#leitor").jCarouselLite.getCurrentPage();   
    var li=jQuery(".page"+page);    
    return li.attr('id');    
}
        

function fechaJanela(){
    jQuery.fn.modalBox('close');
}
function loading(){
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 300,
        directCall : {
            data : '<p align=center>'+jQuery('#loading').html()+'</p>'
        }
    });
}
 
function getMenorAno(){    
    return datas[datas.length-1][1].split("/")[2];    
} 
function getMaiorAno(){
    return datas[0][1].split("/")[2];
}  
function existeAnoAnterior(ano){ 
    for(var i=0;i<datas.length;i++){
        var comp=datas[i]; 
        if(comp[1].indexOf("/"+ano)!=-1){            
            return true;
        }    
    }
    return false;
}
        
function existeMes(mes,ano){        
    if(parseInt(mes)<10){
        mes="0"+mes;
    }        
    for(var i=0;i<datas.length;i++){
        var comp=datas[i];                               
        if(comp[1].indexOf("/"+mes+"/"+ano)!=-1){                
            return true;
        }
    }
    return false;
}        
function existeEdicao(date){
    var curr_date = date.getDate();
    var curr_month = date.getMonth();
    curr_month = curr_month + 1;
    var curr_year = date.getFullYear();
    if(parseInt(curr_date)<10) curr_date="0"+curr_date;
    if(parseInt(curr_month)<10) curr_month="0"+curr_month;
    var dt= curr_date + '/'+ curr_month + '/'+ curr_year;
    for(var i=0;i<datas.length;i++){
        var comp=datas[i];           
        if(comp[1] == dt){                
            return comp[0];
        }
    }
    return null;
}