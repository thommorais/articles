<%
    try{
    boolean media = false;
    String link = request.getParameter("id");
    String date = request.getParameter("date");
    boolean secure="https".equals(request.getParameter("protocol"));
    if (link == null || link.length() == 0) {
        link = request.getParameter("media_id");
        media = true;
    }
    if (link != null && link.length() > 0) {
        String url = br.com.maven.flip.javasql.dao.FlipEstatisticaDAO.registraClique(Integer.parseInt(link), request, media);                
        if (url.toLowerCase().startsWith("open:")) {
            url = url.substring(5);
            url = url.replace("watch?v=", "embed/");
            if (!url.contains("?")) {
                url = url + "?autoplay=1";
            } else {
                url = url + "&autoplay=1";
            }
        } else {
            url = url.replace("(", "");
            url = url.replace(")", "");
        }

        if (url.toLowerCase().startsWith("www")) {
            if (request.isSecure()) {
                url = "https://" + url;
            } else {
                url = "http://" + url;
            }
        }
        if (url.toLowerCase().indexOf("mailto") == -1 && url.toLowerCase().indexOf("@") != -1 && url.toLowerCase().indexOf(".") != -1) {
            url = "mailto:" + url;
        }
        if (url.indexOf("{EDICAO}") != -1 && date != null) {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.setTimeInMillis(Long.parseLong(date));
            url = url.replace("{EDICAO}", "?date=" + br.com.maven.services.util.Format.getDataFormatada(cal.getTime(), "yyyy-MM-dd"));
        }                           
        if (secure && !url.startsWith("https")) {                        
             br.com.maven.util.URLUtil.writeURLContent(url,request, response);            
        } else {            
            response.sendRedirect(url);
        }
   }    
    }catch(Exception ex){
        br.com.maven.flip.Logger.logStackTrace(ex);
        
    }
%>
