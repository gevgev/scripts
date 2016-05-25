SELECT
	cl.msoName,
	CAST( cl.timestamp as DATE) as [date],
	COUNT(cl.Id) AS [all events],  
	COUNT(DISTINCT(cl.deviceId)) as [all devices],
	(COUNT(cl.Id)) / (COUNT(DISTINCT(cl.deviceId))) as [events per devices]
	
FROM dbo.clickstreamEventsLog cl
WHERE 
	timestamp > '2016-04-20' AND timestamp < '2016-05-24' 
--	msoName = 'Mediacom-Moline' 
--	msoName = 'Click-Tacoma' 
GROUP BY cl.msoName, CAST( cl.timestamp as DATE)
ORDER BY cl.msoName, CAST( cl.timestamp as DATE)
