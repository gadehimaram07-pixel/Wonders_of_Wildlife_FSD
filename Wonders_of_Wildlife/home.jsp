<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wildlife.model.Animal" %>
<%@ page import="com.wildlife.model.Sanctuary" %>
<%@ page import="com.wildlife.dao.AnimalDAO" %>
<%@ page import="com.wildlife.dao.SanctuaryDAO" %>
<%
    List<Animal> animals = (List<Animal>) request.getAttribute("animals");
    if (animals == null) {
        animals = new AnimalDAO().getAllAnimals();
    }

    List<Sanctuary> sanctuaries = (List<Sanctuary>) request.getAttribute("sanctuaries");
    if (sanctuaries == null) {
        sanctuaries = new SanctuaryDAO().getAllSanctuaries();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home - Wonders of Wildlife</title>
    <link href="style1.css" rel="stylesheet"> 
    <link href="cards.css" rel="stylesheet"> 
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,300..700;1,300..700&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        .navbar a {
            color: green; 
        }
        .navbar1 {
            background-color: lightgreen;
        }
        .admin-nav-pill {
            background-color: #2e7d32 !important;
            color: white !important;
            border-radius: 20px;
            padding: 4px 14px !important;
            font-weight: bold !important;
        }
        .admin-nav-pill:hover {
            background-color: #1b5e20 !important;
        }
        .home-images-section {
            background: linear-gradient(180deg, #4fa854, #3b8a3f);
            padding: 50px 20px;
        }
        .home-section-title {
            color: white !important;
            font-family: "Cormorant", serif;
            font-size: 42px;
            text-align: center;
            margin-bottom: 35px;
            text-shadow: 0 2px 6px rgba(0,0,0,0.25);
        }
        .home-section-title u {
            color: white !important;
            text-decoration-color: rgba(255,255,255,0.7);
        }
        .explorebtn {
            text-align: center;
            margin: 30px 0 20px;
        }
        .explore-btn {
            padding: 14px 34px;
            border-radius: 30px;
            background-color: #1e4620;
            color: white;
            font-family: 'Cormorant', serif;
            font-size: 20px;
            font-weight: bold;
            border: 2px solid rgba(255,255,255,0.4);
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
        .explore-btn:hover {
            background-color: #0f2910;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <header class="navbar1">
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

<section class="home">
    <div class="hometext">
        <h2>Welcome to Wonders of Wildlife</h2>
        <br><br>
        <pre>
Explore the beauty, diversity, and importance of wildlife
from around the world. Our planet is home to millions of
fascinating species living in forests, oceans, mountains, and wetlands.
Discover amazing animals, view stunning photographs,
and learn why protecting wildlife is essential for our future.</pre><br>
        <pre>
Humans have historically tended to separate civilization from wildlife 
in a number of ways, including the legal, social and moral senses. Some
animals, however, have adapted to suburban environments. This includes
urban wildlife such as feral cats, dogs, mice, and rats. Some religions
declare certain animals to be sacred, and in modern times, concern for
the natural environment has provoked activists to protest against the
exploitation of wildlife for human benefit or entertainment.
        </pre><br><br>
    </div>

    <!-- Section 1: Animals and Birds Grid -->
    <div class="home-images-section">
        <h2 class="home-section-title"><u>Animals and Birds of India (From Oracle DB)</u></h2>
        
        <div class="wildlife-grid">
            <% 
                int displayLimit = Math.min(animals.size(), 8);
                for (int i = 0; i < displayLimit; i++) {
                    Animal a = animals.get(i);
                    boolean isBird = "Bird".equalsIgnoreCase(a.getCategory());
            %>
            <div class="wildlife-card" onclick="location.href='animal-detail?id=<%= a.getId() %>'">
                <div class="card-img-wrap">
                    <span class="card-badge <%= isBird ? "bird" : "" %>">
                        <%= isBird ? "🪶 Bird" : "🐾 Mammal" %>
                    </span>
                    <img src="<%= a.getImageUrl() %>" alt="<%= a.getName() %>" onerror="this.src='bgtiger.jpg'">
                </div>
                <div class="card-body">
                    <h3 class="card-title"><%= a.getName() %></h3>
                    <p class="card-subtitle"><i><%= a.getScientificName() != null ? a.getScientificName() : "" %></i></p>
                    <div class="card-meta">
                        <span>📍 <%= (a.getFoundIn() != null && !a.getFoundIn().isEmpty()) ? a.getFoundIn() : "Protected Reserves" %></span>
                    </div>
                    <div class="card-btn-wrap">
                        <span class="btn-card-action">Explore Species →</span>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div class="explorebtn">
            <button class="explore-btn" onclick="window.location.href='gallery'">Explore Full Wildlife Gallery (20 Species) >></button>
        </div>
    </div>

    <!-- Section 2: Wildlife Sanctuaries Grid on Home Page -->
    <div class="home-images-section" style="background: linear-gradient(180deg, #2e7d32, #1b5e20); border-top: 3px solid rgba(255,255,255,0.2);">
        <h2 class="home-section-title"><u>Wildlife Sanctuaries & National Parks</u></h2>
        
        <div class="wildlife-grid">
            <% 
                int sancLimit = Math.min(sanctuaries.size(), 4);
                for (int i = 0; i < sancLimit; i++) {
                    Sanctuary s = sanctuaries.get(i);
            %>
            <div class="wildlife-card" onclick="location.href='sanctuary-detail?id=<%= s.getId() %>'">
                <div class="card-img-wrap">
                    <span class="card-badge sanctuary">
                        📍 <%= s.getState() %>
                    </span>
                    <img src="<%= s.getImageUrl() %>" alt="<%= s.getName() %>" onerror="this.src='sanbg.jpg'">
                </div>
                <div class="card-body">
                    <h3 class="card-title"><%= s.getName() %></h3>
                    <p class="card-subtitle"><b>Best Season:</b> <%= s.getBestTime() != null ? s.getBestTime() : "Oct - May" %></p>
                    <div class="card-meta">
                        <span>🐅 <%= s.getKeyAnimals() != null ? s.getKeyAnimals() : "Diverse Indigenous Fauna" %></span>
                    </div>
                    <div class="card-btn-wrap">
                        <span class="btn-card-action">View Sanctuary →</span>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div class="explorebtn">
            <button class="explore-btn" onclick="window.location.href='sanctuaries'">Explore All Sanctuaries (15 Reserves) >></button>
        </div>
    </div>

    <div style="background: bisque; padding: 40px 20px;">
        <div class="hometext">
<pre>
Wildlife encompasses all undomesticated animal species—including mammals, 
birds, reptiles, amphibians, and fish—that live and grow in their natural
habitats without being introduced by humans.
</pre><br>
<pre>
It is a critical component of the planet's biodiversity, playing a vital role
in maintaining ecological balance through predator-prey relationships, pollination, 
and seed dispersal.
</pre>
        </div>
    </div>
</section>
</body>
</html>
