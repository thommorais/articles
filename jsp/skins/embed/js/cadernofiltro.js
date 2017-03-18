$(document).ready(function(){    
    $('#filter').keyup(function(e){
        filtraIndice($(this).val());
    });    
});


var pieceResize=0;
function tiraMenuTela(){
    if($("#menu_lateral") != null){
    $("#menu_lateral").html("");
    $("#menu_lateral").remove();
    var size=pieceResize+ 110;
    if(imgmode){
        $("#container_img").css("width",size+"px");
        $("#container_img").css("padding-left","0px");
        $("#container_img_text").show();
    }else{
        $("#jornal").css("width",size+"px");
        $("#jornal").css("padding-left","0px");
    }
    pieceResize=0;
    }
}

function carregaMenuTela(){
    if(pieceResize == 0) pieceResize=document.body.offsetWidth - 110;
    var html="<div id='menu_lateral'></div>";
    if(imgmode){
        $("#container_img").css("width",pieceResize+"px");
        $("#container_img").css("padding-left","130px");
    }else{
        $("#jornal").css("width",pieceResize+"px");
        $("#jornal").css("padding-left","130px");
    }
    $("#container_img_text").hide();
    $("#content").prepend(html);
    var pageAnchor=getCurrentEdition();
    var url=getPagesLink('cadernos_pdf')+'?idForm='+pageAnchor;
    $.post(url,function(data){
        $('#menu_lateral').html(data);
        $('#filter_pdf').keyup(function(e){
            filtraIndice($(this).val());
        });
    });
}

function filtraIndice(val){
    $('#indice_barra .indice,#videos_barra .indice, #menu_lateral .indice, #notas_barra .indice').each(function(index) {
        var title=$(this).attr("title");
        if(title != null && title != 'filtro'){
            if(val == null || val == ''){
                $(this).show();
            }else{
                if(title.indexOf(val) == -1){
                    $(this).hide();
                }else{
                    $(this).show();
                }
            }
        }
    });
}

