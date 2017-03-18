function votar(){
    var serFrm = jQuery('#pool_form');    
     var url=base+'flip/jornal/skins/king/jsp/poolVote.jsp?'+serFrm.serialize();
     jQuery.post(url,function(data){
         jQuery('#pool_itens').html(data);
     });
}

jQuery(function($){
   var url=base+'flip/jornal/skins/king/jsp/enqueteForm.jsp?edicao='+getCurrentEdition();
   jQuery("#enquetelink").click(function(){
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 600,
        directCall : {
           source : url
        }
    });
    });
});