SELECT 
  students.summit_id, 
  students.first_name as student_first, 
  students.last_name as student_last,
  students.grade_level,
  sites.name as school,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  
  courses.name,
  cas.project_score,
  cas.target_start,
  cas.target_end
FROM course_assignments as cas
LEFT OUTER JOIN users as students ON cas.student_id = students.id
LEFT OUTER JOIN sites ON students.site_id = sites.id
LEFT OUTER JOIN users as mentors ON students.mentor_id = mentors.id
LEFT OUTER JOIN courses on courses.id = cas.course_id
;
