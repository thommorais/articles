<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<script type="text/javascript" src="<%= base%>flip/jornal/js/jquery.cycle.all.2.72.js"></script>
<c:if test="${!empty KEY_BANNER_TABLET_PORTRAIT_TOPO}">       
    <link rel="stylesheet" media="screen and (orientation:portrait) and (min-width: 481px)" href="<%= base%>flip/jornal/skins/common/css/bannerMobilePortrait.css"/>                
</c:if>
<c:if test="${!empty KEY_BANNER_TABLET_LANDSCAPE_TOPO}">   
    <link rel="stylesheet" media="screen and (orientation:landscape) and (min-width:640px)" href="<%= base%>flip/jornal/skins/common/css/bannerMobileLandscape.css"/>    
</c:if>    
<c:if test="${!empty KEY_BANNER_SMART_TOPO}">   
    <link rel="stylesheet" media="screen and (max-width: 481px)" href="<%= base%>flip/jornal/skins/common/css/bannerMobileSmart.css"/>    
</c:if>    

<c:if test="${!empty KEY_BANNER_TABLET_PORTRAIT_TOPO}">
    <c:set var="contador" value="0"/>
    <div id="s2bannerdiv_portrait_topo" >
        <c:forEach var="banner" items="${KEY_BANNER_TABLET_PORTRAIT_TOPO}">        
            <c:if test="${!banner.flash}">
                <div id="itemBanner">
                    <c:set var="contador" value="${contador+1}"/>
                    <c:choose>
                        <c:when test="${banner.imagem}">
                            <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                                <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" class="bannertopoimg_portrait_topo" title="Publicidade" align="center">
                            </a>
                        </c:when>
                        <c:when test="${banner.adsense}">                       
                            <c:set var="TITLE_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" scope="session"/>
                            <c:set var="DESCRIPTION_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.description}" scope="session"/>
                            <c:set var="TEXT_PAGE" value="${page.textoPagina}" scope="session"/>
                            <iframe class="adsensebanner" src="<%= base%>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
                        </c:when>
                        <c:when test="${banner.html5}">
                            <c:out value="${banner.html}" escapeXml="false"/>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>       
                </div>
            </c:if>
        </c:forEach>
    </div>
    <c:if test="${contador>1}">
        <script type="text/javascript">
            jQuery(document).ready(function(){
                jQuery('#s2bannerdiv_portrait_topo').cycle({
                    fx:      'scrollDown',
                    speed:    400,
                    timeout:  6000
                });        
            });
        </script>
    </c:if>
</c:if>


<c:if test="${!empty KEY_BANNER_TABLET_LANDSCAPE_TOPO}">
    <c:set var="contador" value="0"/>
    <div id="s2bannerdiv_landscape_topo" >
        <c:forEach var="banner" items="${KEY_BANNER_TABLET_LANDSCAPE_TOPO}">        
            <c:if test="${!banner.flash}">
                <div id="itemBanner">
                    <c:set var="contador" value="${contador+1}"/>
                    <c:choose>
                        <c:when test="${banner.imagem}">
                            <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                                <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" class="bannertopoimg_landscape_topo" title="Publicidade" align="center">
                            </a>
                        </c:when>
                        <c:when test="${banner.adsense}">                       
                            <c:set var="TITLE_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" scope="session"/>
                            <c:set var="DESCRIPTION_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.description}" scope="session"/>
                            <c:set var="TEXT_PAGE" value="${page.textoPagina}" scope="session"/>
                            <iframe class="adsensebanner" src="<%= base%>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
                        </c:when>
                        <c:when test="${banner.html5}">
                            <c:out value="${banner.html}" escapeXml="false"/>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>       
                </div>
            </c:if>
        </c:forEach>
    </div>
    <c:if test="${contador>1}">
        <script type="text/javascript">
            jQuery(document).ready(function(){
                jQuery('#s2bannerdiv_landscape_topo').cycle({
                    fx:      'scrollDown',
                    speed:    400,
                    timeout:  6000
                });        
            });
        </script>
    </c:if>
</c:if>        


<c:if test="${!empty KEY_BANNER_SMART_TOPO}">
    <c:set var="contador" value="0"/>
    <div id="s2bannerdiv_topo_smart" >
        <c:forEach var="banner" items="${KEY_BANNER_SMART_TOPO}">        
            <c:if test="${!banner.flash}">
                <div id="itemBanner">
                    <c:set var="contador" value="${contador+1}"/>
                    <c:choose>
                        <c:when test="${banner.imagem}">
                            <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                                <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" class="bannertopoimg_topo_smart" title="Publicidade" align="center">
                            </a>
                        </c:when>
                        <c:when test="${banner.adsense}">                       
                            <c:set var="TITLE_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" scope="session"/>
                            <c:set var="DESCRIPTION_PAGE" value="${page.flipModeloPublicacaoidid_modelo.prefs.description}" scope="session"/>
                            <c:set var="TEXT_PAGE" value="${page.textoPagina}" scope="session"/>
                            <iframe class="adsensebanner" src="<%= base%>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
                        </c:when>
                        <c:when test="${banner.html5}">
                            <c:out value="${banner.html}" escapeXml="false"/>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>       
                </div>
            </c:if>
        </c:forEach>
    </div>
    <c:if test="${contador>1}">
        <script type="text/javascript">
            jQuery(document).ready(function(){
                jQuery('#s2bannerdiv_topo_smart').cycle({
                    fx:      'scrollDown',
                    speed:    400,
                    timeout:  6000
                });        
            });
        </script>
    </c:if>
</c:if>                