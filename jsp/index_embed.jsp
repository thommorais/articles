<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
    response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String head = "skins/embed/head.jsp";
    String body = "skins/embed/body.jsp";
    String link_edicao = base + request.getAttribute("edicao_dia");
    String edicaoId = "" + request.getAttribute("edicaoId");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
        <meta name="author" content="www.mavenflip.com.br" />        
        <meta name="description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.description}"/>">
            <meta name="keywords" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>">
                <meta name="og:title" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip">                
                      <meta name="og:type" content="website">
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                        <meta name="og:image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>">
                    </c:if>            
                    <script type="text/javascript">
                        var base='<%= base%>';
                        var online=<c:out value="${empty offline || offline eq 'false' || !empty logado}"/>;
                        var folder='<c:out value="${folder}"/>';
                        var sumarioFotos='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>';
                        var zoomBlocked=<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.bloquearZoomNaoAssinantes}"/>;
                        var linkedicao='<c:out value="${edicao_dia}"/>';

                            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}">
                            <c:forEach var="item" items="${page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}" varStatus="i">
                            freePagesList[<c:out value="${i.index}"/>]='<c:out value="${item}"/>';
                            </c:forEach>
                            </c:if>
                            var ipg=null;
                            <c:if test="${!empty param.ipg}">
                        <%if (request.getParameter("ipg").startsWith("anch")) {%>
                            ipg = '<c:out value="${param.ipg}"/>';
                        <%} else {%>
                            ipg = 'anch<c:out value="${param.ipg}"/>';
                        <% }%>
                                </c:if>

                            function getCurrentEdition(){
                                return <c:out value="${page.id}"/>;
                            }
                            function getCurrentEditionNumber() {
                                return <c:out value = "${page.nrFixo}" /> ;
                            } 
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
                    <script type="text/javascript" src="<%= base%>flip/jornal/swfobject/swfobject.js"></script>
                    <script type="text/javascript" src="<%= base%>flip/jornal/player/mavenflip.js"></script>
                    <c:if test="${page.encarte}">
                        <script type="text/javascript"> jQuery.noConflict();</script>
                        <script type="text/javascript" src="<%= base%>flip/jornal/js/popup.js"></script>
                        <link href="<%= base%>flip/jornal/css/popup.css" rel="stylesheet" type="text/css" media="screen" />
                    </c:if>

                    <jsp:include page="<%= head%>" flush="true">
                        <jsp:param name="base" value="<%= base%>"/>
                    </jsp:include>
                    </head>
                    <body oncontextmenu="return false" id="pageDiv" >
                        <jsp:include page="skins/common/topBanner.jsp" flush="true"/>
                        <jsp:include page="<%= body%>" flush="true">
                            <jsp:param name="base" value="<%= base%>"/>
                            <jsp:param name="edicao" value="<%= edicaoId%>"/>
                        </jsp:include>
                        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>
                    </body>
                    </html>
