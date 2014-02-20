select 
  kds.name as "Focus Areas Name",
  courses.name as "Course Name",
  subjects.name as "Subject Name",
  ckds.power as "Is Power?"
from know_dos as kds
join course_know_dos as ckds on ckds.know_do_id = kds.id
join courses  on ckds.course_id = courses.id
join subjects on courses.subject_id = subjects.id
;


-- Focus areas in multiple courses
select 
  kds.id, 
  kds.name, 
  count(courses.id) as cnt, 
  array_to_string(array_agg(courses.name), '; ') as courses
from know_dos as kds
join course_know_dos as ckds on ckds.know_do_id = kds.id
join courses on courses.id = ckds.course_id
group by kds.id
having count(courses.id) > 1
order by cnt desc, min(courses.id)
;