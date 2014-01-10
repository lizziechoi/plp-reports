SELECT 
  students.summit_id, 
  pas.due_on,
  pas.status,
  pas.score,
  pas.raw_score,
  pas.submitted_on,
  pas.scored_on,

  -- This includes projects that have been graded but which cannot be turned into a grade by the PLP  
  (pas.raw_score is null and pas.status in ('rating','performed','scored','inRevision'))::int as turned_in_but_not_scored,
  
  -- ProjectAssignments.submitted_on will only be populated when the teacher has also scored the project.
  -- ShowEvidence will fix this by adding SubmitDate to the assignment statuses file
  -- (pas.scored_on is null and submitted_on is not null) as alt_turned_in_but_not_scored,
  
  -- These are projects that are not yet turned in, and for which the due date has passed
  (cast(now() as date) > pas.due_on) as currently_overdue,
  (cast(now() as date) - pas.due_on) as days_currently_overdue_by,
  
  -- For projects that have been turned in, how long were they overdue by
  (pas.submitted_on - pas.due_on) as days_overdue_by,
  
  -- TODO: number of teachers caught up on grading:
  --    # days between projected turned in and project graded (10 or fewer ungraded)
  --    #/% of projects with >X day turnaround

  students.first_name as student_first, 
  students.last_name as student_last,
  students.grade_level,
  sites.name as school,
  assigners.first_name as assigner_first,
  assigners.last_name as assigner_last,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  projects.name as project_name
FROM project_assignments as pas
LEFT OUTER JOIN users as students ON pas.student_id = students.id
LEFT OUTER JOIN sites ON students.site_id = sites.id
LEFT OUTER JOIN projects on pas.project_id = projects.id
LEFT OUTER JOIN users as assigners ON pas.assigned_by_id = assigners.id
LEFT OUTER JOIN users as mentors ON students.mentor_id = mentors.id
;

-- Bug test: this should not be empty
select id from project_assignments where scored_on is null and submitted_on is not null;
