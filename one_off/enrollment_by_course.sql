select 
  cas.course_id, 
  max(courses.name) as course, 
  count(cas.id) as num_enrolled
from course_assignments as cas
left outer join courses on courses.id = cas.course_id
left outer join subjects on subjects.id = courses.subject_id
group by cas.course_id
order by course
;
