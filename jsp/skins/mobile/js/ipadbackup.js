var page=1;
var total=0;
var myScroll=null;
var myScrollZoom=null;
var pagesum=0;
var cachePages = [""];
$(document).ready(function() {
    init();
    loadImages();
});
jQuery.getCSS = function( url, media ) {
    jQuery( document.createElement('link') ).attr({
        href: url,
        media: media || 'screen',
        type: 'text/css',
        rel: 'stylesheet'
    }).appendTo('head');
};
function getCurrentPage(){
    return page;
}
function loadImages(){
    if(myScroll != null){
        if(myScroll.scale >1){
            return;
        }
    }      
    page=parseInt(myScroll.currPageX);    
    page++;
            
    var pindex=getCurrentPage();
    for(var p=0;p<pfpages.length;p++){
        if(parseInt(pfpages[p][0])==parseInt(pindex)){
            loadImageToDiv(pfpages[p]);
            if(p<(pfpages.length-1)) loadImageToDiv(pfpages[p+1]);
            if(p<(pfpages.length-2))loadImageToDiv(pfpages[p+2]);
            if(p<(pfpages.length-3))loadImageToDiv(pfpages[p+3]);
            if(p<(pfpages.length-4))loadImageToDiv(pfpages[p+4]);            
            break;
        }
    }
}    
function changeQualityImage(op){    
    var pindex=getCurrentPage();                      
    for(var p=0;p<pfpages.length;p++){
        if(parseInt(pfpages[p][0])==parseInt(pindex)){
            var item = pfpages[p];
            var index=item[0];
            $('#pag'+index+' img').each(function(index){   
                var low=$(this).attr('src');                    
                if(low.indexOf("low")!=-1){                    
                    low=low.replace("low","");                        
                    $(this).attr('src',low);                                                                  
                }              
            });
            var obj=$('#pag'+index);  
            var width=$(window).width();
            var height=$(window).height();   
            if(width<1000){
                if(op >1){               
                    obj.css("padding-top","70px");                                                    
                    obj.css("height",height*2+"px");                                
                    obj.removeClass('lowimg');
                    obj.addClass('betterimg');                    
                }else{                  
                    obj.css("padding-top","0px");
                    obj.css("height",height+"px");                                
                    obj.removeClass('betterimg');                
                    obj.addClass('lowimg');
                }              
            }else{
//                var content=$('#pag'+index+' #zoomgallery').html();                
//                $("#zoomitem").html(content);
//                $("#imagegallery,#tab_left,#ext-comp-1013").hide();                
//                $("#wrapper").show();
//                myScrollZoom = new iScroll('zoomitem', {
//                    snap:false,
//                    hScroll:true,
//                    vScroll:true,
//                    zoom: true,
//                    momentum: false,
//                    hScrollbar:true,
//                    vScrollbar:true,
//                    bounce:false,        
//                    useTransition:true        
//                });                                     
//                myScrollZoom.scrollTo(100, '100ms')
            }
            break;
        }
    }    
}
function closeZoom(){
    $("#zoomitem").html("");
    $("#wrapper").hide();    
    $("#tab_left,#imagegallery,#ext-comp-1013").show();
    myScrollZoom.destroy();
}
function loadImageToDiv(item){
    var src=item[2];
    var normal=item[1];
    var index=item[0];    
    var html=$("#pag"+index).html();
    if(html == null || (html != null && html == '') || (html != null && html.indexOf("empty") != -1)){
        $("#pag"+index).html("<img src='"+base+"flip/jornal/skins/mobile/load.gif' align='center'/>");

        var url=base+'flip/jornal/jsp/fatiaHor.jsp?f='+src;
        $.post(url,function (data) {
            while(data.indexOf("'files")!=-1){
                data=data.replace("'files","'"+base+"/files");
            }
            data="<div id='zoomgallery'>"+data+"</div>";                        
            $("#pag"+index).html(data);                         
                                    
            setTimeout(function () {
                updateOrientation();
            }, 0);                     
            
            if(pflinks.length>0){
                for(var p=0;p<pflinks.length;p++){
                    if(pflinks[p]!=null && pflinks[p][0]==index){
                        addAreaLink(pflinks[p][1],pflinks[p][2],pflinks[p][3],pflinks[p][4],index,pflinks[p][5]);
                    }
                }
            }   
            if(pfvideos.length>0){
                for(var v=0;v<pfvideos.length;v++){
                    if(pfvideos[v]!=null && pfvideos[v][0]==index){
                        addVideo(pfvideos[v][1],pfvideos[v][2],pfvideos[v][3],pfvideos[v][4],index,pfvideos[v][5]);
                    }
                }       
            }                        
        });
        
    }else{
        updateOrientation();
    }                
    updatePageChange();
}

function updateOrientation(){
    if(total == 0){
        total=$("#thelist").children().length;
    }
    var width=$(window).width();
    var height=$(window).height();
    var realwidth=(width>1000)?(width/2):width;    
    var size=(parseInt(total)*(realwidth))+"px";                            
    $("#scroller").css("width",size);    
    $('li[id^="pag"]').each(function(index){  
        $(this).css("width",realwidth+"px");
        $(this).css("min-width",realwidth+"px");        
        $(this).css("height",height+"px");                                                                             
    });                                       
    if(myScroll != null){
        setTimeout(function () {
            myScroll.refresh();
        }, 0);
    }
}
function configure(){                
    updateOrientation();
    myScroll = new iScroll('imagegallery', {
        snap:true,
        hScroll:true,
        vScroll:true,
        zoom: true,
        momentum: false,
        hScrollbar:true,
        vScrollbar:true,
        bounce:false,        
        useTransition:true,
        onScrollEnd: function () {                                    
            loadImages();
        },
        onZoomEnd: function(){                        
            this.options.snap=this.scale<=1;
            this.options.wheelAction=this.scale<=1?'scroll':'zoom';            
            changeQualityImage(this.scale);
            this.refresh();
        }        
    });
    
    myThumbScroll = new iScroll('scrollerthumb', {
        snap:true,
        hScroll:true,
        vScroll:false,
        zoom: true,
        momentum: false,
        hScrollbar:true,
        vScrollbar:false,
        bounce:false,        
        useTransition:true        
    });    
   
    
    document.addEventListener('touchmove', function (e) {
        e.preventDefault();
    }, false);
}

function init(){
    configure();
    $(".multimidia_prev").click(function(){
        if(page >0){
            pagesum=1;
            myScroll.scrollToPage(page-2, 0);
        }else{
            page=0;
        }
        return false;
    });
    $(".multimidia_next").click(function(){
        if(page < total){
            pagesum=1;
            myScroll.scrollToPage(page, 0);
        }else{
            page=total;
        }
        return false;

    });
    $(".multimidia_ff").click(function(){
        pagesum=1;
        myScroll.scrollToPage(total-1, 0);
        return false
    });
    $(".multimidia_fr").click(function(){
        pagesum=1;
        myScroll.scrollToPage(0, 0);
        return false
    });
    $('#multimidia_textfield').focus(function(){
        toogleTextField();
    });

    $('#multimidia_textfield').blur(function(){
        updatePageChange();
        editingText='';
    });

    $('#multimidia_textfield').keyup(function(e){
        if(e.keyCode == 13) {
            toogleTextField();
        }
    });
    $("#exportarpdf").click(function(){
        var pageEdition=getCurrentEdition();
        var url=getPagesLink('mavenflip')+'?idEdicao='+pageEdition;
        window.location.href=url;
        return false
    });   
    $("#zoomitem").click(function(){
        closeZoom(); 
    });
 
    $("#dock li ul").height($(window).height());
    $("#dock li").click(function(e){
        if(e.pageX  == undefined || e.pageX > 40){
            return;
        }
        if(lockdock){
            lockdock=false;
            $(this).find("ul.free").animate({
                left:"-700px"
            }, 200);
        }else{
            loadDock(this.id);
            $(this).find("ul").animate({
                left:"40px"
            }, 200);
        }
    });    
}
var editingText='';
function toogleTextField(){
    if(editingText == ''){
        editingText= $('#multimidia_textfield').val();
        $('#multimidia_textfield').val("");
    }else{
        var number=$('#multimidia_textfield').val();
        $('#multimidia_textfield').unbind("keydown");
        var i=(parseInt(number)-1);
        pagesum=1;
        myScroll.scrollToPage(i,0);
        editingText='';
        $('#multimidia_textfield').trigger("blur");
    }
}
function addAreaLink(x,y,w,h,index,link){
    x=parseInt(x)+70;
    y=parseInt(y)+5;    
    w=parseInt(w);
    h=parseInt(h);

    var overlays="<div class=\"overlay\" style='left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px' onclick=\"window.location.href='"+link+"';\">&nbsp;</div>";
    
    $("#pag"+index).append(overlays);
}
function addVideo(x,y,w,h,index,src){
    x=parseInt(x)+105
    y=parseInt(y);  
    w=parseInt(w)-100;
    h=parseInt(h)-10;       
    var div="<div style=\"position:relative;z-index:999;left:"+x+"px;top:"+y+"px; width:"+w+"px; height:0px;\">&nbsp;";
    div=div+"<video controls autoplay height=\""+h+"px\" width=\""+w+"px\" poster=\"http://flip.siteseguro.ws/loading.gif\">";
    div=div+"<source src=\""+base+src+"\" type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"' />";
    div=div+"</video>";
    div=div+"</div>" 
    $("#pag"+index).prepend(div);    
}
function updatePageChange(){
    var current = page;
    if(page <= 0) current=1;
    if(page> total){
        page=total;
    }
    var width=$(window).width();
    if(width>1000){
        var max=current*2;
        var text=(max-1)+' e '+(max)+' de '+total;    
        $('#multimidia_textfield').val(text);        
    }else{
        var text=(current)+' de '+total;    
        $('#multimidia_textfield').val(text);
    }
}
var lockdock=false;
var docked = 0;

function getPagesLink(sector){
    return base+'flip/jornal/skins/king/jsp/'+sector+'.jsp';
}
function abrePaginaIndice(anchor,pagina){
    var p=parseInt(pagina);
    pagesum=1;
    myScroll.scrollToPage(p-1,0);
}
function openEditionMode(p){
    var html='<div id="header"><li class="header">Edições anteriores</li></div>';
    var pageAnchor=getCurrentEdition();
    if(!p) p=0;
    var url=getPagesLink('edicoesiPad')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+p;
    $.post(url,function(data){
        $('#edicoes_barra .free').html(html+data);
    });
}

function openProdutosMode(){
    openProdutosMode(0);
}
function openProdutosMode(p){
    var html='<div id="header"><li class="header">Cadernos e Produtos</li></div>';
    var pageAnchor=getCurrentEdition();
    page=p;
    if(!page || page == undefined){
        page=0;
    }
    var url=getPagesLink('produtos')+'?idForm='+pageAnchor+'&linkedicao='+linkedicao+'&pagina='+page;
    $.post(url,function(data){
        $('#produtos_barra .free').html(html+data);
    });
}

function loadDock(name){
    if(name == 'indice_barra'){
        if($('#indice_barra .free').html().length == 0){
            $.getCSS(base+'flip/jornal/skins/king/css/indice_flip.css');
            var html='<div id="header"><li class="header">Indice</li></div>';
            var pageAnchor=getCurrentEdition();
            var url=getPagesLink('cadernosiPad')+'?idForm='+pageAnchor;
            $.post(url,function(data){
                $('#indice_barra .free').html(html+data);
                $.getScript(base+'flip/jornal/skins/king/js/cadernofiltro.js');
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
    lockdock=true;
}