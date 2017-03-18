var MODAL_OPENED=null;
var searchResult=null;
$(document).ready(function(){
    var oScrollbar1 = null;
    var oScrollbar2 = null;
    var oScrollbar3 = null;
    var oScrollbar4 = null;
    var oScrollbar5 = null;
	
    abrirEnquete = function(){
        fecharOutros();		
        $('#enquete').fadeIn();
        $('#header .icones-esquerda .enquete').addClass('selecionado');
    }
    fecharEnquete = function(){
        $('#enquete').fadeOut();
        $('#header .icones-esquerda .enquete').removeClass('selecionado');
        MODAL_OPENED=null;
    }	
    removerEnquete = function(){
        $('#header .icones-esquerda .enquete').fadeOut(function(){
            $(this).remove()
        } );
    }	
	

    abrirTodasEdicoes = function(){
        if(MODAL_OPENED=='EDICOES'){
            fecharOutros();   
        }else{       
            openEditionMode(0);            
        }        
    }
    fecharTodasEdicoes = function(){
        $('#todas-edicoes').fadeOut();
        $('#btn-todas-edicoes').removeClass('ativo');		
        MODAL_OPENED=null;
    }
		
    abrirIndice = function(){
        if(MODAL_OPENED=='INDICE'){
            fecharOutros();   
        }else{        
            fecharOutros();
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('indice')+'?idForm='+pageAnchor;
            jQuery.post(url,function(data){
                jQuery('#indicecontent').html(data);
                $('#indice').fadeIn();
                $('#btn-indice').addClass('ativo');
                fixaModal();
                MODAL_OPENED='INDICE';
            });   
        }
    }
    fecharIndice = function(){
        $('#indice').fadeOut();
        $('#btn-indice').removeClass('ativo');	
        MODAL_OPENED=null;
    }
	
    abrirPaginas = function(){
        if(MODAL_OPENED=='SUMARIO'){
            fecharOutros();   
        }else{        
            fecharOutros();
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('paginas')+'?idForm='+pageAnchor;
            jQuery.post(url,function(data){
                jQuery('#paginascontent').html(data);
                
                oScrollbar2 = $('#scrollbar2');
                oScrollbar2.tinyscrollbar({
                    axis: 'x'
                });
                $('#paginas').fadeIn();	
                $('#btn-paginas').addClass('ativo');
                fixaModal();
                MODAL_OPENED='SUMARIO';
            });   
        }                
    }
    fecharPaginas = function(){
        $('#paginas').fadeOut();
        $('#btn-paginas').removeClass('ativo');		
        MODAL_OPENED=null;
    }
	
    abrirShare = function(){
        fecharOutros();		
        $('#share').fadeIn();		
        $('#btn-exportar').addClass('ativo');	
        fixaModal();
    }
    fecharShare = function(){
        $('#share').fadeOut();
        $('#btn-exportar').removeClass('ativo');		
        MODAL_OPENED=null;
    }	

    abrirExportar = function(todos){
        
        if(MODAL_OPENED=='EXPORTAR'){
            fecharOutros();   
        }else{        
            fecharOutros();            
            var url=getPDFLink(todos);
            if(url != null){
                jQuery.post(url,function(data){
                    jQuery('#exportarcontent').html(data);                
                    oScrollbar2 = $('#scrollbar3');
                    oScrollbar2.tinyscrollbar({
                        axis: 'x'
                    });
                    $('#exportar').fadeIn();	
                    $('#btn-paginas').addClass('ativo');
                    fixaModal();
                    MODAL_OPENED='EXPORTAR';
                });   
            }
        }                                
    }
    fecharExportar = function(){
        $('#exportar').fadeOut();
        $('#btn-exportar').removeClass('ativo');		
        MODAL_OPENED=null;
    }	
	
    abrirPesquisa = function(){
        if(MODAL_OPENED=='PESQUISA'){
            fecharOutros();   
        }else{        
            fecharOutros();                        
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo='+acervo;
            url=url+'&linkedicao='+linkedicao;                                        
            jQuery.post(url,function(data){
                jQuery('.pesquisacontent').html(data);                
                oScrollbar4 = $('#scrollbar4');
                oScrollbar4.tinyscrollbar();
                $('#pesquisa').fadeIn();	
                $('#btn-pesquisa').addClass('ativo');
                fixaModal();
                MODAL_OPENED='PESQUISA';
            });   
        }        
    }
    fecharPesquisa = function(){
        $('#pesquisa').fadeOut();
        $('#btn-pesquisa').removeClass('ativo');		
        MODAL_OPENED=null;
    }	
	
    abrirTexto = function(){
        if(MODAL_OPENED=='TEXTO'){
            fecharOutros();   
        }else{        
            fecharOutros();                        
            var pageEdition=getCurrentEdition();
            var pageAnchor=getCurrentAnchor();
            var url=getPagesLink('texto')+'?idEdicao='+pageEdition+'&idForm='+pageAnchor;            
            jQuery.post(url,function(data){
                jQuery('.textocontent').html(data);                                
                $('#texto').fadeIn();	                
                fixaModal();
                MODAL_OPENED='TEXTO';
            });   
        }         
    };
        
    abrirComentar = function(){        
        if(MODAL_OPENED=='COMENTA'){
            fecharOutros();   
        }else{        
            fecharOutros();                        
            var pageEdition=getCurrentEdition();
            var pageAnchor=getCurrentAnchor();
            var url=getPagesLink('comentarios')+'?edicao='+pageEdition+'&pagina='+pageAnchor;            
            jQuery.post(url,function(data){
                jQuery('.comentacontent').html(data);                
                oScrollbar5 = $('#scrollbar5');
                oScrollbar5.tinyscrollbar();
                $('#comentar').fadeIn();	
                $('#btn-comentar').addClass('ativo');
                fixaModal();
                MODAL_OPENED='COMENTA';
            });   
        }         
    }
    fecharComentar = function(){
        $('#comentar').fadeOut();
        $('#btn-comentar').removeClass('ativo');		
        MODAL_OPENED=null;
    }			
	
	
    fecharOutros = function(){
        fecharComentar();
        fecharPesquisa();
        fecharExportar();
        fecharShare();
        fecharPaginas();
        fecharIndice();
        fecharTodasEdicoes();
        fecharEnquete();
        MODAL_OPENED=null;
    }
    
    fecharTexto = function(){
        $('#texto').fadeOut();        
        MODAL_OPENED=null;
        
    }	
	
    marcarParaExportar = function(obj, pagina){
        if(!$(obj).hasClass('selecionado')){
            $(obj).addClass('selecionado');
            $(obj).find('i').css('display', 'block');
            $('#exportpage-'+pagina).val('1');
        }else{
            $(obj).removeClass('selecionado');
            $(obj).find('i').css('display', 'none');
            $('#exportpage-'+pagina).val('0');
        }
    }
    
    marcarParaComentar = function(obj, pagina){
        if(!$(obj).hasClass('selecionado')){
            
            $(".selecionado").find('i').css('display', 'none');
            $(".selecionado").removeClass('selecionado');
            
            
            $(obj).addClass('selecionado');
            $(obj).find('i').css('display', 'block');
            $('#selecaoComentar-'+pagina).val('1');
            $("#pagina_anchor").val(pagina);
        }else{
            $(obj).removeClass('selecionado');
            $(obj).find('i').css('display', 'none');
            $('#selecaoComentar-'+pagina).val('0');
            if($("#pagina_anchor").val()==pagina){
                $("#pagina_anchor").val("");
            }
        }
    }
    	
	
    fixaModal = function(){
        if($("#todas-edicoes").length){
            $("#todas-edicoes").css('height', $(window).height() - 40);
            $("#todas-edicoes .viewport").css('height', $(window).height() - 80);
            if(oScrollbar1!=null && oScrollbar1.length){
                oScrollbar1.tinyscrollbar_update();
            }
        }
		
        if($("#pesquisa").length){
            $("#pesquisa").css('height', $(window).height() - 40);
            $("#pesquisa .viewport").css('height', $(window).height() - 80);
            if(oScrollbar4!= null && oScrollbar4.length){
                oScrollbar4.tinyscrollbar_update();
            }
        }		
		
        if($("#comentar").length){
            $("#comentar").css('height', $(window).height() - 40);
            $("#comentar .viewport").css('height', $(window).height() - 80);
            if(oScrollbar5!= null && oScrollbar5.length){
                oScrollbar5.tinyscrollbar_update();
            }
        }                
        
        if($("#texto").length){
            $("#texto").css('height', $(window).height() - 40);
            $("#texto .viewport").css('height', $(window).height() - 80);            
        }        
                
        if($("#paginas").length){
            var totalSimples = $("#paginas .overview .edicoes .edicao.simples").length;
            var totalDuplo = $("#paginas .overview .edicoes .edicao.duplo").length;
            $("#paginas .overview").css('width', (totalDuplo * 240) + (totalSimples * 120) + 50);
            if(oScrollbar2!=null && oScrollbar2.length){
                oScrollbar2.tinyscrollbar_update();
            }
        }
                
		
        if($("#exportar").length){
            var totalSimples = $("#exportar .overview .edicoes .edicao.simples").length;
            var totalDuplo = $("#exportar .overview .edicoes .edicao.duplo").length;
            $("#exportar .overview").css('width', (totalDuplo * 280) + (totalSimples * 120) + 50);
            if(oScrollbar3!=null && oScrollbar3.length){
                oScrollbar3.tinyscrollbar_update();
            }
        }		
    }
	

    $(window).resize(fixaModal);
    fixaModal();
});

function pesquisa(){
    var object=document.pesquisaForm.keywords;
    if(object.value.length < 4 ){
        alert('Deve informar uma palavra com pelo menos 4 caracteres');
        jQuery('#keywords').focus();
    }else{        
        var pageAnchor=getCurrentEdition();
        var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo='+acervo;
        url=url+'&linkedicao='+linkedicao;                                        
        var frm=jQuery('#pesquisaForm');                     
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
            _gaq.push(['_trackEvent',document.title, 'Pesquisa', 'Pesquisa por '+object.value]);
            searchResult=data;
        });      
    }
}

function comentaPagina(){
    var frm = jQuery('#comentaForm');
    var url=base+'flip/enviaEmailSites.do?'+frm.serialize();
    
    if(jQuery("#pagina_anchor").val() == ""){
        alert("Escolha a página.");
        return false;
    }    
    
    if(jQuery("#nomeId").val() == ""){
        alert("Informe o seu nome.");
        return false;
    }
    if(jQuery("#emailId").val() == ""){
        alert("Informe o seu email.");
        return false;
    }else{
        if(!jQuery.validateEmail(jQuery("#emailId").val())){
            alert("O seu email parece incorreto. Corrija-o.!");
            return false;            
        }
    }   
    if(jQuery("#mensagem").val() == ""){
        alert("Informe a mensagem.");
        return false;
    }                    
    jQuery.post(url,function(message) {
        jQuery(".pergunta").html(message);
        jQuery('#comentaForm').html("");                
        _gaq.push(['_trackEvent', document.title, 'Comentário', 'Comentário de '+jQuery("#emailId").val()]);
        reload_comments();
    });            
    return true;
}


function openCommentMode(){
  
    var pageEdition=getCurrentEdition();
    var pageAnchor=getCurrentAnchor();    
    var url=getPagesLink('comenta')+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    jQuery.post(url,function(data){
        jQuery('.comentacontent').html(data);                
        oScrollbar5 = $('#scrollbar5');
        oScrollbar5.tinyscrollbar();
        $('#comentar').fadeIn();	
        $('#btn-comentar').addClass('ativo');
        fixaModal();
        MODAL_OPENED='COMENTA';
    });              
}

function loadDataPesquisaResult(){
    if(searchResult != null){
        jQuery('#result').html(searchResult);
        jQuery('#result').show();            
        jQuery("#aguarde").hide();
        jQuery("#areabotoes").show(); 
    }
}
function getPDFLink(todos){
    var pageAnchor=getCurrentAnchor();
    var pageEdition=getCurrentEdition();
    var page = 'exportar';
    if(todos == 'Z' || todos == 'P'){
        page=page+'Todos';
    }
    var url=getPagesLink(page)+'?idForm='+pageAnchor;
    url=url+'&idEdicao='+pageEdition;
    if(todos == 'Z' || todos == 'P'){        
        _gaq.push(['_trackEvent', document.title, 'Exportar PDF', 'Exportar PDF da edição '+pageEdition]);        
        window.location.href=url;
        return null;
    }else{
        return url;
    }
}
function exportaMarcadas(){     
    var url=getPagesLink('mavenflip')+'?'+jQuery('#exporta_form').serialize();
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 300,
        directCall : {
            data : '<p>Aguarde, estamos gerando o arquivo ... </p>'
        }
    });
    window.location.href=url;
    window.setTimeout("fechaJanela()",3000);
}

var page = 0;
function openEditionMode(){
    openEditionMode(0);
}
function openEditionMode(p){
            
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
        jQuery('#edicoescontent').html(data);                
        oScrollbar1 = $('#scrollbar1');
        oScrollbar1.tinyscrollbar();
        $('#todas-edicoes').fadeIn();		
        $('#btn-todas-edicoes').addClass('ativo');	
        fixaModal();
        MODAL_OPENED='EDICOES';
    });

}
