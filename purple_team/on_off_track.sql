SELECT 
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
  pacs.status as status,
  pacs.msg as message,
  pacs.created_at as status_created_at,
  pas.id as project_assignment_id  
FROM project_assignment_custom_statuses as pacs
LEFT OUTER JOIN users as authors ON pacs.author_id = authors.id
LEFT OUTER JOIN project_assignments as pas ON pacs.project_assignment_id = pas.id
LEFT OUTER JOIN users as students ON pas.student_id = students.id
LEFT OUTER JOIN sites ON students.site_id = sites.id
LEFT OUTER JOIN projects on pas.project_id = projects.id
LEFT OUTER JOIN users as assigners ON pas.assigned_by_id = assigners.id
LEFT OUTER JOIN users as mentors ON students.mentor_id = mentors.id
;