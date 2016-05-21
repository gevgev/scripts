DECLARE @START date
DECLARE @END date
DECLARE @DATE date

SET @START = CONVERT(date, '2016-04-6')
SET @END = CONVERT(date, '2016-04-8')

SET @DATE = CONVERT(date, '2016-04-13')

SELECT --[Id]
	  CAST([timestamp] as date) [Date],
      cast([timestamp] as time) [Time]
      --,[deviceId]
      ,COUNT([event]) AS Count
  FROM [Clickstream].[dbo].[VodEvents]
  GROUP BY CAST([timestamp] as date) , cast([timestamp] as time)
--  HAVING CAST([timestamp] as date) > @START AND CAST([timestamp] as date)< @END
  HAVING CAST([timestamp] as date) = @DATE
  ORDER BY CAST([timestamp] as date) , cast([timestamp] as time)


GO

