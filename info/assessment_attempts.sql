SELECT 
  count(*)
  -- courses.name,
  -- subjects.name,
  -- know_dos.name,  
  -- assessment_takes.taken_at, 
  -- course_know_dos.power, 
  -- assessment_takes.num_correct, 
  -- assessment_takes.num_possible,
  -- know_dos.pcnt_to_pass,
  -- users.last_leave_on > now() as "Is Currently Enrolled?",
  -- users.summit_id,
  -- users.first_name,
  -- users.last_name
FROM 
  course_assignments, 
  assessment_takes, 
  course_know_dos, 
  courses,
  know_dos, 
  users,
  subjects
WHERE 
assessment_takes.student_id = users.id and 
assessment_takes.student_id = course_assignments.student_id AND
course_assignments.course_id = course_know_dos.course_id AND
assessment_takes.know_do_id = course_know_dos.know_do_id AND
course_assignments.course_id = courses.id AND
course_know_dos.know_do_id=know_dos.id AND
courses.subject_id = subjects.id and 
;

-- Missing from Bruce's original: 
-- filter out focus areas for courses the student is not enrolled in
select
  courses.name as "course name",
  subjects.name as "subject name",
  know_dos.name as "focus area name",
  assessment_takes.taken_at,
  ckds.power,
  assessment_takes.num_correct,
  assessment_takes.num_possible,
  (ats.num_correct / cast(ats.num_possible as float)) as pcnt_correct,
  (ats.num_correct / cast(ats.num_possible as float)) >= kds.pcnt_to_pass as passed
  know_dos.pcnt_to_pass,
  users.last_leave_on > now() as "is currently enrolled?",
  users.summit_id,
  users.first_name,
  users.last_name,
  sites.name as school
from assessment_takes as ats
join know_dos as kds on ats.know_do_id = kds.id
join course_know_dos as ckds on ckds.know_do_id = kds.id
join courses on ckds.course_id = courses.id
join subjects on courses.subject_id = subjects.id
join users as students on students.id = ats.student_id
left outer join sites on students.site_id = sites.id
where students.summit_id > 9999
and students.type = 'Student'
;




-- By kid, then assessment, then by date,
-- Add pcnt col
-- Passed