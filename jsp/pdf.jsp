<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="iso-8859-1"%>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - Mavenflipdf</title>
        <meta name="viewport" content="width=device-width, maximum-scale=5.0, minimum-scale=0.25,user-scalable=yes" />
        <script type="text/javascript">
            var base='<%= base%>';
            function getCurrentEdition(){
                return <c:out value="${page.id}"/>;
            }
        </script>
        <link rel="stylesheet" media="all" href="<%= base%>flip/jornal/skins/mobile/css/generic.css"/>
        <link rel="stylesheet" media="all and (orientation:landscape)" href="<%= base%>flip/jornal/skins/mobile/css/landscape.css"/>
        <link rel="stylesheet" media="all and (orientation:portrait)" href="<%= base%>flip/jornal/skins/mobile/css/portrait.css"/>
        <style type="text/css">
            body{
                background: #<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.background}"/> <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.backgroundImageCss && 'NULO' ne page.flipModeloPublicacaoidid_modelo.prefs.backgroundImageCss}">url(<%= base%><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.backgroundImageCss}"/>) repeat fixed</c:if>;
                font-family:<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.fonte}"/>;
                color: #<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.dataColorCorpo}"/>;
            }
        </style>
    </head>
    <body>
        <center>
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                    <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
                    </c:if>
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="Clique para visitar o site" height="40px" align="middle" border="0"/>
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                    </a>
                </c:if>
            </c:if>
            <br/><br/>
        </center>
        <br/>
        <center><strong> <font color="white">Páginas da edição <c:out value="${page.nrFixo}"/> de <c:out value="${page.dataPub_date}"/></font></strong></center>
        <table bgcolor="white" cellpadding="5px" cellspacing="5px" align="center">
            <tbody>
            <c:forEach var="pag" items="${paginas}" varStatus="i">
                <c:if test="${i.index==0}"><tr></c:if>
                <c:if test="${i.index != 0 && i.index % 3 == 0}"></tr><tr></c:if>
                    <td>
                        <img src="<%= base%><c:out value='${pag.pathThumb}'/>" border="1"/>
                    </td>
                    <td align="center">
                        <a href="<%= base %><c:out value="${pag.pdfPath}"/>">
                            Download página <c:out value="${pag.ordem}"/>
                        </a>
                    </td>                   
            </c:forEach>
                    </tr>
            </tbody>
            </table>
    </body>
</html>