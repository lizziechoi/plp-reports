select
pa.id,
pa.due_on,
pa.submitted_on,
pa.submitted_on is null or pa.submitted_on > pa.due_on as overdue,
pa.submitted_on - pa.due_on as overdue_sub,
cast(now() as date) - pa.due_on as overdue_unsub,
least(pa.submitted_on - pa.due_on, (cast(now() as date) - pa.due_on)) as smaller_of_the_two
from project_assignments as pa
order by id
;
