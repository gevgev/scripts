USE Clickstream
GO
DECLARE @START datetime
DECLARE @END datetime
DECLARE @MSO varchar(50)

SET @START = '2016-05-14'
SET @END = '2016-05-26'
SET @MSO = 'Click-Tacoma'

SELECT 
	CASE
          WHEN events.[Timestamp] IS NULL THEN received.[Timestamp]
          ELSE events.[Timestamp]
          END AS [Timestamp],
	[Events], 
	[Received]
FROM (
SELECT
	cl.[timestamp] as [Timestamp],
	--NULL AS [Received],
	COUNT(cl.Id) As [Events]
FROM dbo.eventsLog cl
WHERE 
	--msoName = @MSO
	cl.timestamp >= @START
GROUP BY timestamp
) events
FULL OUTER JOIN 
(SELECT
	received as [Timestamp],
	COUNT(Id) As [Received]
	--NULL AS [Events]
FROM dbo.eventsLog
WHERE 
	--msoName = @MSO
	 received >= @START
GROUP BY received
) received
ON received.Timestamp = events.Timestamp
ORDER By [Timestamp]

