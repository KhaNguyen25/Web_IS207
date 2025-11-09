CREATE TABLE `ACCOUNT` (
  `account_ID` integer PRIMARY KEY,
  `email` varchar(50),
  `password` varchar(50),
  `fullname` varchar(50),
  `aboutme` varchar(5000),
  `media_link` varchar(1000),
  `created_date` date,
  `status` boolean,
  `role` integer
);

CREATE TABLE `INVOICE` (
  `invoice_ID` integer PRIMARY KEY,
  `account_ID` integer,
  `purchase_total_price` decimal(12,2),
  `price_discounted` decimal(12,2),
  `purchase_date` date,
  `coupon_code` varchar(50)
);

CREATE TABLE `INVOICE_DETAIL` (
  `invoice_detail_ID` integer PRIMARY KEY,
  `invoice_ID` integer,
  `course_ID` integer
);

CREATE TABLE `ENROLLMENT` (
  `account_ID` integer,
  `course_ID` integer,
  `start_date` date,
  PRIMARY KEY (`account_ID`, `course_ID`)
);

CREATE TABLE `CART` (
  `cart_ID` integer PRIMARY KEY,
  `account_ID` integer
  UNIQUE (`account_ID`)
);

CREATE TABLE `CART_DETAIL` (
  `cart_ID` integer,
  `course_ID` integer,
  PRIMARY KEY (`cart_ID`, `course_ID`)
);

CREATE TABLE `COURSE` (
  `course_ID` integer PRIMARY KEY,
  `course_title` varchar(50),
  `thumbnail_URL` varchar(500),
  `instructor_id` integer,
  `original_price` decimal(12,2),
  `course_desc` varchar(5000),
  `duration` integer,
  `category_id` integer,
  `status` integer,
  `level_id` integer,
  `language` varchar(50),
  `submit_date` date,
  `last_update` date
);

CREATE TABLE `LEVEL` (
  `level_id` integer PRIMARY KEY,
  `level_name` varchar(50)
);

CREATE TABLE `CATEGORY` (
  `category_id` integer PRIMARY KEY,
  `desc` varchar(50)
);

CREATE TABLE `SECTION` (
  `section_ID` integer PRIMARY KEY,
  `course_ID` integer,
  `index` integer,
  `section_title` varchar(500),
  `section_duration` integer
);

CREATE TABLE `LESSON` (
  `lesson_id` integer PRIMARY KEY,
  `section_ID` integer,
  `index` integer,
  `lesson_title` varchar(500),
  `duration` integer
);

CREATE TABLE `RESOURCE` (
  `resource_id` integer PRIMARY KEY,
  `lesson_id` integer,
  `index` integer,
  `file_path` varchar(500),
  `file_name_original` varchar(255),
  `file_size_bytes` integer
);

CREATE TABLE `USER_LESSON_PROGRESS` (
  `account_ID` integer,
  `lesson_id` integer,
  `is_completed` boolean DEFAULT false,
  PRIMARY KEY (`account_ID`, `lesson_id`)
);

CREATE TABLE `COUPON` (
  `coupon_ID` integer PRIMARY KEY,
  `discount_percent` integer,
  `min_purchase` decimal(12,2),
  `max_discount` decimal(12,2),
  `coupon_des` varchar(200),
  `start_date` date,
  `end_date` date,
  `status` varchar(30)
);

CREATE TABLE `COUPON_DETAIL` (
  `coupon_code` varchar(50) PRIMARY KEY,
  `coupon_ID` integer,
  `is_used` boolean,
  `use_date` date
);

CREATE TABLE `REVIEW` (
  `review_ID` integer PRIMARY KEY,
  `course_id` integer,
  `review_star` integer,
  `review_text` varchar(5000),
  `review_by` integer,
  `review_date` date
);

CREATE TABLE `REPORT` (
  `report_ID` integer PRIMARY KEY,
  `course_ID` integer,
  `account_ID` integer,
  `report_date` date
);

CREATE TABLE `FLAG` (
  `flag_ID` integer PRIMARY KEY,
  `description` varchar(50)
);

CREATE TABLE `FLAG_REPORT_BRIDGE` (
  `flag_ID` integer,
  `report_ID` integer,
  PRIMARY KEY (`flag_ID`, `report_ID`)
);

ALTER TABLE `COURSE` ADD FOREIGN KEY (`instructor_id`) REFERENCES `ACCOUNT` (`account_ID`);

ALTER TABLE `CART` ADD FOREIGN KEY (`account_ID`) REFERENCES `ACCOUNT` (`account_ID`);

ALTER TABLE `CART_DETAIL` ADD FOREIGN KEY (`cart_ID`) REFERENCES `CART` (`cart_ID`);

ALTER TABLE `CART_DETAIL` ADD FOREIGN KEY (`course_ID`) REFERENCES `COURSE` (`course_ID`);

ALTER TABLE `COURSE` ADD FOREIGN KEY (`level_id`) REFERENCES `LEVEL` (`level_id`);

ALTER TABLE `REPORT` ADD FOREIGN KEY (`course_ID`) REFERENCES `COURSE` (`course_ID`);

ALTER TABLE `FLAG_REPORT_BRIDGE` ADD FOREIGN KEY (`flag_ID`) REFERENCES `FLAG` (`flag_ID`);

ALTER TABLE `FLAG_REPORT_BRIDGE` ADD FOREIGN KEY (`report_ID`) REFERENCES `REPORT` (`report_ID`);

ALTER TABLE `COURSE` ADD FOREIGN KEY (`category_id`) REFERENCES `CATEGORY` (`category_id`);

ALTER TABLE `SECTION` ADD FOREIGN KEY (`course_ID`) REFERENCES `COURSE` (`course_ID`);

ALTER TABLE `LESSON` ADD FOREIGN KEY (`section_ID`) REFERENCES `SECTION` (`section_ID`);

ALTER TABLE `REVIEW` ADD FOREIGN KEY (`course_id`) REFERENCES `COURSE` (`course_ID`);

ALTER TABLE `ENROLLMENT` ADD FOREIGN KEY (`account_ID`) REFERENCES `ACCOUNT` (`account_ID`);

ALTER TABLE `ENROLLMENT` ADD FOREIGN KEY (`course_ID`) REFERENCES `COURSE` (`course_ID`);

ALTER TABLE `COUPON_DETAIL` ADD FOREIGN KEY (`coupon_ID`) REFERENCES `COUPON` (`coupon_ID`);

ALTER TABLE `RESOURCE` ADD FOREIGN KEY (`lesson_id`) REFERENCES `LESSON` (`lesson_id`);

ALTER TABLE `REVIEW` ADD FOREIGN KEY (`review_by`) REFERENCES `ACCOUNT` (`account_ID`);

ALTER TABLE `INVOICE` ADD FOREIGN KEY (`account_ID`) REFERENCES `ACCOUNT` (`account_ID`);

ALTER TABLE `INVOICE_DETAIL` ADD FOREIGN KEY (`course_ID`) REFERENCES `COURSE` (`course_ID`);

ALTER TABLE `INVOICE_DETAIL` ADD FOREIGN KEY (`invoice_ID`) REFERENCES `INVOICE` (`invoice_ID`);

ALTER TABLE `USER_LESSON_PROGRESS` ADD FOREIGN KEY (`account_ID`) REFERENCES `ACCOUNT` (`account_ID`);

ALTER TABLE `USER_LESSON_PROGRESS` ADD FOREIGN KEY (`lesson_id`) REFERENCES `LESSON` (`lesson_id`);

ALTER TABLE `INVOICE` ADD FOREIGN KEY (`coupon_code`) REFERENCES `COUPON_DETAIL` (`coupon_code`);

ALTER TABLE `REPORT` ADD FOREIGN KEY (`account_ID`) REFERENCES `ACCOUNT` (`account_ID`);
