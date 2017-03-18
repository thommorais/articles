<%
            String base = request.getParameter("base");
            String token_hash=""+System.currentTimeMillis();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<script type="text/javascript" src="<%= base%>flip/jornal/js/jquery.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/acessibilidade.js?tok=<%= token_hash %>" charset="iso-8859-1"></script>
<link href="<%= base%>flip/jornal/css/layout.css?tok=<%= token_hash %>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/layout_dinamic.jsp?tok=<%= token_hash %>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/acessibilidade.css?tok=<%= token_hash %>" rel="stylesheet" type="text/css" media="screen"/>
<!--[if lt IE 7]>
<script defer type="text/javascript" src="<%= base%>flip/jornal/js/pngfix.js"  ></script>
<![endif]-->