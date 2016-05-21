/* SINGLE DEFECTIVE DATES DEVICE */

DECLARE @START datetime
DECLARE @END datetime

SET @START = '2016-04-01'
SET @END = '2016-05-21'

SELECT *,
	DATEDIFF(second, timestamp, received) 
FROM dbo.clickstreamEventsLog
WHERE deviceId = '0000000FCF79'


SELECT  --TOP 1000 --[Id]
	  [deviceId],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) as [AVG Diff (seconds)],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 3600  as [hours],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 60 % 60 as [min],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) % 60 as [sec],
      
      MIN( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) as [MIN Diff (seconds)],
      MIN( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 3600  as [hours],
      MIN( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 60 % 60 as [min],
      MIN( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) % 60 as [sec],

      MAX( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) as [MAX Diff (seconds)],
      MAX( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 3600  as [hours],
      MAX( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 60 % 60 as [min],
      MAX( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) % 60 as [sec]
      --,[timestamp]
      --,[received]
      --,[deviceId]
      --,[eventCode]
      --,[msoName]
FROM [Clickstream].[dbo].[clickstreamEventsLog] cl
WHERE deviceId = '0000000FCF79' AND 
	(cl.[timestamp] > @START) AND (cl.[timestamp] < @END) AND
	(cl.[received] > @START) AND (cl.[received] < @END)

GROUP BY [deviceId]
ORDER BY [deviceId]
 
GO
