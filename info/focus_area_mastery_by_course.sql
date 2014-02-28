select 
  courses.name as "course name",
  kds.name as "focus area name",
  ckds.power,
  students.last_leave_on > now() as "is currently enrolled?",
  students.summit_id,
  students.first_name,
  students.last_name,
  coalesce(kdms.mastery = 'g', false) as "Mastered?"
from users as students
join course_assignments as cas on cas.student_id = students.id
join courses on cas.course_id = courses.id
join course_know_dos as ckds on ckds.course_id = courses.id
join know_dos as kds on ckds.know_do_id = kds.id
left outer join know_do_masteries as kdms on kdms.know_do_id = kds.id and kdms.student_id = students.id
order by students.summit_id, courses.name
;