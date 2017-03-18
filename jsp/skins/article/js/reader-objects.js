var pageArray = new Array();

function PageObject() {
    this.id = null;
    this.num = null;
    this.pdf = null;
    this.url = null;
    this.urlimg = null;
    this.urlimgthumb = null;
    this.urlimgbig = null;
    this.pdfWidth = null;
    this.pdfHeight = null;
    this.rendered = false;
    this.medias = new Array();
}
function PageMedia() {
    this.type = null;
    this.x = null;
    this.y = null;
    this.width = null;
    this.height = null;
    this.link = null;
    this.px = null;
    this.py = null;
    this.id = null;
    this.pw = null;
    this.ph = null;
    this.label = null;
    this.popupWeb = null;
    this.iconeWeb = null;
    this.skin=null;
    this.pics = new Array();
}
function PagePic() {
    this.cd = null;
    this.media = null;
    this.nome = null;
}
PageObject.prototype.isHtmlPage = function () {
    return this.urlimgbig=='HTML5';
}
PageObject.prototype.isZipPage = function () {
    return this.urlimgbig=='ZIP';
}
PageObject.prototype.isWebViewPage = function () {
    return (this.urlimg.indexOf(".zip")==-1) && (this.urlimg.indexOf("http://")!=-1||this.urlimg.indexOf("https://")!=-1||this.urlimg.indexOf("www")!=-1);
}
PageObject.prototype.getPageClass = function () {
    return this.num==0||this.num % 2 != 0 || singlePageOn == true ? "page_left" : "page_right";
}
PageObject.prototype.addMedia = function (media) {
    var pm = new PageMedia();
    pm.type = media[0];
    pm.x = media[2];
    pm.y = media[3];
    pm.w = media[4];
    pm.h = media[5];
    pm.link = media[6];
    pm.px = media[7];
    pm.py = media[8];
    pm.id = media[9];
    pm.pw = media[10];
    pm.ph = media[11];
    pm.label = media[12];
    pm.popupWeb = media[13];
    pm.iconeWeb = media[14];
    if(media[15]){
        this.skin=media[15];
    }
    this.medias.push(pm);
}
PageMedia.prototype.addPic = function (pic) {
    var pm = new PagePic();
    pm.cd = pic[0];
    pm.media = pic[1];
    pm.nome = pic[2];
    this.pics.push(pm);
}

function addPage(index, object) {
    var page = new PageObject();
    page.num = index;
    page.id = object[0];
    page.urlimgbig = object[1];
    page.urlimg = object[2];
    page.urlimgthumb = object[3];
    page.url = object[4];
    pageArray[index] = page;    
}
function addPageMedia(index, object) {
    pageArray[index].addMedia(object);
}
function addPageMediaPic(index, id, object) {
    var page = pageArray[index];
    for (var i = 0; i < page.medias.length; i++) {
        if (page.medias[i].id == id) {
            page.medias[i].addPic(object);
        }
    }
}
function turn(object, number) {
    switch (object) {
        case "page":
        {
            if (!number) {
                return pageNumber;
            } else {
                var direction = number > pageNumber ? 1 : 0;
                if (pageNumber != number) {
                    if (number % 2 != 0) {
                        number = number - 1;
                    }
                    pageNumber = number;
                    animateAndRenderPages(direction);
                }
            }
            return;
        }
        case "previous":
        {
            if (pageNumber > 1) {                
                pageNumber--;
                if (!isZoomEnabled()) {
                    if (pageNumber % 2 != 0) {
                        pageNumber = pageNumber - 1;
                    }
                }
                animateAndRenderPages(0);
            }
            return;
        }
        case "next":
        {
            if (pageNumber < pageArray.length) {                   
                pageNumber++;
                if (!isZoomEnabled()) {
                    if (pageNumber % 2 != 0) {
                        pageNumber = pageNumber + 1;
                    }
                }
                animateAndRenderPages(1);
            }
            return;
        }
        case "pages":
        {
            return  pageArray.length;
        }
        case "zoom":
        {
            if (!number) {
                return zoomScale;
            } else {
                if (number == "in") {
                    increaseZoom();
                    return;
                }
                if (number == "out") {
                    decreaseZoom();
                    return;
                }
                changeZoom(number);
                return;
            }
        }
        default:
            return null;
    }

}

function isZoomEnabled() {
    return $('body').hasClass("bodyzoom") || singlePageOn==true;
}

function isChrome() {
    return navigator.userAgent.indexOf('Chrome') != -1;
}
function isEmpty(campo) {
    return (campo == null || campo.value == null || campo.value == '');
}
function getInternetExplorerVersion() {
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}
var IEV = getInternetExplorerVersion();
function isDeviceMobile(){
 var isMobile = {
  Android: function() {
      return navigator.userAgent.match(/Android/i) && navigator.userAgent.match(/mobile|Mobile/i);
  },
  BlackBerry: function() {
      return navigator.userAgent.match(/BlackBerry/i)|| navigator.userAgent.match(/BB10; Touch/);
  },
  iOS: function() {
      return navigator.userAgent.match(/iPhone|iPod/i);
  },
  Opera: function() {
      return navigator.userAgent.match(/Opera Mini/i);
  },
  Windows: function() {
      return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/webOS/i) ;
  },
  Portrait: function(){
    return $(window).width()<$(window).height();  
  },
  any: function() {
      return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows() || isMobile.Portrait());
  }
};      
 return isMobile.any()
}