Thanks! Since you're using **pure PHP** (not Laravel), here's the updated `README.md` tailored to your stack:

---

````markdown
# 🎓 UniTrack – University Attendance & Grade Management System

---

## 1. 📘 Description

**UniTrack** is a full university management system built using **pure PHP**. It automates attendance, grade tracking, absence alerts, and academic progression. The system is designed for use across:

- 🧩 A PHP RESTful API (core backend)
- 📱 Mobile application
- 🌐 Web frontend
- 💻 Desktop application

Perfect for educational institutions or developers who want a scalable, open-source solution.

---

## 2. ❗ Problem

Universities often face issues like:
- Manual attendance tracking
- Paper-based grade recording
- Delays in absentee alerts
- Lack of real-time student progress data

**UniTrack** solves these issues with:
- Real-time attendance and grading
- Centralized student records
- Automatic absence alerting
- Progression tracking to the next level

---

## 3. ✨ Features

- ✅ User authentication (register/login)
- ✅ Record and retrieve attendance
- ✅ Grade submission and analysis
- ✅ Alert system for absent students
- ✅ Student progression tracking
- ✅ Fully RESTful PHP backend

---

## 4. 🧱 Project Structure

This repo includes 4 branches for each platform:

| Branch      | Description                            |
|-------------|----------------------------------------|
| `api`       | Pure PHP RESTful API                   |
| `mobile`    | Mobile app (to be developed)           |
| `web`       | Web frontend (to be developed)         |
| `desktop`   | Desktop app (to be developed)          |

---

## 5. 🛢️ Database Schema

📌 *Upload your schema image, then replace the path below:*

```markdown
![Database Schema](path/to/your/schema-image.png)
````

---

## 6. 🔗 API Usage

### Base URL

```
http://yourdomain.com/api/
```

### Authentication

#### Register

```http
POST /api/register.php
{
  "name": "Ali",
  "email": "ali@example.com",
  "password": "123456"
}
```

#### Login

```http
POST /api/login.php
{
  "email": "ali@example.com",
  "password": "123456"
}
```

### Attendance

#### Mark Attendance

```http
POST /api/attendance.php
{
  "student_id": 1,
  "status": "present",
  "date": "2025-05-25"
}
```

#### Get Attendance

```http
GET /api/get_attendance.php?student_id=1
```

### Grades

#### Submit Grade

```http
POST /api/grades.php
{
  "student_id": 1,
  "subject": "Math",
  "grade": 85
}
```

#### Get Grades

```http
GET /api/get_grades.php?student_id=1
```

---

## 7. 🛠️ How to Run the Project Locally

### Requirements

* PHP 8+
* MySQL
* Apache or Nginx
* Postman or any API tester

### Installation

```bash
git clone https://github.com/AliQassim2/unitrack.git
cd unitrack/api
```

1. Import the SQL database (to be included in repo)
2. Configure your database credentials in `/config/db.php`
3. Start Apache or PHP local server:

```bash
php -S localhost:8000
```

You can now access the API at:
`http://localhost:8000/api/`

---

## 8. 🧾 License

**MIT License**
Feel free to use, contribute, or fork the project.

---

## 9. 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

---

## 10. 📧 Contact

Built by **Ali Qassim**
GitHub: [AliQassim2](https://github.com/AliQassim2)

1. Work Plan: Roles, Data Flow, and Access Levels
The following diagram outlines the full hierarchy and data interactions in UniTrack:

Level 1 (Students):
Submit quizzes, receive marks (mid/final), and have absence tracked (morning/evening).

Level 2 (Teachers):
Manage practical and theoretical scores and record attendance.

Level 3 (Management):

Department Curriculum: Monitors attendance and issues warnings.

Head of Department: Approves student grades.

Dean of the College: Grants final academic approvals.

University Supervisors: Oversee all grades and attendance.

📎 Diagram:
![UniTrack drawio](https://github.com/user-attachments/assets/e6548163-43d8-4830-84f1-bb76e9d3c0c6)


---



