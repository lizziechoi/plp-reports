-- TODO: filter out focus areas for courses the student is not enrolled in
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
  sites.name as school
from assessment_takes as ats
join know_dos as kds on ats.know_do_id = kds.id
join course_know_dos as ckds on ckds.know_do_id = kds.id
join courses on ckds.course_id = courses.id
join subjects on courses.subject_id = subjects.id
join users as students on students.id = ats.student_id
left outer join sites on students.site_id = sites.id
where students.type = 'Student'
  and sites.name != 'SPS Demo'
order by students.summit_id, kds.id, ats.taken_at
;