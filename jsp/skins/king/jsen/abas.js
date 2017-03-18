var currentdock = null;
var lockdock = false;
var dockheight = 0;
var shadowLayer = false;

jQuery(document).ready(function () {
    var docked = 0;

    if (jQuery("#s2bannerdiv").length) {
        dockheight = jQuery(window).height() - 30 - pageHeightSpace;
    } else {
        dockheight = jQuery(window).height();
    }
    jQuery("#dock li ul").height(dockheight);
    jQuery("#dock_right li ul").height(dockheight);

    //if (isIE) {
    //    jQuery("#tab_left").css("top","180px");
    //}   
    var tabLeftTop = 0;
    if (jQuery("#tab_left").position()) {
        try {
            tabLeftTop = jQuery("#tab_left").position().top();
        } catch (e) {
            tabLeftTop = 0;
        }
    }

    var tabPos = tabLeftTop - pageHeightSpace;
    if (jQuery("#s2bannerdiv").length) {
        tabPos = tabPos - 30;
    }
    jQuery(".dock_tab_hover").each(function () {
        var pos = jQuery(this).position().top;
        jQuery(".free", this).css("top", "-" + (pos - tabPos) + "px");
    });
    jQuery("#dock .dock").click(function () {
        jQuery(this).parent().parent().addClass("docked").removeClass("free");

        docked += 1;
        var dockH = (dockheight) / docked
        var dockT = 0;

        jQuery("#dock li ul.docked").each(function () {
            jQuery(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        jQuery(this).parent().find(".undock").show();
        jQuery(this).hide();

        if (docked > 0) {
            jQuery("#content").css("margin-left", "250px");
        } else {
            jQuery("#content").css("margin-left", "60px");
        }
    });

    jQuery("#dock_right .dock_right").click(function () {
        jQuery(this).parent().parent().addClass("docked").removeClass("free");

        docked += 1;
        var dockH = (dockheight) / docked
        var dockT = 0;

        jQuery("#dock_right li ul.docked").each(function () {
            jQuery(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        jQuery(this).parent().find(".undock").show();
        jQuery(this).hide();

        if (docked > 0) {
            jQuery("#content").css("margin-right", "250px");
        } else {
            jQuery("#content").css("margin-right", "60px");
        }
    });

    jQuery("#dock .undock").click(function () {
        jQuery(this).parent().parent().addClass("free").removeClass("docked")
                .animate({
                    right: "-1200px"
                }, 200).height(dockheight).css("top", "0px");

        docked = docked - 1;
        var dockH = (dockheight) / docked
        var dockT = 0;

        jQuery("#dock li ul.docked").each(function () {
            jQuery(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        jQuery(this).parent().find(".dock").show();
        jQuery(this).hide();

        if (docked > 0) {
            jQuery("#content").css("margin-left", "250px");
        } else {
            jQuery("#content").css("margin-left", "60px");
        }
    });

    jQuery("#dock_right .undock").click(function () {
        jQuery(this).parent().parent().addClass("free").removeClass("docked")
                .animate({
                    right: "-700px"
                }, 200).height(dockheight).css("top", "0px");

        docked = docked - 1;
        var dockH = (dockheight) / docked
        var dockT = 0;

        jQuery("#dock li ul.docked").each(function () {
            jQuery(this).height(dockH).css("top", dockT + "px");
            dockT += dockH;
        });
        jQuery(this).parent().find(".dock").show();
        jQuery(this).hide();

        if (docked > 0) {
            jQuery("#content").css("margin-right", "250px");
        } else {
            jQuery("#content").css("margin-right", "60px");
        }
    });

    jQuery(".dock_tab_hover").hover(function () {
        if (jQuery(this).attr('class') == 'dock_tab_hover') {
            loadDock(this.id);
            jQuery(this).find("ul").animate({
                left: "40px"
            }, 200);
            currentdock = jQuery(this);
            jQuery(this).stop();
            onDockOn(this.id);
        }
    }, function () {

        //VERJOHN
        var $focused = jQuery(':focus');
        if ($focused) {
            if ($focused.prop('nodeName') == 'SELECT' || $focused.prop('nodeName') == 'INPUT') {
                lockdock = true;
                jQuery('#edicoes_barra ul').css("display", "block");
                jQuery(this).stop();
                return false;
            } else {
                lockdock = false;
                jQuery('#edicoes_barra ul').css("display", "");
            }
        } else {
            lockdock = false;
            jQuery('#edicoes_barra ul').css("display", "");
        }


        if (lockdock == false) {
            jQuery(this).find("ul.free").animate({
                left: "-700px"
            }, 200);
            onDockOff(this.id);
        }
    });

    jQuery("#dock_right li").hover(function () {
        loadDock(this.id);
        jQuery(this).find("ul").animate({
            right: "40px"
        }, 200);
        currentdock = jQuery(this);
    }, function () {
        if (lockdock == false) {
            jQuery(this).find("ul.free").animate({
                right: "-700px"
            }, 200);
        }

    });
});

function onDockOn(idc) {
    if (idc != 'promocao_barra') {
        jQuery("#promocao_barra").hide();
    }
    jQuery("#" + idc).css("z-index", "99999999").css("position", "relative");
    showShadowLayer();
}
function onDockOff(idc) {
    jQuery("#promocao_barra").show();
    jQuery("#" + idc).css("z-index", "100").css("position", "");
    hideShadowLayer();
}

function loadDock(name) {
    if (name == 'sumario_barra') {
        if (jQuery('#sumario_barra .free').html().length == 0) {
            var html = '<div id="header"><li class="header">Páginas</li></div>';
            var pageAnchor = getCurrentEdition();
            var url = getPagesLink('sumario') + '?idForm=' + pageAnchor;
            url = url + '&sumarioFotos=' + sumarioFotos;
            jQuery.post(url, function (data) {
                jQuery('#sumario_barra .free').html(html + data);
                if (dataLayer != null) {
                    dataLayer.push({'event': 'eventTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu sumario', 'eventLabel': dataAnalytics});
                }
            });
        }
    } else {
        if (name == 'indice_barra') {
            if (jQuery('#indice_barra .free').html().length == 0) {

                var html = '<div id="header"><li class="header">Índice</li></div>';
                var pageAnchor = getCurrentEdition();
                var url = getPagesLink('cadernos') + '?idForm=' + pageAnchor;
                jQuery.post(url, function (data) {
                    jQuery('#indice_barra .free').html(html + data);

                    if (dataLayer != null) {
                        dataLayer.push({'event': 'eventTracking', 'eventCategory': 'Cliques Flip - ' + sigla, 'eventAction': 'Abriu indice', 'eventLabel': dataAnalytics});
                    }

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
                    if (name == 'volume_barra') {
                        if (jQuery('#volume_barra .free').html().length == 0) {
                            openVolumesMode();
                        }
                    } else {
                        if (name == 'anotacoes_barra') {
                            if (jQuery('#anotacoes_barra .free').html().length == 0) {
                                var html = '<div id="header"><li class="header">Notas</li></div>';
                                var pageAnchor = getCurrentEdition();
                                var url = getPagesLink('notas') + '?edicao=' + pageAnchor;
                                jQuery.post(url, function (data) {
                                    jQuery('#anotacoes_barra .free').html(html + data);
                                    jQuery.getScript(base + 'flip/jornal/skins/king/js/cadernofiltro.js');
                                });
                            }
                        }
                    }
                }
            }
        }
    }
}
function showShadowLayer() {
    if (shadowLayer == false) {
        jQuery("body").append('<div id="modalBoxFaderLayerAbas" style="opacity: 0.4; display: block; background-color: rgb(0, 0, 0);"></div>');
        jQuery("#tab_left #dock").append('<div id="modalBoxFaderLayerInterno" style="opacity: 0.4; display: block; background-color: rgb(0, 0, 0);"></div>');
        shadowLayer = true;
    }
}
function hideShadowLayer() {
    if (shadowLayer == true) {
        jQuery("#modalBoxFaderLayerAbas").remove();
        jQuery("#tab_left #dock #modalBoxFaderLayerInterno").remove();
        shadowLayer = false;
    }
}