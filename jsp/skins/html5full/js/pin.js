var pinativo=false;
var pinedita=false;

jQuery(document).ready(function(){    
    jQuery( "#pinbutton" ).click(function(){        
        if(pinativo == true){
            jQuery("#pin-container").remove();
            pinativo=false;
            return;
        }
        pinativo=true;
        var magazineContainer=jQuery('.magazine');
        var offset=magazineContainer.offset();
        var left=offset.left;
        var top=offset.top;
        var width=magazineContainer.width();
        var height=magazineContainer.height();
       
        jQuery('body').append('<div id="pin-container" class="pin-container"></div>');       
        jQuery("#pin-container").css("left",left+"px");
        jQuery("#pin-container").css("top",top+"px");
        jQuery("#pin-container").css("width",width+"px");
        jQuery("#pin-container").css("height",height+"px");              
        
        var pinCont=1;
       
        jQuery("#pin-container").click(function(e){                        
            if(pinedita == true){
                disabledEventPropagation(e);
                return;
            }            
            var posX = $(this).position().left,
            posY = $(this).position().top;
            posX=e.pageX - posX;
            posY=e.pageY - posY;            
            var pagePin=pageNumber;
            if(posX>(width/2)){
                pagePin=pagePin+1;
            }
            
            var divPin=jQuery('<div/>',{ 
                'class':'pinitem',
                'id':'pinId'+pagePin+'.'+pinCont
            });           
            
            jQuery(divPin).css('left',posX+"px");
            jQuery(divPin).css('top',posY+"px"); 
            jQuery(divPin).draggable({ containment: "parent" });
            
            jQuery(divPin).click(function(ex){
                var posXe = $(this).position().left, posYe = $(this).position().top;
                posXe=ex.pageX - posXe; posYe=ex.pageY - posYe;
                posXe=posXe+320;                                
                jQuery("#comentariopin").css('left',posXe+"px");
                jQuery("#comentariopin").css('top',posYe+"px");                
                jQuery("#comentariopin").css('z-index','9999999');
                
                jQuery("#comentariobuttoncancel").click(function(){
                    jQuery("#pincoment").val("");
                    jQuery("#comentariopin").hide();
                    pinedita=false;                    
                });                                
                jQuery("#comentariopin").show();
                jQuery("#pincoment").val("");
                jQuery("#pincoment").focus(); 
                pinedita=true;
                disabledEventPropagation(ex);
            });            
            $(this).append(divPin);                       
            pinCont++;           
        });
       
       
    });
});
