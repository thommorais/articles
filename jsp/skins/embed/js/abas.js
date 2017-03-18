$(document).ready(function(){
    var docked = 0;
            
    $("#dock li ul").height($(window).height());
            
    $("#dock .dock").click(function(){
        $(this).parent().parent().addClass("docked").removeClass("free");
                
        docked += 1;
        var dockH = ($(window).height()) / docked
        var dockT = 0;
                
        $("#dock li ul.docked").each(function(){
            $(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        $(this).parent().find(".undock").show();
        $(this).hide();
                
        if (docked > 0)
            $("#content").css("margin-left","250px");
        else
            $("#content").css("margin-left", "60px");
    });
            
    $("#dock .undock").click(function(){
        $(this).parent().parent().addClass("free").removeClass("docked")
        .animate({
            left:"-700px"
        }, 200).height($(window).height()).css("top", "0px");
                
        docked = docked - 1;
        var dockH = ($(window).height()) / docked
        var dockT = 0;
                
        $("#dock li ul.docked").each(function(){
            $(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        $(this).parent().find(".dock").show();
        $(this).hide();
                
        if (docked > 0)
            $("#content").css("margin-left", "250px");
        else
            $("#content").css("margin-left", "60px");
    });

    $("#dock li").hover(function(){
        loadDock(this.id);
        $(this).find("ul").animate({
            left:"40px"
        }, 200);
    }, function(){
        $(this).find("ul.free").animate({
            left:"-700px"
        }, 200);
    });
});

function loadDock(name){
    if(name == 'sumario_barra'){        
        if($('#sumario_barra .free').html().length == 0){
            var html='<div id="header"><li class="header">Sumário</li></div>';
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('sumario')+'?idForm='+pageAnchor;
            url=url+'&sumarioFotos='+sumarioFotos;
            $.post(url,function(data){
                $('#sumario_barra .free').html(html+data);
            });
        }
    }else{
        if(name == 'indice_barra'){
            if($('#indice_barra .free').html().length == 0){
                var html='<div id="header"><li class="header">Índice</li></div>';
                var pageAnchor=getCurrentEdition();
                var url=getPagesLink('cadernos')+'?idForm='+pageAnchor;
                $.post(url,function(data){
                    $('#indice_barra .free').html(html+data);
                });
            }
        }else{
            if(name == 'edicoes_barra'){                
                if($('#edicoes_barra .free').html().length == 0){                    
                    openEditionMode();
                }
            }else{
                if(name == 'produtos_barra'){                
                if($('#produtos_barra .free').html().length == 0){                    
                    openProdutosMode();
                }                    
                }
            }
        }
    }
}