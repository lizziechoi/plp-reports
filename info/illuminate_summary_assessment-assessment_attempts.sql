COPY (
  (select 
    courses.name as "course name",
    kds.name as "focus area name",
    ats.taken_at,
    ckds.power,
    ats.num_correct,
    ats.num_possible,
    (ats.num_correct / cast(ats.num_possible as float)) >= kds.pcnt_to_pass as "Mastered?",
    students.summit_id,
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
  )
  UNION ALL
  (select 
    courses.name as "course name",
    kds.name as "focus area name",
    null as "taken_at",
    ckds.power,
    null as "num_correct",
    null as "num_possible",
    true as "Mastered?",
    students.summit_id,
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
  )
)
TO '/Users/sam/Desktop/takes.csv' (format csv)
;