FlowStock – B2B Inventory Management System
Project Description
FlowStock is a full-stack B2B Inventory Management System developed to simplify inventory tracking, order processing, and multi-shop management. The system allows shop owners to manage products efficiently while enabling administrators to monitor and control operations through a centralized dashboard.
The project demonstrates the implementation of RESTful APIs, modular backend architecture, and real-time data handling using modern web technologies.

Objectives
Simplify inventory management for multiple shops
Provide a structured order management system
Enable real-time data visualization for better decision-making
Implement scalable backend architecture using REST APIs
Key Features
Multi-Shop Management
Unique shopId generation for every shop
Independent inventory tracking for each shop
Product Management
Add new products
Update existing product details
Delete products from inventory
Automatic low-stock indication
Cart and Ordering System
Add products to cart
Place orders efficiently
Manage order workflow
Order Processing
Track order status
Pending and approved order management
Admin-controlled approval system
Interactive Dashboard
Product analytics and insights
Top-performing products visualization
Dynamic chart representation using Chart.js
API-Based Communication
Frontend and backend integration using Fetch API
Real-time data updates without page reloads
Technology Stack
Layer	Technologies Used
Frontend	JSP, HTML, CSS, JavaScript
Backend	Node.js, Express.js
Database	MongoDB with Mongoose
Data Visualization	Chart.js
System Architecture

The application follows a client-server architecture:

Frontend (JSP) handles the user interface and client-side interactions
Backend (Node.js and Express.js) manages business logic and API handling
MongoDB stores shop details, products, and order information
REST API Endpoints
Products
GET /products – Retrieve all products
POST /products – Add a new product
PUT /products/:id – Update product details
DELETE /products/:id – Remove a product
Orders
POST /orders – Place a new order
GET /orders – Fetch all orders
PUT /orders/:id – Update order status
Shops
POST /shops/addShop – Create a new shop
GET /shops/shop/:shopId – Retrieve shop details
Installation and Setup
Step 1 – Clone the Repository
git clone https://github.com/kartigaikwad/Flowstock-B2B.git
cd flowstock
Step 2 – Install Dependencies
npm install
Step 3 – Start Backend Server
node server.js
Step 4 – Run Frontend
Deploy JSP files using Apache Tomcat or any local server
Open the project in a browser
Data Visualization

The dashboard uses Chart.js for graphical representation of data, including:

Top-performing products
Order analytics and statistics

This helps users analyze inventory performance and make better business decisions.

Key Concepts Implemented
RESTful API Design
CRUD Operations
Asynchronous Programming using Fetch API
Modular Backend Architecture
Unique ID Generation Logic
Dynamic Data Visualization

Future Enhancements
JWT-based Authentication
Role-Based Access Control
Real-Time Updates using WebSockets
Mobile Application Integration

Conclusion
FlowStock provides a scalable and efficient solution for inventory and order management in a B2B environment. The project demonstrates strong understanding of full-stack development, REST API integration, database management, and real-time data handling.
