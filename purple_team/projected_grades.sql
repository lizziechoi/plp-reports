select 
  students.summit_id as Student_ID,
  students.first_name as Student_First,
  students.last_name as Student_Last,
  sites.name as School,
  students.grade_level as Grade_Level,
  students.last_leave_on > now() as "is currently enrolled?",
  courses.name as Course,
  subjects.name as Subject,
  mentors.first_name as Mentor_First,
  mentors.last_name as Mentor_Last,

  pgs.projected_on as As_Of,
  pgs.project_pcnt as project_pcnt,
  pgs.power_on_track as On_Track_for_Power,
  pgs.power_num_mastered,
  pgs.projected_on,
  pgs.power_out_of,
  pgs.addl_pcnt as Additional_Focus_Areas,
  pgs.created_at,
  pgs.updated_at,
  pgs.overall_score as Overall_Score,
  pgs.letter_grade as Letter_Grade,
  pgs.num_projects_graded,
  pgs.num_projects_overdue,
  pgs.num_projects_turned_in,
  pgs.num_projects_total,
  pgs.num_projects_below_70,
  pgs.num_projects_ungraded,
  pgs.num_projects_in_revision,
  pgs.num_projects_exempted,
  pgs.power_pcnt

from projected_grades as pgs
left outer join course_assignments as cas on cas.id = pgs.course_assignment_id
left outer join courses on courses.id = cas.course_id
left outer join subjects on subjects.id = courses.subject_id
left outer join users as students on students.id = cas.student_id
left outer join users as mentors on mentors.id = students.mentor_id
left outer join sites on students.site_id = sites.id
order by sites.name
;