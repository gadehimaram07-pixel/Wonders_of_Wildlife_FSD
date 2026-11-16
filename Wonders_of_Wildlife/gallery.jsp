<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wildlife.model.Animal" %>
<%@ page import="com.wildlife.dao.AnimalDAO" %>
<%
    String catParam = request.getParameter("category");
    String searchQuery = request.getParameter("q");

    AnimalDAO animalDAO = new AnimalDAO();
    List<Animal> animals;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        String qLower = searchQuery.trim().toLowerCase();
        List<Animal> all = animalDAO.getAllAnimals();
        animals = new java.util.ArrayList<>();
        for (Animal a : all) {
            if (a.getName().toLowerCase().contains(qLower) || 
                (a.getScientificName() != null && a.getScientificName().toLowerCase().contains(qLower)) ||
                (a.getFoundIn() != null && a.getFoundIn().toLowerCase().contains(qLower))) {
                animals.add(a);
            }
        }
    } else if (catParam != null && !catParam.trim().isEmpty() && !"All".equalsIgnoreCase(catParam)) {
        animals = animalDAO.getAnimalsByCategory(catParam);
    } else {
        animals = animalDAO.getAllAnimals();
        catParam = "All";
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
    <title>Wildlife Gallery - Wonders of Wildlife</title>
    <style>
        body {
            background-image: url('gallerybg.jpg');
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
            margin: 20px auto 25px;
            width: 80%;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            background: rgba(0, 0, 0, 0.5);
            box-shadow: 0 8px 18px rgba(0,0,0,0.35);
            backdrop-filter: blur(6px);
        }

        /* Filter Tabs */
        .filter-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 35px;
        }
        .filter-btn {
            background: rgba(0, 0, 0, 0.55);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 10px 26px;
            border-radius: 30px;
            font-family: 'Cormorant', serif;
            font-size: 1.25rem;
            text-decoration: none;
            transition: 0.3s;
            backdrop-filter: blur(5px);
        }
        .filter-btn:hover, .filter-btn.active {
            background: #2e7d32;
            border-color: #81c784;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.35);
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

    <h1>Wildlife Gallery (<%= animals.size() %> Species)</h1>

    <!-- Filter Buttons -->
    <div class="filter-container">
        <a href="gallery?category=All" class="filter-btn <%= (catParam == null || "All".equalsIgnoreCase(catParam)) ? "active" : "" %>">🌟 All Species (<%= animalDAO.getCount() %>)</a>
        <a href="gallery?category=Animal" class="filter-btn <%= "Animal".equalsIgnoreCase(catParam) ? "active" : "" %>">🐾 Mammals (<%= animalDAO.getCountByCategory("Animal") %>)</a>
        <a href="gallery?category=Bird" class="filter-btn <%= "Bird".equalsIgnoreCase(catParam) ? "active" : "" %>">🪶 Birds of India (<%= animalDAO.getCountByCategory("Bird") %>)</a>
    </div>

    <!-- Gallery Grid -->
    <section>
        <div class="wildlife-grid">
            <% 
                for (Animal a : animals) { 
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

            <% if (animals.isEmpty()) { %>
            <div style="color:white; font-size:24px; text-align:center; padding: 40px; background: rgba(0,0,0,0.5); border-radius: 12px;">
                No wildlife species found matching your filter.
            </div>
            <% } %>
        </div>
    </section>
</body>
</html>
