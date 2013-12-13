SELECT 
  students.summit_id, 
  students.first_name as student_first, 
  students.last_name as student_last,
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
JOIN users as authors ON pacs.author_id = authors.id
JOIN project_assignments as pas ON pacs.project_assignment_id = pas.id
JOIN users as students ON pas.student_id = students.id
JOIN sites ON students.site_id = sites.id
JOIN projects on pas.project_id = projects.id
JOIN users as assigners ON pas.assigned_by_id = assigners.id
JOIN users as mentors ON students.mentor_id = mentors.id
;

