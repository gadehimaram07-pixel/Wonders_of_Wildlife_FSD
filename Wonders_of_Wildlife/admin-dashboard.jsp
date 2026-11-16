<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wildlife.model.Animal" %>
<%@ page import="com.wildlife.model.Sanctuary" %>
<%@ page import="com.wildlife.model.AdminUser" %>
<%@ page import="com.wildlife.model.ContactMessage" %>
<%@ page import="com.wildlife.dao.AnimalDAO" %>
<%@ page import="com.wildlife.dao.SanctuaryDAO" %>
<%@ page import="com.wildlife.dao.ContactDAO" %>
<%
    // Ensure only logged-in administrators can access
    AdminUser adminUser = (AdminUser) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("admin-login");
        return;
    }

    // Load data from request attributes or fallback to DAOs
    SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();
    AnimalDAO animalDAO = new AnimalDAO();
    ContactDAO contactDAO = new ContactDAO();

    List<Sanctuary> sanctuaries = (List<Sanctuary>) request.getAttribute("sanctuaries");
    if (sanctuaries == null) sanctuaries = sanctuaryDAO.getAllSanctuaries();

    List<Animal> animals = (List<Animal>) request.getAttribute("animals");
    if (animals == null) animals = animalDAO.getAllAnimals();

    List<ContactMessage> messages = (List<ContactMessage>) request.getAttribute("messages");
    if (messages == null) messages = contactDAO.getAllMessages();

    int animalCount = animalDAO.getCountByCategory("Animal");
    int birdCount = animalDAO.getCountByCategory("Bird");
    int sanctuaryCount = sanctuaries.size();
    int messageCount = messages.size();

    String msg = request.getParameter("msg");
    String err = request.getParameter("err");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Wonders of Wildlife</title>
    <link rel="stylesheet" href="admin.css">
</head>
<body>

    <!-- Admin Header -->
    <header class="admin-header">
        <h1>
            <span>🌿 Wonders of Wildlife</span>
            <span class="badge">ADMIN PORTAL</span>
        </h1>
        <div class="admin-nav">
            <span>Welcome, <b><%= adminUser.getFullName() != null ? adminUser.getFullName() : adminUser.getUsername() %></b></span>
            <a href="home.jsp" target="_blank">🌐 View Website</a>
            <a href="admin-logout" class="logout-btn">🚪 Logout</a>
        </div>
    </header>

    <div class="admin-container">

        <!-- Notification Alerts -->
        <% if ("sanctuary_added".equals(msg)) { %>
            <div class="alert alert-success">✅ Wildlife Sanctuary has been successfully added to Oracle DB!</div>
        <% } else if ("sanctuary_deleted".equals(msg)) { %>
            <div class="alert alert-success">🗑️ Wildlife Sanctuary was successfully removed from Oracle DB!</div>
        <% } else if ("animal_added".equals(msg)) { %>
            <div class="alert alert-success">✅ Wildlife species has been successfully added to Oracle DB!</div>
        <% } else if ("animal_deleted".equals(msg)) { %>
            <div class="alert alert-success">🗑️ Wildlife species was successfully removed from Oracle DB!</div>
        <% } else if (err != null) { %>
            <div class="alert alert-danger">⚠️ Action failed: <%= err %></div>
        <% } %>

        <!-- Statistics Overview -->
        <div class="stats-grid">
            <div class="stat-card sanctuaries">
                <div class="stat-icon">🏞️</div>
                <div class="stat-info">
                    <h3>Sanctuaries</h3>
                    <p><%= sanctuaryCount %></p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🐅</div>
                <div class="stat-info">
                    <h3>Mammals & Animals</h3>
                    <p><%= animalCount %></p>
                </div>
            </div>
            <div class="stat-card birds">
                <div class="stat-icon">🦜</div>
                <div class="stat-info">
                    <h3>Bird Species</h3>
                    <p><%= birdCount %></p>
                </div>
            </div>
            <div class="stat-card inquiries">
                <div class="stat-icon">✉️</div>
                <div class="stat-info">
                    <h3>Inquiries</h3>
                    <p><%= messageCount %></p>
                </div>
            </div>
        </div>

        <!-- Section 1: Sanctuaries Management -->
        <section class="admin-card">
            <div class="card-title">
                <span>🏞️ Manage Wildlife Sanctuaries</span>
                <span style="font-size: 14px; font-weight: normal; color: #666;">Add or Delete Sanctuaries</span>
            </div>

            <!-- Form: Add Sanctuary -->
            <form action="admin/sanctuary" method="POST" style="margin-bottom: 30px; background: #fafdfa; padding: 20px; border-radius: 8px; border: 1px solid #e2ece2;">
                <input type="hidden" name="action" value="add">
                <h3 style="font-size: 16px; margin-bottom: 15px; color: #2e7d32;">➕ Add New Sanctuary</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Sanctuary Name *</label>
                        <input type="text" name="name" placeholder="e.g. Kaziranga National Park" required>
                    </div>
                    <div class="form-group">
                        <label>State / Region *</label>
                        <input type="text" name="state" placeholder="e.g. Assam" required>
                    </div>
                    <div class="form-group">
                        <label>Best Time to Visit</label>
                        <input type="text" name="bestTime" placeholder="e.g. November to April">
                    </div>
                    <div class="form-group">
                        <label>Key Animals & Highlights</label>
                        <input type="text" name="keyAnimals" placeholder="e.g. One-horned Rhino, Bengal Tiger, Elephant">
                    </div>
                    <div class="form-group">
                        <label>Image Filename or URL</label>
                        <input type="text" name="imageUrl" placeholder="e.g. rhino.jpg or jimcorbett.jpg">
                    </div>
                    <div class="form-group full-width">
                        <label>Description & Natural Significance *</label>
                        <textarea name="description" rows="3" placeholder="Provide detailed background, ecosystem, geography and significance..." required></textarea>
                    </div>
                </div>
                <button type="submit" class="btn-submit">➕ Save Sanctuary to Oracle DB</button>
            </form>

            <!-- Table: Existing Sanctuaries -->
            <h3 style="font-size: 16px; margin-bottom: 12px; color: #37474f;">Current Sanctuaries in Database (<%= sanctuaries.size() %>)</h3>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Preview</th>
                            <th>Sanctuary Name</th>
                            <th>State</th>
                            <th>Key Fauna</th>
                            <th>Best Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Sanctuary s : sanctuaries) { %>
                        <tr>
                            <td>#<%= s.getId() %></td>
                            <td><img src="<%= s.getImageUrl() %>" alt="<%= s.getName() %>" class="admin-thumb" onerror="this.src='sanbg.jpg'"></td>
                            <td><b><%= s.getName() %></b></td>
                            <td><%= s.getState() %></td>
                            <td style="max-width: 260px;"><%= s.getKeyAnimals() != null ? s.getKeyAnimals() : "-" %></td>
                            <td><%= s.getBestTime() != null ? s.getBestTime() : "-" %></td>
                            <td>
                                <a href="sanctuary-detail?id=<%= s.getId() %>" target="_blank" class="btn-view">View</a>
                                <form action="admin/sanctuary" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete <%= s.getName() %>?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= s.getId() %>">
                                    <button type="submit" class="btn-delete">🗑️ Delete</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        <% if (sanctuaries.isEmpty()) { %>
                        <tr>
                            <td colspan="7" style="text-align:center; padding: 20px; color: #999;">No sanctuaries found in database.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Section 2: Animals & Birds Management -->
        <section class="admin-card">
            <div class="card-title">
                <span>🐅 Manage Animals & Birds</span>
                <span style="font-size: 14px; font-weight: normal; color: #666;">Add or Delete Wildlife Species</span>
            </div>

            <!-- Form: Add Animal / Bird -->
            <form action="admin/animal" method="POST" style="margin-bottom: 30px; background: #fafdfa; padding: 20px; border-radius: 8px; border: 1px solid #e2ece2;">
                <input type="hidden" name="action" value="add">
                <h3 style="font-size: 16px; margin-bottom: 15px; color: #2e7d32;">➕ Add New Animal / Bird</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Common Name *</label>
                        <input type="text" name="name" placeholder="e.g. Snow Leopard or Himalayan Monal" required>
                    </div>
                    <div class="form-group">
                        <label>Category *</label>
                        <select name="category" required>
                            <option value="Animal">Animal / Mammal</option>
                            <option value="Bird">Bird</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Scientific Name</label>
                        <input type="text" name="scientificName" placeholder="e.g. Panthera uncia">
                    </div>
                    <div class="form-group">
                        <label>Natural Habitat</label>
                        <input type="text" name="habitat" placeholder="e.g. Alpine rugged mountains">
                    </div>
                    <div class="form-group">
                        <label>Sanctuaries / Found In</label>
                        <input type="text" name="foundIn" placeholder="e.g. Hemis National Park, Ladakh">
                    </div>
                    <div class="form-group">
                        <label>Image Filename or URL</label>
                        <input type="text" name="imageUrl" placeholder="e.g. image1.jpg, leopard.jpg, or URL">
                    </div>
                    <div class="form-group full-width">
                        <label>Species Description & Conservation Notes *</label>
                        <textarea name="description" rows="3" placeholder="Provide behavior, physical characteristics, and ecological importance..." required></textarea>
                    </div>
                </div>
                <button type="submit" class="btn-submit">➕ Save Animal / Bird to Oracle DB</button>
            </form>

            <!-- Table: Existing Animals & Birds -->
            <h3 style="font-size: 16px; margin-bottom: 12px; color: #37474f;">Current Species in Database (<%= animals.size() %>)</h3>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Preview</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Scientific Name</th>
                            <th>Habitat</th>
                            <th>Found In</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Animal a : animals) { %>
                        <tr>
                            <td>#<%= a.getId() %></td>
                            <td><img src="<%= a.getImageUrl() %>" alt="<%= a.getName() %>" class="admin-thumb" onerror="this.src='bgtiger.jpg'"></td>
                            <td><b><%= a.getName() %></b></td>
                            <td>
                                <span class="tag-badge <%= "Bird".equalsIgnoreCase(a.getCategory()) ? "tag-bird" : "tag-animal" %>">
                                    <%= a.getCategory() %>
                                </span>
                            </td>
                            <td><i><%= a.getScientificName() != null ? a.getScientificName() : "-" %></i></td>
                            <td><%= a.getHabitat() != null ? a.getHabitat() : "-" %></td>
                            <td style="max-width: 220px;"><%= a.getFoundIn() != null ? a.getFoundIn() : "-" %></td>
                            <td>
                                <a href="animal-detail?id=<%= a.getId() %>" target="_blank" class="btn-view">View</a>
                                <form action="admin/animal" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete <%= a.getName() %>?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= a.getId() %>">
                                    <button type="submit" class="btn-delete">🗑️ Delete</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        <% if (animals.isEmpty()) { %>
                        <tr>
                            <td colspan="8" style="text-align:center; padding: 20px; color: #999;">No animals or birds found in database.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Section 3: Inquiries -->
        <section class="admin-card">
            <div class="card-title">
                <span>✉️ Visitor Messages & Feedback (<%= messages.size() %>)</span>
            </div>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Sender Name</th>
                            <th>Email</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Submitted At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ContactMessage m : messages) { %>
                        <tr>
                            <td>#<%= m.getId() %></td>
                            <td><b><%= m.getName() %></b></td>
                            <td><a href="mailto:<%= m.getEmail() %>"><%= m.getEmail() %></a></td>
                            <td><%= m.getSubject() %></td>
                            <td><%= m.getMessage() %></td>
                            <td><%= m.getSubmittedAt() != null ? m.getSubmittedAt().toString().substring(0, 19) : "-" %></td>
                        </tr>
                        <% } %>
                        <% if (messages.isEmpty()) { %>
                        <tr>
                            <td colspan="6" style="text-align:center; padding: 20px; color: #999;">No feedback or messages yet.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>

    </div>
</body>
</html>
