<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean" %>
<%
            String base = request.getParameter("base");
            Integer edicao = Integer.parseInt(request.getParameter("edicao"));
            br.com.maven.flip.javasql.FlipEnqueteTbl enquete = br.com.maven.flip.javasql.dao.FlipEnqueteDAO.getEnquete(edicao);
            if (enquete != null) {
                request.setAttribute("enquete", enquete);
%>

<!--<div class='modalboxheader'><fmt:message key='text.menu.enquetes'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>-->    

<!--<div id="box650_440">-->
<script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/pool.js" charset="utf-8"></script>    

<div style="float:left;">
    <strong id="pool">
        Enquete: 
    </strong>
    <a href="#" id="enquetelink" title="<c:out value='${enquete.pergunta}'/>">
       <c:out value="${enquete.perguntaReduzida}"/>
    </a>  
</div>
<!--</div>-->
<%}%>