<%
            String base = request.getParameter("base");
            String token_hash = "" + System.currentTimeMillis();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/prototype.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/scriptaculous.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/basic.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/modalbox.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/printPDF.js"  ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/validation.js"  ></script>
<link href="<%= base%>flip/jornal/css/layout.css?1=2" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/boxes.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/caderno_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/modalbox.css" rel="stylesheet" type="text/css" media="screen"/>
<!--[if lt IE 7]>
<script defer type="text/javascript" src="<%= base%>flip/jornal/js/pngfix.js"  ></script>
<![endif]-->
<link href="<%= base%>flip/jornal/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlHead}" escapeXml="false"/>