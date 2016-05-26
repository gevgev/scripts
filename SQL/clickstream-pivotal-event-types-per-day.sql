DECLARE @START datetime
DECLARE @END datetime
DECLARE @MSO varchar(50)

SET @START = '2015-05-13'
SET @END = '2016-05-24' 
SET @MSO = 'Click-Tacoma'

/*  PER TYPE */
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

/* TOTAL DAILY */
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

/* per type and daily total combined */


-- Store      Week     xCount
-- -------    ----     ------
-- date		  Event		Count
-- -------    ----     ------
-- 102        1        96
-- 101        1        138
-- 105        1        37
-- 109        1        59

-- Store        1          2          3        4        5        6....
-- date
-- ----- 
-- 101        138        282        220
-- 102         96        212        123
-- 105         37        
-- 109

/* PIVOT EVENT TYPES */

DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX)


select @cols = STUFF((SELECT ',' + QUOTENAME(eventCode) --(Week) 
                    from clickstreamEventsLog --yt
                    group by eventCode -- Week
                    order by eventCode-- Week
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

--set @query = 'SELECT store,' + @cols + ' from 
            -- (
            --    select store, week, xCount
            --    from yt
            --) x
            --pivot 
            --(
            --    sum(xCount)
            --    for week in (' + @cols + ')
            --) p '

set @query = '
			DECLARE @START datetime
			DECLARE @END datetime
			DECLARE @MSO varchar(50)

			SET @START = ''2015-05-13''
			SET @END = ''2016-05-24'' 
			SET @MSO = ''Click-Tacoma''

				SELECT date,' + @cols + 'from 
             (
				SELECT 
					CAST(cl.[timestamp] as DATE) as [date],
					cl.eventCode as [EventType],
					COUNT(cl.Id) as [Count]
				FROM dbo.clickstreamEventsLog cl
				WHERE 
					cl.timestamp > @START AND cl.timestamp < @END
					AND cl.msoName = @MSO
				GROUP BY CAST(cl.[timestamp] as DATE), cl.eventCode
            ) x
            pivot 
            (
                sum(Count)
                for EventType in (' + @cols + ')
            ) p '

execute(@query);
GO