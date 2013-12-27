select
pa.id,
pa.due_on,
pa.submitted_on,
pa.submitted_on is null or pa.submitted_on > pa.due_on as overdue,
pa.submitted_on - pa.due_on as overdue_sub,
cast(now() as date) - pa.due_on as overdue_unsub,
pa.submitted_on - pa.due_on > cast(now() as date) - pa.due_on
from project_assignments as pa
order by id
;
