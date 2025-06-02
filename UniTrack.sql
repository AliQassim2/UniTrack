CREATE TABLE `departments`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `college` VARCHAR(255) NOT NULL
);
CREATE TABLE `stage`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `group_name` CHAR(2) NOT NULL,
    `department_id` BIGINT NOT NULL,
    `is_morning` BOOLEAN DEFAULT TRUE NOT NULL,
);
CREATE TABLE `attendance`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` BIGINT NOT NULL,
    `recorded_by` BIGINT NOT NULL,
    `lecture_id` BIGINT NOT NULL,
    `date` DATE NOT NULL,
    `status` TINYINT NOT NULL,
    `remark` VARCHAR(255) NOT NULL
);
CREATE TABLE `lectures`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `semester` TINYINT NOT NULL,
    `stage` BIGINT NOT NULL,
    `is_practical` BOOLEAN NOT NULL,
    `date` DATE NOT NULL
);
CREATE TABLE `grades`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` BIGINT NOT NULL,
    `recorded_by` BIGINT NOT NULL,
    `lecture_id` BIGINT NOT NULL,
    `exam_type` TINYINT NOT NULL,
    `score` FLOAT NOT NULL,
    `date` TIMESTAMP NOT NULL
);
CREATE TABLE `alerts`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` BIGINT NOT NULL,
    `created_by` BIGINT NOT NULL,
    `type` TINYINT NOT NULL,
    `message` TEXT NOT NULL,
    `resolved` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP NOT NULL
);
CREATE TABLE `logs`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `action` TEXT NOT NULL,
    `created_at` DATE NOT NULL
);
CREATE TABLE `lecture_teachers`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `teacher_id` BIGINT NOT NULL,
    `lecture_id` BIGINT NOT NULL,
    `is_practical` BOOLEAN NOT NULL
);
CREATE TABLE `student`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `remember_token` VARCHAR(255) NOT NULL,
    `is_suspended` BOOLEAN NOT NULL,
    `stage_id` BIGINT NOT NULL
);
CREATE TABLE `teacher`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `remember_token` VARCHAR(255) NOT NULL,
    `start_at` TIMESTAMP NOT NULL,
    `academic_rank` VARCHAR(255) NOT NULL,
    `scientific_specialization` VARCHAR(255) NOT NULL,
    `department_id` BIGINT NOT NULL,
    `is_manage` BOOLEAN NOT NULL
);
CREATE TABLE `management`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `teacher_id` BIGINT NOT NULL,
    `role` TINYINT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL
);
CREATE TABLE `messages`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `sender_user` BIGINT NOT NULL,
    `receiving_user` BIGINT NOT NULL,
    `message` TEXT NOT NULL,
    `is_edit` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);
CREATE TABLE `grades_total`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `mid` FLOAT DEFAULT 0,
    `practical_mid` FLOAT DEFAULT 0,
    `quiz` FLOAT DEFAULT 0,
    `practical_quiz` FLOAT DEFAULT 0,
    `absence` FLOAT DEFAULT 0,
    `practical_absence` FLOAT DEFAULT 0,
    `curve` BIGINT DEFAULT 0,
    `pre_final_grade` BIGINT DEFAULT 0,
    `First_approval` BOOLEAN DEFAULT FALSE,
    `final` BIGINT DEFAULT 0,
    `approval_HOD` BIGINT DEFAULT FALSE,
    `approval_DOC` BIGINT DEFAULT FALSE,
    `student_id` BIGINT NOT NULL
);
CREATE TABLE `users`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL,
    `student_id` BIGINT NULL,
    `teacher_id` BIGINT NULL
);
ALTER TABLE `users`
ADD UNIQUE `users_username_unique`(`username`);
ALTER TABLE `users`
ADD UNIQUE `users_email_unique`(`email`);
ALTER TABLE `attendance`
ADD CONSTRAINT `attendance_recorded_by_foreign` FOREIGN KEY(`recorded_by`) REFERENCES `teacher`(`id`);
ALTER TABLE `logs`
ADD CONSTRAINT `logs_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `teacher`(`id`);
ALTER TABLE `alerts`
ADD CONSTRAINT `alerts_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`id`);
ALTER TABLE `messages`
ADD CONSTRAINT `messages_receiving_user_foreign` FOREIGN KEY(`receiving_user`) REFERENCES `users`(`id`);
ALTER TABLE `lectures`
ADD CONSTRAINT `lectures_stage_id_foreign` FOREIGN KEY(`stage_id`) REFERENCES `stage`(`id`);
ALTER TABLE `grades`
ADD CONSTRAINT `grades_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`id`);
ALTER TABLE `attendance`
ADD CONSTRAINT `attendance_lecture_id_foreign` FOREIGN KEY(`lecture_id`) REFERENCES `lectures`(`id`);
ALTER TABLE `lecture_teachers`
ADD CONSTRAINT `lecture_teachers_lecture_id_foreign` FOREIGN KEY(`lecture_id`) REFERENCES `lectures`(`id`);
ALTER TABLE `grades_total`
ADD CONSTRAINT `grades_total_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`id`);
ALTER TABLE `grades`
ADD CONSTRAINT `grades_lecture_id_foreign` FOREIGN KEY(`lecture_id`) REFERENCES `lectures`(`id`);
ALTER TABLE `users`
ADD CONSTRAINT `users_teacher_id_foreign` FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`);
ALTER TABLE `attendance`
ADD CONSTRAINT `attendance_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`id`);
ALTER TABLE `student`
ADD CONSTRAINT `student_stage_id_foreign` FOREIGN KEY(`stage_id`) REFERENCES `stage`(`id`);
ALTER TABLE `alerts`
ADD CONSTRAINT `alerts_created_by_foreign` FOREIGN KEY(`created_by`) REFERENCES `teacher`(`id`);
ALTER TABLE `users`
ADD CONSTRAINT `users_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`id`);
ALTER TABLE `management`
ADD CONSTRAINT `management_teacher_id_foreign` FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`);
ALTER TABLE `stage`
ADD CONSTRAINT `stage_department_id_foreign` FOREIGN KEY(`department_id`) REFERENCES `departments`(`id`);
ALTER TABLE `messages`
ADD CONSTRAINT `messages_sender_user_foreign` FOREIGN KEY(`sender_user`) REFERENCES `users`(`id`);
ALTER TABLE `grades`
ADD CONSTRAINT `grades_recorded_by_foreign` FOREIGN KEY(`recorded_by`) REFERENCES `teacher`(`id`);
ALTER TABLE `lecture_teachers`
ADD CONSTRAINT `lecture_teachers_teacher_id_foreign` FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`);
