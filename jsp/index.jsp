<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String skin = request.getAttribute("skin").toString();
            if (skin == null || skin.trim().length() <= 0) {
                skin = "default";
            }

            String head = "skins/" + skin + "/head.jsp";
            String body = "skins/" + skin + "/body.jsp";
            String iconBase = "skins/" + skin + "/icones_base.jsp";
            String link_edicao = base + request.getAttribute("edicao_dia");
            String edicaoId = "" + request.getAttribute("edicaoId");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip </title>        
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <meta name="revisit-after" content="1 days" />
        <meta name="resource-type" content="document" />
        <meta name="revisit" content="1 days" />
        <meta name="rating" content="General" />
        <meta name="robots" content="ALL" />
        <meta name="author" content="www.mavenflip.com.br" />
        <meta name="description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.description}"/>" />
            <meta name="keywords" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>" />
                <meta name="og:title" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip"/>                
                      <meta name="og:type" content="website"/>
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                        <meta name="og:image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"/>
                    </c:if>
                    <script type="text/javascript" src="<%= base%>flip/jornal/js/flipsite.js?1=3" charset="utf-8"></script>
                    <script type="text/javascript">
                        var base='<%= base%>';
                        var online=<c:out value="${empty offline || offline eq 'false' || !empty logado}"/>;
                        var folder='<c:out value="${folder}"/>';
                        var flashbased=<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash}"/>;
                        var sumarioFotos='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>';
                        var zoomBlocked=<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.bloquearZoomNaoAssinantes}"/>;
                        var linkedicao='<c:out value="${edicao_dia}"/>';
                        var keywords="<c:out value='${param.keywords}'/>";

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
                    <script type="text/javascript" src="<%= base%>flip/jornal/swfobject/swfobject.js"  ></script>
                    <script type="text/javascript" src="<%= base%>flip/jornal/player/mavenflip.js"></script>
                    <c:if test="${page.encarte}">
                        <script type="text/javascript" src="<%= base%>flip/jornal/js/jquery.min.js"></script>
                        <script type="text/javascript"> jQuery.noConflict();</script>
                        <script type="text/javascript" src="<%= base%>flip/jornal/js/popup.js"></script>
                        <link href="<%= base%>flip/jornal/css/popup.css" rel="stylesheet" type="text/css" media="screen" />
                    </c:if>

                    <jsp:include page="<%= head %>" flush="true">
                        <jsp:param name="base" value="<%= base %>"/>
                    </jsp:include>
                    </head>
                    <body oncontextmenu="return false" id="pageDiv" >

                        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlTopo}" escapeXml="false"/>
                        
                        <jsp:include page="skins/common/topBanner.jsp" flush="true"/>

                        <jsp:include page="<%= body %>" flush="true">
                            <jsp:param name="base" value="<%= base %>"/>
                            <jsp:param name="edicao" value="<%= edicaoId %>"/>
                        </jsp:include>

                        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.rodape || page.flipModeloPublicacaoidid_modelo.prefs.facebook || page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete || page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                            <link href="<%= base%>flip/jornal/skins/common/css/rodape.css" rel="stylesheet" type="text/css" media="screen"/>
                            <style type="text/css">
                                .rodape_baixo{
                                    <c:choose>
                                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.backgroundBase eq 'transparent'}">
                                        background-color:transparent;
                                    </c:when>
                                        <c:otherwise>
                                        background-color:#<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.backgroundBase}"/>;
                                    </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Base'}">
                                        height:50px;
                                    </c:when>
                                        <c:otherwise>
                                        height:30px;
                                    </c:otherwise>
                                        </c:choose>
                                        overflow:hidden;                
                                }
                            </style>
                            <div class="rodape_baixo" id="rodape_baixo_id">

                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">
                                    <link href="<%= base%>flip/jornal/skins/common/css/share.css" rel="stylesheet" type="text/css" media="screen"/>
                                    <c:set var="titulo" value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" scope="request"/>
                                    <%
                                String titulo_string = (String) request.getAttribute("titulo");
                                    %>
                                    <jsp:include page="skins/common/facebook.jsp" flush="true">
                                        <jsp:param name="base" value="<%= link_edicao %>"/>
                                        <jsp:param name="titulo" value="<%= titulo_string %>"/>
                                    </jsp:include>
                                </c:if>
                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                                    <div style='float: left; margin: 5px 2px 10px 10px'>
                                        <a href="javascript:showComments();" title="Veja os comentários e comente também!">
                                            <span id="comment_count">
                                                Nenhum comentário
                                            </span>
                                        </a>
                                    </div>
                                </c:if>


                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete}">
                                    <jsp:include page="skins/common/enquete.jsp" flush="true">
                                        <jsp:param name="base" value="<%= base %>"/>
                                        <jsp:param name="edicao" value="<%= edicaoId %>"/>
                                    </jsp:include>
                                </c:if>

                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas}">
                                    <c:choose>
                                        <c:when test="${page.visitas > 1}">
                                            <c:out value="${page.visitas}"/> pessoas visitaram essa edição
                                        </c:when>
                                        <c:otherwise>
                                            Você é a segunda pessoa a ler essa edição!
                                        </c:otherwise>
                                    </c:choose>
                                    <br/>
                                </c:if>
                                <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.rodape}"/>

                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Base'}">

                                    <jsp:include page="<%= iconBase %>" flush="true">
                                        <jsp:param name="base" value="<%= base %>"/>
                                        <jsp:param name="edicao" value="<%= edicaoId %>"/>
                                        <jsp:param name="width" value="35"/>
                                    </jsp:include>
                                </c:if>
                            </div>
                            <script type="text/javascript">
                                    <c:choose>
                                    <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.posicaoBotoes eq 'Base'}">
                                    var rodape_height=50;
                                    </c:when>
                                    <c:otherwise>
                                    var rodape_height=30;
                                    </c:otherwise>
                                    </c:choose>
                                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                                    var COMMENT_TYPE='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';
                                    </c:if>
                            </script>
                            <script type="text/javascript" src="<%= base%>flip/jornal/skins/common/js/rodape.js" charset="utf-8"></script>
                            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
                                <script type="text/javascript" src="<%= base%>flip/jornal/js/comments.js" charset="utf-8"></script>
                            </c:if>

                        </c:if>
                        <c:if test="${page.encarte}">

                            <jsp:include page="skins/common/encarte.jsp" flush="true">
                                <jsp:param name="base" value="<%= base %>"/>
                            </jsp:include>
                        </c:if>

                        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>

                    </body>

                    </html>
