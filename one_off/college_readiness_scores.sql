select summit_id, max(grade_level) as grade_level, count(crs_id) as cnt 
from (
  select summit_id, grade_level, student_id, crses.id as crs_id 
  from college_readiness_scores as crses 
  inner join users as students on students.id = crses.student_id
  where crses.score_type = 'actual'
) as ids 
group by summit_id 
order by cnt DESC, summit_id;


select 
    students.first_name,
    students.last_name,
    concat(mentors.first_name, ' ', mentors.last_name) as mentor_name,
    students.grade_level,
    students.target_grad_date,
    sites.name,
    crses.*
  from college_readiness_scores as crses 
  inner join users as students on students.id = crses.student_id
  left outer join sites on students.site_id = sites.id
  left outer join users as mentors on students.mentor_id = mentors.id
  order by students.site_id, students.id
;