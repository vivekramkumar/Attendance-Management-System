<?php

//attendance.php

include('header.php');

?>

<div class="container" style="margin-top:30px">
  <div class="card">
  	<div class="card-header">
      <div class="row">
        <div class="col-md-9">Attendance List</div>
        <div class="col-md-3" align="right">
          <button type="button" id="report_button" class="btn btn-danger btn-sm">Report</button>
          <button type="button" id="add_button" class="btn btn-info btn-sm">Add</button>
        </div>
      </div>
    </div>
  	<div class="card-body">
  		<div class="table-responsive">
        <span id="message_operation"></span>
        <table class="table table-striped table-bordered" id="attendance_table">
          <thead>
            <tr>
              <th>Student Name</th>
              <th>Roll Number</th>
              <th>Grade</th>
              <th>Attendance Status</th>
              <th>Attendance Date</th>
            </tr>
          </thead>
          <tbody>

          </tbody>
        </table>
  		</div>
  	</div>
  </div>
</div>

</body>
</html>

<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="css/datepicker.css" />

<style>
    .datepicker
    {
      z-index: 1600 !important; /* has to be larger than 1050 */
    }
</style>

<?php

$query = "
SELECT * FROM tbl_grade WHERE grade_id = (SELECT teacher_grade_id FROM tbl_teacher 
    WHERE teacher_id = '".$_SESSION["teacher_id"]."')
";

$statement = $connect->prepare($query);
$statement->execute();
$result = $statement->fetchAll();

?>

<div class="modal" id="formModal">
  <div class="modal-dialog">
    <form method="post" id="attendance_form">
      <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modal_title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">
          <?php
          foreach($result as $row)
          {
          ?>
          <div class="form-group">
            <div class="row">
              <label class="col-md-4 text-right">Grade <span class="text-danger">*</span></label>
              <div class="col-md-8">
               <select required name="teacher_grade_id" id="teacher_grade_id" class="form-control">

                			<option value="">Select Grade</option>

                			<?php

                			echo load_grade_list($connect);

                			?>

                		</select>

						<span id="error_grade_id" class="text-danger"></span>
              </div>
            </div>
          </div>
          
          <div class="form-group">
            <div class="row">
              <label class="col-md-4 text-right">Attendance Date <span class="text-danger">*</span></label>
              <div class="col-md-8">
                <input type="text" name="attendance_date" id="attendance_date" class="form-control" readonly />
                <span id="error_attendance_date" class="text-danger"></span>
              </div>
            </div>
          </div>
          
          <div class="form-group" id="student_details"> 

			 <div class='table-responsive'> <table class='table table-striped table-bordered' id='classtsudents_table'><thead><tr><th>Roll No.</th><th>Student Name</th><th>Present</th><th>Absent</th></tr></thead><tbody> </table>       

         
 
          <?php

          }

          ?>
  
        </div>
  	</div>
</div>
	
        <!-- Modal footer -->
        <div class="modal-footer">
          <input type="hidden" name="action" id="action" value="Add" />
          <input type="submit" name="button_action" id="button_action" class="btn btn-success btn-sm" value="Add" />
          <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
        </div>

      </div>
    </form>
  </div>
</div>

<div class="modal" id="reportModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Make Report</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <div class="form-group">
          <div class="input-daterange">
            <input type="text" name="from_date" id="from_date" class="form-control" placeholder="From Date" readonly />
            <span id="error_from_date" class="text-danger"></span>
            <br />
            <input type="text" name="to_date" id="to_date" class="form-control" placeholder="To Date" readonly />
            <span id="error_to_date" class="text-danger"></span>
          </div>
        </div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" name="create_report" id="create_report" class="btn btn-success btn-sm">Create Report</button>
        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<script>






$(document).ready(function(){

	

  var dataTable = $('#attendance_table').DataTable({

    "processing":true,

    "serverSide":true,

    "order":[],

    "ajax":{

      url:"attendance_action.php",

      method:"POST",

      data:{action:"fetch"}

    }

  });

   

  $('#attendance_date').datepicker({

    format:'yyyy-mm-dd',

    autoclose:true,

    container: '#formModal modal-body'

  });



  function clear_field()

  {

    $('#attendance_form')[0].reset();

    $('#error_attendance_date').text('');

  }



  $('#add_button').click(function(){

    $('#modal_title').text("Add Attendance");
    $('#classtsudents_table tbody').empty(); 

    $('#formModal').modal('show');

    clear_field();

  });

  
  $('#teacher_grade_id').change(function(){
      var selectedGrade = $(this).children("option:selected").val();
      
      $('#classtsudents_table tbody').empty();  
      
       
       $.post('attendance_action.php', { grade:selectedGrade,action:"fetchclasstudents"}, 
     			function(returnedData){
     				
     				for(var i=0, len=returnedData.data.length; i < len; i++){
    					var trow = "<tr><td>"+returnedData.data[i][0]+"</td><td>"+returnedData.data[i][1]+" <input type='hidden' name='student_id[]' value='"+returnedData.data[i][2]+"'</td>";
    					trow = trow +  "<td> <input type='radio' name='attendance_status"+returnedData.data[i][2]+"' checked value='Present' /> </td>";		
    					trow = trow +  "<td> <input type='radio' name='attendance_status"+returnedData.data[i][2]+"' value='Absent' /> </td>";
    					trow = trow + "</tr>";
     					$('#classtsudents_table tbody').append(trow);
     					
     				}
     				
     		},'json');
   });



  $('#attendance_form').on('submit', function(event){

    event.preventDefault();

    $.ajax({

      url:"attendance_action.php",

      method:"POST",

      data:$(this).serialize(),

      dataType:"json",

      beforeSend:function(){

        $('#button_action').val('Validate...');

        $('#button_action').attr('disabled', 'disabled');

      },

      success:function(data)

      {

        $('#button_action').attr('disabled', false);

        $('#button_action').val($('#action').val());

        if(data.success)

        {

          $('#message_operation').html('<div class="alert alert-success">'+data.success+'</div>');

          clear_field();

          $('#formModal').modal('hide');

          dataTable.ajax.reload();

        }

        if(data.error)

        {

          if(data.error_attendance_date != '')

          {

            $('#error_attendance_date').text(data.error_attendance_date);

          }

          else

          {

            $('#error_attendance_date').text('');

          }

        }

      }

    })

  });



  $('.input-daterange').datepicker({

    todayBtn:"linked",

    format:"yyyy-mm-dd",

    autoclose:true,

    container: '#formModal modal-body'

  });



  $(document).on('click', '#report_button', function(){

    $('#reportModal').modal('show');

  });



  $('#create_report').click(function(){

    var from_date = $('#from_date').val();

    var to_date = $('#to_date').val();

    var error = 0;

    if(from_date == '')

    {

      $('#error_from_date').text('From Date is Required');

      error++;

    }

    else

    {

      $('#error_from_date').text('');

    }



    if(to_date == '')

    {

      $('#error_to_date').text("To Date is Required");

      error++;

    }

    else

    {

      $('#error_to_date').text('');

    }



    if(error == 0)

    {

      $('#from_date').val('');

      $('#to_date').val('');

      $('#formModal').modal('hide');

      window.open("report.php?action=attendance_report&from_date="+from_date+"&to_date="+to_date);

    }



  });



});

</script>