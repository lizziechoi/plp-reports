SELECT 
  students.summit_id, 
  students.last_leave_on > now() as "is currently enrolled?",
  pas.due_on,
  pas.status,
  pas.score,
  pas.raw_score,
  pas.submitted_on,
  pas.scored_on,
  pas.exempted,

  -- This includes projects that have been graded but which cannot be turned into a grade by the PLP  
  (pas.raw_score is null and pas.status in ('rating','performed','scored','inRevision'))::int as turned_in_but_not_scored,
  
  (pas.scored_on is null and submitted_on is not null) as alt_turned_in_but_not_scored,
  
  -- These are projects that are not yet turned in, and for which the due date has passed
  (cast(now() as date) > pas.due_on) as currently_overdue,
  (cast(now() as date) - pas.due_on) as days_currently_overdue_by,
  
  -- For projects that have been turned in, how long were they overdue by
  (pas.submitted_on - pas.due_on) as days_overdue_by_for_turned_in_projects,

  pas.scored_on - pas.submitted_on as days_to_grade_for_graded_projects,

  -- Days btwn student turned in and when (teacher graded it, or today if not graded yet)
  coalesce(pas.scored_on, cast(now() as date)) - pas.submitted_on as days_to_grade_incl_ungraded,
  coalesce(pas.scored_on, cast(now() as date)) - pas.submitted_on < 14 as graded_within_2_weeks,
  
  cast(now() as date) - pas.due_on < 14
    AND cast(now() as date) - pas.due_on > 0
    as due_last_2_weeks,
  
  cast(now() as date) - pas.due_on < 14
    AND cast(now() as date) - pas.due_on > 0
    AND pas.status in ('rating','performed','scored','inRevision') 
    as due_last_2_weeks_and_turned_in,

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
