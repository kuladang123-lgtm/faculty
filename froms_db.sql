-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 05, 2026 at 05:57 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `froms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_history`
--

CREATE TABLE `activity_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `log_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `research_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_history`
--

INSERT INTO `activity_history` (`id`, `log_date`, `user_name`, `action`, `research_title`, `details`) VALUES
(1, '2026-10-05 01:14:27', 'Juan Dela Cruz', 'Submitted Research', 'AI-Assisted Learning in Higher Education', 'Research output submitted for administrative review.'),
(2, '2026-10-05 01:14:27', 'Admin Research', 'Approved Research', 'AI-Assisted Learning in Higher Education', 'Research output approved by the administrator.'),
(3, '2026-10-05 01:14:27', 'Maria Santos', 'Submitted Research', 'Digital Transformation in Academic Institutions', 'Research output submitted for review.'),
(4, '2026-10-05 01:14:27', 'Pedro Reyes', 'Submitted Research', 'Sustainable Campus Development', 'Research output submitted for review.');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `date_created`, `is_read`) VALUES
(1, 2, 'Research Approved', 'Your research entitled \"AI-Assisted Learning in Higher Education\" has been approved.', '2026-10-05 01:14:27', 1),
(2, 3, 'Research Under Review', 'Your research entitled \"Digital Transformation in Academic Institutions\" is currently under review.', '2026-10-05 01:14:27', 0),
(3, 4, 'Research Submitted', 'Your research entitled \"Sustainable Campus Development\" has been successfully submitted.', '2026-10-05 01:14:27', 0);

-- --------------------------------------------------------

--
-- Table structure for table `research_outputs`
--

CREATE TABLE `research_outputs` (
  `id` int(10) UNSIGNED NOT NULL,
  `faculty_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` year(4) NOT NULL,
  `publisher` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abstract` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Draft','Submitted','Under Review','Approved','Rejected','Archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `submitted_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `research_outputs`
--

INSERT INTO `research_outputs` (`id`, `faculty_id`, `title`, `type`, `year`, `publisher`, `abstract`, `status`, `created_at`, `submitted_at`, `approved_at`, `rejection_reason`, `updated_at`) VALUES
(1, 2, 'AI-Assisted Learning in Higher Education', 'Journal Article', 2026, 'International Journal of Education', 'This research examines the use of artificial intelligence tools in higher education.', 'Archived', '2026-01-14 16:00:00', '2026-01-17 16:00:00', NULL, 'Please revise the research abstract and provide additional supporting documentation.', '2026-10-05 01:14:28'),
(2, 3, 'Digital Transformation in Academic Institutions', 'Research Project', 2026, 'University Research Center', 'A study on digital transformation strategies in academic institutions.', 'Under Review', '2026-02-09 16:00:00', '2026-02-14 16:00:00', NULL, NULL, '2026-10-05 01:14:26'),
(3, 4, 'Sustainable Campus Development', 'Conference Paper', 2025, 'National Research Conference', 'Research regarding sustainable practices in university campuses.', 'Submitted', '2026-02-28 16:00:00', '2026-03-04 16:00:00', NULL, NULL, '2026-10-05 01:14:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('Administrator','Faculty') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Faculty',
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Research', 'admin@froms.com', 'admin123', 'Administrator', 'Active', '2026-10-05 01:14:26', '2026-10-05 01:14:26'),
(2, 'Juan', 'Dela Cruz', 'faculty@froms.com', 'faculty123', 'Faculty', 'Active', '2026-10-05 01:14:26', '2026-10-05 01:14:26'),
(3, 'Maria', 'Santos', 'maria@froms.com', 'faculty123', 'Faculty', 'Active', '2026-10-05 01:14:26', '2026-10-05 01:14:26'),
(4, 'Pedro', 'Reyes', 'pedro@froms.com', 'faculty123', 'Faculty', 'Active', '2026-10-05 01:14:26', '2026-10-05 01:14:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_history`
--
ALTER TABLE `activity_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activity_date` (`log_date`),
  ADD KEY `idx_activity_action` (`action`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notifications_user` (`user_id`),
  ADD KEY `idx_notifications_read` (`is_read`),
  ADD KEY `idx_notifications_date` (`date_created`);

--
-- Indexes for table `research_outputs`
--
ALTER TABLE `research_outputs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_faculty_title_year` (`faculty_id`,`title`,`year`),
  ADD KEY `idx_research_faculty` (`faculty_id`),
  ADD KEY `idx_research_status` (`status`),
  ADD KEY `idx_research_year` (`year`),
  ADD KEY `idx_research_type` (`type`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_role` (`role`),
  ADD KEY `idx_users_status` (`status`),
  ADD KEY `idx_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_history`
--
ALTER TABLE `activity_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `research_outputs`
--
ALTER TABLE `research_outputs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `research_outputs`
--
ALTER TABLE `research_outputs`
  ADD CONSTRAINT `fk_research_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
