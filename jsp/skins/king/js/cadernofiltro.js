jQuery(document).ready(function(){    
    jQuery('#filter').keyup(function(e){
        filtraIndice(jQuery(this).val());
    });    
});


var pieceResize=0;
function tiraMenuTela(){
    if(jQuery("#menu_lateral") != null){
    jQuery("#menu_lateral").html("");
    jQuery("#menu_lateral").remove();
    var size=pieceResize+ 110;
    if(imgmode){
        jQuery("#container_img").css("width",size+"px");
        jQuery("#container_img").css("padding-left","0px");
        jQuery("#container_img_text").show();
    }else{
        jQuery("#jornal").css("width",size+"px");
        jQuery("#jornal").css("padding-left","0px");
    }
    pieceResize=0;
    }
}

function carregaMenuTela(){
    if(pieceResize == 0) pieceResize=document.body.offsetWidth - 110;
    var html="<div id='menu_lateral'></div>";
    if(imgmode){
        jQuery("#container_img").css("width",pieceResize+"px");
        jQuery("#container_img").css("padding-left","130px");
    }else{
        jQuery("#jornal").css("width",pieceResize+"px");
        jQuery("#jornal").css("padding-left","130px");
    }
    jQuery("#container_img_text").hide();
    jQuery("#content").prepend(html);
    var pageAnchor=getCurrentEdition();
    var url=getPagesLink('cadernos_pdf')+'?idForm='+pageAnchor;
    jQuery.post(url,function(data){
        jQuery('#menu_lateral').html(data);
        jQuery('#filter_pdf').keyup(function(e){
            filtraIndice(jQuery(this).val());
        });
    });
}

function filtraIndice(val){
    jQuery('#indice_barra .indice,#videos_barra .indice, #menu_lateral .indice, #notas_barra .indice').each(function(index) {
        var title=jQuery(this).attr("title");
        if(title != null && title != 'filtro'){
            if(val == null || val == ''){
                jQuery(this).show();
            }else{
                if(title.indexOf(val) == -1){
                    jQuery(this).hide();
                }else{
                    jQuery(this).show();
                }
            }
        }
    });
}

