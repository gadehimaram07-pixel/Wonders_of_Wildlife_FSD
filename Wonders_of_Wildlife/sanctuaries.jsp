<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wildlife.model.Sanctuary" %>
<%@ page import="com.wildlife.dao.SanctuaryDAO" %>
<%
    List<Sanctuary> sanctuaries = (List<Sanctuary>) request.getAttribute("sanctuaries");
    if (sanctuaries == null) {
        sanctuaries = new SanctuaryDAO().getAllSanctuaries();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,300..700;1,300..700&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link href="cards.css" rel="stylesheet">
    <title>Wildlife Sanctuaries - Wonders of Wildlife</title>
    <style>
        body {
            background-image: url('sanbg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            margin: 0;
            font-family: "Roboto", sans-serif;
        }    
        .navbar {
            display: flex;
            justify-content: left;
            padding: 20px 90px;  
            position: relative;
        }
        .navbar ul {
            display: flex;
            list-style: none;
            gap: 50px;
            margin: 0;
            padding: 0;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            padding: 0px 40px;
            transition: all 0.3s ease;
            font-family: "Cormorant", serif;
            font-size: 1.2rem;
        }
        .navbar a:hover {
            text-decoration: underline;
            text-underline-offset: 5px;
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.1);
            border-radius: 6px;
        }
        .admin-nav-pill {
            background-color: rgba(46, 125, 50, 0.85);
            border: 1px solid #81c784;
            border-radius: 20px;
            padding: 4px 18px !important;
            font-weight: bold !important;
        }
        .admin-nav-pill:hover {
            background-color: #2e7d32 !important;
        }
        h1 {     
            text-align: center;
            color: white;
            font-family: "Cormorant", serif;
            font-size: 50px;
            padding: 25px 20px;
            margin: 25px auto 35px;
            width: 80%;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            background: rgba(0, 0, 0, 0.5);
            box-shadow: 0 8px 18px rgba(0,0,0,0.35);
            backdrop-filter: blur(6px);
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar">
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="gallery">Gallery</a></li>
                <li><a href="sanctuaries">Sanctuaries</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="admin-login" class="admin-nav-pill">🔒 Admin</a></li>
            </ul>
        </nav>
    </header>

    <h1>Wildlife Sanctuaries & National Parks (<%= sanctuaries.size() %>)</h1>

    <section>
        <div class="wildlife-grid">
            <% for (Sanctuary s : sanctuaries) { %>
            <div class="wildlife-card" onclick="location.href='sanctuary-detail?id=<%= s.getId() %>'">
                <div class="card-img-wrap">
                    <span class="card-badge sanctuary">
                        📍 <%= s.getState() %>
                    </span>
                    <img src="<%= s.getImageUrl() %>" alt="<%= s.getName() %>" onerror="this.src='sanbg.jpg'">
                </div>
                <div class="card-body">
                    <h3 class="card-title"><%= s.getName() %></h3>
                    <p class="card-subtitle"><b>Best Time:</b> <%= (s.getBestTime() != null && !s.getBestTime().isEmpty()) ? s.getBestTime() : "October to May" %></p>
                    <div class="card-meta">
                        <span>🐅 <b>Key Wildlife:</b> <%= (s.getKeyAnimals() != null && !s.getKeyAnimals().isEmpty()) ? s.getKeyAnimals() : "Diverse Indigenous Species" %></span>
                    </div>
                    <div class="card-btn-wrap">
                        <span class="btn-card-action">Explore Sanctuary →</span>
                    </div>
                </div>
            </div>
            <% } %>

            <% if (sanctuaries.isEmpty()) { %>
            <div style="color:white; font-size:24px; text-align:center; padding: 40px; background: rgba(0,0,0,0.5); border-radius: 12px;">
                No sanctuaries currently found in database.
            </div>
            <% } %>
        </div>
    </section>
</body>
</html>
