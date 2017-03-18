function abreComentarioNota(msg,coord){
    var sizes=coord.split("-");
    var xy=sizes[0].split(",");
    var wh=sizes[1].split(",");
    jQuery(".menu_postit").hide();

    var options = {
        notes:[{
            "id":1,
            "text":msg,
            "pos_x": xy[0],
            "pos_y": xy[1],
            "width": wh[0],
            "height": wh[1]
        }]
    }
    jQuery('#content').stickyNotes(options);
}

function abrePaginaIndice(anchor,pagina,msg,coord){
        gotoAnchor(anchor,false);        
        if(msg != null && coord != null){          
            abreComentarioNota(msg,coord);
        }
    return false;
}


function salvarNotes(){
    var note_ids = jQuery.fn.stickyNotes.currentlyEditedNotes();
    for (var i = note_ids.length - 1; i >= 0; i--){
        var note_id = note_ids[i]
        if (note_id != null) {
            jQuery.fn.stickyNotes.stopEditing(note_id);
        }
    };
    var notes=jQuery.fn.stickyNotes.getNotes();
    for(var i=0;i<notes.length;i++){
        if(notes[i] != null){
            var coord = (notes[i].pos_x+","+notes[i].pos_y+"-"+notes[i].width+","+notes[i].height);
            var msg = (notes[i].text);
            var pageEdition=getCurrentEdition();
            var pagina = getCurrentAnchor();            
            jQuery("#frm #msg").val(msg);
            jQuery("#frm #coord").val(coord);
            jQuery("#frm #idEdicao").val(pageEdition);
            jQuery("#frm #pagina").val(pagina);
            //alert(pagina);            
            var ser = jQuery("#frm").serialize();
            //alert(ser);
            jQuery.post(base+'flip/jornal/skins/king/jsp/registraPostit.jsp',ser,new function(){
                jQuery("#notas_barra .free").html("");
                removeNotas();
            });
        }
    }
}

function removeNotas(){  
        jQuery.fn.stickyNotes.removeAllNotes();
        jQuery(".menu_postit").show();    
}

function openCommentModeMarkup(){
    abreComentarioNota("Clique aqui 2x para escrever.","150,250-200,220");
    return false;
}