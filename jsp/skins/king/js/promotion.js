function openPromocao(edicao){
    var url=getPagesLink('promocaoForm')+'?edicao='+edicao;        
    jQuery.post(url,function(message) {
        jQuery.fn.modalBox({
            setWidthOfModalLayer : 900,
            positionTop : "20",            
            directCall : {
                data :message
            }
        });
    });    
}

function participaPromocao(){                    
    var frm = jQuery("#promocaoForm");
        
    
    if(jQuery("#nomeId").val() == ""){
        alert("Informe o seu nome.");
        return false;
    }    
    if(jQuery("#emailId").val() == ""){
        alert("Informe o seu email.");
        return false;
    }    
    
    if(jQuery("#cidadeId").val() == ""){
        alert("Informe a sua cidade.");
        return false;
    }    
    
    
    jQuery.post(base+'flip/jornal/jsp/promocaoSubmit.jsp', frm.serialize(),function(message) {
        jQuery.fn.modalBox({
            directCall : {
                data :message
            }
        });
    });      
    return true;
}
