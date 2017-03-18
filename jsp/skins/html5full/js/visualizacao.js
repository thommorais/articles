var modoview="";
jQuery(document).ready(function(){       
    jQuery("#modovisualizacao").change(function(){
        var tipo=jQuery(this).val();        
        VIEWMODE=tipo;
        
        if(VIEWMODE_PREVIOUS != VIEWMODE){
            if(VIEWMODE!='4'){
                VIEWMODE_PREVIOUS=VIEWMODE;
            }       
            restoreViewOnZoomOut();
            VIEWMODE_CHANGED=true;
        }
    });
    if(modoview!=null && modoview!=""){
        jQuery("#modovisualizacao").val(modoview);
        VIEWMODE_PREVIOUS='1';
        VIEWMODE=modoview;
        setTimeout("restoreViewOnZoomOut()",2500);
    }
});

function restoreViewOnZoomOut(){ 
    jQuery("#loading").show();
    setTimeout(function(){
        switch(VIEWMODE){
            case '1' :
                html5PaginaDupla();
                updatePageChange();
                jQuery("#loading").hide();
                return;
            case '2' :
                html5PaginaLargura();
                updatePageChange();
                jQuery("#loading").hide();
                return;
            case '3' :
                html5PaginaAltura();
                updatePageChange();
                jQuery("#loading").hide();
                return;
            case '4' :
                html5PaginaZoom();                
                VIEWMODE=VIEWMODE_PREVIOUS;
                updatePageChange();
                jQuery("#loading").hide();
                return;
            default:
                return;
        }   
    },1000);
}

function html5PaginaDupla(){        
    var height=jQuery("#content").height();
    height=height-80;
    var newX=(doc_x*height)/doc_y;      
    //jQuery(".magazine-viewport .magazine").css("width",(newX*2)+"px").css("height",height+"px");                     
        
    jQuery(".magazine-viewport").css('overflow-y','hidden');            
    jQuery("#viewerContainer").css("overflow-y","hidden");        
    jQuery(".magazine").turn("display", "double").turn('size',newX*2,height);        
    if(oldLeftPosition != null){
        jQuery(".magazine").css("left",oldLeftPosition);    
        oldLeftPosition=null;
    }
    resizeViewport();
}

function html5PaginaLargura(){    
    var width = jQuery(document).width(), height = jQuery(document).height();            
    jQuery(".magazine-viewport").css('overflow-y','auto');            
    jQuery("#viewerContainer").css("overflow-y","");
    var size=calculateAspectRatioFit(doc_x,doc_y,width,height*3);    
    var newX=size.split(",")[0];
    var newY=size.split(",")[1];      
    jQuery(".magazine").turn("display", "single").turn('size',newX,newY);                
    jQuery(".magazine").css("left",((newX/2)*-1)+"px");    
    resizeViewport();    
}

function html5PaginaAltura(){        
    var height=jQuery("#content").height();
    height=height-80;
    var newX=(doc_x*height)/doc_y;      
    jQuery(".magazine").turn("display", "single").turn('size',newX,height);
    jQuery(".magazine-viewport").css('overflow-y','hidden');
    if(oldLeftPosition == null){
        oldLeftPosition=jQuery(".magazine").css("left");
    }
    jQuery(".magazine").css("left",((newX/2)*-1)+"px");    
    resizeViewport(); 
}

function html5PaginaZoom(){    
    jQuery('.magazine-viewport').zoom('zoomIn');
}

function calculateAspectRatioFit(srcWidth, srcHeight, maxWidth, maxHeight) {
    var ratio = [maxWidth / srcWidth, maxHeight / srcHeight ];
    ratio = Math.min(ratio[0], ratio[1]);
    return (srcWidth*ratio)+","+(srcHeight*ratio) 
}