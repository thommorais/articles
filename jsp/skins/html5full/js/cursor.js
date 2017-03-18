function cursorLupaMais(){
    if(isIE){
        cursorPonteiro();
    }else{
        jQuery(".magazine-viewport .zoom-in").css('cursor','-webkit-zoom-in');
    }
}
function cursorPonteiro(){    
    if(isIE){
        jQuery(".magazine-viewport .zoom-in").css("cursor","hand");
    }else{
        jQuery(".magazine-viewport .zoom-in").css("cursor","pointer");
    }
}
function cursorMove(){    
    if(isIE){
        jQuery(".magazine-viewport .zoom-in").css("cursor","move");
    }else{
        jQuery(".magazine-viewport .zoom-in").css("cursor","move");
    }
}
function cursorTexto(){
    jQuery(".magazine-viewport .zoom-in").css("cursor","text");
}
function cursorPen(){
    if(isIE){
        jQuery(".magazine-viewport .zoom-in").css("cursor",'url('+base+'doc/visualizador/skins/html5full/pics/hand3.ico),auto');                                          
    }else{
        jQuery(".magazine-viewport .zoom-in").css("cursor",'url('+base+'doc/visualizador/skins/html5full/pics/hand-pencil.gif),auto');
    }                        
}