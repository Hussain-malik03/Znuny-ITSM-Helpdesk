-- Panel: Tickets Assigned Per Agent (table)
-- Owner changes inside the queue, grouped by day and new owner.
SELECT
  $__timeGroupAlias(th.create_time, 1d),
  CONCAT(u.first_name, ' ', u.last_name) AS agent,
  COUNT(DISTINCT th.ticket_id)           AS owner
FROM ticket_history th
JOIN ticket_history_type hty ON hty.id = th.history_type_id AND hty.name = 'OwnerUpdate'
JOIN queue q                 ON q.id   = th.queue_id
JOIN users u                 ON u.id   = th.owner_id
WHERE $__timeFilter(th.create_time)
  AND q.name = 'tech_support'
GROUP BY 1, 2
ORDER BY 1 DESC;
