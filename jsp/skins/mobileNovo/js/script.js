$.ajaxSetup({
    async: false
});
var pageWidth = 0;
var pageHeight = 0;
var currentPage = 0;
var myScroll;
function isLandscape() {
    return $(window).width() > $(window).height();
}
function checkSwiperSize() {
    setTimeout(function () {
        var width = $(window).width();
        var height = $(window).height();
        var newx = (doc_x * height) / doc_y;
        console.log(newx + "-" + height);
        $("#scroller").css("width", (width * pageslist.length));
        $('#thelist li').css("width", width).css("height", height);        
        $('#thelist li>img').css("width", newx).css("height", height);
        pageWidth = width;
        pageHeight = height;
        setTimeout(function () {
            myScroll.refresh();
        }, 0);
    }, 100);
}

$(document).ready(function () {

    document.addEventListener('touchmove', function (e) {
        e.preventDefault();
    }, false);

    myScroll = new IScroll('#wrapper', {
        zoom: true,
        scrollX: true, scrollY: false,
        mouseWheel: true,
        wheelAction: 'zoom',
        snap: true,
        bounce: false
    });
    myScroll.on('scrollEnd', function () {
        var dir = this.directionX;
        console.log('DIR=' + dir);
        if (dir == -1) {
            currentPage--;
        } else {
            currentPage++;
        }
        if (currentPage < 0)
            currentPage = 0;
        if (currentPage > pageslist.length)
            currentPage = pageslist.length;

        mySwiperLoadPage();
    });

    $(window).bind('resize', function (e, onready) {
        checkSwiperSize();
    });
    $(window).bind('orientationchange', function (e, onready) {
        checkSwiperSize();
    });
    function mySwiperLoadPage() {
        var page = currentPage;
        console.log('page = ' + page);
        var pageDiv = $("#pag" + page);
        loadPage(page + 1, pageDiv);
    }
    mySwiperLoadPage();
    $('#wrapper').on('tap', regionClick);
    console.dir(myScroll.options);


});

function loadPage(page, pageElement) {
    
    console.log("Carregando " + page);
    
        var html = $(pageElement).html();
    if (html==null||(html!=null&&html=='')||(html!=null&&html.indexOf("empty")!=-1)) {
        $(pageElement).html("<img src='"+base+"flip/jornal/skins/mobile/load.gif' align='center' id='carregador' style='width:90px;height:90px;max-width:90px;max-height:90px;' width='90px'  height='90px'/>");
    }
    
    var url = pageslist[page - 1][1];
    console.log('url=' + url);
    if (url == 'HTML5') {
        var img = $('<div class="htmlcontent"/>');
        var id = pageslist[page - 1][0];
        $(img).html($("#html5-" + id).html());
        $(img).appendTo(pageElement);
        $(img).css("width", "100%").css("height", "100%");
        pageElement.find('.loader').remove();
        img.css("z-index", "999999999999999999999");
        calculaAltura();
    } else {
        if (url.indexOf(".html") != -1 || url.indexOf(".zip") != -1) {
            var img = $('<div class="htmlcontent"/>');
            if (pageslist[page - 1][2].indexOf(".zip")) {
                url = 'html5.jsp?path=' + url;
            }
            if (url.indexOf("http") == -1) {
                url = base + url;
            }
            url = url.replace('&amp', '&');
            var height = $(window).height() - 80;
            var newx = (doc_x * height) / doc_y;
            $('<iframe>', {
                src: url,
                id: 'frame' + page,
                frameborder: 0,
                scrolling: 'yes',
                width: "100%",
                height: "100%"
            }).addClass("framepageimg").appendTo(img);
            $(img).appendTo(pageElement);
            $(img).css("width", "100%").css("height", "100%");
            pageElement.find('.loader').remove();
            img.css("z-index", "999999999999999999999");
            calculaAltura();
        } else {
            var img = $('<img />');
            img.mousedown(function (e) {
                disabledEventPropagation(e);
            });
            img.on('load', function () {
                $(this).css({
                    width: '100%',
                    height: '100%'
                });
                $(this).appendTo(pageElement);
                pageElement.find('.loadimg').remove();
            });
            if (url.indexOf("http") == -1) {
                url = base + '/' + url;
            }
            url = url.replace('&amp;', '&');
            img.attr('src', url);
            img.attr('class', 'pageimg');
            console.log('img=' + url);
            loadRegions(page, pageElement);
        }
    }
    checkSwiperSize();
}
function loadRegions(page, element) {

    var was = false;
    for (var i = 0; i < pfmedias.length; i++) {
        if (pfmedias[i][1] == page) {
            was = true;
            x = parseInt(pfmedias[i][2]);
            y = parseInt(pfmedias[i][3]);
            w = parseInt(pfmedias[i][4]);
            h = parseInt(pfmedias[i][5]);
            px = parseInt(pfmedias[i][7]);
            py = parseInt(pfmedias[i][8]);
            imageWidth = pageWidth,
                    imageHeight = pageHeight;

            var newx = parseFloat(imageWidth) / (100 / px);
            var newy = parseFloat(imageHeight) / (100 / py);
            var neww = (w * parseFloat(imageWidth)) / pfmedias[i][10];
            var newh = (h * parseFloat(imageHeight)) / pfmedias[i][11];

            var texticon = "";
            if (pfmedias[i][12]) {
                texticon = pfmedias[i][12];
                pfmedias[i][12] = pfmedias[i][12].split(" ").join("%_%");
            }
            var skin = "default";
            if (pfmedias[i][15]) {
                skin = pfmedias[i][15];
            }

            if (newh <= 0) {
                newh = 15;
            }
            //0=class,1=page,2=x,3=y,4=w,5=h,6=cd,7=px,8=py,9=id,10=pw,11=ph,12=text,13=type,14=icon,15=skin            

            var region = {
                "x": newx,
                "y": newy,
                "width": neww,
                "height": newh,
                "class": pfmedias[i][0],
                "data": {
                    "index": pfmedias[i][1],
                    "url": pfmedias[i][6],
                    "text": pfmedias[i][12],
                    "texticon": texticon,
                    "tipo": pfmedias[i][13],
                    "icon": pfmedias[i][14],
                    "width": neww,
                    "height": newh,
                    "id": pfmedias[i][9],
                    "skin": skin
                }
            };
            addRegion(region, element, imageWidth, imageHeight);
        } else {
            if (was) {
                break;
            }
        }
    }
}


function addRegion(region, pageElement, pageWidth, pageHeight) {
    var tooltip = region.data.url.indexOf("anch") == -1 ? region.data.texticon : "Clique aqui";
    var reg = $('<div />', {
        'class': 'region  ' + region['class'],
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
        var regionType = $.trim(region.attr('class').replace('region', ''));
        var action = processRegion(region, regionType);
        if (event.preventDefault) { /* Chrome, Safari, Firefox */
            event.preventDefault();
        }
        return true;
    }
}
function processRegion(region, regionType) {
    data = decodeParams(region.attr('region-data'));

    if (data.text)
        data.text = data.text.split("%_%").join(" ");

    switch (regionType) {
        case 'link' :
            if (data.url.indexOf("anch") != -1) {
                gotoAnchor(data.url);
            } else {
                if (data.tipo == 'V') {
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
                if (data.tipo == 'V') {
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
        case 'zoom' :
            var regionOffset = region.offset(),
                    viewportOffset = $('.magazine-viewport').offset(),
                    pos = {
                        x: regionOffset.left - viewportOffset.left,
                        y: regionOffset.top - viewportOffset.top
                    };
            $('.magazine-viewport').zoom('zoomIn', pos);
            break;
        case 'to-page' :
            $('.magazine').turn('page', data.page);
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
        case 'search':
            var regionOffset = region.offset(),
                    viewportOffset = $('.magazine-viewport').offset(),
                    pos = {
                        x: regionOffset.left - viewportOffset.left,
                        y: regionOffset.top - viewportOffset.top
                    };
            $('.magazine-viewport').zoom('zoomIn', pos);
            break;
        case 'audiopicture':
            var url = window.location.origin + "/" + data.url;
            window.open(window.location.origin + "/flip/jornal/skins/html5full/jsp/audioLink.jsp?audiourl=" + url, "_blank", "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300, left=500, width=350,height=40");
            break;
    }
}

function openGalleryHtml5(cd, text, skin) {

    if (skin == 'default') {
        var url = base + '/flip/jornal/plugin/gallery.jsp?cd=' + cd;
        var html5lightbox_options = {
            watermark: "",
            watermarklink: ""
        };
        html5Lightbox.showLightbox(7, url, text, 850, 480);
    } else {
        $("#darkbox").remove();
        $('.gallery-dark-box').remove();
        var html = $('<div/>', {
            'position': 'relative',
            'class': 'gallery-dark-box',
            'id': 'gallery' + cd
        });
        var first = null;
        for (var i = 0; i < pfmediaspics.length; i++) {
            if (pfmediaspics[i][1] == cd) {
                var img = $('<img/>', {
                    'src': base + pfmediaspics[i][2],
                    'data-darkbox': base + pfmediaspics[i][2],
                    'data-darkbox-description': pfmediaspics[i][3],
                    'alt': pfmediaspics[i][3]
                });
                img.appendTo(html);
                if (first == null) {
                    first = img;
                }
            }
        }
        $("body").append(html);
        loadDarkBox();
        $(first).click();
    }
    if (dataLayer != null) {
        dataLayer.push({'event': 'eventTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu galeria', 'eventLabel': dataAnalytics});
    }
}

function decodeParams(data) {
    var parts = data.split('&'), d, obj = {};
    for (var i = 0; i < parts.length; i++) {
        d = parts[i].split('=');
        obj[decodeURIComponent(d[0])] = decodeURIComponent(d[1]);
    }
    return obj;
}
function disabledEventPropagation(event)
{
    if (event.stopPropagation) {
        event.stopPropagation();
    } else if (window.event) {
        window.event.cancelBubble = true;
    }
}
