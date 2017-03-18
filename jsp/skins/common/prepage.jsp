<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%

    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>

<c:set var="banner" value="${page.prepage}"/>

<c:if test="${!empty banner}">  
    <style type="text/css">
        #banner_prepage{
            position:absolute;
            z-index:9999;
            display:none;
            top:80px;
        }
    </style>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            addListener(checkPrepageBanner, 'UPDATE_PAGE');
            addListener(checkPrepageBanner, 'ZOOM_IN_PAGE');
            addListener(checkPrepageBanner, 'ZOOM_OUT_PAGE');
        });
        function checkPrepageBanner() {
            var page = getCurrentPage();
            if (page==1 && zoommode==false) {
                var left = Math.abs(jQuery(".magazine").css("left").replace("px", ""))/2;                
                var top=80;                
                if (jQuery("#facerecomenda") && jQuery("#facerecomenda").length>0) {
                    top=110;
                }                
                jQuery("#banner_prepage").css("top", top+"px").css("left", left);
                jQuery("#banner_prepage").show();
            } else {
                jQuery("#banner_prepage").hide();
            }
        }
    </script>
    <div id="banner_prepage">                                        
        <c:choose>
            <c:when test="${banner.flash}">
                <object type="application/x-shockwave-flash" data="<%= base%><c:out value="${banner.banner}"/>" width="<c:out value="${banner.width}"/>" height="<c:out value="${banner.height}"/>">
                <param name="movie" value="<%= base%><c:out value="${banner.banner}"/>" />
                <param name="loop" value="true" />
                </object>
            </c:when>
            <c:when test="${banner.adsense}">       
                <c:set var="TITLE_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" scope="session"/>
                <c:set var="DESCRIPTION_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.description}" scope="session"/>                            
                <c:set var="TEXT_PAGE" value="${page.textoPagina}" scope="session"/>
                <iframe src="<%= base%>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
            </c:when>                                       
            <c:when test="${banner.html5}">                           
                <c:out value="${banner.html}" escapeXml="false"/>
            </c:when>                                       
            <c:otherwise>
                <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                    <img src="<%= base%><c:out value='${banner.banner}'/>" border="0" alt="Publicidade" id="bannerlateralimg" title="Publicidade"/>
                </a>
            </c:otherwise>  
        </c:choose>
    </div>
</c:if>    