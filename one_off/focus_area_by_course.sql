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