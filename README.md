# 🌿 Wonders of Wildlife - Full Stack Development (FSD) Project

A complete full-stack web application showcasing Indian Wildlife, Avian Species, and Wildlife Sanctuaries. Built using **Java Servlets**, **JSP (JavaServer Pages)**, **Oracle Database XE**, and **Apache Tomcat**.

---

## 🚀 Key Changes & Features Implemented

1. **Website Login Gate Removed**:
   - The public website (`/`, `homepage.jsp`, `home.jsp`, `gallery`, `sanctuaries`, etc.) is now **open to all visitors without any login barrier**.
   - Visitors can explore wildlife species, birds, and national parks freely.

2. **Secure Admin Panel & Authentication**:
   - Login authentication is now dedicated to the **Admin Panel** (`/admin-login`).
   - Only authenticated administrators can log in to manage database records.
   - Built with secure HTTP session tracking and logout functionality.

3. **Admin Dashboard (Add & Delete Capabilities)**:
   - **Add Wildlife Sanctuary**: Enter Sanctuary Name, State, Description, Highlights/Fauna, Best Time, and Image.
   - **Delete Sanctuary**: Instantly removes records from Oracle DB with confirmation safeguards.
   - **Add Animal or Bird Species**: Common Name, Category (`Animal` or `Bird`), Scientific Name, Habitat, Found In, Image URL/file, and Description.
   - **Delete Animal or Bird**: Instantly removes species from Oracle DB.
   - **Live Statistics Overview**: Real-time counter of total sanctuaries, mammals, birds, and contact inquiries.
   - **Contact Messages Viewer**: Review visitor feedback submitted through the contact page.

4. **Expanded Wildlife Dataset**:
   - **Mammals / Animals**: Bengal Tiger, Indian Rhinoceros, Asian Elephant, Indian Leopard, Asiatic Lion, Blackbuck, Nilgiri Tahr, Kashmir Stag (Hangul), Indian Wild Ass (Khur), Spotted Deer (Chital), and more.
   - **Birds of India**: Great Indian Hornbill, Indian Peafowl (Peacock), Rose-ringed Parakeet, Malabar Pied Hornbill, and more.
   - **Sanctuaries & National Parks**: Jim Corbett National Park, Gir National Park, Periyar Tiger Reserve, Chinnar Wildlife Sanctuary, Wayanad Wildlife Sanctuary, Bondla Wildlife Sanctuary, Karnala Bird Sanctuary, Wild Ass Sanctuary (Little Rann of Kutch), Dandeli Wildlife Sanctuary, Sundarbans National Park, Kaziranga National Park, Ranthambore National Park, and more.

5. **Clean & Simple Backend Architecture**:
   - Zero bulky frameworks—standard, easy-to-understand **Servlets + JSP + standard JDBC**.
   - Clean MVC (Model-View-Controller) structure:
     - **Model**: `Animal`, `Sanctuary`, `AdminUser`, `ContactMessage`
     - **DAO**: `AnimalDAO`, `SanctuaryDAO`, `AdminDAO`, `ContactDAO`
     - **Util**: `DBConnection` (Oracle JDBC connection pool helper)
     - **Controllers (Servlets)**: `HomeServlet`, `GalleryServlet`, `SanctuariesServlet`, `AnimalDetailServlet`, `SanctuaryDetailServlet`, `AdminLoginServlet`, `AdminLogoutServlet`, `AdminDashboardServlet`, `AdminSanctuaryServlet`, `AdminAnimalServlet`, `ContactServlet`
     - **Views (JSP)**: `index.jsp`, `homepage.jsp`, `home.jsp`, `gallery.jsp`, `sanctuaries.jsp`, `animal-detail.jsp`, `sanctuary-detail.jsp`, `admin-login.jsp`, `admin-dashboard.jsp`, `about.jsp`, `contact.jsp`

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| **Server / Runtime** | Apache Tomcat 9.0 (HTTP Port: `8081`) |
| **Java Platform** | Java JDK (Java EE 8 / Servlet 4.0 & JSP 2.3) |
| **Database** | Oracle Database 10g/11g/19c/21c Express Edition (XE) on Port `1521` |
| **JDBC Driver** | Oracle JDBC Thin Driver (`ojdbc14.jar`) |
| **Frontend** | HTML5, CSS3, JavaScript, Video Backgrounds, Responsive Flexbox & Grid |

---

## 🔑 Admin Credentials

| Username | Password | Role |
|---|---|---|
| `admin` | `admin123` | Full Administrator |
| `wildlife123` | `tiger123` | Wildlife Staff |

---

## 🌐 Application URL Map

| Page | URL | Purpose |
|---|---|---|
| **Home Landing** | `http://localhost:8081/Wonders_of_Wildlife/` | Hero video landing page |
| **Main Home** | `http://localhost:8081/Wonders_of_Wildlife/home.jsp` | Welcome section & featured fauna |
| **Gallery (All)** | `http://localhost:8081/Wonders_of_Wildlife/gallery` | Full animal & bird gallery |
| **Gallery (Birds)** | `http://localhost:8081/Wonders_of_Wildlife/gallery?category=Bird` | Filtered birds of India |
| **Gallery (Animals)** | `http://localhost:8081/Wonders_of_Wildlife/gallery?category=Animal` | Filtered mammals & wild animals |
| **Sanctuaries** | `http://localhost:8081/Wonders_of_Wildlife/sanctuaries` | Wildlife sanctuaries & national parks |
| **Animal Details** | `http://localhost:8081/Wonders_of_Wildlife/animal-detail?id=1` | Dynamic animal detail view |
| **Sanctuary Details** | `http://localhost:8081/Wonders_of_Wildlife/sanctuary-detail?id=1` | Dynamic sanctuary detail view |
| **About Us** | `http://localhost:8081/Wonders_of_Wildlife/about.jsp` | About project & developer details |
| **Contact Us** | `http://localhost:8081/Wonders_of_Wildlife/contact.jsp` | Contact form with DB persistence |
| **Admin Login** | `http://localhost:8081/Wonders_of_Wildlife/admin-login` | Admin authentication portal |
| **Admin Dashboard** | `http://localhost:8081/Wonders_of_Wildlife/admin-dashboard` | Add / Delete sanctuaries & species |

---

## 📂 Project Directory Structure

```text
C:\Wonders_of_Wildlife\
├── Wonders_of_Wildlife/                # Web Application Root
│   ├── WEB-INF/
│   │   ├── web.xml                     # Deployment Descriptor
│   │   ├── classes/                    # Compiled Java .class files
│   │   └── lib/                        # Libraries (ojdbc14.jar, servlet-api, jsp-api)
│   ├── src/com/wildlife/
│   │   ├── util/DBConnection.java      # Oracle JDBC connection manager
│   │   ├── model/                      # Java Beans (Animal, Sanctuary, AdminUser, ContactMessage)
│   │   ├── dao/                        # Data Access Objects with PreparedStatements
│   │   └── servlet/                    # Java EE HTTP Servlets (javax.servlet)
│   ├── sql/
│   │   ├── schema.sql                  # Oracle DB table definitions & sequences
│   │   └── DBInit.java                 # Standalone database seeder
│   ├── css/ & style files              # style1.css, animal.css, sanctuaries.css, admin.css, etc.
│   ├── media files                     # Images (.jpg, .png) and Videos (.mp4)
│   └── jsp pages                       # All dynamic JSP views
├── tomcat_base/                        # Active Tomcat instance (conf, logs, webapps, work)
├── build_and_deploy.bat                # 1-click script to compile and deploy to Tomcat
├── start_server.bat                    # 1-click script to start Tomcat on port 8081
├── stop_server.bat                     # Script to stop Tomcat
└── setup_oracle_database.bat           # Script to re-seed Oracle DB
```

---

## ⚡ How to Run

1. **Verify Oracle DB is running**:
   - `OracleServiceXE` and `OracleXETNSListener` run as Windows services on port `1521`.
2. **Start the Tomcat Server**:
   - Double-click `start_server.bat` (or run `cmd /c C:\Wonders_of_Wildlife\start_server.bat`).
3. **Open the Website in your browser**:
   - Navigate to: **`http://localhost:8081/Wonders_of_Wildlife/`** (or `http://localhost:8081/`).
4. **Log in to Admin Panel**:
   - Click **"🔒 Admin"** on the top navigation bar or go directly to `http://localhost:8081/Wonders_of_Wildlife/admin-login`.
   - Enter `admin` / `admin123`.
   - Test adding or deleting sanctuaries and animals/birds!
