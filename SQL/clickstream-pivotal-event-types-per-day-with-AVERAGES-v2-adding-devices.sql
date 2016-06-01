/*
DECLARE @START datetime
DECLARE @END datetime
DECLARE @MSO varchar(50)

SET @START = '2015-05-13'
SET @END = '2016-05-24' 
SET @MSO = 'Click-Tacoma'

--  PER TYPE 
SELECT 
	CAST(cl.[timestamp] as DATE) as [date],
	cl.eventCode as [Event Type],
	COUNT(cl.Id) as [Count],
	COUNT(DISTINCT cl.[deviceId]) as [reportedDevices],
	COUNT(cl.Id) / COUNT(DISTINCT cl.[deviceId]) as [events per device]
FROM dbo.clickstreamEventsLog cl
WHERE 
	cl.timestamp > @START AND cl.timestamp < @END
	AND cl.msoName = @MSO
GROUP BY CAST(cl.[timestamp] as DATE), cl.eventCode
ORDER BY CAST(cl.[timestamp] as DATE), cl.eventCode

-- TOTAL DAILY 
SELECT 
	CAST(cl.[timestamp] as DATE) as [date],
	COUNT(cl.Id) as [EventsCount],
	COUNT(DISTINCT cl.[deviceId]) as [devices],
	COUNT(cl.Id) / COUNT(DISTINCT cl.[deviceId]) as [events per device]
FROM dbo.clickstreamEventsLog cl
WHERE 
	cl.timestamp > @START AND cl.timestamp < @END
	AND cl.msoName = @MSO
GROUP BY CAST(cl.[timestamp] as DATE) 
ORDER BY CAST(cl.[timestamp] as DATE)

GO
*/
/*
Get the columns for dynamic pivoting and replace NULL with zero

DECLARE @cols NVARCHAR (MAX)

SELECT @cols = COALESCE (@cols + ',[' + Location + ']', '[' + Location + ']')
               FROM (SELECT DISTINCT Location FROM #tblStock) PV 
               ORDER BY Location 
-- Since we need Total in last column, we append it at last
SELECT @cols += ',[Total]'


--Varible to replace NULL with zero
DECLARE @NulltoZeroCols NVARCHAR (MAX)

SELECT @NullToZeroCols = SUBSTRING((SELECT ',ISNULL(['+Location+'],0) AS ['+Location+']' 
FROM (SELECT DISTINCT Location FROM #tblStock)TAB  
ORDER BY Location FOR XML PATH('')),2,8000) 

SELECT @NullToZeroCols += ',ISNULL([Total],0) AS [Total]'
*/

/*
PartCode = [date]
StockQty = [Count]; also [reportedDevices], [events per device]
Location = [Event Type]

#tblStock = my query
*/

-- Get the columns for dynamic pivoting and replace NULL with zero
-- FROM: http://stackoverflow.com/questions/28227924/row-and-column-total-in-dynamic-pivot

DECLARE @cols NVARCHAR (MAX)

SELECT @cols = COALESCE (@cols + ',[' + [Event Type] + ']', '[' + [Event Type] + ']')
               FROM (SELECT DISTINCT (cl.[eventCode]) as [Event Type]
					 FROM dbo.clickstreamEventsLog cl
               ) PV 
               ORDER BY [Event Type]
-- Since we need Total in last column, we append it at last
SELECT @cols += ',[Total]'


--Varible to replace NULL with zero
DECLARE @NulltoZeroCols NVARCHAR (MAX)

SELECT @NullToZeroCols = SUBSTRING((SELECT ',ISNULL(['+[Event Type]+'],0) AS ['+[Event Type]+']' 
FROM ( SELECT DISTINCT (cl.[eventCode]) as [Event Type]
					 FROM dbo.clickstreamEventsLog cl)TAB  
ORDER BY [Event Type] FOR XML PATH('')),2,8000) 

SELECT @NullToZeroCols += ',ISNULL([Total],0) AS [Total]'

--SELECT @cols, @NulltoZeroCols

/* using CUBE */

/*
PartCode = [date]
StockQty = [Count]; also [reportedDevices], [events per device]
Location = [Event Type]

#tblStock = my query
*/


DECLARE @query NVARCHAR(MAX)

SET @query = '
            DECLARE @START datetime
			DECLARE @END datetime
			DECLARE @MSO varchar(50)

			SET @START = ''2015-05-13''
			SET @END = ''2016-05-24'' 
			SET @MSO = ''Click-Tacoma''
			
			SELECT totals.*, pivotal.*
			FROM (
				SELECT [date],' + @NulltoZeroCols + ' FROM 
				 (
					 SELECT 
					 ISNULL(CAST([date] AS VARCHAR(30)),''Total'')[date], 
					 SUM([Count])[Count], 
					 ISNULL([Event Type],''Total'')[Event Type]              
					 FROM (
						SELECT 
							CAST(cl.[timestamp] as DATE) as [date],
							cl.eventCode as [Event Type],
							COUNT(cl.Id) / COUNT(DISTINCT cl.[deviceId]) as [Count]
							--COUNT(DISTINCT cl.[deviceId]) as [reportedDevices],
							--COUNT(cl.Id) / COUNT(DISTINCT cl.[deviceId]) as [events per device]
						FROM dbo.clickstreamEventsLog cl
						WHERE 
							cl.timestamp > @START AND cl.timestamp < @END
							AND cl.msoName = @MSO
						GROUP BY CAST(cl.[timestamp] as DATE), cl.eventCode
					 ) tbl
					 GROUP BY [Event Type],[date]
					 WITH CUBE
				 ) x
				 PIVOT 
				 (
					 MIN([Count])
					 FOR [Event Type] IN (' + @cols + ')
				) p
				-- ORDER BY CASE WHEN ([date]=''Total'') THEN 1 ELSE 0 END,[date] 
            )pivotal
            INNER JOIN (
	            SELECT 
					CAST(cl.[timestamp] as DATE) as [date],
					COUNT(cl.Id) as [TotalEventsCount],
					COUNT(DISTINCT cl.[deviceId]) as [TotalDevices],
					COUNT(cl.Id) / COUNT(DISTINCT cl.[deviceId]) as [AVG all events per device]
				FROM dbo.clickstreamEventsLog cl
				WHERE 
					cl.timestamp > @START AND cl.timestamp < @END
					AND cl.msoName = @MSO
				GROUP BY CAST(cl.[timestamp] as DATE) 
            ) totals
            ON CAST(totals.[date] AS VARCHAR(30)) = pivotal.[date]
            ORDER BY CASE WHEN (pivotal.[date]=''Total'') THEN 1 ELSE 0 END,pivotal.[date]
            '
            

EXEC SP_EXECUTESQL @query
