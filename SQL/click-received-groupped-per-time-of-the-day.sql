USE Clickstream
GO

DECLARE @START datetime
DECLARE @END datetime
DECLARE @MSO varchar(50)

SET @START = '2015-05-13'
SET @END = '2016-05-24'
SET @MSO = 'Click-Tacoma'


SELECT 
	CONVERT(TIME, timestamp) AS [Time],
	COUNT(Id) As [Events],
	COUNT(DISTINCT(deviceId)) AS [Devices]
FROM dbo.clickstreamEventsLog
WHERE 
	msoName = @MSO
	AND timestamp > @START AND timestamp < @END
GROUP BY CONVERT(TIME, timestamp)
ORDER BY CONVERT(TIME, timestamp)

