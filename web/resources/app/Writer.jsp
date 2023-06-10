<%-- 
    Document   : Writer
    Created on : 02-Sep-2020, 11:12:19
    Author     : acer
--%>

<%@page import="servlet.Message"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"  session="true" %>
<% List<Message> feedList = (List<Message>) application.getAttribute("completeList"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/style.css">
        <title>Writer</title>
    </head>
    <body>
        <h1>Welcome writer!</h1>
        <p class="info">You can highlight messages that contain keywords: <em>Goal</em>, <em>Fault</em>, <em>Penalty</em> and <em>END</em></p>
        <p class="status"> Webcast 
        <% 
            if (feedList != null && !feedList.isEmpty()) out.print("attivo");
            else out.print("inattivo");
        %>
        </p>
        <form action="../../AddFeed" method="POST" >
            <input id="send-message-input" type="textinput" name="message" placeholder="Insert your feed message here">
            <input id="send-message-btn" type="submit" value="Submit">
        </form>
        <table id="feed-table" cellspacing="0">
            <tr>
                <th width="10%">Nr.</th>
                <th width="90%">Feed</th>
            </tr>
            <%
                if (feedList != null)
                    for (Message m : feedList) {
                        out.println("<tr><td>");
                        out.println(m.nr);
                        out.println("</td><td>");
                        out.println(m.string);
                        out.println("</tr>");
                    }
            %>
        </table>
    </body>
</html>
