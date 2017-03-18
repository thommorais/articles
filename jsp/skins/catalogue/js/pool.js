function votar(){
    var serFrm = $('#pool_form');    
     var url=base+'flip/jornal/skins/king/jsp/poolVote.jsp?'+serFrm.serialize();
     $.post(url,function(data){
         $('#pool_itens').html(data);
     });
}

jQuery(function($){
   var url=base+'flip/jornal/skins/king/jsp/enqueteForm.jsp?edicao='+getCurrentEdition();
   $("#enquetelink").click(function(){
    jQuery.fn.modalBox({
        setWidthOfModalLayer : 600,
        directCall : {
           source : url
        }
    });
    });
});