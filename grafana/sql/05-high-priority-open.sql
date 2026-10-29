-- Panel: High Priority Tickets (table)
-- Adjust the priority names to match your setup (e.g. P1/P2 or '5 very high'/'4 high').
SELECT
  t.tn                                   AS ticket_number,
  t.title                                AS subject,
  tp.name                                AS priority,
  ts.name                                AS state,
  CONCAT(u.first_name, ' ', u.last_name) AS owner,
  t.create_time                          AS created
FROM ticket t
JOIN queue q               ON q.id   = t.queue_id
JOIN ticket_priority tp    ON tp.id  = t.ticket_priority_id
JOIN ticket_state ts       ON ts.id  = t.ticket_state_id
JOIN ticket_state_type tst ON tst.id = ts.type_id
JOIN users u               ON u.id   = t.user_id
WHERE q.name = 'tech_support'
  AND tst.name IN ('new', 'open')
  AND tp.name IN ('P1', 'P2')
ORDER BY t.create_time;
