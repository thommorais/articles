<!DOCTYPE html>
<%@ page language="java" pageEncoding="iso-8859-1"%>
<%
    response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String head = "skins/html5/head.jsp";
    String body = "skins/html5/body.jsp";
    String link_edicao = base + request.getAttribute("edicao_dia");
    String edicaoId = "" + request.getAttribute("edicaoId");

%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<!doctype html>
<!--[if lt IE 7 ]> <html class="ie6"> <![endif]-->
<!--[if IE 7 ]>    <html  class="ie7"> <![endif]-->
<!--[if IE 8 ]>    <html  class="ie8"> <![endif]-->
<!--[if IE 9 ]>    <html  class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html  class="noie"> <!--<![endif]-->
    <head>
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - Edição <c:out value="${page.nrEdicao}"/> - Mavenflip </title>
    <meta name="description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.description}"/>" />
    <meta name="keywords" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>" />        
    <meta name="viewport" content="width = 1050, user-scalable = no" />
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

    <script type="text/javascript">
        var base='<%= base%>';
        var linkedicao='<c:out value="${edicao_dia}"/>';
        var acervo=<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisaHistorico}"/>;
        function getCurrentEdition(){
            return <c:out value="${page.id}"/>;
        }    
        function getCurrentEditionNumber() {
                return <c:out value = "${page.nrFixo}" /> ;
            }        
        var command='<c:out value="${param.command}"/>';
        var param='<c:out value="${param.param}"/>';
        var folder='<c:out value="${folder}"/>';        
        var keywords=<c:choose><c:when test='${!empty param.keywords}'>"<c:out value='${param.keywords}'/>";</c:when><c:otherwise>"<c:out value='${session.KEYWORD_SEARCH}'/>"</c:otherwise></c:choose>
            var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-31102692-1']);
        _gaq.push(['_trackPageview']);
        (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            //ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();    

        var ipg=null;
        <c:if test="${!empty param.ipg}">
        <%if (request.getParameter("ipg").startsWith("anch")) {%>
                                    ipg = '<c:out value="${param.ipg}"/>';
        <%} else {%>
                                    ipg = 'anch<c:out value="${param.ipg}"/>';
        <% }%>
        </c:if>

    </script>
    <jsp:include page="<%= head%>" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
    </jsp:include>              


</head>
<body>
    <jsp:include page="skins/common/topBanner.jsp" flush="true"/>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlTopo}" escapeXml="false"/>
<jsp:include page="<%= body%>" flush="true">
    <jsp:param name="base" value="<%= base%>"/>
    <jsp:param name="edicao" value="<%= edicaoId%>"/>
</jsp:include>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>

</body>
</html>