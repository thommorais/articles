<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
        String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);
        String edicao = request.getParameter("idEdicao");
        String anchorId = request.getParameter("idForm");

        anchorId = anchorId.replaceAll("anch", "");
        java.util.List<String[]> list = br.com.maven.flip.util.ImpressaoPaginas.readImages(anchorId,edicao,request);
%>

<div class='modalboxheader'><fmt:message key='site.exportar'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= baseweb %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    
<div id="box650_440">
<%

        for (String[] string : list) {
            String bigImage = string[0]; //br.com.maven.flip.util.page.DataLoader.cryptLink(string[0]);
            String image = string[1]; //br.com.maven.flip.util.page.DataLoader.cryptLink(string[1]);
            String pdf=string[2];
            pdf=org.apache.commons.lang.StringUtils.replace(pdf, "\\", "/");
            pdf=br.com.maven.flip.util.page.DataLoader.cryptLink(pdf);
            
%>

    <div style="width:50%;height:340px;overflow:auto;text-align:center;float:left;">
        <img src="<%= base %><%=image %>" border="1" title="<fmt:message key='site.cliqueexportar'/>">
        <br/><br/>
        <input type="button" value="<fmt:message key='site.exportar'/>" class="BotaoBranco" onClick="abrePdf('<%= base %>/pg.jsp?pg=<%=pdf%>');"  title="<fmt:message key='site.cliqueexportarpagina'/>"/>
    </div>

<%   }%>
</div>