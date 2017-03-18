<!DOCTYPE html>
<%@ page language="java" pageEncoding="iso-8859-1"%>
<%
    response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String head = "skins/static/head.jsp";
    String body = "skins/static/body.jsp";
    String link_edicao = base + request.getAttribute("edicao_dia");
    String edicaoId = "" + request.getAttribute("edicaoId");

%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<html>
    <head>
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - Edição <c:out value="${page.nrEdicao}"/> - Mavenflip </title>
    <meta name="description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.description}"/>" />
    <meta name="keywords" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>" />        
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Cache-control" content="no-cache, must-revalidate"/>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <meta name="author" content="www.mavenflip.com.br" />        
    <meta name="description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.description}"/>" />
    <meta name="og:description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>"/>
          <meta name="keywords" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>" />
    <meta name="og:title" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>"/>                
          <meta name="og:type" content="website"/>
    <meta name="og:image" content="<%= base%><c:out value="${page.img}"/>"/>

          <jsp:include page="<%= head%>" flush="true">
              <jsp:param name="base" value="<%= base%>"/>
          </jsp:include>        
    <script type="text/javascript">
        var base='<%= base%>';
        var linkedicao='<c:out value="${edicao_dia}"/>';
        function getCurrentEdition(){
            return <c:out value="${page.id}"/>;
        }
        var dIndex=<c:out value="${page.day}"/>;
        var mIndex=<c:out value="${page.month+1}"/>;
        var yIndex=<c:out value="${page.year}"/>;
        
        var index=0,indexlinks=0,indexvideos=0;        
        var pflinks = new Array();
        var folder='<c:out value="${folder}"/>';
        var pfvideos = new Array();
            <c:forEach var="pag" items="${paginaslist}" varStatus="i">                
            <c:if test="${!empty pag.links}"><c:forEach var="link" items="${pag.links}"><c:if test="${!link.anchor}">
            pflinks[indexlinks++]=["<c:out value='${pag.ordem}'/>","<c:out value="${link.x}"/>","<c:out value="${link.y}"/>","<c:out value="${link.width}"/>","<c:out value="${link.height}"/>","<c:out value="${link.link}"/>"];
            </c:if></c:forEach></c:if><c:if test="${!empty pag.videos}">
            <c:forEach var="link" items="${pag.videos}"><c:if test="${link.MP4}">
            pfvideos[indexvideos++]=["<c:out value='${pag.ordem}'/>","<c:out value="${link.x}"/>","<c:out value="${link.y}"/>","<c:out value="${link.width}"/>","<c:out value="${link.height}"/>","<c:out value="${link.video.video}"/>"];
            </c:if></c:forEach></c:if>
            </c:forEach>
            var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-31102692-1']);
        _gaq.push(['_trackPageview']);

        (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            //ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();            
    </script>

</head>
<body>
    <jsp:include page="skins/common/topBanner.jsp" flush="true"/>
    <jsp:include page="<%= body%>" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
        <jsp:param name="edicao" value="<%= edicaoId%>"/>
    </jsp:include>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>

</body>
</html>