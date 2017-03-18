jQuery(document).ready(function(){
    var docked = 0;
            
    jQuery("#dock li ul").height(jQuery(window).height());
            
    jQuery("#dock .dock").click(function(){
        jQuery(this).parent().parent().addClass("docked").removeClass("free");
                
        docked += 1;
        var dockH = (jQuery(window).height()) / docked
        var dockT = 0;
                
        jQuery("#dock li ul.docked").each(function(){
            jQuery(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        jQuery(this).parent().find(".undock").show();
        jQuery(this).hide();
                
        if (docked > 0)
            jQuery("#content").css("margin-left","250px");
        else
            jQuery("#content").css("margin-left", "60px");
    });
            
    jQuery("#dock .undock").click(function(){
        jQuery(this).parent().parent().addClass("free").removeClass("docked")
        .animate({
            left:"-700px"
        }, 200).height(jQuery(window).height()).css("top", "0px");
                
        docked = docked - 1;
        var dockH = (jQuery(window).height()) / docked
        var dockT = 0;
                
        jQuery("#dock li ul.docked").each(function(){
            jQuery(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        jQuery(this).parent().find(".dock").show();
        jQuery(this).hide();
                
        if (docked > 0)
            jQuery("#content").css("margin-left", "250px");
        else
            jQuery("#content").css("margin-left", "60px");
    });

    jQuery("#dock li").hover(function(){
        loadDock(this.id);
        jQuery(this).find("ul").animate({
            left:"40px"
        }, 200);
    }, function(){
        jQuery(this).find("ul.free").animate({
            left:"-700px"
        }, 200);
    });
});

function loadDock(name){
    if(name == 'sumario_barra'){        
        if(jQuery('#sumario_barra .free').html().length == 0){
            var html='<div id="header"><li class="header">Thumbnail</li></div>';
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('sumario')+'?idForm='+pageAnchor;
            url=url+'&sumarioFotos='+sumarioFotos;
            jQuery.post(url,function(data){
                jQuery('#sumario_barra .free').html(html+data);
            });
        }
    }else{
        if(name == 'indice_barra'){
            if(jQuery('#indice_barra .free').html().length == 0){
                var html='<div id="header"><li class="header">Sumario</li></div>';
                var pageAnchor=getCurrentEdition();
                var url=getPagesLink('cadernos')+'?idForm='+pageAnchor;
                jQuery.post(url,function(data){
                    jQuery('#indice_barra .free').html(html+data);
                });
            }
        }else{
            if(name == 'edicoes_barra'){                
                if(jQuery('#edicoes_barra .free').html().length == 0){
                    openEditionMode(page);
                }
            }else{
                if(name == 'produtos_barra'){                
                    if(jQuery('#produtos_barra .free').html().length == 0){                    
                        openProdutosMode();
                    }                    
                }else{
                    if(name == 'anotacoes_barra'){                
                        if(jQuery('#anotacoes_barra .free').html().length == 0){                            
                            var html='<div id="header"><li class="header">Notas</li></div>';
                            var pageAnchor=getCurrentEdition();                            
                            var url=getPagesLink('notas')+'?edicao='+pageAnchor;                            
                            jQuery.post(url,function(data){
                                jQuery('#anotacoes_barra .free').html(html+data);
                                $.getScript(base+'flip/jornal/skins/king/js/cadernofiltro.js');
                            });
                        }                        
                    }
                }
            }
        }
    }
}