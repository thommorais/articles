<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>


<div class='modalboxheader'><fmt:message key='site.comentar'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    

<div id="box650_440">
    <br/>
    <h2 align="center"  class="TextoPreto"> <fmt:message key= 'site.qualpagina'/> </h2>
    <%            
            String anchorId = request.getParameter("idForm");
            anchorId = anchorId.replaceAll("anch", "");
            String edicao = request.getParameter("idEdicao");
            boolean markup = "true".equals(request.getParameter("markup"));
            java.util.List<String[]> list = br.com.maven.flip.util.ImpressaoPaginas.readImages(anchorId, edicao, request);

            for (String[] string : list) {
                String bigImage = string[0];
                String image = string[1];
                String id = string[3];
    %>
    <div style="width:50%;height:340px;overflow:auto;text-align:center;float:left;">        
        <br/>
        <a href="javascript:<%= markup? "openCommentStep2ModeMarkup" :"openCommentStep2Mode" %>(<%= id%>);">
            <img src="<%= base + image%>" border="1" alt="<fmt:message key= 'site.cliquecomente'/>" title="<fmt:message key= 'site.cliquecomente'/>">
        </a>
    </div>
    <%   }%>
</div>