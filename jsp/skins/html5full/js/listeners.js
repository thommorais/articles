var updatePageListeners = new Array();
var zoomInPageListeners = new Array();
var zoomOutPageListeners = new Array();
function addListener(listener, type) {
    if (type=='UPDATE_PAGE') {
        updatePageListeners.push(listener);
    } else {
        if (type=='ZOOM_IN_PAGE') {
            zoomInPageListeners.push(listener);
        } else {
            if (type=='ZOOM_OUT_PAGE') {
                zoomOutPageListeners.push(listener);
            }
        }
    }
}
function executeListener(type) {
    if (type=='UPDATE_PAGE') {
        for (var i = 0; i<updatePageListeners.length; i++) {
            setTimeout(updatePageListeners[i],50);            
        }
    } else {
        if (type=='ZOOM_IN_PAGE') {
            for (var i = 0; i<zoomInPageListeners.length; i++) {
                setTimeout(zoomInPageListeners[i],50);
            }
        } else {
            if (type=='ZOOM_OUT_PAGE') {
                for (var i = 0; i<zoomOutPageListeners.length; i++) {
                    setTimeout(zoomOutPageListeners[i],50);
                }
            }
        }
    }
}