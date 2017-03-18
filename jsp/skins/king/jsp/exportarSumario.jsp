<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>

<div class='modalboxheader'><fmt:message key='site.exportarpaginas'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    

<div id="box650_440">
<form name="exporta_form" id="exporta_form" method="post">
    <br/>
    <div id="indice_container">
        <%
        String edicaoId = request.getParameter("idEdicao");
        edicaoId = edicaoId.replaceAll("anch", "");
        %>
        <input type="hidden" name="idEdicao" value="<%= edicaoId %>"/>



        <%
        boolean apenasFotos = "true".equals(request.getParameter("sumarioFotos"));
        java.util.List<br.com.maven.flip.javasql.view.SumarioBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.sumario(Integer.parseInt(edicaoId));

        boolean block=false;
        for (br.com.maven.flip.javasql.view.SumarioBean bean : list) {
            if(bean.isBloqueiaExportar()||bean.isBloqueiaExportarPai()){
                block=true;
                break;
            }
        }
        if(!block){
        %>
                <input type="checkbox" name="exportallpage" value="S" id="exportallpage" /> <fmt:message key="site.exportartudo"/>
        <br/>
        
        <%
               }
        String caderno=null;
        String cadernoPai=null;        
        for (br.com.maven.flip.javasql.view.SumarioBean bean : list) {
            String anchor = "anch" + bean.getId();            
            if(caderno == null || !caderno.equals(bean.getCaderno())){                
                if(caderno != null && !bean.getCaderno().equals("Capa")){                    
                    caderno=bean.getCaderno();                    
                    cadernoPai=null;
                }else{
                    if(caderno == null){                        
                        caderno=bean.getCaderno();     
                        cadernoPai=null;                                          
                    }
                }
            }
            if(cadernoPai == null || (bean.getCadernoPai() != null && !cadernoPai.equals(bean.getCadernoPai()))){                
                if(cadernoPai != null &&  cadernoPai.length()>0 && !bean.getCadernoPai().equals("Capa")){                    
                    cadernoPai=bean.getCadernoPai();               
                }else{
                    if(cadernoPai == null||cadernoPai.length()==0){                        
                        cadernoPai=bean.getCadernoPai();                                                                        
                    }
                }
            }   
            String description="";            
            if(cadernoPai != null && cadernoPai.length()>0 && caderno != null && cadernoPai.equals(caderno)){
                description=caderno;                
            }else{
                if(cadernoPai != null && cadernoPai.length()>0){                    
                    description=cadernoPai+">"+caderno;
                }else{
                    description=caderno;                    
                }
            }            
            boolean libera=true;
            if(cadernoPai==null||cadernoPai.length()<=0){             
                libera=!bean.isBloqueiaExportar();                
            }else{                                                
                libera=!bean.isBloqueiaExportarPai();
                if(libera){
                    libera=!bean.isBloqueiaExportar();
                }
            }            
            if(libera){
                if(description.length()>30){
                    description=description.substring(0,30)+"...";
                }      
                
        %>

        <div class="indice_box" title="<fmt:message key='site.cliquevisualizar'/>" id="indice<%=anchor%>">
             <input type="checkbox" name="exportpage" id="exportpage" value="<%=  bean.getId() %>"/>
            &nbsp;
            <% if (!apenasFotos) {%><b><%= bean.getOrdem()%></b> - <%= description%> <% }%>
            <a href="javascript:void(0);" onclick="MegaZine.gotoAnchor('<%= anchor%>',false);fechaTela(); return false;" title="<%= description %>">
                <img src="<%= base %><%= bean.getThumb()%>" border="1" align="center"  title="<fmt:message key='site.cliqueler'/>" height="120px"/>
            </a>
        </div>
        <%
        }}%>
    </div>
    <div style="float:right;margin-right:40px;margin-top:3px;">
        <input type="button" name="btn btn-primary" value="<fmt:message key='site.exportarpaginas'/>" class="BotaoBranco" onclick="exportaMarcadas()"/>
    </div>
</form>
</div>