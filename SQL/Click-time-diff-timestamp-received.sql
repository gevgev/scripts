DECLARE @START datetime
DECLARE @END datetime

SET @START = '2016-04-01'
SET @END = '2016-05-21'

SELECT  TOP 1000 --[Id]
	  [deviceId],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) as [Diff (seconds)],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 3600  as [hours],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 60 % 60 as [min],
      AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) % 60 as [sec]
      --,[timestamp]
      --,[received]
      --,[deviceId]
      --,[eventCode]
      --,[msoName]
FROM [Clickstream].[dbo].[clickstreamEventsLog] cl
WHERE 
	(cl.[timestamp] > @START) AND (cl.[timestamp] < @END) AND
	(cl.[received] > @START) AND (cl.[received] < @END)
GROUP BY [deviceId]
ORDER BY [deviceId]

SELECT  TOP 1000 --[Id]
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
WHERE 
	-- deviceId = '0000000FCF79' AND 
	(cl.[timestamp] > @START) AND (cl.[timestamp] < @END) AND
	(cl.[received] > @START) AND (cl.[received] < @END)

GROUP BY [deviceId]
ORDER BY [deviceId]


SELECT  AVG(CAST( ([Diff]) as BIGINT)) AS [Total Average],

		AVG(CAST( ([Diff]) as BIGINT)) / 3600 AS [TA hours],
		AVG(CAST( ([Diff]) as BIGINT)) / 60 % 60 AS [TA min],
		AVG(CAST( ([Diff]) as BIGINT)) % 60 AS [TA sec],

		MIN(CAST( ([Diff]) as BIGINT)) AS [Total Min],

		MIN(CAST( ([Diff]) as BIGINT)) / 3600 AS [TMin hours],
		MIN(CAST( ([Diff]) as BIGINT)) / 60 AS [TMin min],
		MIN(CAST( ([Diff]) as BIGINT)) % 60 AS [TMin sec],

		MAX(CAST( ([Diff]) AS BIGINT)) AS [Total Max],

		MAX(CAST( ([Diff]) AS BIGINT)) / 3600 AS [TMax],
		MAX(CAST( ([Diff]) AS BIGINT)) / 60 % 60 AS [TMax],
		MAX(CAST( ([Diff]) AS BIGINT)) % 60 AS [TMax]

FROM 
(  SELECT  TOP 1000 --[Id]
		  [deviceId],
		  AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) as [Diff],
		  AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 3600  as [hours],
		  AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) / 60 % 60 as [min],
		  AVG( CAST(( DATEDIFF(second, [timestamp], [received])) as BIGINT)) % 60 as [sec]
		  --,[timestamp]
		  --,[received]
		  --,[deviceId]
		  --,[eventCode]
		  --,[msoName]
	FROM [Clickstream].[dbo].[clickstreamEventsLog] cl
	WHERE 
		(cl.[timestamp] > @START) AND (cl.[timestamp] < @END) AND
		(cl.[received] > @START) AND (cl.[received] < @END)
	GROUP BY [deviceId]
	ORDER BY [deviceId]
)ClickData
GO


/*
SELECT  TOP 1000 --[Id]
	  [deviceId],
      ( DATEDIFF(second, [timestamp], [received])) as [Diff (seconds)]
      --,[timestamp]
      --,[received]
      --,[deviceId]
      --,[eventCode]
      --,[msoName]
FROM [Clickstream].[dbo].[clickstreamEventsLog]
ORDER BY [deviceId]

*/
