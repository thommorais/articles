var loaded = false;
function comment_callback(number) {
    if (number && number > 1) {
        document.getElementById("comment_count").innerHTML = number + " comments";
    } else {
        if (number && number == 1) {
            document.getElementById("comment_count").innerHTML = number + " comments";
        } else {
            document.getElementById("comment_count").innerHTML = "No comments!";
        }
    }
    loaded = true;
}

function reload_comments() {    
    if (loaded&&COMMENT_TYPE!='P') {
        return;
    } else {
        var anchor = getCurrentAnchor();
        var edicao = getCurrentEdition();
        var url = base+'flip/jornal/jsp/loadNumberComments.jsp?edicao='+edicao+'&pagina='+anchor;        
        jQuery.post(url, function (data) {
            comment_callback(data);
        });
    }
}

function showComments() {
    var pageAnchor = getCurrentAnchor();
    var pageEdition = getCurrentEdition();
    var url = getPagesLink('mostraComentarios')+'?pagina='+pageAnchor;
    url = url+'&edicao='+pageEdition;
    jQuery.fn.modalBox({
        setWidthOfModalLayer: 700,
        directCall: {
            source: url
        }
    });
}