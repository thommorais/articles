<%
    String cd = request.getParameter("cd");
    boolean corner = "c".equals(request.getParameter("tp"));
    String date = request.getParameter("date");
    if (cd != null) {
        String url = br.com.maven.flip.javasql.dao.FlipEstatisticaDAO.registraCliqueBanner(cd, corner,request);
        if (url != null && url.length() > 0) {
            if (url.toLowerCase().startsWith("www")) {
                url = "http://" + url;
            }
            if (url.toLowerCase().indexOf("mailto") == -1 && url.toLowerCase().indexOf("@") != -1 && url.toLowerCase().indexOf(".") != -1) {
                url = "mailto:" + url;
            }            
            if (url.indexOf("{EDICAO}") != -1 && date != null) {
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setTimeInMillis(Long.parseLong(date));
                url = url.replace("{EDICAO}", "?date=" + br.com.maven.services.util.Format.getDataFormatada(cal.getTime(), "yyyy-MM-dd"));                                
            }
            response.sendRedirect(url);
        }
    }
%>