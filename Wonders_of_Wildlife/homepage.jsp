<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Wonders of Wildlife - Explore Nature</title>
    <link rel="stylesheet" href="style1.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,300..700;1,300..700&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        .admin-nav-pill {
            background-color: rgba(46, 125, 50, 0.7);
            border: 1px solid #81c784;
            border-radius: 20px;
            padding: 4px 14px !important;
            font-weight: bold !important;
        }
        .admin-nav-pill:hover {
            background-color: #2e7d32 !important;
        }
        .search-box {
            position: absolute;
            top: 24px;
            right: 40px;
            z-index: 10;
        }
        .search-box input {
            padding: 8px 14px;
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.4);
            background: rgba(0,0,0,0.4);
            color: white;
            outline: none;
            backdrop-filter: blur(5px);
        }
        .search-box input::placeholder {
            color: #ddd;
        }
        .search-box button {
            padding: 8px 16px;
            border: none;
            background-color: #2e7d32;
            color: white;
            border-radius: 20px;
            cursor: pointer;
            margin-left: 5px;
        }
        .quick-actions {
            margin-top: 30px;
            display: flex;
            gap: 20px;
            justify-content: center;
        }
        .hero-btn {
            background-color: #2e7d32;
            color: white;
            padding: 12px 28px;
            border-radius: 30px;
            text-decoration: none;
            font-family: 'Cormorant', serif;
            font-size: 20px;
            font-weight: bold;
            transition: 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }
        .hero-btn:hover {
            background-color: #1b5e20;
            transform: scale(1.05);
        }
        .hero-btn.secondary {
            background-color: rgba(255,255,255,0.2);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255,255,255,0.4);
        }
        .hero-btn.secondary:hover {
            background-color: rgba(255,255,255,0.4);
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

    <div class="search-box">
        <form action="gallery" method="GET" style="display:flex;">
            <input type="text" name="q" placeholder="Search wildlife, birds...">
            <button type="submit">Search</button>
        </form>
    </div>

    <div class="bg-video">
        <video autoplay loop muted playsinline> 
            <source src="backgroundvideo.mp4" type="video/mp4">
        </video>
    </div>
        
    <div class="hero-text1">
        <h1>WONDERS OF WILDLIFE</h1>
        <h3>- Explore the beauty of nature -</h3>
        <div class="quick-actions">
            <a href="home.jsp" class="hero-btn">Explore Wildlife</a>
            <a href="sanctuaries" class="hero-btn secondary">View Sanctuaries</a>
        </div>
    </div>
</body>
</html>
