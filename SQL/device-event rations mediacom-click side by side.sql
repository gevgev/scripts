USE Clickstream
GO

DECLARE @START datetime
DECLARE @END datetime


SET @START = '2016-05-13'
SET @END = '2016-05-24' 

SELECT mc.[date], mc.msoName, mc.[all events], mc.[all devices], mc.[events per devices],
			 clc.msoName, clc.[all events], clc.[all devices], clc.[events per devices]
FROM
(
SELECT
	cl.msoName,
	CAST( cl.timestamp as DATE) as [date],
	COUNT(cl.Id) AS [all events],  
	COUNT(DISTINCT(cl.deviceId)) as [all devices],
	(COUNT(cl.Id)) / (COUNT(DISTINCT(cl.deviceId))) as [events per devices]
	
FROM dbo.clickstreamEventsLog cl
WHERE 
	cl.timestamp > @START AND cl.timestamp < @END
    AND cl.msoName = 'Mediacom-Moline' 
GROUP BY cl.msoName, CAST( cl.timestamp as DATE)
--ORDER BY cl.msoName, CAST( cl.timestamp as DATE)
) mc

INNER JOIN 
(
SELECT
	cl2.msoName,
	CAST( cl2.timestamp as DATE) as [date],
	COUNT(cl2.Id) AS [all events],  
	COUNT(DISTINCT(cl2.deviceId)) as [all devices],
	(COUNT(cl2.Id)) / (COUNT(DISTINCT(cl2.deviceId))) as [events per devices]
	
FROM dbo.clickstreamEventsLog cl2
WHERE 
	cl2.timestamp > @START AND cl2.timestamp < @END
    AND cl2.msoName = 'Click-Tacoma' 
GROUP BY cl2.msoName, CAST( cl2.timestamp as DATE)
--ORDER BY cl.msoName, CAST( cl.timestamp as DATE)
) clc

ON mc.[date] = clc.[date]
ORDER by mc.[date]