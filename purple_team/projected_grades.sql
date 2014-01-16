select 
  students.summit_id as Student_ID,
  students.first_name as Student_First,
  students.last_name as Student_Last,
  students.grade_level as Grade_Level,
  courses.name as Course,
  subjects.name as Subject,
  mentors.first_name as Mentor_First,
  mentors.last_name as Mentor_Last,
  pgs.projected_on as As_Of,
  pgs.project_pcnt as Projected_Overall_Score,
  pgs.power_on_track as On_Track_for_Power,
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
  pgs.power_pcnt
from projected_grades as pgs
join course_assignments as cas on cas.id = pgs.course_assignment_id
join courses on courses.id = cas.course_id
join subjects on subjects.id = courses.subject_id
join users as students on students.id = cas.student_id
join users as mentors on mentors.id = students.mentor_id
;