<%-- 
    Document   : Reader
    Created on : 02-Sep-2020, 12:58:32
    Author     : acer
--%>

<%@page import="servlet.Message.SpecialString"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="servlet.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"  session="true" %>
<%
    List<Message> completeFeed = (ArrayList<Message>) application.getAttribute("completeList");
    List<Message> feed = new ArrayList<>();
    int last = 0, current = 0;
    if (session.getAttribute("lastId") == null)
        session.setAttribute("lastId", last);
    if (session.getAttribute("refresh") == null)
        session.setAttribute("refresh", 30);
    else last = (Integer) session.getAttribute("lastId");
    if (completeFeed != null)
    for (Message m : completeFeed) {
        if (m != null && m.nr > last) feed.add(m);
        if (m.nr > current) {
            current = m.nr;
            session.setAttribute("current", current);
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="refresh" http-equiv="refresh" content="<%= session.getAttribute("refresh") %>">
        <link rel="stylesheet" href="../css/style.css">
        <title>Reader</title>
        <script>
            function setAutoRefresh() {
                var meta = document.getElementsByName("refresh");
                var value = 30;
                var valElem = document.getElementById("autorefresh");
                if (valElem.value != null && valElem.value > 30)
                    value = valElem.value;
                document.querySelector('meta[name="refresh"]').setAttribute("content", value);
                
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                    }
                };
                var x = document.getElementById("autorefresh").value;
                xhttp.open("GET", "../../Forget?refresh=" + x, true);
                xhttp.send();
            }
        </script>
    </head>
    <body>
        <table id="event" cellspacing="0">
            <tr id="e-head">
                <th colspan="2" id="e-title">Event-x</th>
            </tr>
            <tr id="e-subhead">
                <th colspan="2" id="e-comment">Commentary</th>
            </tr>
            <% if (feed.isEmpty()) { %>
            <tr>
                <td colspan="2"><span class="warning">
                        No available event now
                </span></td>
            </tr>
            <% } else {
                for (Message m : feed) {
                    if (m != null) {
                        SpecialString s = m.hasSpecialString();
                        if (s == SpecialString.GOAL || s == SpecialString.FAULT || s == SpecialString.PENALTY) 
                            out.print("<tr class=\"highlight\">"); 
                        else 
                            out.print("<tr>");
                        out.print("<td width=\"10%\">" + m.nr + "</td>");
                        out.print("<td width=\"90%\">" + m.string + "</td></tr>");
                   }
                }
            }%>
        </table>

        <form action="../../Forget" method="POST">
            <input id="forget-btn" type="submit" value="Forget">
        </form>
            <input id="autorefresh" type="number" min="30" value="<%= session.getAttribute("refresh") %>">
        <button id="autorefresh-btn" onclick="setAutoRefresh()">Set Autorefresh</button>
    </body>
</html>
