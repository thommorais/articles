<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<%
    Integer PAGE_SIZE = 200;
    try {
        String edicaoId = request.getParameter("idForm");
        String link = request.getParameter("linkedicao");
        String pageNumber = request.getParameter("pagina");
        String nr = request.getParameter("nr");
        String di = request.getParameter("di");
        String df = request.getParameter("df");
        String tx = request.getParameter("tx");
        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
        if (pageNumber == null || pageNumber.trim().length() <= 0) {
            pageNumber = "0";
        }
        Integer pagina = Integer.parseInt(pageNumber);
        int[] count = new int[2];
        Object days = request.getSession().getAttribute("SUBSCRIPTION_DAYS");
        Object dates = request.getSession().getAttribute("SUBSCRIPTION_DATES");
        java.util.List<br.com.maven.flip.javasql.view.EdicaoBean> list = br.com.maven.flip.javasql.dao.FlipEdicaoDAO.edicoes(Integer.parseInt(edicaoId), pagina, count, PAGE_SIZE, days,dates, nr, di, df, tx);
        int i = 0;
        if (list.size() > 0 && count[0] > PAGE_SIZE) {
            pagina++;
            java.math.BigDecimal big = new java.math.BigDecimal(count[0]).divide(new java.math.BigDecimal(PAGE_SIZE));
            big = big.setScale(0, java.math.BigDecimal.ROUND_UP);
            int paginas = big.intValue();
            int first = (pagina - 1) * PAGE_SIZE;
            int last = first + list.size();
        } else {
            pagina = 1;
        }
        for (br.com.maven.flip.javasql.view.EdicaoBean bean : list) {
%>
<%= base + bean.getPath()%>,<%= bean.getNr()%>,<%= bean.getDataFormatada()%>;                        
<%   }
} catch (Exception e) {
    br.com.maven.flip.Logger.logStackTrace(e);
%>
<fmt:message key="site.erro"/> <%= e.getMessage()%>
<%
    }
%>      