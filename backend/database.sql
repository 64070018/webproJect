
CREATE TABLE `images` (
    `img_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `room_id` int(5) unsigned,
    `file_path` varchar(50) NOT NUll,
    `cus_id` int(5),
    `upload_date` datetime DEFAULT CURRENT_TIMESTAMP,
    `main` int(1),
    PRIMARY KEY (`img_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE `roomDetail` (
    `room_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `room_type` varchar(100) NOT NULL,
    `price` int(10) NOT NULL,
    `description` varchar(2500),
    `service_id` int(5) unsigned,
    `room_img_id` int(2) unsigned,
    `people`int(2) unsigned NOT NUll,
    `count` int(5) unsigned DEFAULT 0,
    PRIMARY KEY (`room_id`),
    FOREIGN KEY (`room_img_id`) REFERENCES `images`(`img_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE `users` (
    `cus_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `first_name` varchar(50) NOT NULL,
    `last_name` varchar(50) NOT NULL,
    `phone` varchar(10) NOT NULL,
    `email` varchar(100) NOT NULL,
    `DOB` date NOT NUll,
    PRIMARY KEY (`cus_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE `booking` (
    `booking_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `cus_id` int(5) unsigned NOT NULL,
    `room_id` int(5) unsigned NOT NULL,
    `price` int(10) unsigned NOT NUll,
    `check_in` date NOT NULL,
    `check_out` date NOT NULL,
    `booking_fname` varchar(50) NOT NULL,
    `booking_lname` varchar(50) NOT NULL,
    `timestamp_booking` datetime NOT NULL,
    `people` int(1) NOT NULL,
    `countRoom` int(2) NOT NULL,
    `status` enum('booked', 'checkOut', 'checkIn', 'cancel') NOT NUll DEFAULT 'booked',
    PRIMARY KEY (`booking_id`),
    FOREIGN KEY (`room_id`) REFERENCES `roomDetail`(`room_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE INDEX booking_ibfk_2 ON booking (cus_id);

CREATE TABLE `services` (
    `service_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `breakfast` enum('yes', 'no') NOT NULL,
    `pool` enum('yes', 'no') NOT NULL,
    `wifi` enum('yes', 'no') NOT NULL,
    `air_conditioner` enum('yes', 'no') NOT NULL,
    PRIMARY KEY (`service_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE `comments` (
    `comment_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `content` varchar(100) NOT NUll,
    `cus_id` int(5) unsigned NOT NUll,
    `like` int(5) DEFAULT 0,
    `room_id` int(5) NOT NUll,
    `post_time` datetime DEFAULT CURRENT_TIMESTAMP,
    `rate` int(1) unsigned DEFAULT 5,
    PRIMARY KEY (`comment_id`),
    FOREIGN KEY (`cus_id`) REFERENCES `users`(`cus_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE `reports` (
    `report_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `content` varchar(500) NOT NUll,
    `cus_id` int(5) unsigned NOT NUll,
    `status` enum('submit', 'accept') DEFAULT 'submit',
    `report_time` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`report_id`),
    FOREIGN KEY (`cus_id`) REFERENCES `users`(`cus_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE INDEX plase_ibfk_1 ON comments (cus_id);
CREATE INDEX users_ibfk_2 ON reports (cus_id);

CREATE TABLE `login` (
    `login_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `cus_id` int(5) unsigned NOT NULL,
    `username` varchar(25) NOT NULL,
    `password` varchar(100) NOT NULL,
    `login_role` enum('manager', 'customer') NOT NULL DEFAULT 'customer',
    PRIMARY KEY (`login_id`),
    FOREIGN KEY (`cus_id`) REFERENCES `users`(`cus_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE INDEX roomDetail_ibfk_1 ON roomDetail (room_img_id);
CREATE INDEX images_ibfk_1 ON images (room_id);



CREATE TABLE `payments` (
    `payment_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
    `payment_date` date NOT NULL,
    `payment_slip` varchar(200) ,
    `payment_total_money` int(10) NOT NULL,
    `booking_id` int(5) unsigned NOT NULL,
    `payment_amount` int(5),
     `status` enum('incomplete', 'complete') NOT NUll DEFAULT 'incomplete',
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`booking_id`) REFERENCES `booking`(`booking_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE `unvalible_room` (
    `un_id` int(5) AUTO_INCREMENT,
    `room_id` int(5) unsigned NOT NULL,
    `count` int(2) NOT NULL,
    `date` date NOT NUll,
    PRIMARY KEY (`un_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE INDEX tokens_ibfk_1 ON login (login_id);

CREATE TABLE `tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `login_id` int(5) unsigned NOT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_UN` (`token`),
  FOREIGN KEY (`login_id`) REFERENCES `login` (`login_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;
