var page=1;
function getCurrentPage(){return page; }

$(document).ready(function() {
    loadImages();
    init();
});

function loadPages(){
    $('#loadingText').html("Carregando, aguarde ...");
    $('#imagegallery').hide();
    var edicao=getCurrentEdition();
    var params='edicao='+edicao+'&index='+getCurrentPage();
    $.post(base+'/flip/jornal/jsp/loadPages.jsp',params,function(data){
        $('#loadingText').html("");
        $('#pagesgallery').show();
        $('#pagesgallery').html(data);
        $("#pagesgallery div:eq(0)").show("slow", function () {
            $(this).next("div").show("slow", arguments.callee);
        });
        $('.pagemin').click(function(){
            $('#loadingText').html("Carregando, aguarde ...");
            var idNext=this.id;
            page=idNext.substring(3);
            $('#pagesgallery').html("");
            $('#imagegallery').show();
            $('#imagegallery').cycle(parseInt(page)-1);
            loadImages();
        });
    });
}

function loadImages(){
    $('#loadingText').html("Carregando, aguarde ...");
    var edicao=getCurrentEdition();
    var page=getCurrentPage();    
    $.getScript(base+'/flip/jornal/jsp/loadPage.jsp?idForm='+edicao+'&index='+page,function() {        
        $('#loadingText').html("");
    });
}

function loadImageToDiv(src,index){
    $("#imagegallery img").css("width","1024px");
    $("#imagegallery .page").css("width","1024px");
    $("#imagegallery").css("width","1024px");
    src='<img src=\"'+base+"/"+src+"\" usemap=\"#mapa"+index+"\" border=\"1\" onclick=\"zoom();\"/>";
    $("#pag"+index).append(src);
}

function zoom(){   
    $("#imagegallery img").css("width","2361px");
    $("#imagegallery .page").css("width","2361px");
    $("#imagegallery").css("width","2361px");
    $("#imagegallery img").css("height","1878px");
    $("#imagegallery .page").css("height","1878px");
    $("#imagegallery").css("height","1878px");
}

function init(){    
    $('#imagegallery').cycle({
        timeout: 0,
        fx: 'scrollHorz',
        next: '#next,#next1',
        prev: '#prev,#prev1',        
        prevNextClick : function(isNext, zeroBasedSlideIndex, slideElement){
            if(slideElement.innerHTML == ''){
             var idNext=slideElement.id;
             page=idNext.substring(3);
             loadImages();
            }
        }
    });
    $("#pages, #pages1").click(function(){
        loadPages();
    });
}

function addAreaLink(x,y,w,h,index,link){
var overlays="<div class=\"overlay\" style='left:"+x+"px;top:"+y+"px;width:"+w+"px;height:"+h+"px' onclick=\"window.location.href='"+link+"';\">&nbsp;</div>";
$("#pag"+index).append(overlays);
}

function addVideo(x,y,w,h,src,index){
src='/'+src;
var div="<div style=\"position:absolute; left: "+x+"px; top: "+y+"px;\">";
div=div+"<video class=\"video-js\" width=\""+w+"\" height=\""+h+"\" controls preload autoplay>";
div=div+"<source src=\""+base+src+"\" type='video/mp4'; codecs=\"avc1.42E01E, mp4a.40.2\" />";
div=div+"</video></div>";
$("#pag"+index).append(div);
}