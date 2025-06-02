# 🎓 UniTrack – University Attendance & Grade Management System

![Status](https://img.shields.io/badge/status-Active-success)

---

## 1. 📘 Description

**UniTrack** is a comprehensive university management system built with **pure PHP**. It automates:

* Attendance tracking
* Grade recording and analysis
* Absence alerts
* Academic progression

The system is designed to be used across multiple platforms:

* 🧩 **PHP backend (core)**
* 📱 **Mobile application** (coming soon)
* 🌐 **Web frontend** (coming soon)
* 💻 **Desktop application** (coming soon)

UniTrack is ideal for educational institutions or developers seeking a scalable, open-source solution.

---

## 2. ❗ Problem

Many universities face challenges such as:

* Manual, paper-based attendance tracking
* Spreadsheet or paper-based grade recording
* Delayed absence notifications
* Lack of real-time visibility into student progress

**UniTrack** addresses these issues by providing:

* 🕒 Real-time attendance and grading
* 📑 Centralized, digital student records
* 🔔 Automated absence alerting
* 📈 Clear progression tracking to the next academic stage

---

## 3. ✨ Features

* ✅ Secure user authentication (register/login)
* ✅ Record and retrieve attendance (per lecture, per day)
* ✅ Submit and analyze grades (quizzes, midterms, finals, practicals)
* ✅ Automatic alert system for absent or underperforming students
* ✅ Student progression tracking (automatic promotion logic)
* ✅ Pure PHP backend (no external frameworks required)

---

## 4. 🧱 Project Structure

This repository is organized into four main branches, each targeting a different platform:

| Branch    | Description                       |
| --------- | --------------------------------- |
| `api`     | Core PHP backend (in progress)    |
| `mobile`  | Mobile application (in progress)  |
| `web`     | Web frontend (in progress)        |
| `desktop` | Desktop application (in progress) |

---

## 5. 🛢️ Database Schema

![UniTrack Database Schema](https://github.com/user-attachments/assets/711ccbec-e299-444e-825e-f59e3345ed4e)

### 📚 Database Schema & Design Rationale

UniTrack follows a **fixed, stage-based curriculum model**:

1. **`users` / `student` / `teacher`**

   * **`users`**: Common login/authentication fields (`username`, `email`, `password`, `remember_token`).
   * Each row in `users` may reference exactly one `student_id` **OR** `teacher_id`.

     * A row in **`student`** holds student-specific information (e.g., `stage_id`, `remember_token`).
     * A row in **`teacher`** holds instructor-specific data (e.g., `academic_rank`, `department_id`, `is_manage`).
   * This separation allows one unified authentication table while keeping student and teacher attributes distinct.

2. **`departments` & `Stage`**

   * **`departments`**: Lists all academic departments (e.g., “Computer Science,” “Mathematics”).
   * **`Stage`**: Defines a fixed academic cohort (e.g., “2nd Year, Group A, CS Department, Evening Shift”).

     * Fields: `Name` (e.g., “Year 2”), `Group` (tinyint, e.g., `1` or `2`), `department_id`, `is_morning` (boolean).
   * Every student belongs to one `Stage`. Since lectures are assigned to a stage, there is **no need for an “enrollments” table**—all students within that stage automatically take the same lectures.

3. **`Lectures` & `lecture_teachers`**

   * **`Lectures`**: Defines each course offered to a stage (`Name`, `semester`, `Stage_id`, `is_practical`, `date`).
   * **`lecture_teachers`** (junction table): Links `teacher_id` → `lecture_id` (many-to-many).

     * The boolean `is_practical` indicates if the teacher handles the practical component (labs, workshops) versus the theoretical component.
   * This design allows a single lecture to have separate instructors for theory and practical sessions when needed.

4. **`grades_totle` & `grades`**

   * **`grades_totle`**: Aggregates a student’s overall performance per lecture:

     * Columns include `mid`, `practical_mid`, `quiz`, `practical_quiz`, `absence`, `practical_absence`, `curve`, `pre_final_grade`, `first_approval`, `final`, `approval_HOD`, `approval_DOC`, plus `student_id`.
     * Captures the **approval workflow**—once “mid” and “practical\_mid” are entered, the Head of Department (HOD) and Dean of College can approve the combined preliminary grades.
   * **`grades`**: Stores each individual exam or quiz entry:

     * Fields: `student_id`, `recorded_by` (teacher ID), `lecture_id`, `exam_type` (ENUM: `midterm`, `final`, `practical`, `quiz`, etc.), `score`, `date`.
     * By separating raw exam scores (`grades`) from the aggregated approval state (`grades_totle`), you maintain a complete audit trail while controlling final grade approvals.

5. **`attendance` & `alerts`**

   * **`attendance`**: Tracks daily presence for each student in each lecture:

     * Fields: `student_id`, `recorded_by` (teacher ID), `lecture_id`, `date`, `status` (tinyint or ENUM: `present`, `absent`, `late`), `remarks`.
   * **`alerts`**: Triggers warnings for academic issues (e.g., “Too many absences,” “Low overall grade”).

     * Fields: `student_id`, `created_by` (staff or teacher ID), `type` (ENUM: `absence_warning`, `grade_warning`, etc.), `message`, `resolved` (boolean), `created_at`.

6. **`Management`**

   * Maps teachers to **administrative roles** (Department Curriculum Committee, Head of Department, Dean of College, University Supervisor) over a date range:

     * Fields: `teacher_id`, `role` (tinyint referencing a static list of management roles), `start_date`, `end_date`.
   * This table allows tracking exactly which teacher holds which administrative office at any given time, rather than embedding role fields directly into the `teacher` table.

7. **`Messages` & `logs`**

   * **`Messages`**: In-system messaging between any two users (student, teacher, or admin)

     * Fields: `sender_user` (user ID), `receiving_user` (user ID), `message` (text), `is_edit` (boolean), `created_at`, `updated_at`.
     * Useful for notifying students of important events (e.g., “Your final grade has been posted”).
   * **`logs`**: Simple audit trail

     * Fields: `user_id`, `action` (text description), `created_at` (timestamp)
     * Captures who did what and when (e.g., “Teacher X updated student Y’s midterm score on 2025-05-31”).

> **Key Takeaway**
> Because UniTrack assumes a **fixed, stage-based curriculum** (where every “Stage” dictates a predefined list of lectures), there is **no dynamic enrollment table**. Instead, each `student.stage_id` → `lectures.stage_id` relationship automatically enrolls students in the correct courses.

---

## 6. 🛠️ How to Run the Project Locally

### Requirements

* PHP 8+
* MySQL / MariaDB
* Apache or Nginx
* Postman or any API testing tool

### Installation Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/AliQassim2/unitrack.git
   cd unitrack/api
   ```

2. **Import the SQL database**

   * Use the provided SQL dump (`database/unitrack.sql`) to create the schema and seed data.
   * Example (MySQL CLI):

     ```bash
     mysql -u root -p < database/unitrack.sql
     ```

3. **Configure database credentials**

   * Open `config/db.php` and update:

     ```php
     <?php
     return [
       'host'     => '127.0.0.1',
       'database' => 'unitrack_db',
       'username' => 'root',
       'password' => 'your_password',
       'charset'  => 'utf8mb4',
     ];
     ```

4. **Start PHP’s built-in server**

   ```bash
   php -S localhost:8000
   ```

   * The backend API will be available at: `http://localhost:8000/api/`

5. **Test endpoints** via Postman or your preferred API client

   * Refer to documentation and sample requests in the “Example Usage” folder or upcoming API docs.

---

## 7. 🤝 Contributing

Contributions are always welcome! Please follow these guidelines:

1. **Fork** the repository.
2. **Create a new branch** (`git checkout -b feature/YourFeature`).
3. **Make your changes** and commit with clear messages.
4. **Push** to your fork (`git push origin feature/YourFeature`).
5. **Open a Pull Request** and describe the changes you made.

For major changes, open an issue first to discuss what you’d like to implement or fix.

---

## 8. 📧 Contact

Built with ❤️ by **Ali Qassim**

* GitHub: [@AliQassim2](https://github.com/AliQassim2)
* Email: [ali@example.com](mailto:ali@example.com)

---

## 9. 📊 Work Plan: System Roles, Data Flow & Access Levels

> 🎯 **Overview**
> This section outlines the responsibilities, access levels, and data interaction patterns for each user in the **UniTrack** system.

### 🗂️ Diagram Overview

![UniTrack Role Diagram](https://github.com/user-attachments/assets/75a4080f-2b42-419a-966c-152a6a73b20a)
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

Teachers are separated into two categories:

### 🧪 Practical Teachers

* Role: Handle lab and hands-on sessions.
* Permissions:

  * ![View](https://img.shields.io/badge/View-Practical_Students-blue) View practical students and their data.
  * ![Edit](https://img.shields.io/badge/Edit-Practical_Marks_&_Absences-green) Record practical marks and attendance.

> 🔒 Cannot modify theoretical data.

---

### 📖 Theoretical Teachers

* Role: Manage lectures and written assessments.
* Permissions:

  * ![View](https://img.shields.io/badge/View-Theoretical_Students-blue) View theoretical students and their data.
  * ![Edit](https://img.shields.io/badge/Edit-Theory_Marks_&_Absences-green) Record theory marks and attendance.

> 🔒 Cannot modify practical data but can view it (if granted access).

---

## 🔷 Academic Oversight Roles \[`Supervisor Access 🛡️`]

These roles are responsible for oversight, validation, and policy compliance.

### 🏛️ Department Curriculum Committee

* ![Monitor](https://img.shields.io/badge/Monitor-Attendance-yellow) Monitor attendance for all students in the department.
* ![Action](https://img.shields.io/badge/Issue-Warnings-red) Issue official warnings for excessive absences or underperformance.

---

### 🧑‍🏫 Head of Department

* ![Approve](https://img.shields.io/badge/Approve-Teacher_Marks-orange) Review and approve marks submitted by teachers.
* Ensures grading consistency and fairness within the department.

---

### 🎓 Dean of College

* ![Approve](https://img.shields.io/badge/Final_Approval-All_Marks_&_Absences-brightgreen) Give final approval to all department marks and attendance.
* Upholds college-wide academic standards and policies.

---

### 🧑‍💼 University Supervisors

* ![View](https://img.shields.io/badge/View-All_Student_Data-blue) Full access to attendance and grading data across all departments.
* ![Enforce](https://img.shields.io/badge/Ensure-Policy_Compliance-lightgrey) Ensure institutional and governmental academic policies are followed.

---

## 🧩 Role Summary Table

| **Role**                     | 🖥️ **View Access**                      | ✏️ **Add/Edit Marks** | 🕘 **Record Absences** | ✅ **Approval Rights**     | 🚨 **Actions**       |
| ---------------------------- | ---------------------------------------- | --------------------- | ---------------------- | ------------------------- | -------------------- |
| 👨‍🎓 Student                | ✅ Own only                               | ❌                     | ❌                      | ❌                         | ❌                    |
| 👨‍🏫 Teacher – Practical    | ✅ Assigned students                      | ✅ Practical only      | ✅ Practical only       | ❌                         | ❌                    |
| 👩‍🏫 Teacher – Theoretical  | ✅ Assigned students (view practical too) | ✅ Theory only         | ✅ Theory only          | ❌                         | ❌                    |
| 📋 Curriculum Committee      | ✅ All department students                | ❌                     | ✅ Monitor only         | ❌                         | ✅ Issue Warnings     |
| 🏫 Head of Department        | ✅ All department students                | ❌                     | ❌                      | ✅ Teacher grade approvals | ❌                    |
| 🎓 Dean of College           | ✅ All department students                | ❌                     | ❌                      | ✅ Final approval          | ❌                    |
| 🧑‍💼 University Supervisors | ✅ All students across university         | ❌                     | ❌                      | ❌                         | ✅ Policy enforcement |

---

> 🔐 **Summary**:
> UniTrack enforces strict **role-based access control (RBAC)** to maintain data integrity, academic fairness, and institutional compliance. Each role—Student, Teacher (Practical/Theory), Curriculum Committee, Head of Department, Dean of College, and University Supervisor—has clearly defined permissions for viewing, editing, approving, and issuing actions. This hierarchy ensures accountability and transparency throughout the academic data lifecycle.
