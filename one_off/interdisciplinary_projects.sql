select 
  projects.id, 
  projects.name, 
  count(pcs.course_id) as num_courses, 
  array_agg(courses.name) 
from projects 
inner join project_courses as pcs on pcs.project_id = projects.id 
inner join courses on courses.id = pcs.course_id 
group by projects.id 
having count(pcs.course_id) > 1
;