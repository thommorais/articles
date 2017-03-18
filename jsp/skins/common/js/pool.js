function votar(){
    var serFrm = Form.serialize('pool_form');
     var url=base+'flip/jornal/jsp/poolVote.jsp?'+serFrm;    
     var myAjax = new Ajax.Request(url, {
        method: 'get',
        parameters: null,
        onSuccess: function(response) {
            var text = response.responseText;
            text = text.replace(/\+/g," ");
            text = unescape(text);
            $('pool_itens').innerHTML=text;
        },
        onFailure: function(response) {
            var text = response.responseText;
            text = text.replace(/\+/g," ");
            text = unescape(text);
            $('pool_itens').innerHTML=text;
        }
    });
}

function votarJQuery(){
    var serFrm = $('#pool_form').serialize();
     var url=base+'flip/jornal/jsp/poolVote.jsp?'+serFrm;    
    $.post(url,function(data){
       $("#pool_itens").html(data);
    });     
}