SELECT 
  -- count(*)
  students.summit_id, 
  students.first_name as student_first, 
  students.last_name as student_last,
  students.grade_level,
  sites.name as school,
  authors.first_name as author_first,
  authors.last_name as author_last,
  assigners.first_name as assigner_first,
  assigners.last_name as assigner_last,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  projects.name as project_name,
  pacs.msg as message,
  pacs.created_at as status_created_at
FROM project_assignment_custom_statuses as pacs
LEFT OUTER JOIN users as authors ON pacs.author_id = authors.id
LEFT OUTER JOIN project_assignments as pas ON pacs.project_assignment_id = pas.id
LEFT OUTER JOIN users as students ON pas.student_id = students.id
LEFT OUTER JOIN sites ON students.site_id = sites.id
LEFT OUTER JOIN projects on pas.project_id = projects.id
LEFT OUTER JOIN users as assigners ON pas.assigned_by_id = assigners.id
LEFT OUTER JOIN users as mentors ON students.mentor_id = mentors.id
;

-- Number of custom statuses per ProjectAssignment
select 
  project_assignment_id as pa_id, 
  count(pacs.id) as num_custom_statuses,
  max(assigners.email) as assigner_email
from project_assignment_custom_statuses as pacs
left outer join project_assignments as pas on pacs.project_assignment_id = pas.id
left outer join users as assigners on pas.assigned_by_id = assigners.id
group by pa 
order by cnt desc;

