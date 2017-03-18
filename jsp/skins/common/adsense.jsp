<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><c:out value="${TITLE_PAGE}"/></title>        
        <meta name="description" content="<c:out value="${DESCRIPTION_PAGE}"/>" />
    </head>
    <body style="margin: 0px; padding: 0px;">
        <div style="display:none"><c:out value="${TEXT_PAGE}"/></div>
        <form name="form1" method="post" action="<%= base%>flip/jornal/skins/commons/adsense.jsp?ads=<c:out value="${param.ads}"/>&amp;slot=<c:out value="${param.ads}"/>">    
            <div id="anuncio">
                <script type='text/javascript'>
                    (function() {
                        var useSSL = 'https:' == document.location.protocol;
                        var src = (useSSL ? 'https:' : 'http:') +
                            '//www.googletagservices.com/tag/js/gpt.js';
                        document.write('<scr' + 'ipt src="' + src + '"></scr' + 'ipt>');
                    })();
                </script>

                <script type='text/javascript'>
                    googletag.defineSlot('<c:out value='${param.slot}'/>', [<c:out value='${param.w}'/>, <c:out value='${param.h}'/>], '<c:out value='${param.ads}'/>').addService(googletag.pubads());
                    googletag.pubads().enableSyncRendering();
                    googletag.pubads().enableSingleRequest();
                    googletag.enableServices();
                </script>

                <!-- flip_teste_160x600 -->
                <div id='div-gpt-ad-1379362479155-0' style='width:<c:out value='${param.w}'/>px; height:<c:out value='${param.h}'/>px;'>
                    <script type='text/javascript'>
                        googletag.display('<c:out value='${param.ads}'/>');
                    </script>
                </div>

            </div>
        </form>
    </body>
</html>