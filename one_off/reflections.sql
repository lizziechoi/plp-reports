SELECT 
  students.summit_id, 
  students.first_name as student_first, 
  students.last_name as student_last,
  students.grade_level,
  sites.name as school,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  entries.contents as reflection_contents,
  prompts.message as prompt,
  entries.entry_type,
  entries.due_on,
  entries.completed,
  entries.completed_at,
  entries.created_at
FROM reflection_log_entries as entries
JOIN users as students ON entries.student_id = students.id
JOIN reflection_log_prompts as prompts ON prompts.id = entries.reflection_log_prompt_id
JOIN sites ON students.site_id = sites.id
JOIN users as mentors ON students.mentor_id = mentors.id
;
