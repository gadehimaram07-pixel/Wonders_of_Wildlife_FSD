<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wildlife.model.Animal" %>
<%@ page import="com.wildlife.dao.AnimalDAO" %>
<%
    Animal a = (Animal) request.getAttribute("animal");
    AnimalDAO animalDAO = new AnimalDAO();
    if (a == null) {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                a = animalDAO.getAnimalById(Integer.parseInt(idParam));
            } catch (Exception ignored) {}
        }
    }
    if (a == null) {
        response.sendRedirect("gallery");
        return;
    }

    boolean isBird = "Bird".equalsIgnoreCase(a.getCategory());
    List<Animal> allAnimals = animalDAO.getAllAnimals();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= a.getName() %> - Wonders of Wildlife</title>
    <link rel="stylesheet" href="detail-view.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>

    <!-- Top Navigation Header -->
    <header class="detail-navbar">
        <a href="home.jsp" class="brand-logo">
            <span>🌿</span> Wonders of Wildlife
        </a>
        <ul class="nav-links">
            <li><a href="home.jsp">Home</a></li>
            <li><a href="gallery">Gallery</a></li>
            <li><a href="sanctuaries">Sanctuaries</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="admin-login" class="nav-admin-btn">🔒 Admin</a></li>
        </ul>
    </header>

    <!-- Breadcrumb Bar -->
    <nav class="breadcrumb-bar">
        <a href="home.jsp">Home</a>
        <span class="breadcrumb-sep">/</span>
        <a href="gallery">Wildlife Gallery</a>
        <span class="breadcrumb-sep">/</span>
        <a href="gallery?category=<%= a.getCategory() %>"><%= isBird ? "Birds of India" : "Animals & Mammals" %></a>
        <span class="breadcrumb-sep">/</span>
        <span><%= a.getName() %></span>
    </nav>

    <!-- Main Detail Layout -->
    <main class="detail-container">
        <article class="detail-card">
            
            <!-- Two Column Split Hero -->
            <div class="detail-hero-grid">
                
                <!-- Left: Focused Image Box -->
                <div class="detail-image-box">
                    <span class="detail-badge-floating <%= isBird ? "bird" : "" %>">
                        <%= isBird ? "🪶 Avian Species" : "🐾 Mammal / Fauna" %>
                    </span>
                    <img src="<%= a.getImageUrl() %>" alt="<%= a.getName() %>" onerror="this.src='bgtiger.jpg'">
                </div>

                <!-- Right: Information Overview -->
                <div class="detail-header-content">
                    <h1 class="detail-title"><%= a.getName() %></h1>
                    
                    <div class="detail-scientific">
                        <b>Binomial:</b> <i><%= (a.getScientificName() != null && !a.getScientificName().isEmpty()) ? a.getScientificName() : "Species of India" %></i>
                    </div>

                    <!-- Quick Facts Grid -->
                    <div class="facts-grid">
                        <div class="fact-item">
                            <div class="fact-item-label">🌿 Category</div>
                            <div class="fact-item-value"><%= a.getCategory() %></div>
                        </div>

                        <div class="fact-item">
                            <div class="fact-item-label">🏞️ Natural Habitat</div>
                            <div class="fact-item-value"><%= (a.getHabitat() != null && !a.getHabitat().isEmpty()) ? a.getHabitat() : "Indian Wilderness" %></div>
                        </div>

                        <div class="fact-item">
                            <div class="fact-item-label">📍 Key Sanctuaries / Region</div>
                            <div class="fact-item-value"><%= (a.getFoundIn() != null && !a.getFoundIn().isEmpty()) ? a.getFoundIn() : "Protected Reserves" %></div>
                        </div>

                        <div class="fact-item">
                            <div class="fact-item-label">🛡️ Conservation Focus</div>
                            <div class="fact-item-value">Protected Indian Wildlife</div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="detail-action-buttons">
                        <a href="gallery" class="btn-primary-action">← Back to Gallery</a>
                        <a href="sanctuaries" class="btn-secondary-action">Explore Sanctuaries →</a>
                    </div>
                </div>

            </div>

            <!-- Detailed Ecological Story -->
            <section class="detail-body-section">
                <h2 class="section-heading">
                    <span>📖</span> Natural History & Behavioral Profile
                </h2>
                
                <p class="detail-description-text">
                    <%= a.getDescription() %>
                </p>

                <!-- Did You Know Highlight -->
                <div class="highlight-card">
                    <div class="highlight-icon">💡</div>
                    <div class="highlight-content">
                        <h4>Did You Know?</h4>
                        <p>
                            <% if (isBird) { %>
                                Birds play an irreplaceable role as seed dispersers, pest regulators, and pollinators across Indian forests. Protecting avian sanctuaries directly preserves entire forest canopies!
                            <% } else { %>
                                India is home to nearly 7.6% of all mammalian species on Earth, including apex predators like tigers and resilient desert equids, all preserved in protected wildlife reserves.
                            <% } %>
                        </p>
                    </div>
                </div>
            </section>

            <!-- Other Species Strip -->
            <section class="related-strip">
                <h3>🔍 Discover More Indian Wildlife</h3>
                <div class="related-grid">
                    <% 
                        int count = 0;
                        for (Animal rel : allAnimals) {
                            if (rel.getId() != a.getId() && count < 5) {
                                count++;
                    %>
                    <a href="animal-detail?id=<%= rel.getId() %>" class="related-card">
                        <img src="<%= rel.getImageUrl() %>" alt="<%= rel.getName() %>" onerror="this.src='bgtiger.jpg'">
                        <div class="related-card-info">
                            <h4><%= rel.getName() %></h4>
                            <span><%= rel.getCategory() %></span>
                        </div>
                    </a>
                    <% 
                            }
                        }
                    %>
                </div>
            </section>

        </article>
    </main>

    <footer class="detail-footer">
        &copy; Wonders of Wildlife &bull; Full Stack Project with Servlets, JSP & Oracle DB
    </footer>

</body>
</html>
