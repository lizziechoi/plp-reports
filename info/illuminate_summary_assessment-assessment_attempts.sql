COPY (
  (select 
    students.summit_id as "Student ID",
    courses.name as "Course Name",
    kds.name as "Focus Area Name",
    ats.taken_at as "Date Taken",
    ckds.power as "Is Power?",
    ats.num_correct as "Num Correct",
    ats.num_possible as "Num Possible",
    (ats.num_correct / cast(ats.num_possible as float)) >= kds.pcnt_to_pass as "Mastered?",
    students.first_name,
    students.last_name,
    null as reason
  from users as students
  join course_assignments as cas on cas.student_id = students.id
  join courses on cas.course_id = courses.id
  join course_know_dos as ckds on ckds.course_id = courses.id
  join know_dos as kds on ckds.know_do_id = kds.id
  left outer join assessment_takes as ats 
    on ats.know_do_id = kds.id and ats.student_id = students.id
  where students.type = 'Student'
    and students.last_leave_on > now()
    and students.site_id != 7 -- SPS Demo
  
  )
  UNION ALL
  (select 
    students.summit_id as "Student ID",
    courses.name as "Course Name",
    kds.name as "Focus Area Name",
    null as "Date Taken",
    ckds.power as "Is Power?",
    null as "Num Correct",
    null as "Num Possible",
    true as "Mastered?",
    students.first_name,
    students.last_name,
    kdms.reason
  from users as students
  join course_assignments as cas on cas.student_id = students.id
  join courses on cas.course_id = courses.id
  join course_know_dos as ckds on ckds.course_id = courses.id
  join know_dos as kds on ckds.know_do_id = kds.id
  join know_do_masteries as kdms 
    on kdms.know_do_id = kds.id and kdms.student_id = students.id
  where students.type = 'Student'
    and kdms.reason != 'illuminate'
    and students.last_leave_on > now()
    and students.site_id != 7 -- SPS Demo
  )
)
TO STDOUT (format csv, HEADER TRUE)
;