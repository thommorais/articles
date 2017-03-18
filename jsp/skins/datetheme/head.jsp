<%
            String base = request.getParameter("base");
            String token_hash=""+System.currentTimeMillis();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/datetheme/js/jquery.min.js"  ></script>
<script type="text/javascript"> jQuery.noConflict();</script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/datetheme/js/jquery-ui-1.7.2.custom.min.js"  ></script>
<link href="<%= base%>flip/jornal/css/boxes.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/caderno_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/datetheme/css/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/datetheme/css/layout.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/datetheme/css/layout_dinamic.jsp?tok=<%= token_hash %>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/modalbox.css" rel="stylesheet" type="text/css" media="screen"/>

<!--[if lte IE 7]>
	   <style>
	       #datepicker {font-size:9px; margin-top:4px; margin-left:5px;}
</style>
<![endif]-->
<script type="text/javascript" src="<%= base%>flip/jornal/skins/datetheme/js/easySlider.packed.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/prototype.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/scriptaculous.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/basic.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/modalbox.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/printPDF.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/validation.js"  ></script>
<!--[if lt IE 7]>
<script defer type="text/javascript" src="<%= base%>flip/jornal/js/pngfix.js"  ></script>
<![endif]-->
<script type="text/javascript">   
    jQuery(document).ready(function(){
        jQuery("#slider").easySlider({
            prevText:'Cima',
            nextText:'Baixo',
            orientation:'vertical'
        });
    });
    jQuery(function(){
        jQuery('#datepicker').datepicker({
            inline: true,
            dateFormat: "yy-mm-dd",
            <c:choose>
                <c:when test="${!empty diffDays}">
                    defaultDate: <c:out value="${diffDays}"/>,
                </c:when>
                <c:otherwise>
                    defaultDate: -7,
                </c:otherwise>
            </c:choose>
            onSelect: function(date, inst) {
                window.location = 'index.jsp?date='+date;
            }
        });
    });
</script>
