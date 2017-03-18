<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-bean-el" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html" prefix="html"%>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>
            <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
        <meta http-equiv="expires" content="Fri, 1 Jan 1990 00:00:00 GMT"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <meta name="revisit-after" content="5 days" />
        <meta name="resource-type" content="document" />
        <meta name="revisit" content="5 days" />
        <meta name="rating" content="General" />
        <meta name="robots" content="ALL" />
        <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate"/>
        <meta name="Description" content="Folheando revistas e publicações na internet - Mais completa plataforma multimídia interativa que combina a única experiência de folhear uma revista." />
        <meta name="Keywords" content="pageflip, revista digital, folheando revista, jornal digital, jornal virtual, documentos eletrônicos, revista em flash, papel virtual" />
        <link href="<%= base%>flip/jornal/css/layout.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%= base%>flip/jornal/js/jquery.js" charset="utf-8"></script>
        <script type="text/javascript">
            if ($.browser.mozilla) {
                $(document).keypress(trata);
            } else {
                $(document).keydown(trata);
            }
            function trata(e) {
                var charCode = (e.which) ? e.which : window.event.keyCode;                
                if (charCode===115||charCode===83) {                    
                    $('#formulario').submit();
                } else {
                    if (charCode!=9) {
                        $('#auth').val('NOAUTH');
                        $('#skin').val("");
                        $('#formulario').submit();
                        $('#corpo').html("<h1 align='center'> Aguarde, carregando ... </h1>");
                    }
                }
            }
        </script>
    </head>
    <body >
        <div id="top">
            <div id="logocliente">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                        <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
                    </c:if>
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="Clique para visitar o site" height="40px"/>
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                        </a>
                    </c:if>
                </c:if>
            </div>
        </div>
        <div id="corpo">

            <div style="margin-top:200px">
                <h1 align="center"> Deseja acessar a revista como TXT ou Flash? </h1>
                <br/>
                <h2 align="center"> Pressione a tecla <font color="blue">S</font> para TXT, ou qualquer outra tecla para FLASH. </h2>

            </div>

            <form action="<%= base%>flip/showEdicao.do" method="post" id="formulario">
                <input type="hidden" name="hash" value="<c:out value="${hash}"/>"/>
                <input type="hidden" name="folder" value="<c:out value="${folder}"/>"/>
                <input type="hidden" name="edicao" value="<c:out value="${page.id}"/>"/>
                <input type="hidden" name="modelo" value="<c:out value="${modelo}"/>"/>
                <input type="hidden" name="auth" value="AUTH" id="auth"/>
                <input type="hidden" name="skin" value="acessibilidade" id="skin"/>
            </form>

        </div>
    </body>
</html>