<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<a class="btn-fechar" href="javascript:void(0);" onClick="fecharIndice()"><i class="icon-remove"></i></a>
<p class="titulo">ÍNDICE</p>
<ul>
    <%
        String edicaoId = request.getParameter("idForm");
        java.util.List<br.com.maven.flip.javasql.view.CadernoBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.cadernos(Integer.parseInt(edicaoId));
        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
        for (br.com.maven.flip.javasql.view.CadernoBean bean : list) {
            String anchor = bean.getAnchor();

    %>

    <li title="<fmt:message key= 'site.cliquepagina'/>">
        <a class="btn" href="javascript:void(0);" onclick="gotoAnchor('<%= anchor%>',false);fechaJanela(); return false;">
            <span><%= bean.getIndexText()%></span>
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
        if (!bean.getChildren().isEmpty()) {
    %>
    <li>
        <ul>
            <%
                for (br.com.maven.flip.javasql.view.CadernoBean child : bean.getChildren()) {
                    String anchor1 = child.getAnchor();
            %>
            <li title="<fmt:message key= 'site.cliquepagina'/>">
                <a class="btn" href="javascript:void(0);" onclick="gotoAnchor('<%= anchor1%>',false);fechaJanela(); return false;">
                    <span><%= child.getIndexText()%></span>
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
            %>
        </ul>
    </li>
    <%
            }
        }
    %>
</ul>