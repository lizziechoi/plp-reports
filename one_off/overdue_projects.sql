select
  pa.id,
  pa.status,
  pa.submitted_on,
  pa.due_on,
  pa.submitted_on is null or pa.submitted_on > pa.due_on as overdue
  -- (pa.status = 'assigned' and pa.due_on < now()) or (pa.submitted_on > pa.due_on) as overdue
  pa.submitted_on > pa.due_on or (pa.submitted_on is null and pa.due_on < cast(now() as date)) as overdue,
  
from project_assignments as pa
order by overdue desc
;
