<%
            String base = request.getParameter("base");
            String token_hash = "" + System.currentTimeMillis();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<script type="text/javascript" src="<%= base%>flip/jornal/skins/static/js/jquery-1.5.2.min.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/static/js/jcarousellite_1.0.1.min.js?hs=<%= token_hash%>"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/static/js/jcalendar-source.js?hs=<%= token_hash%>"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/embed/modalbox/js/jquery.modalbox-1.2.0-min.js?hs=<%= token_hash%>"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/static/js/ddpowerzoomer.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/static/js/basic.js?hs=<%= token_hash%>"></script>
<link rel="stylesheet" href="<%= base%>flip/jornal/skins/static/css/jcalendar.css?hs=<%= token_hash%>">
<link rel="stylesheet" href="<%= base%>flip/jornal/skins/static/css/layout.css?hs=<%= token_hash%>">
<link href="<%= base%>flip/jornal/skins/embed/modalbox/css/jquery.modalbox.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%= base%>flip/jornal/skins/embed/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/embed/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/embed/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen" />
