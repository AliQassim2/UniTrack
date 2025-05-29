# 🎓 UniTrack – University Attendance & Grade Management System

---

## 1. 📘 Description

**UniTrack** is a full university management system built using **pure PHP**. It automates attendance, grade tracking, absence alerts, and academic progression. The system is designed for use across:

* 🧩 A PHP RESTful API (core backend)
* 📱 Mobile application
* 🌐 Web frontend
* 💻 Desktop application

Perfect for educational institutions or developers who want a scalable, open-source solution.

---

## 2. ❗ Problem

Universities often face issues like:

* Manual attendance tracking
* Paper-based grade recording
* Delays in absentee alerts
* Lack of real-time student progress data

**UniTrack** solves these issues with:

* Real-time attendance and grading
* Centralized student records
* Automatic absence alerting
* Progression tracking to the next level

---

## 3. ✨ Features

* ✅ User authentication (register/login)
* ✅ Record and retrieve attendance
* ✅ Grade submission and analysis
* ✅ Alert system for absent students
* ✅ Student progression tracking
* ✅ Fully RESTful PHP backend

---

## 4. 🧱 Project Structure

This repo includes 4 branches for each platform:

| Branch    | Description                    |
| --------- | ------------------------------ |
| `api`     | Pure PHP RESTful API           |
| `mobile`  | Mobile app (to be developed)   |
| `web`     | Web frontend (to be developed) |
| `desktop` | Desktop app (to be developed)  |

---

## 5. 🛢️ Database Schema

📌 *Upload your schema image, then replace the path below:*

```markdown
![Database Schema](path/to/your/schema-image.png)
```

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

---

## 11. 📊 Work Plan: System Roles, Data Flow & Access Levels

> 🎯 **Overview**
> This section outlines the responsibilities, access levels, and data interaction patterns for each user in the **UniTrack** system.

### 🗂️ Diagram Overview

![UniTrack drawio (7)](https://github.com/user-attachments/assets/75a4080f-2b42-419a-966c-152a6a73b20a)
*A visual representation of the role hierarchy and data flow across the system.*

---

## 🔷 Student Role \[`Read-only 👁️`]

🎓 Students are divided into two shifts:

* 🕗 **Morning**
* 🌙 **Evening**

#### 🛠️ Permissions:

* ![View](https://img.shields.io/badge/View-Absences-blue) View their own attendance records.
* ![View](https://img.shields.io/badge/View-Marks-blue) View all marks:

  * Quizzes
  * Midterms
  * Finals
  * Curved Grades (if applicable)

> 🛑 **Cannot** request or edit any information. Purely informational access.

---

## 🔷 Teacher Role \[`Input + View 👁️✍️`]

Teachers are divided into two categories:

### 🧪 Practical Teachers

Role: Handle lab and hands-on sessions.

* ![View](https://img.shields.io/badge/View-Practical_Students-blue)
* ![Edit](https://img.shields.io/badge/Edit-Practical_Marks_&_Absences-green)

> 🔒 No access to modify theoretical data.

---

### 📖 Theoretical Teachers

Role: Manage lectures and written assessments.

* ![View](https://img.shields.io/badge/View-Theoretical_Students-blue)
* ![Edit](https://img.shields.io/badge/Edit-Theory_Marks_&_Absences-green)

> 🔒 Cannot modify practical data but can view it (if granted access).

---

## 🔷 Academic Oversight Roles \[`Supervisor Access 🛡️`]

These roles are responsible for oversight, validation, and policy compliance.

### 🏛️ Department Curriculum Committee

* ![Monitor](https://img.shields.io/badge/Monitor-Attendance-yellow)
* ![Action](https://img.shields.io/badge/Issue-Warnings-red)

---

### 🧑‍🏫 Head of Department

* ![Approve](https://img.shields.io/badge/Approve-Teacher_Marks-orange)
* Ensures consistency and grading fairness.

---

### 🎓 Dean of College

* ![Approve](https://img.shields.io/badge/Final_Approval-All_Marks_&_Absences-brightgreen)
* Highest academic validator.

---

### 🧑‍💼 University Supervisors

* ![View](https://img.shields.io/badge/View-All_Student_Data-blue)
* ![Enforce](https://img.shields.io/badge/Ensure-Policy_Compliance-lightgrey)

---

## 🧩 Role Summary Table

| **Role**                     | 🖥️ **View Access**    | ✏️ **Add/Edit Marks** | 🕘 **Record Absences** | ✅ **Approval Rights** | 🚨 **Actions**       |
| ---------------------------- | ---------------------- | --------------------- | ---------------------- | --------------------- | -------------------- |
| 👨‍🎓 Student                | ✅ Own only             | ❌                     | ❌                      | ❌                     | ❌                    |
| 👨‍🏫 Teacher - Practical    | ✅ Own students         | ✅ Practical only      | ✅ Practical only       | ❌                     | ❌                    |
| 👩‍🏫 Teacher - Theoretical  | ✅ Own + Practical View | ✅ Theory only         | ✅ Theory only          | ❌                     | ❌                    |
| 📋 Curriculum Committee      | ✅ All                  | ❌                     | ✅ Monitor only         | ❌                     | ✅ Warnings           |
| 🏫 Head of Department        | ✅ All                  | ❌                     | ❌                      | ✅ Teachers’ Marks     | ❌                    |
| 🎓 Dean of College           | ✅ All                  | ❌                     | ❌                      | ✅ Final Approval      | ❌                    |
| 🧑‍💼 University Supervisors | ✅ All                  | ❌                     | ❌                      | ❌                     | ✅ Policy Enforcement |

---

> 🔐 **Summary**: UniTrack enforces strict role-based access to maintain data integrity, academic fairness, and institutional compliance.
