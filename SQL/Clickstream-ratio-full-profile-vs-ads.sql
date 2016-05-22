SELECT
	cl.msoName,
	CAST( cl.timestamp as DATE) as [date],
	COUNT(cl.Id) AS [all events],  
	COUNT(DISTINCT(cl.deviceId)) as [all devices],
	(COUNT(cl.Id)) / (COUNT(DISTINCT(cl.deviceId))) as [events per devices]
	
FROM dbo.clickstreamEventsLog cl
WHERE 
--	msoName = 'Mediacom-Moline' 
--	AND timestamp > '2016-04-23' AND timestamp < '2016-04-25' 
	msoName = 'Click-Tacoma' 
GROUP BY cl.msoName, CAST( cl.timestamp as DATE)
--	AND timestamp < '2016-05-16' AND timestamp > '2016-05-14'
ORDER BY cl.msoName, CAST( cl.timestamp as DATE)
