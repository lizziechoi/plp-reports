select
  courses.name as "course name",
  subjects.name as "subject name",
  kds.name as "focus area name",
  ats.taken_at,
  ckds.power,
  ats.num_correct,
  ats.num_possible,
  (ats.num_correct / cast(ats.num_possible as float)) as pcnt_correct,
  (ats.num_correct / cast(ats.num_possible as float)) >= kds.pcnt_to_pass as passed,
  kds.pcnt_to_pass,
  students.last_leave_on > now() as "is currently enrolled?",
  students.summit_id,
  students.first_name,
  students.last_name,
  students.grade_level,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  sites.name as school
from users as students
left outer join sites on students.site_id = sites.id
left outer join users as mentors on mentors.id = students.mentor_id
join course_assignments as cas on cas.student_id = students.id
join courses on cas.course_id = courses.id
join subjects on courses.subject_id = subjects.id
join course_know_dos as ckds on ckds.course_id = courses.id
join know_dos as kds on ckds.know_do_id = kds.id
left outer join assessment_takes as ats 
  on ats.know_do_id = kds.id and ats.student_id = students.id
where students.type = 'Student'
  and sites.name != 'SPS Demo'
order by students.summit_id, kds.id, ats.taken_at
;