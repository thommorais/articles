<%@ page language="java" pageEncoding="iso-8859-1"%>
<%
    String id = request.getParameter("audio");    
    try {      
        String link = br.com.maven.flip.util.audio.AudioUtil.getMp3Url(id);
        if (link != null) {
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            link = base + link;                           
%>
<object class="playerpreview" type="application/x-shockwave-flash" data="<%= base%>player_mp3_maxi.swf?1=1" width="200" height="20">
    <param name="movie" value="<%= base%>player_mp3_maxi.swf?1=1" />
    <param name="FlashVars" value="mp3=<%= link%>&amp;showstop=1&amp;showvolume=1&amp;bgcolor1=189ca8&amp;bgcolor2=085c68" />
    <p>Arquivo de áudio.</p>
</object>

<%
        }
    } catch (Exception e) {
        br.com.maven.flip.Logger.logStackTrace(e);
    }
%>
