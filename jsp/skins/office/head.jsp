<%
            String base = request.getParameter("base");
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<link href="<%= base%>flip/jornal/css/boxes.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/caderno_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/office/css/layout.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/office/css/layout_dinamic.jsp" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/office/css/menu.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/modalbox.css" rel="stylesheet" type="text/css" media="screen"/>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/prototype.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/scriptaculous.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/basic.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/modalbox.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/printPDF.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/validation.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/web/js/cropper/cropper.js?cacheBust=1.2.0" ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/office/js/cropper.js" ></script>
<!--[if lt IE 7]>
<script defer type="text/javascript" src="<%= base%>flip/jornal/js/pngfix.js"  ></script>
<![endif]-->