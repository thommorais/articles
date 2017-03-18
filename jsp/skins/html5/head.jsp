<%
            String base = request.getParameter("base");
            String token_hash = ""; //
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<script type="text/javascript" src="<%= base%>flip/jornal/swfobject/swfobject.js?1=1"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/player/mavenflip.js?1=1"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/html5/extras/modernizr.2.5.3.min.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/html5/extras/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/html5/lib/hash.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/html5/js/magazine.js?token=<%= token_hash%>"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/king/modalbox/js/jquery.modalbox-1.2.0-min.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/jquery-ui-1.8.23.custom.min.js" ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/html5/js/wrapper.js?token=<%= token_hash%>"></script>
<link href="<%= base%>flip/jornal/skins/king/css/template.css?tok=<%= token_hash%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/king/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link type="text/css" rel="stylesheet" href="<%= base%>flip/jornal/skins/html5/css/magazine.css"/>
<link type="text/css" rel="stylesheet" href="<%= base%>flip/jornal/skins/html5/css/layout.css?1=1"/>
<link href="<%= base%>flip/jornal/skins/king/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/king/modalbox/css/jquery.modalbox.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%= base%>flip/jornal/skins/king/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" type="text/css" media="screen" />

