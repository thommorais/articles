<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
String nometxt = "";
String emailtxt = "";

Object email=request.getSession().getAttribute("user_email");
if(email == null){
    email=request.getSession().getAttribute("username");    
}
if(email != null && email.toString().indexOf("@")!=-1) { 
        emailtxt=email.toString(); 
}
Object nome=request.getSession().getAttribute("user_nome");
if(nome!=null){
    nometxt=nome.toString();
}else{
    nometxt=emailtxt;
}
%>

<div class='modalboxheader'><fmt:message key="site.recomendar"/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    

<div id="box650_440">

 <c:if test="${empty permissions or permissions.redes}">    
                        <c:choose>
                            <c:when test="${empty page.flipModeloPublicacaoidid_modelo.prefs.htmlAddThis}">
                                <div id="social-links" class="addthis_toolbox addthis_default_style" style='position:absolute;left:50%;margin-right:-50%;transform: translate(-50%, -50%);'>
                                    <a class="addthis_button_facebook_like" fb:like:layout="button_count" <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}">fb:like:href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}'/>"</c:if>></a>                        
                                    <a class="addthis_button_tweet" tw:via='Mavenflip'/></a>                                                
                                    <a class="addthis_counter addthis_pill_style" addthis:ui_hover_direction="-1"></a>                                
                                </div>                                                            
                                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=xa-529fe7e849b8a504"></script>                            
                            </c:when>
                            <c:otherwise>
                                <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAddThis}" escapeXml="false"/>
                            </c:otherwise>
                        </c:choose>
                        <br/>    <br/>   
                    </c:if>    
    
    
    <form method="POST" action="#" name="faleConoscoForm" id="faleConoscoForm">
        <input type="hidden" name="edicao" value="<%= request.getParameter("idForm")%>"/>
        <input type="hidden" name="pagina_anchor"  id="pagina_anchor"/>
        <input type="hidden" name="link"  id="link"/>
        <table width="100%" align="left" border="0" cellpadding="3px" cellspacing="1px">            
            <tr>
                <td   class="TextoPreto">
            <fmt:message key="site.seunome"/> *
            </td>
            <td   class="TextoPreto">
            <fmt:message key="site.seuemail"/> *
            </td>
            </tr>
            <tr>
                <td >
                    <input type="text" name="nome" id="nomeId" size="40" maxlength="255"  class="CampoTexto" value="<%= nometxt %>" style="width:220px"/>
                </td>
                <td ><input type="text" name="email"  id="emailId" size="40" maxlength="255"  class="CampoTexto" value="<%= emailtxt %>" style="width:220px"/></td>
            </tr>
            <tr>
                <td   class="TextoPreto"><fmt:message key="site.emailamigo"/> 1: </td>
            <td   class="TextoPreto"><fmt:message key="site.emailamigo"/> 2:</td>
            </tr>
            <tr>
                <td  ><input type="text" name="para" id="para1" value="" size="40" maxlength="255" class="CampoTexto"  style="width:220px"/></td>
                <td  ><input type="text" name="para" id="para2" value="" size="40" maxlength="255" class="CampoTexto" autocomplete="off"  style="width:220px"/></td>
            </tr>
            <tr>
                <td   class="TextoPreto"><fmt:message key="site.emailamigo"/> 3: </td>
            <td   class="TextoPreto"><fmt:message key="site.emailamigo"/> 4:</td>
            </tr>
            <tr>
                <td  ><input type="text" name="para" id="para3" value="" size="40" maxlength="255" class="CampoTexto" autocomplete="off"  style="width:220px"/></td>
                <td  ><input type="text" name="para"  id="para4" value="" size="40" maxlength="255" class="CampoTexto" autocomplete="off"  style="width:220px"/></td>
            </tr>
            <tr>
                <td    class="TextoPreto"><fmt:message key="site.mensagem"/> </td>
            </tr>
            <tr>
                <td  colspan="4">
                    <textarea name="mensagem" id="mensagem" cols="67" rows="6" class="CampoTexto" style="height:60px;width:500px"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="TextoPreto TextoRequired" colspan="4">* <fmt:message key="site.camposobrigatorios"/> </td>
            </tr>                        
            <tr>
                <td colspan="4" align="center">
                    <input type="button" name="button" value="<fmt:message key='site.enviar'/>" size="" class="BotaoBranco" onclick="recomendaAmigo();"/>                    
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>            
        </table>
    </form>

</div>