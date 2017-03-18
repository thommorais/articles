<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<div class="dockproduto">
    <li>
        <div  id="edicao_container">
            <!-- <h3> <fmt:message key= 'text.flip.produtos.title'/> </h3>  -->                           
            <%
                try {
                    String edicaoId = request.getParameter("idForm");
                    String link = request.getParameter("linkedicao");
                    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);

                    java.util.List<br.com.maven.flip.javasql.view.ProdutoBean> list = br.com.maven.flip.javasql.dao.FlipCadernoEdicaoDAO.produtos(Integer.parseInt(edicaoId));
                    int i = 0;
    
                    for (br.com.maven.flip.javasql.view.ProdutoBean bean : list) {
                      String linktemp=link;
                      if(bean.isFamilia()) {
                          linktemp = "pub/" + bean.getFolder() + "/?edicao=" + bean.getId();
                      } else if(bean.isOutros()) {
                            if(bean.getIndex()!=null&&bean.getIndex()>1){
                                if(bean.getFolder()!=null && bean.getFolder().length()>0){
                                    linktemp="pub/"+bean.getFolder()+"/?edicao="+bean.getId();
                                }else{
                                    linktemp="pub/"+bean.getLink()+"/index"+bean.getIndex()+"/?edicao="+bean.getId();
                                }
                            }else{
                                linktemp="pub/"+bean.getLink()+"/?edicao="+bean.getId();
                            }
                        }else{
                          linktemp=linktemp+"/?edicao="+bean.getId();
                        }
            %>
            <div class="box" <% if (bean.getId().intValue() == Integer.parseInt(edicaoId)) {%>id="selected"<% }%>>
                <div class='boxinner'>
                <div class='boxcover'>                                    
                     <a href="<%= base + linktemp%>"> 
                        <img src="<%= base + bean.getImage()%>" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                    </a>
                </div>
                <div class="boxdata">     
                <label class="datatext"><%= bean.getNome()%></label>
                </div>
                </div>
            </div>

            <%   }
                if (list.size() == 0) {
            %>
            <h2> <fmt:message key="site.nenhumproduto"/>!</h2>
            <%            }

            } catch (Exception e) {
                br.com.maven.flip.Logger.logStackTrace(e);
            %>
            <h2> <fmt:message key="site.erro"/> </h2>
            <%
                }
            %>
        </div>
    </li>
</div>