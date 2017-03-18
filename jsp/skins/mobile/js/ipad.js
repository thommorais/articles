var total = 0;
var myScroll = null;
var myScrollZoom = null;
var pagesum = 0;
var showMenu = true;
var ponto = 0;
var sketchobject = null;
var cachePages = [""];
var lastobject = null;

jQuery(document).ready(function () {
    init();
    loadImages();
    addToHomescreen();
});
jQuery.getCSS = function (url, media) {
    jQuery(document.createElement('link')).attr({
        href: url,
        media: media || 'screen',
        type: 'text/css',
        rel: 'stylesheet'
    }).appendTo('head');
};
function getCurrentPage() {
    return page;
}
function tapChangeMenu() {
    if (showMenu === true) {
        jQuery("#tab_left").hide();
        showMenu = false;
    } else {
        jQuery("#tab_left").show();
        showMenu = true;
    }
}

var innerScroll = null;
function loaded() {
    document.addEventListener('touchmove', function (e) {
        e.preventDefault();
    });

    innerScroll = new iScroll('scroll-content', {
        vScrollbar: true,
        hScrollbar: true,
        zoom: true,
        zoomMin: 1,
        zoomMax: 6,
        momentum: true,
        bounce: false,
        onScrollStart: function () {
        },
        onScrollEnd: function () {
            reloadLinksZoom(page);
        }
    });
}

var cnv = null;
var ctx = null;
function configureCanvas() {
    if (cnv == null) {
        cnv = document.createElement("canvas");
        cnv.id = "canvaspagina";
        ctx = cnv.getContext("2d");
    } else {
        ctx.clearRect(0, 0, cnv.width, cnv.height);
        var w = cnv.width;
        cnv.width = 1;
        cnv.width = w;
    }
}
function openZoomMode(item, e) {
    if (isLandscape()) {
        jQuery("#zoomarea").html("<img src='" + base + "flip/jornal/skins/mobile/load.gif' id='loader' align='center' style='margin-top:230px;top:230px;max-width:90px;max-height:90px;' width='90px' height='90px'/>");
    } else {
        jQuery("#zoomarea").html("<img src='" + base + "flip/jornal/skins/mobile/load.gif' id='loader' align='center' style='margin-top:300px;top:300px;max-width:90px;max-height:90px;' width='90px' height='90px'/>");
    }
    configureCanvas();
    jQuery("#toposistema").hide();
    jQuery("#basesistema").hide();
    jQuery("#zoomarea").show();
    jQuery("#menufechar").show();
    jQuery("#ext-comp-1013").hide();
    var pindex = parseInt(item.currPageX);
    pindex++;
    var img = '';
    if (isLandscape()) {
        if (pindex > 1)
            pindex = (pindex * 2) - 2;
        if (pindex > 1 && ponto > 500 && pindex < (total - 1)) {
            pindex++;
        }
        for (var p = 0; p < pfpages.length; p++) {
            if (parseInt(pfpages[p][0]) == parseInt(pindex)) {
                img = pfpages[p][2];
                break;
            }
        }
        if (img == '') {
            img = pfpages[pindex - 1][2];
        }
    } else {
        for (var p = 0; p < pfpages.length; p++) {
            if (parseInt(pfpages[p][0]) == parseInt(pindex)) {
                img = pfpages[p][2];
                break;
            }
        }
        if (img == '') {
            img = pfpages[pindex - 1][2];
        }
    }
    if (img != '') {
        var url = base + 'flip/jornal/jsp/slice.jsp?f=' + img;
        jQuery.post(url, function (data) {
            var pages = data.split(",");
            jQuery("#zoomarea").append("<div id='scroll-content'></div>");
            jQuery("#scroll-content").append(cnv);
            var imageleft = 0;
            var imagetop = 0;
            var imagepos = -1;
            //var imgwidth=506;
            //var imgheight=509;
            var imgwidth = 501;
            var imgheight = 667;

            //var size=getImgSize(base+pages[0]);
            //alert(size);

            for (var i = 0; i < pages.length; i++) {
                var imgurl = pages[i];
                if (imgurl != 'LAST') {
                    var image = new Image();
                    image.src = base + imgurl;
                    imagepos = imagepos + 1;
                    if (imagepos > 0) {
                        if (imagepos <= 2) {
                            imageleft = imageleft + (imgwidth);
                        } else {
                            imagepos = 0;
                            imagetop = imagetop + (imgheight);
                            imageleft = 0;
                        }
                    }
                    jQuery(image).attr('posleft', imageleft);
                    jQuery(image).attr('postop', imagetop);
                    jQuery(image).load(function () {
                        var left = jQuery(this).attr('posleft');
                        var top = jQuery(this).attr('postop');
                        this.width = imgwidth;
                        this.height = imgheight;
                        ctx.drawImage(this, left, top, imgwidth, imgheight);
                    });
                }
            }
            jQuery("#loader").hide();
            cnv.width = imgwidth * 3;
            cnv.height = imgheight * 4;
            loaded();

            _gaq.push(['_trackEvent', document.title, 'Zoom em ipad', 'Pagina ' + page]);
            setTimeout(function () {
                reloadLinksZoom(pindex);
            }, 2000);

        });

        jQuery("#menufechar").click(function (e) {
            if (isLandscape()) {
                jQuery("#zoomarea").html("<img src='" + base + "flip/jornal/skins/mobile/load.gif' id='loader' align='center' style='margin-top:230px;top:230px;max-width:90px;max-height:90px;' width='90px' height='90px'/>");
            } else {
                jQuery("#zoomarea").html("<img src='" + base + "flip/jornal/skins/mobile/load.gif' id='loader' align='center' style='margin-top:300px;top:300px;max-width:90px;max-height:90px;' width='90px' height='90px'/>");
            }
            jQuery("#menufechar").hide();
            jQuery("#zoomarea").hide();
            jQuery("#ext-comp-1013").show();
            jQuery("#toposistema").show();
            jQuery("#basesistema").show();
            myScroll._resetPos(e);
        });
    }

    return false;
}

var lastpage = 0;
function loadImages() {
    if (myScroll != null) {
        if (myScroll.scale > 1) {
            return;
        }
    }
    page = parseInt(myScroll.currPageX);
    page++;
    //var changes=isLandscape()?2:1;
    var pindex = getCurrentPage();
    if (page == pindex && page == lastpage) {
        return;
    }
    lastpage = pindex;
    if (isLandscape()) {
        var novoindex = (parseInt(pindex) * 2) - 1;
        if (novoindex == pfpages.length - 1) {
            novoindex--;
        }
        pindex = novoindex;
    }
    var c = 0;
    while (pindex <= pfpages.length && c <= 3) {
        loadImageToDiv(pfpages[parseInt(pindex) - 1]);
        pindex++;
        c++;
    }
    updatePageChange();
    if (myScroll != null) {
        setTimeout(function () {
            myScroll.refresh();
        }, 10);
    }
}


function loadImageToDiv(item) {
    var src = item[2];
    var normal = item[1];
    var index = item[0];
    var html = jQuery("#pag" + index).html();
    if (html == null || (html != null && html == '') || (html != null && html.indexOf("empty") != -1)) {
        jQuery("#pag" + index).html("<img src='" + base + "flip/jornal/skins/mobile/load.gif' align='center' id='carregador' style='width:90px;height:90px;max-width:90px;max-height:90px;' width='90px'  height='90px'/>");
        var img = new Image();
        jQuery(img).load(function () {
            var loaded = jQuery(this).attr('loaded');
            if (loaded != "true") {
                jQuery(this).hide();
                jQuery("#pag" + index).html("<div id='zoomgallery'><div id='thepage'></div></div>");
                jQuery("#pag" + index + " #zoomgallery #thepage").css("position", "relative");
                jQuery("#pag" + index + " #zoomgallery #thepage").css("margin", "0 auto");
                jQuery("#pag" + index + " #zoomgallery #thepage").css("display", "block");
                jQuery("#pag" + index + " #zoomgallery #thepage").append(this);
                setTimeout(function () {
                    updateOrientation();
                }, 20);
                if (myScroll != null) {
                    setTimeout(function () {
                        myScroll.refresh();
                    }, 50);
                }
                jQuery(this).fadeIn();
                jQuery(this).attr('loaded', 'true');
                jQuery(this).attr('src', base + src);
                jQuery(this).click(function (e) {
                    tapChangeMenu();
                });
            }
        });
        jQuery(img).attr('src', base + normal);

    }
    var image = jQuery("#pag" + index + " #zoomgallery img");
    if (isLandscape()) {
        if (index > 1 && index < (total)) {
            if (index % 2 == 0) {
                jQuery(img).attr('class', 'direita');
            } else {
                jQuery(img).attr('class', 'esquerda');
            }
        }
    } else {
        jQuery(img).attr('align', 'center');
    }
}

function updateOrientation() {
    if (total == 0) {
        total = jQuery("#thelist").children().length;
    }
    var landscape = isLandscape();
    var width = jQuery(window).width();
    var height = jQuery(window).height();
    var realwidth = landscape == true ? (width / 2) : width;
    var sum = landscape == true ? 2 : 0;
    var size = ((parseInt(total) + sum) * (realwidth)) + "px";
    jQuery("#scroller").css("width", (size));
    var max = 0;
    jQuery('li[id^="pag"]').each(function (index) {
        if ((index == 0 || index == (total - 1)) && landscape == true) {
            var altura = height - 30;
            var imgwidth = jQuery('img', this).attr('width');
            if (imgwidth == undefined) {
                imgwidth = 400;
            }
            var dif = (width - imgwidth) / 2;
            jQuery(this).css("width", (imgwidth + "px"));
            jQuery(this).css("margin-right", (dif + "px"));
            jQuery(this).css("margin-left", (dif + "px"));
            jQuery(this).css("min-width", (imgwidth + "px"));
            //  jQuery('img',this).css("width",imgwidth+"px");            
            //  jQuery('img',this).css("max-height", (altura+"px")); 
            jQuery('img', this).attr('align', 'center');
            jQuery('img', this).attr('class', '');
        } else {
            var altura = height - 30;
            if ((index == 0 || index == (total - 1)) && landscape == false) {
                jQuery(this).css("max-width", (width + "px"));
                jQuery(this).css("margin-right", ("0px"));
                jQuery(this).css("margin-left", ("0px"));
                jQuery(this).css("max-height", (altura + "px"));
                jQuery(this).css("height", "auto");
                //   jQuery('img',this).css("max-height", (altura+"px"));                
                jQuery(this).css("width", realwidth + "px");
                jQuery(this).css("min-width", realwidth + "px");
                //    jQuery('img',this).css("width","auto");
            } else {
                // if(landscape==false){
                ////     jQuery('img',this).css("max-height", (altura+"px"));                
                // }
                jQuery(this).css("width", realwidth + "px");
                jQuery(this).css("min-width", realwidth + "px");
                //if(landscape==false){
                //     jQuery('img',this).css("width","auto");
                // }
            }



            if (landscape) {
                if (index % 2 != 0) {
                    jQuery('img', this).attr('align', 'right');
                    jQuery('img', this).attr('class', 'direita');
                } else {
                    jQuery('img', this).attr("align", "left");
                    jQuery('img', this).attr('class', 'esquerda');
                }
            } else {
                jQuery('img', this).attr('align', 'center');
                jQuery('img', this).attr('class', '');
            }
        }
        jQuery('#thepage', this).css("height", altura + "px");

    });
    reloadLinks(null);
    if (myScroll != null) {
        setTimeout(function () {
            myScroll.refresh();
        }, 0);
    }
}
function resetaPagina() {
    var p = page;
    if (isLandscape()) {
        if (page % 2 != 0)
            page--;
        p = (page / 2);
    } else {
        p = (page * 2) - 3;
    }
    setTimeout(function () {
        myScroll.refresh();
    }, 100);
    setTimeout(function () {
        myScroll.scrollToPage(p, 0);
        updatePageChange();
    }, 200);
}
function configure() {
    updateOrientation();
    myScroll = new iScroll('imagegallery', {
        snap: true,
        hScroll: true,
        vScroll: true,
        zoom: false,
        momentum: false,
        hScrollbar: true,
        vScrollbar: true,
        bounce: false,
        useTransition: true,
        onScrollStart: function () {
            lastobject = this;
        },
        onScrollEnd: function () {
            lastobject = this;
            loadImages();
        },
        onZoomStart: function (that, e) {
            lastobject = this;
        },
        onTouchStart: function (that, e) {
            lastobject = this;
        }
    });

    jQuery("#imagegallery").dblclick(function (that, e) {
        openZoomMode(lastobject, e);
    });
    jQuery(window).bind('orientationchange', function (e, onready) {
        jQuery("#rotacionando").show();
        setTimeout(function () {
            updateOrientation();
            resetaPagina();
            setTimeout(function () {
                jQuery("#rotacionando").fadeOut(1000);
            }, 200);
        }, 100);
    });


    document.addEventListener('touchmove', function (e) {
        e.preventDefault();
    }, false);
}


jQuery.event.special.dblclick = {
    setup: function (data, namespaces) {
        var elem = this,
                $elem = jQuery(elem);
        $elem.bind('touchend.dblclick', jQuery.event.special.dblclick.handler);
    },
    teardown: function (namespaces) {
        var elem = this,
                $elem = jQuery(elem);
        $elem.unbind('touchend.dblclick');
    },
    handler: function (event) {
        var elem = event.target,
                $elem = jQuery(elem),
                lastTouch = $elem.data('lastTouch') || 0,
                now = new Date().getTime();

        var delta = now - lastTouch;
        if (delta > 20 && delta < 500) {
            $elem.data('lastTouch', 0);
            $elem.trigger('dblclick');
        } else
            $elem.data('lastTouch', now);
    }
};


function init() {
    configure();
    jQuery(".multimidia_prev").click(function () {
        if (page > 0) {
            pagesum = 1;
            myScroll.scrollToPage(page - 2, 0);
        } else {
            page = 0;
        }
        return false;
    });
    jQuery(".multimidia_next").click(function () {
        if (page < total) {
            pagesum = 1;
            myScroll.scrollToPage(page, 0);
        } else {
            page = total;
        }
        return false;

    });
    jQuery(".multimidia_ff").click(function () {
        pagesum = 1;
        myScroll.scrollToPage(total - 1, 0);
        return false
    });
    jQuery(".multimidia_fr").click(function () {
        pagesum = 1;
        myScroll.scrollToPage(0, 0);
        return false
    });
    jQuery('#multimidia_textfield').focus(function () {
        toogleTextField();
    });

    jQuery('#multimidia_textfield').blur(function () {
        updatePageChange();
        editingText = '';
    });

    jQuery('#multimidia_textfield').keyup(function (e) {
        if (e.keyCode == 13) {
            toogleTextField();
        }
    });
    jQuery("#exportarpdf").click(function () {
        var pageEdition = getCurrentEdition();
        var url = getPagesLink('mavenflip') + '?idEdicao=' + pageEdition;
        window.location.href = url;
        return false
    });
    /*
     jQuery("#edittool").click(function(){
     enableSketch();
     jQuery("#edittool").hide();
     jQuery("#savetool").show();
     });
     jQuery("#savetool").click(function(){       
     jQuery("#edittool").show();
     jQuery("#savetool").hide();          
     sketchobject.data('sketch').share('png');       
     jQuery("#colors_sketch").remove();
     cnvdraw=null;
     });    
     jQuery("#savetool").hide();        */
    jQuery("#dock li ul").height(jQuery(window).height());
    jQuery("#dock li").click(function (e) {
        if (e.pageX == undefined || e.pageX > 40) {
            return;
        }
        if (lockdock == true) {
            lockdock = false;
            jQuery("#dock").find("ul.free").animate({
                left: "-700px"
            }, 200);
            if (this.id != lockbar) {
                loadDock(this.id);
                jQuery(this).find("ul").animate({
                    left: "40px"
                }, 200);
            }
        } else {
            loadDock(this.id);
            jQuery(this).find("ul").animate({
                left: "40px"
            }, 200);
        }
    });
    var width = jQuery(window).width();
    if (width < 600) {
        jQuery("#tab_left").hide();
    }
    if (page > 0 || ipg != null) {
        if (ipg != null) {
            for (var i = 0; i < pfpages.length; i++) {
                if (pfpages[i][3] == ipg) {
                    page = pfpages[i][0];
                    break;
                }
            }
        }
        if (page > 1) {
            setTimeout(function () {
                if (isLandscape()) {
                    abrePaginaPorAnchor((parseInt(page) * 2) + 1);
                } else {
                    abrePaginaPorAnchor(parseInt(page) + 1);
                }
            }, 500);
        }
    }
}
var editingText = '';
function toogleTextField() {
    if (editingText == '') {
        editingText = jQuery('#multimidia_textfield').val();
        jQuery('#multimidia_textfield').val("");
    } else {
        var number = jQuery('#multimidia_textfield').val();
        jQuery('#multimidia_textfield').unbind("keydown");
        var i = (parseInt(number) - 1);
        pagesum = 1;
        if (isLandscape()) {
            if (i % 2 != 0)
                i++;
            i = (i / 2);
        }
        myScroll.scrollToPage(i, 0);
        editingText = '';
        jQuery('#multimidia_textfield').trigger("blur");
    }
}

function reloadLinks(index) {
    if (pflinks.length > 0) {
        for (var p = 0; p < pflinks.length; p++) {
            if (index == null || (pflinks[p] != null && pflinks[p][0] == index)) {
                addAreaLink(pflinks[p][0], pflinks[p][1], pflinks[p][2], pflinks[p][3], pflinks[p][4], index, pflinks[p][5], pflinks[p][6], pflinks[p][7], pflinks[p][8], pflinks[p][9], pflinks[p][10], pflinks[p][11], pflinks[p][12], pflinks[p][13], pflinks[p][14]);
            }
        }
    }
    if (pfvideos.length > 0) {
        for (var v = 0; v < pfvideos.length; v++) {
            if (index == null || (pfvideos[v] != null && pfvideos[v][0] == index)) {
                addVideo(pfvideos[v][0], pfvideos[v][1], pfvideos[v][2], pfvideos[v][3], pfvideos[v][4], index, pfvideos[v][5], pfvideos[v][6], pfvideos[v][7], pfvideos[v][8], pfvideos[v][9], pfvideos[v][10], pfvideos[v][11]);
            }
        }
    }
}

var linkselements = [];
function reloadLinksZoom(index) {
    if (pflinks.length > 0 && index != null) {
        linkselements = [];
        var canvasOffset = jQuery(cnv).offset();
        var offsetX = canvasOffset.left;
        var offsetY = canvasOffset.top;
        cnv.addEventListener('click', function (e) {
            var x = parseInt(e.pageX - offsetX);
            var y = parseInt(e.pageY - offsetY);
            y = y - (innerScroll.y);
            x = x - (innerScroll.x);
            linkselements.forEach(function (element) {
                if (y > element.top && y < element.top + element.height
                        && x > element.left && x < element.left + element.width) {
                    if (element.link.indexOf("abreModal") == -1) {
                        var action = "window.open('" + element.link + "');";
                        if (element.link.indexOf("anch") != -1) {
                            var comp = jQuery("." + element.link).attr('id');
                            if (comp != null && comp != undefined) {
                                var p = comp.replace("pag", "");
                                action = "abrePaginaPorAnchor(" + p + ");";
                            }
                        }
                        eval(action);
                    } else {
                        jQuery("#menufechar").click();
                        eval(element.link);
                    }
                }
            });
        }, false);

        for (var p = 0; p < pflinks.length; p++) {
            if (index == null || (pflinks[p] != null && pflinks[p][0] == index)) {
                addAreaLinkZoom(pflinks[p][0], pflinks[p][1], pflinks[p][2], pflinks[p][3], pflinks[p][4], index, pflinks[p][5], pflinks[p][6], pflinks[p][7], pflinks[p][8], pflinks[p][9], pflinks[p][10], pflinks[p][11], pflinks[p][12], pflinks[p][13]);
            }
        }
    }
}

function addAreaLinkZoom(pagId, x, y, w, h, index, link, px, py, linkId, bw, bh, tipo, tamanho, popup, icone) {
    if (ctx) {
        x = parseInt(x);
        y = parseInt(y);
        w = parseInt(w);
        h = parseInt(h);
        px = parseInt(px);
        py = parseInt(py);
        var imageWidth = cnv.width;
        var imageHeight = cnv.height;
        var fator = 10;
        var newx = imageWidth / (100 / px);
        var newy = imageHeight / (100 / py);
        var neww = (w * imageWidth) / bw;
        var newh = (h * imageHeight) / bh;

        newx = newx + fator;
        newy = newy + fator;
        neww = neww + fator;
        newh = newh + fator;

        ctx.beginPath();
        ctx.fillStyle = linkcolor;
        ctx.globalAlpha = 0.5;
        ctx.fillRect(newx, newy, neww, newh);

        if (tipo == 'V' || popup == 'true') {
            if (tamanho != '') {
                tamanho = tamanho.replace("x", " ");
            } else {
                tamanho = "740 560";
            }
            var sizes = tamanho.split(" ");
            var action = "abreModal('" + link + "'," + sizes[0] + "," + sizes[1] + ");";
            link = action;
        }

        linkselements.push({
            width: neww,
            height: newh,
            top: newy,
            left: newx,
            link: link
        });

    }
}

function addAreaLink(pagId, x, y, w, h, index, link, px, py, linkId, bw, bh, tipo, tamanho, popup, icone) {
    var img = jQuery("#pag" + pagId + " #thepage img");
    if (jQuery(img).length) {
        x = parseInt(x);
        y = parseInt(y);
        w = parseInt(w);
        h = parseInt(h);
        px = parseInt(px);
        py = parseInt(py);
        var imageWidth = jQuery(img).attr("width");
        var imageHeight = jQuery(img).attr("height");

        if (index === 0 && isLandscape()) {
            imageWidth = jQuery(window).width();
            imageHeight = jQuery(window).height();
        }

        if (imageWidth == undefined) {
            imageWidth = jQuery(img).css("width").replace("px", "");
        }
        if (imageHeight == undefined) {
            imageHeight = jQuery(img).css("height").replace("px", "");
        }

        var newx = imageWidth / (100 / px);
        var newy = imageHeight / (100 / py);
        var neww = (w * imageWidth) / bw;
        var newh = (h * imageHeight) / bh;

        var overlay = ("#overlay" + linkId);
        if (jQuery(overlay).length) {
            jQuery(overlay).css('left', newx);
            jQuery(overlay).css('top', newy);
            jQuery(overlay).css('width', neww);
            jQuery(overlay).css('height', newh);
        } else {
            if (tipo == 'V' || popup == 'true') {
                if (tamanho != '') {
                    tamanho = tamanho.replace("x", " ");
                } else {
                    tamanho = "740 560";
                }
                var sizes = tamanho.split(" ");
                var action = "abreModal('" + link + "'," + sizes[0] + "," + sizes[1] + ")";

                if (tipo == 'G') {
                    action = "openGalleryHtml5('" + link + "', '', 'fullscreen');";
                }

                if (icone != null && icone != '') {
                    overlay = "<div class=\"overlaytransp\" id=\"overlay" + linkId + "\" style='position:absolute;left:" + newx + "px;top:" + newy + "px;width:" + neww + "px;height:" + newh + "px' onclick=\"" + action + "\">";
                    overlay = overlay + "<div style='width:100%;height:100%;margin:0px;background-image:url(" + base + icone + ");position:relative;background-size:auto 100%;background-repeat:no-repeat'/>";
                    overlay = overlay + "</div>";
                } else {
                    overlay = "<div class=\"overlay\" id=\"overlay" + linkId + "\" style='position:absolute;left:" + newx + "px;top:" + newy + "px;width:" + neww + "px;height:" + newh + "px' onclick=\"" + action + "\">";
                    overlay = overlay + '&nbsp;';
                    overlay = overlay + "</div>";
                }
                jQuery("#pag" + pagId + " #thepage").append(overlay);
            } else {
                var action = "window.location.href='" + link + "';";
                if (link.indexOf("anch") != -1) {
                    var comp = jQuery("." + link).attr('id');
                    if (comp != null && comp != undefined) {
                        var p = comp.replace("pag", "");
                        action = "abrePaginaPorAnchor(" + p + ");";
                    }
                }
                if (icone != null && icone != '') {
                    overlay = "<div class=\"overlaytransp\" id=\"overlay" + linkId + "\" style='position:absolute;left:" + newx + "px;top:" + newy + "px;width:" + neww + "px;height:" + newh + "px' onclick=\"" + action + "\">";
                    overlay = overlay + "<div style='width:100%;height:100%;margin:0px;background-image:url(" + base + icone + ");position:relative;background-size:auto 100%;background-repeat:no-repeat'/>";
                    overlay = overlay + "</div>";
                } else {
                    overlay = "<div class=\"overlay\" id=\"overlay" + linkId + "\" style='position:absolute;left:" + newx + "px;top:" + newy + "px;width:" + neww + "px;height:" + newh + "px' onclick=\"" + action + "\">";
                    overlay = overlay + '&nbsp;';
                    overlay = overlay + "</div>";
                }
                jQuery("#pag" + pagId + " #thepage").append(overlay);
            }
        }
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
        jQuery("#darkbox").remove();
        jQuery('.gallery-dark-box').remove();
        var html = jQuery('<div/>', {
            'position': 'relative',
            'class': 'gallery-dark-box',
            'id': 'gallery' + cd
        });
        var first = null;
        for (var i = 0; i < pfmediaspics.length; i++) {
            if (pfmediaspics[i][1] == cd) {
                var img = jQuery('<img/>', {
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
        jQuery("body").append(html);
        loadDarkBox();
        jQuery(first).click();
    }
}

function abreModal(src, w, h) {

    Shadowbox.open({
        content: src,
        type: "iframe",
        player: "iframe",
        title: "",
        height: h,
        width: w
    });
}

function gotoAnchor(p) {
    abrePaginaPorAnchor(p);
}

function abrePaginaPorAnchor(p) {
    if (isLandscape()) {
        if (p % 2 != 0)
            p++;
        p = (p / 2);
        p--;
        myScroll.scrollToPage(p, 0);
        ;
    } else {
        myScroll.scrollToPage((p - 1), 0);
    }
}

function addVideo(pagId, x, y, w, h, index, src, px, py, linkId, bw, bh, icone) {
    var img = jQuery("#pag" + pagId + " #thepage img");
    if (jQuery(img).length) {
        x = parseInt(x);
        y = parseInt(y);
        w = parseInt(w);
        h = parseInt(h);
        px = parseInt(px);
        py = parseInt(py);
        var imageWidth = jQuery(img).attr("width");
        var imageHeight = jQuery(img).attr("height");

        if (index === 0 && isLandscape()) {
            imageWidth = jQuery(window).width();
            imageHeight = jQuery(window).height();
        }
        if (imageWidth == undefined) {
            imageWidth = jQuery(img).css("width").replace("px", "");
        }
        if (imageHeight == undefined) {
            imageHeight = jQuery(img).css("height").replace("px", "");
        }

        var newx = imageWidth / (100 / px);
        var newy = imageHeight / (100 / py);
        var neww = (w * imageWidth) / bw;
        var newh = (h * imageHeight) / bh;
        var overlay = ("#overlay" + linkId);
        if (jQuery(overlay).length) {
            jQuery(overlay).css('left', newx);
            jQuery(overlay).css('top', newy);
            jQuery(overlay).css('width', neww);
            jQuery(overlay).css('height', newh);
        } else {
            if (src.indexOf('.mp4') != -1) {
                src = base + src;
            } else {
                src = YouTubeUrlNormalize(src);
            }
            var tamanho = "740 560";
            var sizes = tamanho.split(" ");
            var action = "abreModal('" + src + "'," + sizes[0] + "," + sizes[1] + ")";
            if (icone != null && icone != '') {
                overlay = "<div class=\"overlaytransp\" id=\"overlay" + linkId + "\" style='position:absolute;left:" + newx + "px;top:" + newy + "px;width:" + neww + "px;height:" + newh + "px' onclick=\"" + action + "\">";
                overlay = overlay + "<div style='width:100%;height:100%;margin:0px;background-image:url(" + base + icone + ");position:relative;background-size:auto 100%;background-repeat:no-repeat'/>";
                overlay = overlay + "</div>";
            } else {
                overlay = "<div class=\"overlay\" id=\"overlay" + linkId + "\" style='position:absolute;left:" + newx + "px;top:" + newy + "px;width:" + neww + "px;height:" + newh + "px' onclick=\"" + action + "\">";
                overlay = overlay + '&nbsp;';
                overlay = overlay + "</div>";
            }
            jQuery("#pag" + pagId + " #thepage").append(overlay);

        }
    }
}
function updatePageChange() {
    var current = page;
    if (page <= 0)
        current = 1;
    if (page > total) {
        page = total;
    }
    if (isLandscape()) {
        var max = (current * 2) - 1;
        if (max <= 2) {
            jQuery('#multimidia_textfield').val('1 de ' + total);
        } else {
            if (max > total) {
                jQuery('#multimidia_textfield').val(total + ' de ' + total);
            } else {
                var text = (max - 1) + ' e ' + (max) + ' de ' + total;
                jQuery('#multimidia_textfield').val(text);
            }
        }
    } else {
        var text = (current) + ' de ' + total;
        jQuery('#multimidia_textfield').val(text);
    }
    validateRecomment();
    jQuery(".wa_btn_s").attr('data-href', base + linkedicao + '?pg=' + page);
}

var lockdock = false;
var docked = 0;

function getPagesLink(sector) {
    return base + 'flip/jornal/skins/king/jsp/' + sector + '.jsp';
}
function abrePaginaIndice(anchor, pagina) {
    var p = parseInt(pagina);
    pagesum = 1;
    if (isLandscape()) {
        if (p > 1) {
            if (p % 2 != 0) {
                p = p - 1;
            }
            p = (p / 2);
        }
        myScroll.scrollToPage(p, 0);
    } else {
        myScroll.scrollToPage(p - 1, 0);
    }

    if (lockdock == true) {
        lockdock = false;
        lockdock = false;
        jQuery("#dock").find("ul.free").animate({
            left: "-700px"
        }, 200);
    }

}
function openEditionMode(p) {
    var html = '<div id="header"><li class="header">Edições anteriores</li></div>';
    var pageAnchor = getCurrentEdition();
    if (!p)
        p = 0;
    var url = getPagesLink('edicoesiPad') + '?idForm=' + pageAnchor + '&linkedicao=' + linkedicao + '&pagina=' + p;
    jQuery.post(url, function (data) {
        jQuery('#edicoes_barra .free').html(html + data);
    });
}

function openProdutosMode() {
    openProdutosMode(0);
}
function openProdutosMode(p) {
    var html = '<div id="header"><li class="header">Cadernos e Produtos</li></div>';
    var pageAnchor = getCurrentEdition();
    page = p;
    if (!page || page == undefined) {
        page = 0;
    }
    var url = getPagesLink('produtos') + '?idForm=' + pageAnchor + '&linkedicao=' + linkedicao + '&pagina=' + page;
    jQuery.post(url, function (data) {
        jQuery('#produtos_barra .free').html(html + data);
    });
}

var lockbar = '';
function loadDock(name) {
    lockbar = name;
    if (name == 'indice_barra') {
        if (jQuery('#indice_barra .free').html().length == 0) {
            jQuery.getCSS(base + 'flip/jornal/skins/king/css/indice_flip.css');
            var html = '<div id="header"><li class="header">Índice</li></div>';
            var pageAnchor = getCurrentEdition();
            var url = getPagesLink('cadernosiPad') + '?idForm=' + pageAnchor;
            jQuery.post(url, function (data) {
                jQuery('#indice_barra .free').html(html + data);
                jQuery.getScript(base + 'flip/jornal/skins/king/js/cadernofiltro.js');
            });
        }
    } else {
        if (name == 'edicoes_barra') {
            if (jQuery('#edicoes_barra .free').html().length == 0) {
                openEditionMode();
            }
        } else {
            if (name == 'produtos_barra') {
                if (jQuery('#produtos_barra .free').html().length == 0) {
                    openProdutosMode();
                }
            } else {
                if (name == 'sumario_barra') {
                    if (jQuery('#sumario_barra .free').html().length == 0) {
                        var html = '<div id="header"><li class="header">Páginas</li></div>';
                        var pageAnchor = getCurrentEdition();
                        var url = getPagesLink('sumarioiPad') + '?idForm=' + pageAnchor + '&sumarioFotos=true';
                        jQuery.post(url, function (data) {
                            jQuery('#sumario_barra .free').html(html + data);
                        });
                    }
                }
            }
        }
    }
    lockdock = true;
}
function isLandscape() {
    return jQuery(window).width() > jQuery(window).height();
}

var cnvdraw = null;
var ctxdraw = null;
function configureCanvasSketch() {
    if (cnvdraw == null) {
        var width = jQuery(window).width();
        var height = jQuery(window).height();
        cnvdraw = document.createElement("canvas");
        jQuery(cnvdraw).attr('id', 'colors_sketch');
        jQuery(cnvdraw).attr('width', width);
        jQuery(cnvdraw).attr('height', height);
        jQuery("body").append(cnvdraw);

        if (isLandscape()) {
            var src = jQuery("#pag" + page + " #zoomgallery img").attr('src');
            jQuery(cnvdraw).css('background', 'url(' + src + ')');
        } else {
            var src = jQuery("#pag" + page + " #zoomgallery img").attr('src');
            jQuery(cnvdraw).css('background', 'url(' + src + ')');
        }
        ctxdraw = cnvdraw.getContext("2d");

    } else {
        ctxdraw.clearRect(0, 0, cnvdraw.width, cnvdraw.height);
        var w = cnvdraw.width;
        var h = cnvdraw.height;
        cnvdraw.width = w;
        cnvdraw.height = h;
    }
}

function enableSketch() {
    configureCanvasSketch();
    sketchobject = jQuery('#colors_sketch').sketch({
        defaultColor: "#ff0",
        defaultSize: 3
    });
}

function validateRecomment() {
    validateRecommend(getCurrentPage());
}

function closeRecommendArea() {
    jQuery("#facerecomenda").hide("slow");
}
function validateRecommend(current) {
    if (jQuery("#facerecomenda")) {
        var faceurltemplate = "http://www.facebook.com/plugins/like.php?href=$URL&;layout=standard&show_faces=false&width=380&action=recommend&colorscheme=light&height=30&locale=pt_BR";
        var width = jQuery(window).width();
        var height = jQuery(window).height();
        if (current > 0 && current % 2 == 0) {
            current--;
        }
        var link = linkedicao + '?page=' + current;
        var url = faceurltemplate.replace("$URL", link);
        jQuery("#faceframeleft").attr('src', url);
        if ((height > width) || (current == 0 || current == total || current == null)) {
            width = width / 2;
            jQuery("#faceright").hide();
            jQuery("#facerecomenda").css("width", width + "px");
            jQuery("#faceleft").css("width", "100%");
            jQuery(".closeleft").show();
        } else {
            jQuery(".closeleft").hide();
            jQuery("#facerecomenda").css("width", width + "px");
            jQuery("#faceleft").css("width", "50%");
            jQuery("#faceright").css("width", "50%");
            jQuery("#faceright").show();
            var link = linkedicao + '?page=' + (current + 1);
            url = faceurltemplate.replace("$URL", link);
            jQuery("#faceframeright").attr('src', url);
        }
    }
}
var addToHomeConfig = {
    animationIn: 'bubble',
    animationOut: 'drop',
    lifespan: 7000,
    expire: 2,
    touchIcon: true,
    message: "Instale o aplicativo em seu %device. Clique em %icon e escolha 'Adicionar à  tela de início'"
};

var YouTubeUrlNormalize = function (url)
{
    var rtn = url;
    if (url)
    {
        if (document.location.protocol == 'https:') {
            url = url.replace("http://", "https://");
        }

        var vidId;
        if (url.indexOf("youtube.com/watch?v=") !== -1)
        {
            vidId = url.substr(url.indexOf("youtube.com/watch?v=") + 20);
            rtn = "https://www.youtube.com/embed/" + vidId;
        } else if (url.indexOf("youtube.com/watch/?v=") !== -1)
        {
            vidId = url.substr(url.indexOf("youtube.com/watch/?v=") + 21);
            rtn = "https://www.youtube.com/embed/" + vidId;
        } else if (url.indexOf("youtu.be") !== -1)
        {
            vidId = url.substr(url.indexOf("youtu.be") + 9);
            rtn = "https://www.youtube.com/embed/" + vidId;
        } else if (url.indexOf("www.youtube.com/embed/") !== -1)
        {
            rtn = url;
        } else
        {
            rtn = null;
        }
    }
    return rtn;
};


var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
            sURLVariables = sPageURL.split('#'),
            sParameterName,
            i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('/');
        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }

};