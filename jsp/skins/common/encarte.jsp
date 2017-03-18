<%
            String base = request.getParameter("base");
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<div id="popupContact">
    <a id="popupContactClose">x</a>
    <h1>Selecione o encarte</h1>
    <p id="contactArea">
        Selecione o encarte da revista que deseja visualizar.       
        <br/>
    <table align="center">
        <tr>
            <c:forEach var="encarte" items="${page.encartes}">
                <td>
                    <a href="#" onclick="try{javascript:MegaZine.gotoAnchor('<c:out value='${encarte.key}'/>',false);}catch(e){}disablePopup();">
                        <img src='<%= base%><c:out value="${encarte.value}"/>' alt="<c:out value="${encarte.value}"/>" id="finishButton" width="200px"/>
                    </a>
                </td>
            </c:forEach>            
        </tr>
    </table>
</p>
</div>

<div id="backgroundPopup"></div>