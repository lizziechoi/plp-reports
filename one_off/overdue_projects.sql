select
pa.id,
pa.due_on,
pa.submitted_on,
pa.submitted_on is null or pa.submitted_on>pa.due_on as overdue,
pa.submitted_on - pa.due_on as days_overdue
from project_assignments as pa;