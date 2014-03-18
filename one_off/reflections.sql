SELECT 
  reflectors.summit_id, 
  reflectors.first_name as user_first, 
  reflectors.last_name as user_last,
  reflectors.grade_level,
  reflectors.type as user_type,
  sites.name as school,
  mentors.first_name as mentor_first,
  mentors.last_name as mentor_last,
  entries.contents as reflection_contents,
  prompts.message as prompt,
  tags.tag_string as tag_list,  
  entries.entry_type,
  entries.due_on,
  entries.completed,
  entries.completed_at,
  entries.created_at
FROM reflection_log_entries as entries
LEFT OUTER JOIN users as reflectors ON entries.user_id = reflectors.id
LEFT OUTER JOIN reflection_log_prompts as prompts ON prompts.id = entries.reflection_log_prompt_id
LEFT OUTER JOIN sites ON reflectors.site_id = sites.id
LEFT OUTER JOIN users as mentors ON reflectors.mentor_id = mentors.id
LEFT OUTER JOIN (
  select 
    entries.id as entry_id,
    array_to_string(array_agg(tags.name),'; ') as tag_string
  from reflection_log_entries as entries
  left outer join reflection_log_entry_reflection_log_tags as entry_tags on entry_tags.reflection_log_entry_id = entries.id
  left outer join reflection_log_tags as tags on entry_tags.reflection_log_tag_id = tags.id
  group by entries.id
) as tags on tags.entry_id = entries.id
;


SELECT 
  reflectors.first_name as user_first, 
  reflectors.last_name as user_last,
  sites.name as school,
  entries.contents as reflection_contents,
  prompts.message as prompt,
  entries.entry_type,
  entries.due_on,
  entries.completed,
  entries.completed_at,
  entries.created_at
FROM reflection_log_entries as entries
LEFT OUTER JOIN users as reflectors ON entries.user_id = reflectors.id
LEFT OUTER JOIN reflection_log_prompts as prompts ON prompts.id = entries.reflection_log_prompt_id
LEFT OUTER JOIN sites ON reflectors.default_site_id = sites.id
where reflectors.type = 'Teacher'
;
