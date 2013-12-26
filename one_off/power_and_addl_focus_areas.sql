select name, power_count, addl_count, subject_id, shadow
from courses 
left outer join (
  select course_id, count(ckds.id) as power_count
  from course_know_dos as ckds
  where ckds.power = true
  group by course_id
) as power_counts on power_counts.course_id = courses.id
left outer join (
  select course_id, count(ckds.id) as addl_count
  from course_know_dos as ckds
  where ckds.power = false
  group by course_id
) as addl_counts on addl_counts.course_id = courses.id
-- where power_count is null OR addl_count is null
order by sequence, shadow, subject_id
;
