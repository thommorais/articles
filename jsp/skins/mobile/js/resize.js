
var isMobile = { 
    Android: function() { 
        return navigator.userAgent.match(/Android/i); 
    }, 
    BlackBerry: function() { 
        return navigator.userAgent.match(/BlackBerry/i); 
    }, 
    iOS: function() { 
        return navigator.userAgent.match(/iPhone|iPad|iPod/i); 
    }, 
    Opera: function() { 
        return navigator.userAgent.match(/Opera Mini/i); 
    }, 
    Windows: function() { 
        return navigator.userAgent.match(/IEMobile/i); 
    }, 
    any: function() { 
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows()); 
    } 
}; 
	
	
function hideAddressBar(){     
    if (navigator.userAgent.match(/Android/i)) { 
        window.scrollTo(0,0); // reset in case prev not scrolled 
        var nPageH =jQuery(document).height(); 
        var nViewH = window.outerHeight; 
        if (nViewH > nPageH ) { 
            nViewH = nViewH / window.devicePixelRatio; 
           jQuery('BODY').css('height',nViewH + 'px'); 
        } 
        window.scrollTo(0,1); 
    }else{ 
        addEventListener("load", function() { 
            setTimeout(hideURLbar, 0); 
            setTimeout(hideURLbar, 500); 
        }, false); 
    } 
    function hideURLbar(){ 
        if(!pageYOffset){ 
            window.scrollTo(0,1); 
        } 
    } 
    return this; 
} 
jQuery(document).ready(function(){    
    /*try{
        hideAddressBar();    
    }catch(e){}*/
});
	 
function getImgSize(imgSrc){
    var newImg = new Image();    
    newImg.src = imgSrc;
    var height = newImg.height;
    var width = newImg.width;
    p = jQuery(newImg).ready(function(){
        return {
            width: newImg.width, 
            height: newImg.height
            };
    });
    return (p[0]['width']+"x"+p[0]['height']);
}         


