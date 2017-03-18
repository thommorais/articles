<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<c:if test="${!empty KEY_BANNER_LATERAL}">
    <script type='text/javascript'>             
              var maxwidth=150;
                var paddingbanner=0;
            var paddingbannertop=10;
        </script>
    <script type="text/javascript" src="<%= base%>flip/jornal/skins/common/js/banner.js?hs=<%=System.currentTimeMillis() %>"  ></script>    
    <link href="<%= base%>flip/jornal/skins/common/css/banner.css?1=2" rel="stylesheet" type="text/css" media="screen"/>
    
    <c:if test="${ (!empty page.prepage.id && page.prepage.id > 0) || (!empty page.postpage.id && page.postpage.id>0) }">
        <style type="text/css">            
            #banner_lateral img,#banner_lateral_esquerda img{                         
                clear:both;
                margin-bottom:4px;
                z-index:9999;
            }            
        </style>
    </c:if>   
    <c:set var="temDireitos" value="false"/>
    <c:set var="temEsquerdos" value="false"/>
    <c:forEach var="banner" items="${KEY_BANNER_LATERAL}">        
        <c:if test="${banner.lado eq 'E' && banner.lateral}">
            <c:set var="temEsquerdos" value="true"/>
        </c:if>
        <c:if test="${banner.lado eq 'D' && banner.lateral}">
            <c:set var="temDireitos" value="true"/>
        </c:if>           
    </c:forEach>    

    <c:if test="${temDireitos eq 'true'}">           
        <div id="banner_lateral" style="display:none">
            <c:set var="escondeCapa" value="true"/>
            <c:forEach var="banner" items="${KEY_BANNER_LATERAL}">
                <c:if test="${banner.lado eq 'D'  && banner.lateral}">
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
                            <iframe src="<%= base %>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
                        </c:when>                                       
                        <c:when test="${banner.html5}">

<style type="text/css">            
            <c:if test="${banner.lado eq 'D'}">
		#banner_lateral img{
			max-height:auto;
		}
	    </c:if>
 <c:if test="${banner.lado eq 'E'}">
		#banner_lateral_esquerda img{
			max-height:auto;
		}
	    </c:if>
</style>
    
                            <c:out value="${banner.html}" escapeXml="false"/>
                        </c:when>                                       
                        <c:otherwise>

<style type="text/css">            
            <c:if test="${banner.lado eq 'D'}">
		#banner_lateral img{
			max-height:520px;
		}
	    </c:if>
 <c:if test="${banner.lado eq 'E'}">
		#banner_lateral_esquerda img{
			max-height:520px;
		}
	    </c:if>
</style>

                            <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                                <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" id="bannerlateralimg" title="Publicidade"/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${!banner.escondeCapa}">
                        <c:set var="escondeCapa" value="false"/>
                    </c:if>
                    <br/>   
                </c:if>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${temEsquerdos eq 'true'}">           
        <div id="banner_lateral_esquerda" style="display:none">
            <c:set var="escondeCapa" value="true"/>
            <c:forEach var="banner" items="${KEY_BANNER_LATERAL}">
                <c:if test="${banner.lado eq 'E'  && banner.lateral}">
                    <c:choose>
                        <c:when test="${banner.flash}">
                            <object type="application/x-shockwave-flash" data="<%= base%><c:out value="${banner.banner}"/>" width="<c:out value="${banner.width}"/>" height="<c:out value="${banner.height}"/>">
                                <param name="movie" value="<%= base%><c:out value="${banner.banner}"/>" />
                                       <param name="loop" value="true" />
                            </object>
                        </c:when>
                        <c:when test="${banner.adsense}">                       
                            <iframe class="adsensebanner" src="<%= base%>flip/jornal/skins/common/adsense.jsp?ads=<c:out value='${banner.googleAds}'/>&slot=<c:out value='${banner.googleSlot}'/>&w=<c:out value='${banner.width}'/>&h=<c:out value='${banner.height}'/>" frameborder="0" height="<c:out value='${banner.height}'/>px" width="<c:out value='${banner.width}'/>px" style="border-width: 0px;" allowtransparency="true"></iframe>                    
                        </c:when>                                       
                        <c:when test="${banner.html5}">
                            <c:out value="${banner.html}" escapeXml="false"/>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:out value='${banner.linkPublico}'/>" <c:if test="${!banner.pagina}">target="_blank"</c:if> title="Publicidade">
                                <img src="<%= base%><c:out value="${banner.banner}"/>" border="0" alt="Publicidade" id="bannerlateralimg" title="Publicidade"/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${!banner.escondeCapa}">
                        <c:set var="escondeCapa" value="false"/>
                    </c:if>
                    <br/>   
                </c:if>
            </c:forEach>
        </div>
    </c:if>

    <script type="text/javascript">        
        esconderForaDaCapa="<c:out value='${escondeCapa}'/>";   
        jQuery(document).ready(function(){       
            <c:if test="${!empty page.prepage.id || !empty page.postpage.id}">
            if(window.document.body.clientWidth<=1024){
            maxwidth=95;
        }else{
            maxwidth=150;
        }
            </c:if>          
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado}">
            paddingbanner=50;
            </c:if>
            <c:if test="${!empty KEY_BANNER_SUPER}"> 
            paddingbannertop=paddingbannertop+70;
            </c:if>
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.htmlTopo}">
            paddingbannertop=paddingbannertop+30;
            maxwidth=200;
            <c:if test="${!empty KEY_BANNER_SUPER}"> 
            paddingbannertop=paddingbannertop+30;
            </c:if>
            </c:if>
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao eq 'modern'||page.flipModeloPublicacaoidid_modelo.prefs.corPadrao eq 'modern_blue'}">
    paddingbannertop=paddingbannertop+35;
    </c:if>
    
       
        showBannerLateral();
    });
    </script>
</c:if>