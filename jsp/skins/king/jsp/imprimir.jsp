<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<div class='modalboxheader'><fmt:message key='site.imprimir'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    

<div  class="printdiv" id="printdiv">
    <br/>
    <%
     try{
        String anchorId = request.getParameter("idForm");        
        anchorId = anchorId.replaceAll("anch", "");        
        String edicao = request.getParameter("idEdicao");        
        java.util.List<String[]> list = br.com.maven.flip.util.ImpressaoPaginas.readImages(anchorId, edicao, request);        
        for (String[] string : list) {
            String bigImage = string[0];
            String image = string[1];
            String pdf = string[2];               
    %>
    <div style="width:50%;height:340px;overflow:auto;text-align:center;float:left;">
        <img src="<%= base + image%>" border="1" alt="<fmt:message key="site.cliquebotaoimprimir"/>" title="<fmt:message key="site.cliquebotaoimprimir"/>" style="max-width:160px">
        <br/><br/>
        <input type="button" value="<fmt:message key="site.imprimir"/>" class="BotaoBranco" onclick="printLoad('<%= bigImage%>');" alt="<fmt:message key="site.cliqueimprimirpagina"/>" title="<fmt:message key="site.cliqueimprimirpagina"/>"/>
    </div>
    <%   }%>
</div>    
    <iframe id="printImage" name="printImage" onload="printReload();"  style="width:0px;height:0px;border-width:0px;"></iframe>    
    
    <%}catch(Exception e){         
        br.com.maven.flip.Logger.logStackTrace(e);
        %> Ocorreu um erro ao gerar a impressão, tente mais tarde. <% 
        
    }%>
    
    
