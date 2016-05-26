DECLARE @START datetime
DECLARE @END datetime
DECLARE @MSO varchar(50)

SET @START = '2016-05-13'
SET @END = '2016-05-24' 
SET @MSO = 'Click-Tacoma'

SELECT TOP 100
	CAST(cl.[timestamp] as DATE) as [date],
	cl.eventCode as [Event Type],
	COUNT(cl.Id) as [Count]
--	tt.[Count],
--	COUNT(DISTINCT(cl.[deviceId])) as [total devices]
FROM dbo.clickstreamEventsLog cl
--INNER JOIN (
--	SELECT 
--		CAST(cl2.[timestamp] as DATE) as [date],
--		COUNT(cl2.Id) as [Count]
--	FROM dbo.clickstreamEventsLog cl2
--	WHERE 
--		cl2.timestamp > @START AND cl2.timestamp < @END
--		AND cl2.msoName = @MSO
--	GROUP BY CAST(cl2.[timestamp] as DATE)
--) tt
--ON CAST(cl.[timestamp] as DATE) = tt.date
WHERE 
	cl.timestamp > @START AND cl.timestamp < @END
	AND cl.msoName = @MSO
GROUP BY CAST(cl.[timestamp] as DATE), cl.eventCode
ORDER BY CAST(cl.[timestamp] as DATE), cl.eventCode



