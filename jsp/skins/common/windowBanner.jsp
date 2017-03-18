<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<c:if test="${!empty KEY_BANNER_JANELA}">
    <script type="text/javascript" src="<%= base%>flip/jornal/skins/common/js/banner.js" ></script>
    <link href="<%= base%>flip/jornal/skins/common/css/banner.css?1=1" rel="stylesheet" type="text/css" media="screen"/>

    <c:forEach var="banner" items="${KEY_BANNER_JANELA}" varStatus="i">
        <style type="text/css">
            #layer<c:out value='${i.index}'/>_popup {
                width: <c:out value="${banner.width}"/>px;
                height: <c:out value="${banner.height}"/>px;
            }
        </style>

        <div id="layer<c:out value='${i.index}'/>_popup" class="layerpopup">
            <span id="close_popup" style="width:50px">
                <a href="javascript:setVisible('layer<c:out value='${i.index}'/>_popup');" style="text-decoration: none">
                        <img src="<%= base%>flip/jornal/images/close2.png" style="width: 25px; height: 25px; margin-right: 4px; margin-top: 4px;"/>
                </a>
            </span>
            <c:choose>
                <c:when test="${banner.flash}">
                    <object type="application/x-shockwave-flash" data="<%= base%><c:out value="${banner.banner}"/>" width="<c:out value="${banner.width}"/>" height="<c:out value="${banner.height}"/>">
                        <param name="movie" value="<%= base%><c:out value="${banner.banner}"/>" />
                    </object>
                </c:when>
                <c:when test="${banner.adsense}">  
                    <c:set var="TITLE_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" scope="session"/>
                    <c:set var="DESCRIPTION_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.description}" scope="session"/>                    
                    <c:set var="TEXT_PAGE" value="${page.textoPagina}" scope="session"/>
                    <iframe id="adsensewindow" class="adsensebanner" src="<%= base%>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
                </c:when>
                <c:when test="${banner.html5}">
                    <c:out value="${banner.html}" escapeXml="false"/>
                </c:when>                    
                <c:otherwise>
                    <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if>>
                        <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade"/>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
        <script type="text/javascript" for="window" event="onload">
            setVisible('layer<c:out value='${i.index}'/>_popup',true);
        </script>
    </c:forEach>
</c:if>