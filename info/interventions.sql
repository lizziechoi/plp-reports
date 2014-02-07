select
  teachers.first_name,
  teachers.last_name,
  teachers.email,
  interventions.intervened_at,
  interventions.desc,
  interventions.created_at,
  interventions.updated_at
from interventions
join users as teachers on teachers.id = interventions.teacher_id
order by teachers.email
;