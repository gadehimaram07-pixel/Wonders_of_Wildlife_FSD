<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About - Wonders of Wildlife</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,300..700;1,300..700&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background: #f4f9f4;
            color: #333;
        }

        .navbar-top {
            background-color: #1e4620;
            padding: 16px 80px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-top ul {
            display: flex;
            list-style: none;
            gap: 40px;
            margin: 0;
            padding: 0;
            align-items: center;
        }

        .navbar-top a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: 1.1rem;
            transition: 0.3s;
        }

        .navbar-top a:hover {
            color: #a5d6a7;
        }

        .admin-nav-pill {
            background-color: #2e7d32;
            border: 1px solid #81c784;
            border-radius: 20px;
            padding: 4px 16px !important;
            font-weight: bold !important;
        }

        .admin-nav-pill:hover {
            background-color: #1b5e20 !important;
        }

        header {
            background: linear-gradient(135deg, #2e7d32, #66bb6a);
            color: white;
            text-align: center;
            padding: 40px 20px;
        }

        header h1 {
            font-size: 36px;
            margin-bottom: 8px;
        }

        section {
            padding: 40px 10%;
            text-align: center;
        }

        section h2 {
            margin-bottom: 20px;
            color: #2e7d32;
        }

        .mission ul {
            list-style: none;
        }

        .mission li {
            padding: 10px;
            font-size: 18px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: white;
            padding: 24px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .developer {
            background: #e8f5e9;
            border-radius: 10px;
            max-width: 800px;
            margin: 30px auto;
        }

        .message {
            font-style: italic;
        }

        footer {
            background: #2e7d32;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <nav class="navbar-top">
        <div style="color:white; font-weight:bold; font-size:1.2rem;">🌿 Wonders of Wildlife</div>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="gallery">Gallery</a></li>
            <li><a href="sanctuaries">Sanctuaries</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="admin-login" class="admin-nav-pill">🔒 Admin</a></li>
        </ul>
    </nav>

    <header>
        <h1>🌿 Wonders of Wildlife</h1>
        <p>A Full Stack Development Project on Indian Wildlife, Birds, and Sanctuaries</p>
    </header>

    <section class="about">
        <h2>About Us</h2>
        <p style="font-size: 18px; line-height: 1.8; max-width: 800px; margin: 0 auto;">
            Welcome to our platform dedicated to exploring the rich biodiversity and avian treasures of India.
            From dense Western Ghat rainforests to Himalayan heights and delta wetlands, India offers diverse ecosystems that support thousands of rare and majestic species.
        </p>
    </section>

    <section class="mission">
        <h2>🐦 Our Mission</h2>
        <ul>
            <li>Promote awareness about Indian wildlife sanctuaries and national parks</li>
            <li>Provide useful information for students, wildlife researchers, and travelers</li>
            <li>Encourage conservation and eco-friendly responsible tourism</li>
            <li>Showcase India's unique animals and bird diversity through full stack technology</li>
        </ul>
    </section>

    <section class="features">
        <h2>🌍 What We Offer</h2>
        <div class="cards">
            <div class="card">
                <h3>🔍 Explore Sanctuaries</h3>
                <p>Discover famous wildlife sanctuaries and national parks managed dynamically via Oracle DB.</p>
            </div>
            <div class="card">
                <h3>🐅 Wildlife Gallery</h3>
                <p>Browse mammals and avian species with detailed scientific names, habitats, and locations.</p>
            </div>
            <div class="card">
                <h3>⚙️ Admin Management</h3>
                <p>Interactive administrative panel to add or delete sanctuaries and species dynamically.</p>
            </div>
            <div class="card">
                <h3>📸 Visual Experience</h3>
                <p>Explore wildlife through stunning photography, curated notes, and interactive web pages.</p>
            </div>
        </div>
    </section>

    <section class="developer">
        <h2>👨‍💻 Project Developer</h2>
        <p style="font-size: 17px; line-height: 1.7;">
            Developed as a <strong>Full Stack Development (FSD)</strong> Project.<br>
            <strong>Backend Architecture:</strong> Java Servlets, JSP, Oracle DB, Apache Tomcat.<br>
            <strong>Frontend:</strong> HTML5, CSS3, JavaScript, Video Hero, Responsive Grid.
        </p>
    </section>

    <section class="message">
        <h2>🌱 Conservation Message</h2>
        <p style="font-size: 18px;">
            "Protecting wildlife is our shared responsibility. Every small step towards environmental conservation makes a lasting difference."
        </p>
    </section>

    <footer>
        <p>&copy; Wonders of Wildlife & Sanctuaries of India | Full Stack Project</p>
    </footer>
</body>
</html>
