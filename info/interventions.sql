select
  students.summit_id, 
  students.first_name as student_first, 
  students.last_name as student_last,
  students.grade_level,
  sites.name as school,
  teachers.first_name as teacher_first,
  teachers.last_name as teacher_last,
  teachers.email as teacher_email,
  interventions.id as "intervention db ID",
  interventions.intervened_at,
  interventions.desc,
  interventions.created_at,
  interventions.updated_at
  
from student_interventions as sis
join interventions on sis.intervention_id = interventions.id
join users as teachers on teachers.id = interventions.teacher_id
join users as students on sis.student_id = students.id
left outer join sites ON students.site_id = sites.id
left outer join users as mentors ON students.mentor_id = mentors.id
order by interventions.id, teachers.email
;

