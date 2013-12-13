SELECT * FROM reflection_log_entries as entries
JOIN users as students ON entries.student_id = students.id
JOIN reflection_log_prompts as prompts ON prompts.id = entries.reflection_log_prompt_id
;