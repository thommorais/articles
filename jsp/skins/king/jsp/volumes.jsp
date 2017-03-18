<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<div class="dockindice">
<%
            String edicaoId = request.getParameter("idForm");
            java.util.List<br.com.maven.flip.javasql.view.ProdutoBean> list = br.com.maven.flip.javasql.dao.FlipCadernoEdicaoDAO.volumes(Integer.parseInt(edicaoId));
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            for (br.com.maven.flip.javasql.view.ProdutoBean bean : list) {                
%>
<li class="indice imaior"   style="display:block;float:left;width:96%;height:auto;margin-right:5px;" title="<fmt:message key= 'site.cliquepagina'/>"><span class="dock_icone">&#8226</span>
    <a href="./?edicao=<%= bean.getId() %>" >
        <%= bean.getNome()%>
    </a>
</li>
<% } %>
</div>