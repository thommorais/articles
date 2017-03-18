function executeCommand(command,param){
    if(command != null && command != '' && command != undefined){
        alert('Executando '+command+" e "+param);
        if(param != null && param != ""){
            command=command+"('"+param+"')";
        }else{
            command=command+"()";
        }
        var fn = eval(command);        
    }
}


/**
 * Abre a tela de impressao
 */
function openPrint(){
    jQuery('.imprimir').click();
}
/**
 * Abre as edicoes anteriores
 */
function openIssues(){
    jQuery('.edicoes').click();
}
/**
 * Abre a tela de ajuda
 */
function openHelp(){
    var helpUrl=base+'flip/jornal/skins/html5/pics/tutorial.jpg';
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 728,
        positionTop : "2",
        directCall : {
            data : '<img src="'+helpUrl+'" width="600px"/>'
        }
    });
}
/***
 * Abre a tela para pesquisa
 */
function openSearch(){
    jQuery('.procurar').click();
}
/**
 * Realiza a pesquisa geral
 */
function doSearch(keyword){
    pesquisaAll(keyword);
}
/**
 * Busca as capas 
 */
function listIssues(tx){
    //return openEditionModeAll(keyword);    
    var html='';
    var pageAnchor=getCurrentEdition();
    var page=0;    
    var url=getPagesLink('edicoesCapa')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;    
    if(tx!=null && tx!=undefined){
        url=url+"&tx="+tx;        
    }            
    
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 730,
        directCall : {
            source: url
        }
    });       
}    