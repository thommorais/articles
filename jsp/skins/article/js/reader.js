var zoomScale = 0;
var zoomStyle = 'jpg'; //pdf,jpg
var loadingIcon = '<i class="fa fa-spinner" aria-hidden="true"></i>';
var zoomStageCreated = false, clicked = false, clickY, clickX;
var offsetX = 0;
var offsetY = 0;
var menuHeight = 50;
var singlePageDefault=isDeviceMobile();
var singlePageOn = false;

if (zoomStyle == 'pdf' && typeof (PDFJS) !== "undefined") {
    PDFJS.disableWorker = true;
    PDFJS.isPaused = true;
}


$(document).ready(function () {

    $('.arrow-navigate-left').click(function () {
        $('.multimidia_prev').click();
    });
    $('.arrow-navigate-right').click(function () {
        $('.multimidia_next').click();
    });
    $('.pageimg').on('doubleTap', function () {
        var pageIndex = $(this).attr('page-index');
        showZoom(pageArray[pageIndex]);
    });
    $('.pageimg').dblclick(function () {
        var pageIndex = $(this).attr('page-index');        
        showZoom(pageArray[parseInt(pageIndex)]);
    });
    renderPages();
    loadMagazineApp();    
});

function animateAndRenderPages(direction) {
    if (isZoomEnabled()) {
        refreshPageZoom();
    } else {
        var w = $('#readercontainer').css("width").replace("px", "");
        w = direction == 1 ? 0 - w : parseInt($(window).width()) + parseInt(w);
        $('#readercontainer').animate({'left': w}, 500, function () {
            renderPages();
        });
    }
}

function refreshPageZoom() {
    if (zoomScale == 0) {
        zoommode = false;
        $(window).scrollTop(0);
        $("body").removeClass("bodyzoom");
        $("#header").css("position","relative");
        renderPages();
        $('#readerzoom').hide();
        $('#readercontainer').show();
        if (zoomStyle == 'pdf') {
            PDFJS.isPaused = true;
        }
    } else {
        $("#header").css("position","fixed");
        showZoom(getCurrentPageObject());
    }
}

function getCurrentPageObject() {
    return pageArray[pageNumber - 1];
}
function renderPages() {
    $('#readercontainer').css("left", "0px");
    $('#readercontainer').parent().css("top", menuHeight + "px");
    var realPage = pageNumber > 0 ? pageNumber - 1 : 0;
    var pageLeft = realPage;
    var pageRight = pageLeft + 1;

    var pageLeftObject = pageArray[realPage];    
    singlePageOn = singlePageDefault;
    //console.log('render pages ' + realPage + " - " + pageLeftObject.isHtmlPage() + " - " + pageLeftObject.isZipPage()+" - "+singlePageOn);
    if (realPage < 1 || pageLeftObject.isHtmlPage() || pageLeftObject.isZipPage() || singlePageOn == true) {
        $('.page_html5').hide();
        $('.page_right').hide();
        if (pageLeftObject.isHtmlPage()==true || pageLeftObject.isZipPage()==true) {
            $('.page_left').hide();
            showPage(pageLeftObject);
            $('.page_html5').show();
            singlePageOn = true;
        } else {
            $('.page_left').addClass("page_center").show();
            showPage(pageLeftObject);
        }
        disableControls(realPage);
    } else {
        $('.page_html5').hide();
        if (pageRight >= pageArray.length) {
            $('.page_left').addClass("page_center").show();
            $('.page_right').hide();
            showPage(pageLeftObject);
        } else {
            var pageRightObject = pageArray[pageRight];
            if (pageRightObject.isHtmlPage() || pageRightObject.isZipPage()) {
                singlePageOn = true;
                //console.log('pagina da direita é html5, exibindo a da esquerda sozinha');
                $('.page_left').addClass("page_center").show();
                $('.page_right').hide();
                showPage(pageLeftObject);
            } else {
                $('.page_left').removeClass("page_center").show();
                $('.page_right').removeClass("page_center").show();
                showPage(pageLeftObject);
                showPage(pageRightObject);
            }
        }
        disableControls(pageLeft);
    }
}


function showPage(pageObject) {
    if (pageObject.isHtmlPage() || pageObject.isZipPage()) {
        //console.log('carregando pagina html de ' + pageObject.urlimg);
        var img = $('<div class="htmlcontent"/>');
        if (pageObject.isWebViewPage() || pageObject.isZipPage()) {
            var url = pageObject.urlimg;
            if (pageObject.isZipPage()) {
                url = 'html5.jsp?path=' + url;
            }
            if (url.indexOf("http") == -1) {
                url = base + url;
            }
            url = url.replace('&amp;', '&');
            //console.log('pagina html de ' + url);
            var id = 'frame' + pageObject.id;
            var iframe=$('<iframe>', {
                src: url,
                id: id,
                frameborder: 0,
                scrolling: 'yes',
                width: "100%",
                height: "100%"
            });
            $(iframe).addClass("framepageimg").appendTo(img);                        
            
        } else {
            var url = base + 'flip/jornal/contentHtml5.jsp?cd=' + pageObject.id;
            $(img).load(url, function () {                
            });
        }
        $('.page_html5').html(img);

    } else {
        var pageElement = $("." + pageObject.getPageClass() + " .pageimg");
        $(pageElement).html(loadingIcon);
        var container = $('<div/>').addClass("pagecontainer");
        var img = $('<img />');
        var ph = $(window).height() - 55;
        img.load(function () {
            $(container).html(this);
            var scale = parseFloat(ph) / this.height;            
            this.width = this.width * scale;
            this.height = this.height * scale;            
            $(container).css("width", this.width).css("height", this.height);            
            $(pageElement).html(container);
            showMedias(this, pageObject);
            
        });
        var url = pageObject.urlimg.replace('&amp;', '&');
        img.attr('src', base + url);
        $(pageElement).attr('page-index', pageObject.num);
        $(pageElement).attr('page-id', pageObject.id);
    }
}
function showMedias(pageImage, pageObject) {
    if (pageObject.medias.length > 0) {
        for (var i = 0; i < pageObject.medias.length; i++) {            
            var midia = pageObject.medias[i];
            x = parseFloat(midia.x);
            y = parseFloat(midia.y);
            w = parseFloat(midia.w);
            h = parseFloat(midia.h);
            px = parseFloat(midia.px);
            py = parseFloat(midia.py);
            imageWidth = pageImage.width;
            imageHeight = pageImage.height;
           // console.log('calc '+imageWidth+"X"+imageHeight);
            var newx = parseFloat(imageWidth) / (100 / px);
            var newy = parseFloat(imageHeight) / (100 / py);
            var neww = (w * parseFloat(imageWidth)) / midia.pw;
            var newh = (h * parseFloat(imageHeight)) / midia.ph;


            var texticon = "";
            if (midia.label) {
                texticon = midia.label;
                texticon = texticon.split(" ").join("%_%");
            }
            var popupWeb = "";
            if(midia.popupWeb){
                popupWeb=midia.popupWeb;
            }
            var skin = "default";
            if (midia.skin) {
                skin = midia.skin;
            }
            if (newh <= 0) {
                newh = 15;
            }
           
            var region = {
                "x": newx,
                "y": newy,
                "width": neww,
                "height": newh,
                "class": midia.type,
                "data": {
                    "index": pageObject.num,
                    "url": midia.link,
                    "text": midia.label,
                    "texticon": texticon,
                    "tipo": midia.type,
                    "icon": midia.iconeWeb,
                    "width": neww,
                    "height": newh,
                    "id": midia.id,
                    "skin": skin,
                    "popupweb": popupWeb
                }
            };
            var element = $(pageImage).parent();
            addRegion(region, element, imageWidth, imageHeight);
        }
        $('.tooltip').tooltipster();
        $('.region').click(regionClick);
    }
}


function addRegion(region, pageElement, pageWidth, pageHeight) {
    var tooltip = region.data.url.indexOf("anch") == -1 ? region.data.texticon : "Clique aqui";
    if(tooltip == '' || tooltip == undefined){
        tooltip='Clique aqui';
    }
    var reg = $('<div />', {
        'class': 'region  ' + region['class'] + ' tooltip',
        'alt': tooltip,
        'title': tooltip
    });

    var height = Math.round(region.height / pageHeight * 100);
    if (parseInt(height) == 0) {
        height = region.height;
    }

    reg.css({
        top: Math.round(region.y / pageHeight * 100) + '%',
        left: Math.round(region.x / pageWidth * 100) + '%',
        width: Math.round(region.width / pageWidth * 100) + '%',
        height: height + '%'
    }).attr('region-data', $.param(region.data || ''));

    if (region['class'] != 'search') {
        if (region['class'] == 'video' && iconVideo == false) {
            if (region.data.url.indexOf("youtube") != -1) {
                var url = region.data.url;
                if (url.indexOf("https://") != -1) {
                    url = url.replace("https://", "http://");
                }
                var index = region.data.index;
                url = YouTubeUrlNormalize(url) + "?showinfo=0";
                var html = '<div id="player' + index + '">';
                html = html + '<iframe width="' + region.width + '" height="' + region.height + '" style="width:"' + region.width + '";height:"' + region.height + ';" src="' + url + '" frameborder="0" allowfullscreen></iframe>';
                html = html + '</div>';
                $(reg).append(html);
            } else {
                var url = region.data.url;
                var index = region.data.index;
                var video = '<video width="' + region.width + '" height="' + region.height + '"  style="width: 100%; height: 100%;"  id="player' + index + '" preload="none" controls autoplay>';
                video = video + '<source type="video/mp4" src="' + url + '" codecs="avc1.42E01E, mp4a.40.2"/>';
                video = video + '</video>';
                $(reg).append(video);
            }
        } else {
            if (region.data.icon != '') {
                if (region.data.tipo == 'I') {
                    var img = $('<img/>', {
                        'src': base + region.data.url,
                        'class': 'regionImage'
                    });
                    $(img).css('left', "0px");
                    $(img).css('top', "0px");
                    $(img).css('max-height', "100%");
                    img.appendTo(reg);
                } else {
                    var img = $('<img/>', {
                        'class': 'iconimg',
                        'src': base + region.data.icon
                    });
                    $(img).css('left', "0px");
                    $(img).css('top', "0px");
                    $(img).css('max-height', region.height + "px");
                    img.appendTo(reg);
                }
            } else {
                var icon = $('<div/>', {
                    'class': region['class'] + 'img'
                });
                icon.appendTo(reg);
            }
        }
    }
    reg.appendTo(pageElement);
}

function regionClick(event) {    
    var region = $(event.target);
    if (region.hasClass('linkimg') || region.hasClass('videoimg') || region.hasClass('galleryimg') || region.hasClass('iconimg')) {
        region = $(region).parent();
    }
    if (region.hasClass('region')) {
        var regionType = $.trim(region.attr('class').replace('region', '').replace('tooltipstered', '').replace('tooltip', ''));
       
        var action = processRegion(region, regionType);
        if (event.preventDefault) { /* Chrome, Safari, Firefox */
            event.preventDefault();
        }
        return true;
    }
}

function abreArtigo(cd, title){    
    var url=base+'flip/jornal/reader.jsp?cd='+cd+'&mod='+mid;    
     Videobox.leiaMais(url, title);           
}

function processRegion(region, regionType) {
    data = decodeParams(region.attr('region-data'));    
    if (data.text)
        data.text = data.text.split("%_%").join(" ");
    
    switch (data.tipo) {
        case 'link' :            
            
            if (data.url.indexOf("anch") != -1) {
                gotoAnchor(data.url);
            } else {                
                if (data.popupweb == 'V') {
                    var url = data.url;
                    Videobox.leiaMais(url, data.text);
                } else {
                    window.open(data.url);
                }
            }
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu link', 'eventLabel': dataAnalytics});
            }
            break;
        case 'icon' :
            if (data.url.indexOf("anch") != -1) {
                gotoAnchor(data.url);
            } else {
                if (data.popupweb == 'V') {
                    var url = data.url;
                    Videobox.leiaMais(url, data.text);
                } else {
                    window.open(data.url);
                }
            }
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu link', 'eventLabel': dataAnalytics});
            }
            break;
        case 'to-page' :
            turn('page', data.page);
            break;
        case 'video':
            var url = data.url;
            Videobox.open(url, data.text);
            if (dataLayer != null) {
                dataLayer.push({'event': 'pageViewTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu Video', 'eventLabel': dataAnalytics});
            }
            break;
        case 'gallery':
            openGalleryHtml5(data.url, data.text, data.skin);
            break;
        case 'audiopicture':
            var url = window.location.origin + "/" + data.url;
            window.open(window.location.origin + "/flip/jornal/skins/html5full/jsp/audioLink.jsp?audiourl=" + url, "_blank", "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300, left=500, width=350,height=40");
            break;
    }
}
function showZoom(pageObject) {
    $("body").addClass("bodyzoom");
    if (zoomScale == 0) {
        zoomScale = 1;
    }
    if (zoomStageCreated == false) {
        interact('#reader-flow').draggable({
            inertia: true,
            autoScroll: true,
            onstart: function (event) {
                clickY = event.pageY;
                clickX = event.pageX;                
            },
            onmove: dragMoveListener,
            onend: function (event) {
                $('body').css('cursor', 'default');
            }
        });
        zoomStageCreated = true;

        if (!window.escTip) {
            escTip = true;
            $('<div/>', {'class': 'esc'}).
                    html('<div>ESC para fechar</div>').
                    appendTo($('body')).
                    delay(2000).animate({opacity: 0}, 500, function () {
                $(this).remove();
            });
        }
        $("#header").css("position","fixed");

    }
    $('#readerloading').show();
    if (zoomStyle == 'pdf') {
        PDFJS.isPaused = false;
        PDFJS.workerSrc = base + "flip/jornal/skins/article/js/pdfjs/js/pdf.worker.js";
    }
    zoommode = true;
    renderPage(pageObject);
    disableControls(pageObject.num);
}
function closeZoom() {
    zoomScale = 0;
    refreshPageZoom();
}
function dragMoveListener(event) {    
    $('body').css('cursor', 'crosshair');    
    var top=$(window).scrollTop() + (clickY - event.pageY);
    var left=$(window).scrollLeft() + (clickX - event.pageX);    
    $(window).scrollTop(top);
    $(window).scrollLeft(left);
}

function renderPage(pageObject) {
    if (zoomStyle == 'pdf') {
        var url = base + pageObject.url;
        if (pageObject.pdf == null) {
            var b = PDFJS.getDocument(url);
            b.then(function (e) {
                if (e.pdfInfo.numPages > 0) {
                    e.getPage(1).then(function (page) {
                        pageObject.pdf = page;
                        setTimeout(function () {
                            renderPagePDFObject(pageObject);
                        }, 50);
                    });
                }
            });
        } else {            
            setTimeout(function () {
                renderPagePDFObject(pageObject);
            }, 50);
        }
    } else {
        if (zoomStyle == 'svg') {
            var url = base + 'svg.jsp?file=' + pageObject.url;
            var pageDiv = $("#reader-flow");
            $(pageDiv).load(url, function (response, status, xhr) {
                if (status === "error") {
                    try {
                        var msg = "Ocorreu um problema ao carregar este documento. Tente mais tarde ";
                        $(this).html(msg + xhr.status + " " + xhr.statusText);
                    } catch (e) {
                    }
                    $('#readerloading').hide();
                } else {
                    var neww = $(window).width() - 50;
                    $(pageDiv).parent().css("width", neww).css("height", "auto");
                    $(pageDiv).css("width", neww).css("height", "auto");
                    $(pageDiv).css("visibility", "visible");
                    $('#readercontainer').hide();
                    $('#readerzoom').show();
                    $('#readerloading').hide();
                }
            });
        } else {
            if (zoomStyle === 'jpg') {
                var url = base + pageObject.urlimgbig;
                var pageDiv = $("#reader-flow");
                $(pageDiv).html(loadingIcon);
                var img = $('<img />');
                img.load(function () {
                    $(pageDiv).html($(this));
                    var neww = $(window).width() - 50;
                    var newh = (this.height * neww) / this.width;
                    (pageDiv).parent().css("width", neww).css("height", newh);
                    $(pageDiv).css("width", neww).css("height", newh);
                    $(this).dblclick(function (e) {
                        increaseZoom(e);
                    });
                    showMedias(this, pageObject);
                    $('#readercontainer').hide();
                    $('#readerzoom').show();
                    $('#readerloading').hide();

                });
                img.attr('src', url);
            }
        }
    }
}


function increaseZoom(event) {
    //console.log('increase '+event.scale);
    var nextScale = zoomScale + 0.3;
    if (zoomStyle == 'jpg') {
        changeZoom(nextScale, event);
    } else {
        refreshPageZoom();
    }
}
function decreaseZoom(event) {
   // console.log('decrease '+event.scale);
    var nextScale = zoomScale - 0.3;
    if (nextScale < 1) {
        nextScale = 1;
    }
    changeZoom(nextScale, event);
}
function changeZoom(nextScale, event) {
    if (zoomStyle == 'jpg') {
        
        //console.log(event);
        var $container = $('#reader-flow');
        var areaWidth = $container.width();
        var areaHeight = $container.height();
        var clientX = event.pageX - $container.offset().left;
        var clientY = event.pageY - $container.offset().top;

        var percentXInCurrentBox = clientX / areaWidth;
        var percentYInCurrentBox = clientY / areaHeight;

        var currentBoxWidth = areaWidth / zoomScale;
        var currentBoxHeight = areaHeight / zoomScale;

        var nextBoxWidth = areaWidth / nextScale;
        var nextBoxHeight = areaHeight / nextScale;

        var deltaX = (nextBoxWidth - currentBoxWidth) * (percentXInCurrentBox - 0.5);
        var deltaY = (nextBoxHeight - currentBoxHeight) * (percentYInCurrentBox - 0.5);

        var nextOffsetX = offsetX - deltaX;
        var nextOffsetY = offsetY - deltaY;

        $container.css({
            //transform: 'scale(' + nextScale + ')',
            left: -1 * nextOffsetX * nextScale,
            right: nextOffsetX * nextScale,
            top: -1 * nextOffsetY * nextScale,
            bottom: nextOffsetY * nextScale            
        });
        $("img",$container).css("transform",'scale(' + nextScale + ')');
        offsetX = nextOffsetX;
        offsetY = nextOffsetY;
        zoomScale = nextScale;

    } else {
        zoomScale = nextScale;
        refreshPageZoom();
    }
}


function renderPagePDFObject(pageObject) {
    var zoom = zoomScale;
    var num = pageObject.num;
    var page = pageObject.pdf;
    var pageDiv = $("#reader-flow");
    if (pageObject.pdfWidth == null || pageObject.pdfHeight == null) {
        var unscaledViewport = page.getViewport(1);
        pageObject.pdfWidth = unscaledViewport.width;
        pageObject.pdfHeight = unscaledViewport.height;
    }
    var neww = $(window).width() - 50;
    var newh = (pageObject.pdfHeight * neww) / pageObject.pdfWidth;
    var scale = Math.min((newh / pageObject.pdfHeight), (neww / pageObject.pdfWidth));
    var scaledViewport = page.getViewport(scale * zoom);
    var canvas = getClearCanvas();
    canvas.height = scaledViewport.height;
    canvas.width = scaledViewport.width;
    $(pageDiv).parent().css("width", canvas.width).css("height", canvas.height);
    $(pageDiv).css("width", canvas.width).css("height", canvas.height);
    var context = canvas.getContext('2d');
    context.clearRect(0, 0, canvas.width, canvas.height);
    var renderContext = {
        canvasContext: context,
        viewport: scaledViewport
    };
    page.render(renderContext).promise.then(function () {
        $(canvas).css("visibility", "visible");
        $('#readercontainer').hide();
        $('#readerzoom').show();
        pageObject.pdf = null;
        PDFJS.isPaused = true;
        $('#readerloading').hide();
    }, function (error) {
        $('#readerloading').hide();
    });
}

function getClearCanvas() {
    var canvas = document.getElementById("canvaszoom");
    if (canvas) {
        var context = canvas.getContext('2d');
        context.clear();
        context.setTransform(-1, 0, 0, 1, 200, 200);
        context.clear(true);
        return canvas;
    } else {
        var canvas = $("<canvas/>").attr('id', "canvaszoom");
        $('#reader-flow').html(canvas);
        canvas = document.getElementById("canvaszoom");
        return canvas;
    }
}

