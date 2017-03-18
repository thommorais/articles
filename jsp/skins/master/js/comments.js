var loaded=false;
function comment_callback(number){    
    if(number && number > 1){
        document.getElementById("comment_count").innerHTML=number;
    }else{
        if(number && number == 1){
            document.getElementById("comment_count").innerHTML=number;
        }else{
            document.getElementById("comment_count").innerHTML="0";
        }
    }
    loaded=true;
}

function reload_comments(){    
    if(loaded && COMMENT_TYPE != 'P'){
        return;
    }else{
    var anchor=getCurrentAnchor();
    var edicao=getCurrentEdition();
    var url=base+'flip/jornal/jsp/loadNumberComments.jsp?edicao='+edicao+'&pagina='+anchor;    
    jQuery.post(url,function(data){
       comment_callback(data);
    });
    }
}