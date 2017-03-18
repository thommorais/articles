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

<div class='modalboxheader'><fmt:message key="site.facacomentario"/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    

<div id="box650_440">    
    <br/>
    <form method="POST" action="#" name="faleConoscoForm" id="faleConoscoForm" accept-charset="ISO-8859-1">
        <input type="hidden" name="edicao" value="<%= request.getParameter("idForm")%>"/>
        <input type="hidden" name="pagina_anchor"  value="<%= request.getParameter("pagina")%>"/>
        <input type="hidden" name="comentario"  value="true"/>
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
                    <input type="text" name="nome" id="nomeId" value="<%= nometxt %>" size="40" maxlength="255"  class="CampoTexto" style="width:300px"/>
                </td>
                <td ><input type="text" name="email" id="emailId" value="<%= emailtxt %>" size="40" maxlength="255"  class="CampoTexto"  style="width:300px"/></td>
            </tr>
            <tr>
                <td    class="TextoPreto"><fmt:message key="site.mensagem"/> * </td>
            </tr>
            <tr>
                <td  colspan="4">
                    <textarea name="mensagem" id="mensagem" cols="84" rows="6" class="CampoTexto" style="height:60px;width:627px"></textarea>
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
                    <input type="button" name="button" value="<fmt:message key='text.button.save'/>" size="" class="BotaoBranco" onclick="comentaPagina();"/>                    
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