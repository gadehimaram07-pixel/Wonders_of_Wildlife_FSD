<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wildlife.model.Sanctuary" %>
<%@ page import="com.wildlife.dao.SanctuaryDAO" %>
<%
    Sanctuary s = (Sanctuary) request.getAttribute("sanctuary");
    SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();
    if (s == null) {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                s = sanctuaryDAO.getSanctuaryById(Integer.parseInt(idParam));
            } catch (Exception ignored) {}
        }
    }
    if (s == null) {
        response.sendRedirect("sanctuaries");
        return;
    }

    List<Sanctuary> allSanctuaries = sanctuaryDAO.getAllSanctuaries();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= s.getName() %> - Wonders of Wildlife</title>
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
        <a href="sanctuaries">Wildlife Sanctuaries</a>
        <span class="breadcrumb-sep">/</span>
        <span><%= s.getName() %></span>
    </nav>

    <!-- Main Detail Layout -->
    <main class="detail-container">
        <article class="detail-card">
            
            <!-- Two Column Split Hero -->
            <div class="detail-hero-grid">
                
                <!-- Left: Focused Image Box -->
                <div class="detail-image-box">
                    <span class="detail-badge-floating sanctuary">
                        📍 <%= s.getState() %>
                    </span>
                    <img src="<%= s.getImageUrl() %>" alt="<%= s.getName() %>" onerror="this.src='sanbg.jpg'">
                </div>

                <!-- Right: Information Overview -->
                <div class="detail-header-content">
                    <h1 class="detail-title"><%= s.getName() %></h1>
                    
                    <div class="detail-scientific">
                        <b>Region:</b> <span><%= s.getState() %>, India</span>
                    </div>

                    <!-- Quick Facts Grid -->
                    <div class="facts-grid">
                        <div class="fact-item">
                            <div class="fact-item-label">📍 State / Location</div>
                            <div class="fact-item-value"><%= s.getState() %></div>
                        </div>

                        <div class="fact-item">
                            <div class="fact-item-label">📅 Best Time to Visit</div>
                            <div class="fact-item-value"><%= (s.getBestTime() != null && !s.getBestTime().isEmpty()) ? s.getBestTime() : "October to May" %></div>
                        </div>

                        <div class="fact-item">
                            <div class="fact-item-label">🐅 Key Wildlife & Fauna</div>
                            <div class="fact-item-value"><%= (s.getKeyAnimals() != null && !s.getKeyAnimals().isEmpty()) ? s.getKeyAnimals() : "Diverse Indigenous Species" %></div>
                        </div>

                        <div class="fact-item">
                            <div class="fact-item-label">🛡️ Reserve Designation</div>
                            <div class="fact-item-value">Protected Biosphere / National Park</div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="detail-action-buttons">
                        <a href="sanctuaries" class="btn-primary-action">← Back to Sanctuaries</a>
                        <a href="gallery" class="btn-secondary-action">Explore Wildlife Gallery →</a>
                    </div>
                </div>

            </div>

            <!-- Detailed Ecological Story -->
            <section class="detail-body-section">
                <h2 class="section-heading">
                    <span>🏞️</span> Natural Significance & Ecosystem Overview
                </h2>
                
                <p class="detail-description-text">
                    <%= s.getDescription() %>
                </p>

                <!-- Travel & Safari Tip Highlight -->
                <div class="highlight-card">
                    <div class="highlight-icon">🧭</div>
                    <div class="highlight-content">
                        <h4>Visitor & Conservation Guide</h4>
                        <p>
                            Visiting Indian wildlife sanctuaries supports local conservation efforts and eco-tourism. Always maintain designated safari tracks, avoid single-use plastics, and respect the natural habitat of wild animals and birds.
                        </p>
                    </div>
                </div>
            </section>

            <!-- Other Sanctuaries Strip -->
            <section class="related-strip">
                <h3>🔍 Explore More Indian Wildlife Reserves</h3>
                <div class="related-grid">
                    <% 
                        int count = 0;
                        for (Sanctuary rel : allSanctuaries) {
                            if (rel.getId() != s.getId() && count < 5) {
                                count++;
                    %>
                    <a href="sanctuary-detail?id=<%= rel.getId() %>" class="related-card">
                        <img src="<%= rel.getImageUrl() %>" alt="<%= rel.getName() %>" onerror="this.src='sanbg.jpg'">
                        <div class="related-card-info">
                            <h4><%= rel.getName() %></h4>
                            <span>📍 <%= rel.getState() %></span>
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
