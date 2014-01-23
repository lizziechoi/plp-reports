SELECT 
  courses.name,
  subjects.name,
  know_dos.name,  
  assessment_takes.taken_at, 
  course_know_dos.power, 
  assessment_takes.num_correct, 
  assessment_takes.num_possible,
  know_dos.pcnt_to_pass,
  users.summit_id
FROM 
  course_assignments, 
  assessment_takes, 
  course_know_dos, 
  courses,
  know_dos, 
  users,
  subjects
WHERE 
  course_assignments.course_id = course_know_dos.course_id AND
  course_assignments.course_id = courses.id AND
  assessment_takes.student_id = course_assignments.student_id AND
  assessment_takes.know_do_id = course_know_dos.know_do_id AND
  course_know_dos.know_do_id=know_dos.id AND
  assessment_takes.student_id = users.id and 
  courses.subject_id = subjects.id and 
  users.summit_id > 9999
;