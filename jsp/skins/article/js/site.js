var MODAL_OPENED=null;
var ARTICLE_OPENED=false;
var searchResult=null;
$(document).ready(function(){


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
            $('body').removeClass('overlay-opened')

        }else{
            fecharOutros();
            openEditionMode(0);
            $('body').addClass('overlay-opened')
        }
    }

    fecharTodasEdicoes = function(){
        $('#todas-edicoes').fadeOut();
        $('#btn-todas-edicoes').removeClass('ativo');
        $('body').removeClass('overlay-opened');
        MODAL_OPENED=null;
    }

    abrirIndice = function(){
        if(MODAL_OPENED=='INDICE'){
            fecharOutros();
            $('body').removeClass('overlay-opened')

        }else{
            fecharOutros();
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('indice')+'?idForm='+pageAnchor;
            jQuery.post(url,function(data){
                jQuery('#indicecontent').html(data);
                $('#indice').fadeIn();
                $('#btn-indice').addClass('ativo');

                MODAL_OPENED='INDICE';
            });
            $('body').addClass('overlay-opened');

        }
    }
    fecharIndice = function(){
        $('#indice').fadeOut();
        $('#btn-indice').removeClass('ativo');
        $('body').removeClass('overlay-opened');
        MODAL_OPENED=null;
    }

    abrirArtigos = function(){
        if(ARTICLE_OPENED == false){
            jQuery("#article-reader").show();
            jQuery("#reader").hide();
            jQuery("footer").hide();
            ARTICLE_OPENED=true;
            $('#btn-artigos').addClass('ativo');
            $("body").css("overflow-y","auto");
            // $('body').addClass('overlay-opened')

        }else{
            jQuery("#article-reader").hide();
            jQuery("#reader").show();
            jQuery("footer").show();
            ARTICLE_OPENED=false;
            $('#btn-artigos').removeClass('ativo');
            $("body").css("overflow","hidden");
            // $('body').removeClass('overlay-opened')

        }
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
                $('#paginas').fadeIn();
                $('#btn-paginas').addClass('ativo');

                MODAL_OPENED='SUMARIO';
            });

            $('body').addClass('overlay-opened')

        }

    }

    fecharPaginas = function(){
        $('#paginas').fadeOut();
        $('body').removeClass('overlay-opened');
        $('#btn-paginas').removeClass('ativo');
        MODAL_OPENED=null;
    }

    abrirShare = function(){
        fecharOutros();
        $('#share').fadeIn();
        $('#btn-exportar').addClass('ativo');

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
                    $('#exportar').fadeIn();
                    $('#btn-paginas').addClass('ativo');

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
                $('#pesquisa').fadeIn();
                $('#btn-pesquisa').addClass('ativo');

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
                $('#comentar').fadeIn();
                $('#btn-comentar').addClass('ativo');

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
        $('body').removeClass('overlay-opened');

        $('.overlay-content').fadeOut();

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
        $('#comentar').fadeIn();
        $('#btn-comentar').addClass('ativo');

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
        $('#todas-edicoes').fadeIn();
        $('#btn-todas-edicoes').addClass('ativo');

        MODAL_OPENED='EDICOES';
    });

}
