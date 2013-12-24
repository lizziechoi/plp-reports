select summit_id, count(crs_id) as cnt 
from (
  select summit_id, student_id, crses.id as crs_id 
  from college_readiness_scores as crses 
  inner join users as students on students.id = crses.student_id
  -- where crses.score_type = 'actual'
) as ids 
group by summit_id 
order by cnt DESC, summit_id;