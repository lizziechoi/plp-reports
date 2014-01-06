select
students.summit_id as student_id,
students.last_name as student_last,
-- students.first_name as student_first,
-- mentors.last_name as mentor_last,
-- mentors.first_name as mentor_first,
assigners.last_name as assigner_last,
projects.name as project_name,
pa.due_on,
pa.submitted_on,
least(pa.submitted_on - pa.due_on, (cast(now() as date) - pa.due_on)) > 0 as overdue,
least(pa.submitted_on - pa.due_on, (cast(now() as date) - pa.due_on)) as days_overdue 
from project_assignments as pa
join users as students on students.id=pa.student_id
join users as mentors on mentors.id = students.mentor_id
join users as assigners on assigners.id = pa.assigned_by_id
join projects on projects.id = pa.project_id
order by pa.due_on desc
;