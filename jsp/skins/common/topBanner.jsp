<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);  
%>
<c:if test="${!empty KEY_BANNER_SUPER}">   
    <style type="text/css">
        #s2bannerdiv{            
            clear:both;                        
            max-height:90px;
            min-height:90px;
            text-align: center;    
            vertical-align: middle;
            overflow:hidden;                        
            margin: 0 auto;               
            width:100%;
        }  
        .bannertopoimg{
            max-height: 90px;                
            display:block;
            margin-left: auto;
            margin-right: auto;   
            vertical-align: middle;
        }
        #jornal{
            height:80%;
        }        
        #s2bannerdiv2{
            width:50%;
            margin:0 auto;
        }
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao eq 'modern'||page.flipModeloPublicacaoidid_modelo.prefs.corPadrao eq 'modern_blue'}">
        #tab_left{
            top: 65%;        
            transform: translate(0%,-53%);        
            -webkit-transform: translate(0%, -53%);
            z-index:9999;
            _top: 170px;
            *top: 170px;
        }
        </c:if>
    </style>
    <c:set var="contador" value="0"/>
    <div id="s2bannerdiv" >
        <div id="s2bannerdiv2">
            <div id="s2bannerdivinterno">
                <c:forEach var="banner" items="${KEY_BANNER_SUPER}">        
                    <div id="itemBanner">
                        <c:set var="contador" value="${contador+1}"/>
                        <c:choose>
                            <c:when test="${banner.imagem}">
                                <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                                    <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" class="bannertopoimg" title="Publicidade" align="center">
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
                                <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"  id="banner_topo1" align=""  width="728" height="90" >
                                    <param name=movie value="<%= base%><c:out value='${banner.banner}'/>">
                                    <param name=menu value=false>
                                    <param name=quality value=high>
                                    <param name=bgcolor value=#ffffff>
                                    <embed src="<%= base%><c:out value="${banner.banner}"/>" menu=false quality=high bgcolor=#ffffff" align="" width="728" height="90" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>
                                </object>
                            </c:otherwise>
                        </c:choose>       
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <c:if test="${contador>1}">
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/js/jquery.cycle.all.2.72.js"></script>                                
        <script type="text/javascript">
            jQuery(document).ready(function () {
                jQuery('#s2bannerdivinterno').cycle({
                    fx: 'scrollDown',
                    speed: 400,
                    timeout: 6000
                });
            });
        </script>
    </c:if>
</c:if>