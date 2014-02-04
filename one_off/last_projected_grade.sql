select 
  students.summit_id as Student_ID,
  students.first_name as Student_First,
  students.last_name as Student_Last,
  courses.name as "Course Name",
  subjects.name as Subject,

  pgs.letter_grade as "Letter Grade",
  pgs.overall_score as "Overall Score",
  pgs.project_pcnt as project_pcnt,
  pgs.power_on_track as On_Track_for_Power,
  pgs.addl_pcnt as Additional_Focus_Areas,
  pgs.power_pcnt

from projected_grades as pgs
left outer join course_assignments as cas on cas.id = pgs.course_assignment_id
left outer join courses on courses.id = cas.course_id
left outer join subjects on subjects.id = courses.subject_id
left outer join users as students on students.id = cas.student_id
left outer join users as mentors on mentors.id = students.mentor_id
left outer join sites on students.site_id = sites.id
where projected_on = '2014-02-03'
and students.summit_id in (30431)
and courses.name not in ('Geometry 1')
order by students.summit_id
;