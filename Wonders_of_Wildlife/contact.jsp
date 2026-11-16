<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Wonders of Wildlife</title>
    <link rel="stylesheet" href="contact.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,300..700;1,300..700&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
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

        .alert-box {
            padding: 14px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 15px;
            font-family: 'Roboto', sans-serif;
        }

        .alert-box.success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .alert-box.error {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
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

    <div class="contact-container">
        <div class="contact-info">
            <h1>Contact Us</h1>
            <p class="intro">
                We'd love to hear from you! If you have any questions, feedback, or suggestions about Indian wildlife or this project, feel free to contact us.
            </p>
            <div class="info-box">
                <h3>Email</h3>
                <p>wildlifeadventure@gmail.com</p>
            </div>
            <div class="info-box">
                <h3>Phone</h3>
                <p>+91 99491 05106</p>
            </div>
            <div class="info-box">
                <h3>Location</h3>
                <p>India</p>
            </div>
            <div class="info-box">
                <h3>Project Architecture</h3>
                <p>Full Stack: Java Servlets + JSP + Oracle DB + Tomcat</p>
            </div>
        </div>

        <div class="contact-form">
            <h2>Send a Message</h2>

            <% if ("success".equals(request.getParameter("status"))) { %>
                <div class="alert-box success">
                    ✅ Your message was successfully recorded in our Oracle Database! Thank you for reaching out.
                </div>
            <% } else if ("error".equals(request.getParameter("status"))) { %>
                <div class="alert-box error">
                    ⚠️ Please fill out all required fields properly.
                </div>
            <% } %>

            <form id="contactForm" action="contact" method="POST">
                <input type="text" id="name" name="name" placeholder="Your Full Name" required>
                <input type="email" id="email" name="email" placeholder="Your Email Address" required>
                <input type="text" id="subject" name="subject" placeholder="Subject / Topic" required>
                <textarea id="message" name="message" rows="5" placeholder="Write your feedback or message here..." required></textarea>
                <button type="submit" class="submit-btn">Submit to Database</button>
            </form>
        </div>
    </div>
</body>
</html>
