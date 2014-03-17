DELETE FROM assessment_takes
-- SELECT * FROM assessment_takes
WHERE id in 
  (
  SELECT at2.id FROM assessment_takes as at1
  JOIN assessment_takes as at2
   ON  at1.student_id = at2.student_id
   AND at1.num_correct = at2.num_correct
   AND at1.num_possible = at2.num_possible
   AND at1.know_do_id = at2.know_do_id
   AND at1.id <> at2.id
   AND at1.taken_at = at2.taken_at
  )
-- ORDER BY student_id, know_do_id, num_correct, taken_at, completed_at
;
