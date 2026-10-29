-- Panel: Tickets Closed Per Agent Per Day (bar chart, time series)
-- Counts state changes into any "closed" state type, attributed to the agent who closed it.
SELECT
  $__timeGroupAlias(th.create_time, 1d),
  CONCAT('closed_tickets ', u.first_name, ' ', u.last_name) AS metric,
  COUNT(DISTINCT th.ticket_id)                               AS value
FROM ticket_history th
JOIN ticket_history_type hty ON hty.id = th.history_type_id AND hty.name = 'StateUpdate'
JOIN ticket_state ts         ON ts.id  = th.state_id
JOIN ticket_state_type tst   ON tst.id = ts.type_id AND tst.name = 'closed'
JOIN queue q                 ON q.id   = th.queue_id
JOIN users u                 ON u.id   = th.create_by
WHERE $__timeFilter(th.create_time)
  AND q.name = 'tech_support'
GROUP BY 1, 2
ORDER BY 1;
