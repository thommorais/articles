/*
* jQuery modalBox plugin v1.2.0 <http://code.google.com/p/jquery-modalbox-plugin/> 
* @requires jQuery v1.3.2 or later 
* is released under the MIT License <http://www.opensource.org/licenses/mit-license.php> 
*/
(function(c){var d={minimalTopSpacingOfModalbox:50,usejqueryuidragable:false,killModalboxWithCloseButtonOnly:false,setWidthOfModalLayer:null,customClassName:null,getStaticContentFrom:null,positionLeft:null,positionTop:null,effectType_show_fadingLayer:["fade","fast"],effectType_hide_fadingLayer:["fade","fast"],effectType_show_modalBox:["show"],effectType_hide_modalBox:["hide"],selectorModalboxContainer:"#modalBox",selectorModalboxBodyContainer:"#modalBoxBody",selectorModalboxBodyContentContainer:".modalBoxBodyContent",selectorFadingLayer:"#modalBoxFaderLayer",selectorAjaxLoader:"#modalBoxAjaxLoader",selectorModalboxCloseContainer:"#modalBoxCloseButton",selectorModalboxContentContainer:".modalboxContent",selectorHiddenAjaxInputField:"ajaxhref",selectorPreCacheContainer:"#modalboxPreCacheContainer",selectorImageGallery:".modalgallery",setModalboxLayoutContainer_Begin:'<div class="modalboxStyleContainer_surface_left"><div class="modalboxStyleContainer_surface_right"><div class="modalboxStyleContainerContent"><div class="modalBoxBodyContent">',setModalboxLayoutContainer_End:'</div></div></div></div><div class="modalboxStyleContainer_corner_topLeft"><!-- - --></div><div class="modalboxStyleContainer_corner_topRight"><!-- - --></div><div class="modalboxStyleContainer_corner_bottomLeft"><!-- - --></div><div class="modalboxStyleContainer_corner_bottomRight"><!-- - --></div><div class="modalboxStyleContainer_surface_top"><div class="modalboxStyleContainer_surface_body"><!-- - --></div></div><div class="modalboxStyleContainer_surface_bottom"><div class="modalboxStyleContainer_surface_body"><!-- - --></div></div>',localizedStrings:{messageCloseWindow:"Fechar janela",messageAjaxLoader:"Carregando...",errorMessageIfNoDataAvailable:"<strong>No content available!</strong>",errorMessageXMLHttpRequest:'Error: XML-Http-Request Status "500"',errorMessageTextStatusError:"Error: AJAX Request failed"},setTypeOfFadingLayer:"black",setStylesOfFadingLayer:{white:"background-color:#fff; filter:alpha(opacity=60); -moz-opacity:0.6; opacity:0.6;",black:"background-color:#000; filter:alpha(opacity=40); -moz-opacity:0.4; opacity:0.4;",transparent:"background-color:transparent;",custom:null},directCall:{source:null,data:null,element:null},ajax_type:"POST",ajax_contentType:"application/x-www-form-urlencoded; charset=utf-8",callFunctionBeforeShow:function(){return true;},callFunctionAfterShow:function(){},callFunctionBeforeHide:function(){},callFunctionAfterHide:function(){}};try{d=jQuery.extend({},d,modalboxGlobalDefaults);}catch(b){}var a={init:function(j){var j=jQuery.extend({},d,j);if(j.directCall){if(j.directCall["source"]){l({type:"ajax",source:j.directCall["source"],data:null});}else{if(j.directCall["data"]){l({type:"static",source:null,data:j.directCall["data"]});}else{if(j.directCall["element"]){l({type:"static",source:null,data:jQuery(j.directCall["element"]).html()});}}}}var h=false;jQuery(window).resize(function(){h=true;});if(!h){jQuery(this).die("click").live("click",function(n){e({event:n,element:jQuery(this)});});}function e(p){var p=jQuery.extend({event:null,element:null},p||{});if(p.event&&p.element){var o=p.event;var t=p.element;var q=false;var v=false;if(t.is("input")){var n=t.parents("form").attr("action");var r=t.parents("form").serialize();var s="ajax";v=true;o.preventDefault();}else{if(jQuery("input[name$='"+j.selectorHiddenAjaxInputField+"']",t).length!=0){var n=jQuery("input[name$='"+j.selectorHiddenAjaxInputField+"']",t).val();var r="";var s="ajax";o.preventDefault();}else{if(jQuery(j.selectorModalboxContentContainer,t).length!=0){if(jQuery(j.selectorModalboxContentContainer+" img"+j.selectorImageGallery,t).length!=0){var u=jQuery(j.selectorModalboxContentContainer+" img"+j.selectorImageGallery,t);}var n="";var r=jQuery(j.selectorModalboxContentContainer,t).html();var s="static";o.preventDefault();}else{if(j.getStaticContentFrom){var n="";var r=jQuery(j.getStaticContentFrom).html();var s="static";o.preventDefault();}else{q=true;}}}}if(!q){l({type:s,element:t,source:n,data:r,loadingImagePreparer:{currentImageObj:u,finalizeModalBox:false}});}if(v){return false;}}}function f(o){var o=jQuery.extend({ar_XMLHttpRequest:null,ar_textStatus:null,ar_errorThrown:null,targetContainer:null,ar_enableDebugging:false},o||{});var p=o.ar_XMLHttpRequest;var s=o.ar_textStatus;var q=o.ar_errorThrown;if(p&&s!="error"){if(p.status==403){var r=p.getResponseHeader("Location");if(typeof r!=="undefined"){location.href=r;}}else{if(p.status==500&&o.targetContainer){n({errorMessage:j.localizedStrings["errorMessageXMLHttpRequest"],targetContainer:o.targetContainer});}}if(o.ar_enableDebugging){console.log("XMLHttpRequest.status: "+p.status);}}else{if(s=="error"){if(o.targetContainer){n({errorMessage:j.localizedStrings["errorMessageTextStatusError"],targetContainer:o.targetContainer});}if(o.ar_enableDebugging){console.log("textStatus: "+s);}}else{}}function n(t){var t=jQuery.extend({errorMessage:null,targetContainer:null},t||{});if(t.errorMessage&&t.targetContainer){var u="";u+='<div class="simleModalboxErrorBox"><div class="simleModalboxErrorBoxContent">';u+=t.errorMessage;u+="</div></div>";jQuery(t.targetContainer).removeAttr("style").html(u);if(jQuery(t.targetContainer).parents(j.selectorModalboxContainer).length>0){jQuery(j.selectorAjaxLoader).remove();i();}}}}function g(n){var n=jQuery.extend({currentURL:"",addParameterName:"ajaxContent",addParameterValue:"true"},n||{});var p=n.currentURL;if(p.indexOf(n.addParameterName)!=-1){p=p;}else{if(p.indexOf("?")!=-1){var o="&";}else{var o="?";}p=p+o+n.addParameterName+"="+n.addParameterValue;}return p;}function k(n){var n=jQuery.extend({type:n.type,element:n.element,source:n.source,data:n.data,loadingImagePreparer:{currentImageObj:n.loadingImagePreparer["currentImageObj"],finalizeModalBox:n.loadingImagePreparer["finalizeModalBox"]},nameOfImagePreloaderContainer:"imagePreparerLoader",wrapContainer:'<div class="modalBoxCarouselItemContainer"></div>'},n||{});var o=n.loadingImagePreparer["currentImageObj"];if(o){jQuery(j.selectorModalboxContentContainer).css({display:"block",position:"absolute",left:"-9999px",top:"-9999px"}).removeAttr("style");l({type:n.type,element:n.element,source:n.source,data:n.data,loadingImagePreparer:{currentImageObj:o,finalizeModalBox:true,nameOfImagePreloaderContainer:n.nameOfImagePreloaderContainer}});}}function l(p){var p=jQuery.extend({type:null,element:null,source:null,data:null,loadingImagePreparer:{currentImageObj:null,finalizeModalBox:false,nameOfImagePreloaderContainer:null}},p||{});function r(){a.close({callFunctionBeforeHide:j.callFunctionBeforeHide,callFunctionAfterHide:j.callFunctionAfterHide});}if(!j.killModalboxWithCloseButtonOnly){jQuery(j.selectorFadingLayer).die("click").live("click",function(){r();});}jQuery(j.selectorModalboxContainer+" .closeModalBox").die("click").live("click",function(){r();});jQuery(j.selectorPreCacheContainer).remove();if(p.loadingImagePreparer["currentImageObj"]&&!p.loadingImagePreparer["finalizeModalBox"]){k({type:p.type,element:p.element,source:p.source,data:p.data,loadingImagePreparer:p.loadingImagePreparer});}else{if(p.type&&j.callFunctionBeforeShow()){if(p.source){p.source=g({currentURL:p.source});}var s="";var o="";if(p.element){if(jQuery(p.element).hasClass("large")){o+="large";}else{if(jQuery(p.element).hasClass("medium")){o+="medium";}else{if(jQuery(p.element).hasClass("small")){o+="small";}else{if(p.loadingImagePreparer["nameOfImagePreloaderContainer"]){o+="auto modalBoxBodyContentImageContainer";}}}}if(jQuery(p.element).hasClass("emphasis")){o+=" emphasis";}}if(j.customClassName){o+=" "+j.customClassName;}if(j.setWidthOfModalLayer){s+="width:"+parseInt(j.setWidthOfModalLayer)+"px; ";}if(jQuery(j.selectorModalboxContainer).length==0){jQuery("body").append(a.modalboxBuilder({customStyles:'class="'+o+'" style="'+s+'"'}));}else{var q=a.cleanupSelectorName({replaceValue:j.selectorAjaxLoader});a.clean({setModalboxContentContainer:j.selectorModalboxBodyContentContainer,selectorAjaxLoader:q,localizedStrings:j.localizedStrings["messageAjaxLoader"]});}var n=function(){switch(p.type){case"static":jQuery(j.selectorAjaxLoader).hide();jQuery(j.selectorModalboxBodyContentContainer,j.selectorModalboxContainer).html(p.data);i({callFunctionAfterShow:j.callFunctionAfterShow});break;case"ajax":jQuery.ajax({type:j.ajax_type,url:p.source,data:p.data,contentType:j.ajax_contentType,success:function(t,u){jQuery(j.selectorAjaxLoader).fadeOut("fast",function(){jQuery(j.selectorModalboxBodyContentContainer,j.selectorModalboxContainer).html(t);i({callFunctionAfterShow:j.callFunctionAfterShow});});},error:function(t,v,u){f({ar_XMLHttpRequest:t,ar_textStatus:v,ar_errorThrown:u,targetContainer:j.selectorModalboxContainer+" "+j.selectorModalboxBodyContentContainer});}});break;}};m({callFunctionAfterShow:n});}}}function m(o){var o=jQuery.extend({isResized:false,callFunctionAfterShow:null},o||{});if(jQuery(j.selectorFadingLayer).length==0){if(j.setTypeOfFadingLayer=="white"){var n=j.setStylesOfFadingLayer["white"];}else{if(j.setTypeOfFadingLayer=="black"){var n=j.setStylesOfFadingLayer["black"];}else{if(j.setTypeOfFadingLayer=="custom"&&j.setStylesOfFadingLayer["custom"]){var n=j.setStylesOfFadingLayer["custom"];}else{var n=j.setStylesOfFadingLayer["transparent"];}}}var q=a.cleanupSelectorName({replaceValue:j.selectorFadingLayer});jQuery("body").append('<div id="'+q+'" style="'+n+'"></div>');var p=jQuery(j.selectorFadingLayer);if(j.setTypeOfFadingLayer=="disable"){j.effectType_show_fadingLayer[0]="";}switch(j.effectType_show_fadingLayer[0]){case"fade":p.fadeIn(j.effectType_show_fadingLayer[1],function(){i({isResized:o.isResized,callFunctionAfterShow:o.callFunctionAfterShow});});break;default:p.show();i({isResized:o.isResized,callFunctionAfterShow:o.callFunctionAfterShow});break;}jQuery(window).resize(function(){if(p.is(":visible")){i({isResized:true});}});}else{i({isResized:o.isResized,callFunctionAfterShow:o.callFunctionAfterShow});}}function i(p){var p=jQuery.extend({isResized:false,callFunctionAfterShow:null},p||{});var n=jQuery(j.selectorModalboxContainer);if(jQuery(j.selectorPreCacheContainer).length==0&&n.length!=0){if(jQuery("body a.modalBoxTopLink").length==0){jQuery("body").prepend('<a class="modalBoxTopLink"></a>');}var o=false;var t="absolute";var r=0;var s=n.width();var q=n.height();var v=parseInt(jQuery(window).width()-s)/2;if(v<=0){v=0;}if(j.positionLeft){v=j.positionLeft+"px";}else{v=v+"px";}if(j.positionTop){r=parseInt(jQuery(window).height()-q);if(r>parseInt(j.positionTop)){t="fixed";}r=j.positionTop+"px";}else{r=parseInt(jQuery(window).height()-q-70)/2;if(r<=0){r=j.minimalTopSpacingOfModalbox+"px";o=true;}else{r=r+"px";t="fixed";}}function u(){if(o&&!n.hasClass("modalboxScrollingSuccessfully")){n.addClass("modalboxScrollingSuccessfully");a.scrollTo();}if(!p.isResized){if(p.callFunctionAfterShow){p.callFunctionAfterShow();}if(j.usejqueryuidragable){n.draggable("destroy").draggable({opacity:false,iframeFix:true,refreshPositions:true});}}}switch(j.effectType_show_modalBox[0]){case"fade":if(n.hasClass("modalboxFadingSuccessfully")){n.css({position:t,left:v,top:r,display:"block",visibility:"visible"});u();}else{n.css({position:t,left:v,top:r,visibility:"visible"}).fadeIn(j.effectType_show_modalBox[1],function(){jQuery(this).addClass("modalboxFadingSuccessfully");u();});}break;default:n.css({position:t,left:v,top:r,display:"block",visibility:"visible"});u();break;}}}},close:function(e){var e=jQuery.extend({},d,e);if(e.selectorFadingLayer&&e.selectorModalboxContainer){e.callFunctionBeforeHide();var g=jQuery(e.selectorFadingLayer+", "+e.selectorModalboxContainer);if(e.setTypeOfFadingLayer=="disable"){e.effectType_hide_fadingLayer[0]="";}switch(e.effectType_hide_fadingLayer[0]){case"fade":switch(e.effectType_hide_modalBox[0]){case"fade":jQuery(e.selectorModalboxContainer).fadeOut(e.effectType_hide_modalBox[1],function(){jQuery(e.selectorFadingLayer).fadeOut(e.effectType_hide_fadingLayer[1],function(){f(g);});});break;default:jQuery(e.selectorModalboxContainer).hide();jQuery(e.selectorFadingLayer).fadeOut(e.effectType_hide_fadingLayer[1],function(){f(g);});break;}break;default:switch(e.effectType_hide_modalBox[0]){case"fade":jQuery(e.selectorModalboxContainer).fadeOut(e.effectType_hide_modalBox[1],function(){f(g);});break;default:f(g);break;}break;}}function f(h){h.remove();e.callFunctionAfterHide();}},clean:function(e){var e=jQuery.extend({setModalboxContentContainer:null,selectorAjaxLoader:null,localizedStrings:null},e||{});if(e.setModalboxContentContainer){jQuery(e.setModalboxContentContainer).html('<div id="'+e.selectorAjaxLoader+'">'+e.localizedStrings+"</div>");}},scrollTo:function(f){var f=jQuery.extend({targetElement:"a.modalBoxTopLink",typeOfAnimation:"swing",animationSpeed:800,callAfterSuccess:function(){}},f||{});if(f.targetElement){if(jQuery.browser.webkit){var e=jQuery("body");}else{var e=jQuery("html");}e.animate({scrollTop:jQuery(f.targetElement).offset().top},f.animationSpeed,f.typeOfAnimation,function(){f.callAfterSuccess();});}},cleanupSelectorName:function(e){var e=jQuery.extend({replaceValue:""},e||{});var f=e.replaceValue;f=f.replace(/[#]/g,"");f=f.replace(/[.]/g,"");return f;},precache:function(e){var e=jQuery.extend({},d,e);if(e.selectorPreCacheContainer){if(jQuery(e.selectorPreCacheContainer).length==0){var h=a.cleanupSelectorName({replaceValue:e.selectorPreCacheContainer});var g=a.modalboxBuilder();var f="";f+='<div id="'+h+'" style="position:absolute; left:-9999px; top:-9999px;">';f+=g;f+="</div>";jQuery("body").append(f);jQuery(e.selectorModalboxContainer).show();}}},modalboxBuilder:function(h){var h=jQuery.extend({customStyles:""},h||{});h=jQuery.extend({},d,h);var g=a.cleanupSelectorName({replaceValue:h.selectorModalboxContainer});var f=a.cleanupSelectorName({replaceValue:h.selectorModalboxBodyContainer});var k=a.cleanupSelectorName({replaceValue:h.selectorModalboxBodyContentContainer});var e=a.cleanupSelectorName({replaceValue:h.selectorModalboxCloseContainer});var j=a.cleanupSelectorName({replaceValue:h.selectorAjaxLoader});var i="";i+='<div id="'+g+'"'+h.customStyles+">";i+='<div id="'+f+'">';i+=h.setModalboxLayoutContainer_Begin;i+='<div class="'+k+'">';i+='<div id="'+j+'">'+h.localizedStrings["messageAjaxLoader"]+"</div>";i+="</div>";i+=h.setModalboxLayoutContainer_End;i+='<div id="'+e+'"><a href="javascript:void(0);" class="closeModalBox"><span class="closeModalBox">'+h.localizedStrings["messageCloseWindow"]+"</span></a></div>";i+="</div>";i+="</div>";return i;}};jQuery.fn.modalBox=function(e){if(a[e]){return a[e].apply(this,Array.prototype.slice.call(arguments,1));}else{if(typeof e==="object"||!e){return a.init.apply(this,arguments);}else{jQuery.error("Method "+e+" does not exist on jQuery.modalBox");}}};jQuery(document).ready(function(){jQuery.fn.modalBox("precache");jQuery(".openmodalbox").modalBox();});})(jQuery);