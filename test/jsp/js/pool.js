function votar(){
    var serFrm = jQuery('#pool_form');    
    var url=base+'flip/jornal/skins/master/jsp/poolVote.jsp?'+serFrm.serialize();
    jQuery.post(url,function(data){
        jQuery('.pool_itens').html(data);
    });
}