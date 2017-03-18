<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String skin = request.getAttribute("skin").toString();
            if (skin == null || skin.trim().length() <= 0) {
                skin = "default";
            }

            String head = "skins/acessibilidade/head.jsp";
            String body = "skins/acessibilidade/body.jsp";
            String iconBase = "skins/acessibilidade/icones_base.jsp";
            String link_edicao = base + request.getAttribute("edicao_dia");
            String edicaoId = "" + request.getAttribute("edicaoId");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip </title>        
        <meta http-equiv="P3P" content="CP='CAO PSA OUR'"/>
        <meta http-equiv="expires" content="Fri, 1 Jan 1990 00:00:00 GMT"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate"/>
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <meta name="revisit-after" content="1 days" />
        <meta name="resource-type" content="document" />
        <meta name="revisit" content="1 days" />
        <meta name="rating" content="General" />
        <meta name="robots" content="ALL" />
        <meta name="author" content="www.mavenapp.com.br" />
        <meta name="description" content="Mavenflip - Publicações digitais - Sistema para criar revistas e jornais em formato de flip" />
        <meta name="keywords" content="revista digital, folheando revista, jornal digital, jornal virtual, documentos eletrônicos, revista em flash, papel virtual, mavenflip, banca virtual" />
        <script type="text/javascript">
            var base='<%= base%>';            
            var folder='<c:out value="${folder}"/>';
            var linkedicao='<c:out value="${edicao_dia}"/>';
            var page=1;
            var total=<c:out value="${page.paginas}"/>;
            function getCurrentEdition(){
                return <c:out value="${page.id}"/>;
            }
            function getCurrentPage(){
                return page;
            }
            var _gaq = _gaq || [];
            <c:if test = "${!page.flipModeloPublicacaoidid_modelo.prefs.analytics}" >
            _gaq.push([gaPrefix+'_setAccount', 'UA-31102692-1']);
            _gaq.push([gaPrefix+'_trackPageview'], '/' + linkedicao + 'edicao=' + getCurrentEdition());
            (function() {
            var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);
                })();
            </c:if>   
    
        </script>
        <jsp:include page="<%= head%>" flush="true">
            <jsp:param name="base" value="<%= base%>"/>
        </jsp:include>
    </head>
    <body >
        <jsp:include page="<%= body%>" flush="true">
            <jsp:param name="base" value="<%= base%>"/>
            <jsp:param name="edicao" value="<%= edicaoId%>"/>
        </jsp:include>
    </body>

</html>
