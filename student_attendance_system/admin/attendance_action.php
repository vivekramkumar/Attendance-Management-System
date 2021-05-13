<?php

//student_action.php

include('database_connection.php');

session_start();

if(isset($_POST["action"]))
{
	if($_POST["action"] == "fetch")
	{
		$query = "
		SELECT * FROM tbl_attendance 
		INNER JOIN tbl_student 
		ON tbl_student.student_id = tbl_attendance.student_id 
		INNER JOIN tbl_grade 
		ON tbl_grade.grade_id = tbl_student.student_grade_id 
		INNER JOIN tbl_teacher 
		ON tbl_teacher.teacher_id = tbl_attendance.teacher_id 
		";
		if(isset($_POST["search"]["value"]))
		{
			$query .= '
				WHERE tbl_student.student_name LIKE "%'.$_POST["search"]["value"].'%" 
				OR tbl_student.student_roll_number LIKE "%'.$_POST["search"]["value"].'%" 
				OR tbl_attendance.attendance_status LIKE "%'.$_POST["search"]["value"].'%" 
				OR tbl_attendance.attendance_date LIKE "%'.$_POST["search"]["value"].'%" 
				OR tbl_teacher.teacher_name LIKE "%'.$_POST["search"]["value"].'%" 
			';
		}
		if(isset($_POST["order"]))
		{
		   $col = $_POST['order']['0']['column'] + 1;
			$query .= '
			ORDER BY '.$col.' '.$_POST['order']['0']['dir'].' 
			';
		}
		else
		{	
			$query .= '
			ORDER BY tbl_attendance.attendance_id DESC 
			';
		}

		if($_POST["length"] != -1)
		{
			$query .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
		}

		$statement = $connect->prepare($query);
		$statement->execute();
		$result = $statement->fetchAll();
		$data = array();
		$filtered_rows = $statement->rowCount();
		foreach($result as $row)
		{
			$sub_array = array();
			$status = '';
			if($row["attendance_status"] == "Present")
			{
				$status = '<label class="badge badge-success">Present</label>';
			}
			if($row["attendance_status"] == "Absent")
			{
				$status = '<label class="badge badge-danger">Absent</label>';
			}
			$sub_array[] = $row["student_name"];
			$sub_array[] = $row["student_roll_number"];
			$sub_array[] = $row["grade_name"];
			$sub_array[] = $status;
			$sub_array[] = $row["attendance_date"];
			$sub_array[] = $row["teacher_name"];
			$data[] = $sub_array;
		}
		$output = array(
			"draw"				=>	intval($_POST["draw"]),
			"recordsTotal"		=> 	$filtered_rows,
			"recordsFiltered"	=>	get_total_records($connect, 'tbl_attendance'),
			"data"				=>	$data
		);

		echo json_encode($output);	
	}

	if($_POST["action"] == "index_fetch")
	{
		$query = "
SELECT * FROM tbl_attendance a,tbl_student b,tbl_grade c,tbl_teacher d where a.student_id=b.student_id and c.grade_id=a.grade_id and a.teacher_id = d.teacher_id
		";
		if(isset($_POST["search"]["value"]))
		{
			$query .= '
			and ( b.student_name LIKE "%'.$_POST["search"]["value"].'%" 
			OR b.student_roll_number LIKE "%'.$_POST["search"]["value"].'%" 
			OR c.grade_name LIKE "%'.$_POST["search"]["value"].'%" 
			OR d.teacher_name LIKE "%'.$_POST["search"]["value"].'%" )
			';
		}
		$query .= 'GROUP BY b.student_id ';
		
		if(isset($_POST["order"]))
		{  
		   $col = $_POST['order']['0']['column'] + 1;	
			$query .= 'ORDER BY '.$col.' '.$_POST['order']['0']['dir'].' ';
		}
		else
		{
			$query .= 'ORDER BY b.student_name ASC ';
		}

		if($_POST["length"] != -1)
		{
			$query .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
		}

		$statement = $connect->prepare($query);
		$statement->execute();
		$result = $statement->fetchAll();
		$data = array();
		$filtered_rows = $statement->rowCount();
		
		foreach($result as $row)
		{
			$sub_array = array();
			$sub_array[] = $row["student_name"];
			$sub_array[] = $row["student_roll_number"];
			$sub_array[] = $row["grade_name"];
			$sub_array[] = $row["teacher_name"];
			//error_log($row["teacher_name"]);
			$sub_array[] = get_attendance_percentage($connect, $row["student_id"]);
			$sub_array[] = '<button type="button" name="report_button" data-student_id="'.$row["student_id"].'" class="btn btn-info btn-sm report_button">Report</button>&nbsp;&nbsp;&nbsp;<button type="button" name="chart_button" data-student_id="'.$row["student_id"].'" class="btn btn-danger btn-sm report_button">Chart</button>
			';
			$data[] = $sub_array;
		}

		$output = array(
			'draw'				=>	intval($_POST["draw"]),
			"recordsTotal"		=> 	$filtered_rows,
			"recordsFiltered"	=>	get_total_records($connect, 'tbl_student'),
			"data"				=>	$data
		);

		echo json_encode($output);
	}
}


?>