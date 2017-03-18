<%
            String base = request.getParameter("base");
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/datetheme/js/jquery.min.js"  ></script>
<script type="text/javascript"> jQuery.noConflict();</script>
<link href="<%= base%>flip/jornal/css/boxes.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/caderno_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/modalbox.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/layout.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/layout_dinamic.jsp" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/clean/css/layout.css" rel="stylesheet" type="text/css" media="screen"/>

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
        jQuery("#menu_side").mouseover(function(){
            jQuery("#expand_img").hide();
            jQuery("#itens_menu").show();
            jQuery("#menu_side").animate(
            {
                width:"200px"
            },
            { queue:false, duration:300 } );            
        }
    );

        jQuery("#menu_side").mouseout(function(){
            jQuery("#expand_img").show();
            jQuery("#itens_menu").hide();
            jQuery("#menu_side").animate(
            {
                width:"13px"
            },
            { queue:false, duration:300 } );
        });
    });

</script>
