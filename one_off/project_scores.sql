SELECT 
  students.summit_id, 
  pas.due_on,
  pas.status,
  pas.score,
  pas.raw_score,
  pas.submitted_on,
  pas.scored_on,
  students.first_name as student_first, 
  students.last_name as student_last,
  students.grade_level,
  sites.name as school,
  assigners.first_name as assigner_first,
  assigners.last_name as assigner_last,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  projects.name as project_name,
  projects.seventy_pcnt_score as seventy_pcnt_score,
  projects.weight as project_weight_in_course
FROM project_assignments as pas
LEFT OUTER JOIN users as students ON pas.student_id = students.id
LEFT OUTER JOIN sites ON students.site_id = sites.id
LEFT OUTER JOIN projects on pas.project_id = projects.id
LEFT OUTER JOIN users as assigners ON pas.assigned_by_id = assigners.id
LEFT OUTER JOIN users as mentors ON students.mentor_id = mentors.id
;