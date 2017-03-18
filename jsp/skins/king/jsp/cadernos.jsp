<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<div class="dockindice">
<%
            String edicaoId = request.getParameter("idForm");
            java.util.List<br.com.maven.flip.javasql.view.CadernoBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.cadernos(Integer.parseInt(edicaoId));
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            for (br.com.maven.flip.javasql.view.CadernoBean bean : list) {
                String anchor = bean.getAnchor();
                if(bean.isProduct()){
                    anchor="product:"+anchor;
                }

%>
<li class="indice imaior"   style="display:block;float:left;width:100%;height:auto;" title="<fmt:message key= 'site.cliquepagina'/>"><span class="dock_icone">&#8226</span>
    <a href="javascript:void(0)" onclick="abreIndice('<%= anchor%>','<%= bean.getNome()%>');fechaJanela(); return false;">
        <c:choose>
            <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                <%= bean.getNomeEn()%>
            </c:when>
            <c:otherwise>
                <%= bean.getNome()%>
            </c:otherwise>
        </c:choose>
    </a>
</li>
<%
                for (br.com.maven.flip.javasql.view.CadernoBean child : bean.getChildren()) {
                    String anchor1 = child.getAnchor();
%>
<li class="indice" title="<%= child.getNome()%>" style="display:block;float:left;width:100%;height:auto;">
    <span class="dock_icone" style="margin-left:10px">&#8226</span>
    <a href="javascript:void(0)" onclick="abreIndice('<%= anchor1 %>','<%= bean.getNome()%>');fechaJanela(); return false;">
        <c:choose>
            <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                <%= child.getNomeEn()%>
            </c:when>
            <c:otherwise>
                <%= child.getNome()%>
            </c:otherwise>
        </c:choose>
    </a>
</li>
<%
                }


            }
%>
</div>