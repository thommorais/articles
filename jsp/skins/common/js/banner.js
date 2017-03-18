var esconderForaDaCapa=false;
x_banner = 230;
y_banner = 100;
function setVisible(obj){
    var id=obj;
    obj = document.getElementById(obj);
    if(obj){
        obj.style.visibility = (obj.style.visibility == 'visible') ? 'hidden' : 'visible';
        try{
            window.onscroll = setTimeout("placeIt('"+id+"')",500);
        }catch(e){}
        if(obj.style.visibility == 'hidden'){
            if(document.getElementById("adsensewindow")){
                document.getElementById("adsensewindow").style.visibility="hidden";
            }
        }
    }
}

function placeIt(obj){
    var id=obj;
    obj = document.getElementById(obj);
    if (document.documentElement){
        theLeft = document.documentElement.scrollLeft;
        theTop = document.documentElement.scrollTop;
    }
    else if (document.body){
        theLeft = document.body.scrollLeft;
        theTop = document.body.scrollTop;
    }
    theLeft += x_banner;
    theTop += y_banner;
    
    obj.style.left = theLeft + 'px' ;
    obj.style.top = theTop + 'px' ;
    setTimeout("placeIt('"+id+"')",500);
}
function updateSideBanner(current){    
    if(current <=1){
        showBannerLateral();
    }else{
        hideBannerLateral();
    }
}

function hideBannerLateral(){    
    if(esconderForaDaCapa == 'true'){
        if(document.getElementById('banner_lateral')){
            document.getElementById('banner_lateral').style.display='none';
        }
        if(document.getElementById('banner_lateral_esquerda')){
            document.getElementById('banner_lateral_esquerda').style.display='none';
        }
    }
}

function showBannerLateral(){
    var obj = document.getElementById('banner_lateral');
    
    bannerMaxHeight=parseInt(jQuery("#content").css("height").replace("px",""))-jQuery("#content").position().top;
    
    if(obj){
        var theLeft=window.document.body.clientWidth;
        var theTop =window.document.body.clientHeight;        
        theTop = 80;
        theLeft = (theLeft)-maxwidth-50;
        theLeft = theLeft-paddingbanner;
        theTop = theTop+paddingbannertop;
        //obj.style.left = theLeft+'px';
        obj.style.right='5px';
        obj.style.top = theTop+'px';   
        //try{
       // if(bannerMaxHeight>0){
       //     jQuery("img",obj).css("max-height",bannerMaxHeight+"px");        
       // }
       // }catch(e){}
        document.getElementById('banner_lateral').style.display='block';
    }
    obj = document.getElementById('banner_lateral_esquerda');
    if(obj){        
        var theTop =window.document.body.clientHeight;        
        theTop = 80;        
        var theLeft = 40+paddingbanner;
        theTop = theTop+paddingbannertop;
        obj.style.left = theLeft+'px';
        obj.style.top = theTop+'px';   
        try{
        if(bannerMaxHeight>0){
            jQuery("img",obj).css("max-height",bannerMaxHeight+"px");        
        }
        }catch(e){}
        document.getElementById('banner_lateral_esquerda').style.display='block';
    }    
}