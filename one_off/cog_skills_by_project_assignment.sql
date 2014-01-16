SELECT 
  students.summit_id as student_id, 
  students.first_name as student_first, 
  students.last_name as student_last,
  projects.name as project_name,
  csds.name as cog_skil_domain,
  pads.score as cog_skill_domain_score,
  pas.due_on,
  pas.status,
  pas.score,
  pas.raw_score,
  pas.submitted_on,
  pas.scored_on,
  students.grade_level,
  sites.name as school,
  assigners.first_name as assigner_first,
  assigners.last_name as assigner_last,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last
FROM project_assignment_domain_scores as pads
INNER JOIN project_assignments as pas on pas.id = pads.project_assignment_id
INNER JOIN cog_skill_domains as csds on csds.id = pads.cog_skill_domain_id
INNER JOIN users as students ON pas.student_id = students.id
INNER JOIN sites ON students.site_id = sites.id
LEFT OUTER JOIN projects on pas.project_id = projects.id
LEFT OUTER JOIN users as assigners ON pas.assigned_by_id = assigners.id
LEFT OUTER JOIN users as mentors ON students.mentor_id = mentors.id
;
