
CREATE DATABASE `attendance`;

USE `attendance`;

/*Table structure for table `tbl_admin` */

DROP TABLE IF EXISTS `tbl_admin`;

CREATE TABLE `tbl_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_name` varchar(100) NOT NULL,
  `admin_password` varchar(150) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

create index admin_ind1 on tbl_admin(admin_user_name);

/*Data for the table `tbl_admin` */

insert  into `tbl_admin`(`admin_id`,`admin_user_name`,`admin_password`) values 
(1,'admin','$2y$10$D74Zy1qMkATvmGRoVeq7hed4ajWof2aqDGnEaD3yPHABA.p.e7f4u');

/*Table structure for table `tbl_attendance` */

DROP TABLE IF EXISTS `tbl_attendance`;

CREATE TABLE `tbl_attendance` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `attendance_status` enum('Present','Absent') NOT NULL,
  `attendance_date` date NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `grade_id` int(11) NOT NULL,
  PRIMARY KEY (`attendance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=latin1;





/*Table structure for table `tbl_grade` */

DROP TABLE IF EXISTS `tbl_grade`;

CREATE TABLE `tbl_grade` (
  `grade_id` int(11) NOT NULL AUTO_INCREMENT,
  `grade_name` varchar(10) NOT NULL,
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_grade` */

insert  into `tbl_grade`(`grade_id`,`grade_name`) values 
(1,'11 - A'),
(2,'11 - B'),
(3,'12 - A'),
(4,'12 - B'),
(5,'11 - C'),
(6,'10 - A'),
(7,'10 - B'),
(8,'10 - C');

/*Table structure for table `tbl_student` */

DROP TABLE IF EXISTS `tbl_student`;

CREATE TABLE `tbl_student` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_name` varchar(150) NOT NULL,
  `student_roll_number` int(11) NOT NULL,
  `student_dob` date NOT NULL,
  `student_grade_id` int(11) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

ALTER TABLE tbl_student ADD FOREIGN KEY (student_grade_id) REFERENCES tbl_grade(grade_id);

/*Table structure for table `tbl_student_log` */

CREATE TABLE `tbl_student_log` (
  `student_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `performed_by` varchar(100),
  `performed_when` datetime,
  `performed_action` varchar(50),
  `student_id` int(11) ,
  `student_name` varchar(150) ,
  `student_roll_number` int(11),
  `student_dob` date,
  `student_grade_id` int(11),
  PRIMARY KEY (`student_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

ALTER TABLE tbl_student_log ADD FOREIGN KEY (performed_by) REFERENCES tbl_admin(admin_user_name);




/*Data for the table `tbl_student` */

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('vivek',1,'2000-02-23',6);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('joshua',2,'2001-12-12',6);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('gautham',3,'2001-07-02',6);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('richard',4,'2002-03-21',6);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('naveen',5,'2003-05-20',6);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sharon',6,'2001-06-19',6);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('haniel',1,'2000-02-23',7);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('rahul',2,'2001-12-12',7);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('joshua',3,'2001-07-02',7);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('hashim',4,'2002-03-21',7);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('farzan',5,'2003-05-20',7);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('aadithya',6,'2001-06-19',7);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('abhisheka',1,'2000-02-23',8);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('abhibvarshini',2,'2001-12-12',8);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('lakshmi',3,'2001-07-02',8);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('gautham',4,'2002-03-21',8);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('vignesh',5,'2003-05-20',8);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('aadithya',6,'2001-06-19',8);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('vivek',1,'2000-02-23',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('joshua',2,'2001-02-12',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('gautham',3,'2001-08-02',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('richard',4,'2002-07-21',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('naveen',5,'2003-05-20',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sharon',6,'2001-06-20',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('abhisheka',7,'2000-02-21',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('abhibvarshini',8,'2001-12-12',1);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('lakshmi',9,'2001-07-02',1);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('tharun',1,'2007-02-23',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('joshua',2,'2008-02-12',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('gautham',3,'2006-08-02',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('vignesh',4,'2005-07-21',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('murali',5,'2003-05-20',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('aadithya',6,'2003-06-20',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('pratheesh',7,'2008-02-21',2);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sibi',8,'2008-12-12',2);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('aadithya',1,'2002-04-23',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('madhu',2,'2008-05-12',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('deepak',3,'2006-11-02',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('lekha',4,'2002-07-21',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('divya',5,'2003-05-22',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sabari',6,'2003-06-12',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('karthick',7,'2008-02-11',3);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sai',8,'2008-12-02',3);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('tharun',1,'2002-04-13',4);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('jeyaram',2,'2008-05-02',4);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sriram',3,'2006-11-22',4);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('baadi',4,'2002-07-21',4);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('subhash',5,'2003-07-22',4);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('arvind',6,'2003-06-12',4);

insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('girish',1,'2002-04-03',5);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('sakthi',2,'2008-05-22',5);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('santhosh',3,'2006-11-12',5);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('malik',4,'2002-10-21',5);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('faizal',5,'2006-07-22',5);
insert into tbl_student(student_name,student_roll_number,student_dob,student_grade_id) values('shreyas',6,'2012-06-12',5);




/*Table structure for table `tbl_teacher` */

DROP TABLE IF EXISTS `tbl_teacher`;

CREATE TABLE `tbl_teacher` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_name` varchar(150) NOT NULL,
  `teacher_address` text NOT NULL,
  `teacher_emailid` varchar(100) NOT NULL,
  `teacher_password` varchar(100) NOT NULL,
  `teacher_qualification` varchar(100) NOT NULL,
  `teacher_doj` date NOT NULL,
  `teacher_image` varchar(100) NOT NULL,
  `teacher_grade_id` int(11) NOT NULL,
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

create index teacher_ind1 on tbl_teacher(teacher_name);

ALTER TABLE tbl_teacher ADD FOREIGN KEY (teacher_grade_id) REFERENCES tbl_grade(grade_id);


/*Table structure for table `tbl_teacher_log` */

CREATE TABLE `tbl_teacher_log` (
  `teacherlog_id` int(11) NOT NULL AUTO_INCREMENT,
  `performed_by` varchar(150),
  `performed_when` datetime,
  `performed_action` varchar(50),
  `teacher_id` int(11) ,
  `teacher_name` varchar(150),
  `teacher_address` text,
  `teacher_emailid` varchar(100),
  `teacher_password` varchar(100),
  `teacher_qualification` varchar(100),
  `teacher_doj` date,
  `teacher_image` varchar(100),
  `teacher_grade_id` int(11),
  PRIMARY KEY (`teacherlog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


/*Data for the table `tbl_teacher` */

insert  into `tbl_teacher`(`teacher_id`,`teacher_name`,`teacher_address`,`teacher_emailid`,`teacher_password`,`teacher_qualification`,`teacher_doj`,`teacher_image`,`teacher_grade_id`) values 
(2,'Jonathan Gonzalez','1810 Kuhl Avenue Gainesville, GA 30501','jonathan12@gmail.com','$2y$10$s2MmR/Ml6ohRRrrFY0SRQ.vWohGvthVsKe59zgLOIvm3Qd0PzavD2','B.Sc, B.Ed','2019-05-01','5cdd2ed638edc.jpg',1),
(3,'Peter Parker','620 Jody Road, Philadelphia, PA 19108','peter_parker@gmail.com','$2y$10$jmgJN1xvteg6XqBnHvT7UerviGNJOSnF8KFzBHnCky0FJWa74Nvmu','M.Sc, B. Ed','2017-12-31','5ce53488d50ec.jpg',2),
(4,'John Smith','780 University Drive, Chicago, IL 60606','john.smith@gmail.com','$2y$10$Vb9t4CvkJwm41KXgPehuLOFcM7o5Qdm1RFxSBxzh9cvBcc21AUAiW','B.Sc','2019-05-01','5cdd2f35be8fa.jpg',3),
(5,'Donald Trump','3354 Round Table Drive, Cincinnati, OH 45240','donald@trump.com','$2y$10$SVxX4/7lf3pDs1vrpuJexOG7Ue1e1jqIntGmXip3JzxkB753uxBiO','M.Sc','2019-05-01','5e9e889828921.jpg',4),
(7,'test','chennai','test@test.com','$2y$10$AelqjaysJZpZxq.8Brp1OuaK2yYxVphzOB2Dl6KOIO3lhZygjM2Wa','PHD','2019-05-01','5cdd2ed638edc.jpg',3);

/*View for`student_join_view` */

create or replace view student_join_view as 
SELECT * FROM tbl_student 
INNER JOIN tbl_grade 
ON tbl_grade.grade_id = tbl_student.student_grade_id ;

/*View for`attendance_join_view` */

create or replace view attendance_join_view as 
SELECT a.attendance_id,a.student_id,a.attendance_status,a.attendance_date,a.teacher_id as v,a.grade_id as p,b.student_id as x,b.student_name,b.student_roll_number,b.student_dob,b.student_grade_id as y,c.grade_id,c.grade_name FROM tbl_attendance a
INNER JOIN tbl_student b
ON b.student_id = a.student_id 
INNER JOIN tbl_grade c 
ON c.grade_id = b.student_grade_id ;
 
ALTER TABLE tbl_attendance ADD FOREIGN KEY (student_id) REFERENCES tbl_student(student_id);
ALTER TABLE tbl_attendance ADD FOREIGN KEY (teacher_id) REFERENCES tbl_teacher(teacher_id);

/*Trigger functions for `tbl_student_log` */

DELIMITER $$
CREATE or replace DEFINER=CURRENT_USER TRIGGER student_log_update
before update
ON tbl_student
FOR EACH ROW
BEGIN
  INSERT INTO tbl_student_log (performed_by,performed_when,performed_action,student_id,student_name,student_roll_number,student_dob,
	student_grade_id)
  VALUES ('admin',now(),'UPDATE',new.student_id,new.student_name,new.student_roll_number,new.student_dob,
	new.student_grade_id);
END;
$$

DELIMITER $$
CREATE or replace DEFINER=CURRENT_USER TRIGGER student_log_delete
before delete
ON tbl_student
FOR EACH ROW
BEGIN
  INSERT INTO tbl_student_log (performed_by,performed_when,performed_action,student_id,student_name,student_roll_number,student_dob,
	student_grade_id)
  VALUES ('admin',now(),'DELETE',old.student_id,old.student_name,old.student_roll_number,old.student_dob,
	old.student_grade_id);
END;
$$

DELIMITER $$
CREATE or replace DEFINER=CURRENT_USER TRIGGER student_log_insert
after insert
ON tbl_student
FOR EACH ROW
BEGIN
  INSERT INTO tbl_student_log (performed_by,performed_when,performed_action,student_id,student_name,student_roll_number,student_dob,
	student_grade_id)
  VALUES ('admin',now(),'INSERT',new.student_id,new.student_name,new.student_roll_number,new.student_dob,
	new.student_grade_id);
END;
$$

/*Trigger functions for `tbl_teacher_log` */

DELIMITER $$
CREATE or replace DEFINER=CURRENT_USER TRIGGER teacher_log_update
before update
ON tbl_teacher
FOR EACH ROW
BEGIN
  INSERT INTO tbl_teacher_log (performed_by,performed_when,performed_action,teacher_id,teacher_name,teacher_address,teacher_emailid,
	teacher_password,teacher_qualification,teacher_doj,teacher_image,teacher_grade_id)
  VALUES (@username,now(),'UPDATE',new.teacher_id,new.teacher_name,new.teacher_address,new.teacher_emailid,
	new.teacher_password,new.teacher_qualification,new.teacher_doj,new.teacher_image,new.teacher_grade_id);
END;
$$


DELIMITER $$
CREATE or replace DEFINER=CURRENT_USER TRIGGER teacher_log_insert
after insert 
ON tbl_teacher
FOR EACH ROW
BEGIN
  INSERT INTO tbl_teacher_log (performed_by,performed_when,performed_action,teacher_id,teacher_name,teacher_address,teacher_emailid,
	teacher_password,teacher_qualification,teacher_doj,teacher_image,teacher_grade_id)
  VALUES ('admin',now(),'INSERT',new.teacher_id,new.teacher_name,new.teacher_address,new.teacher_emailid,
	new.teacher_password,new.teacher_qualification,new.teacher_doj,new.teacher_image,new.teacher_grade_id);
END;
$$

DELIMITER $$
CREATE or replace DEFINER=CURRENT_USER TRIGGER teacher_log_delete
before delete
ON tbl_teacher
FOR EACH ROW
BEGIN
  INSERT INTO tbl_teacher_log (performed_by,performed_when,performed_action,teacher_id,teacher_name,teacher_address,teacher_emailid,
	teacher_password,teacher_qualification,teacher_doj,teacher_image,teacher_grade_id)
  VALUES ('admin',now(),'DELETE',old.teacher_id,old.teacher_name,old.teacher_address,old.teacher_emailid,old.teacher_password,old.teacher_qualification,old.teacher_doj,old.teacher_image,old.teacher_grade_id);
END;
$$

