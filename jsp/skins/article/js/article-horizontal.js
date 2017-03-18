jQuery(document).ready(function () {
    jQuery('.wide-title').addClass('dontend');
    var w = jQuery(window).width();
    var h = jQuery(window).height() - 70;
    if (w > 800) {
        w = w / 3;
    } else {
        if (w > 400) {
            w = w / 2;
        }
    }
    jQuery('.wide').columnize({
        width: w,
        height: h
    });
    jQuery("#article-reader").hide();
    jQuery("div:has('.wide-title')").addClass('wide-column-border-left');
    jQuery("div:has('.leiamais')").addClass('wide-column-border-right');
});