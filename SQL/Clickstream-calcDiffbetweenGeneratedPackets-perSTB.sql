--CTE - ALL 
With tblDifference as
(
Select Row_Number() OVER (Order by [deviceId], [timestamp]) as RowNumber, [deviceId], [timestamp] from dbo.Packets
)
--Actual Query
Select ' ' +Cur.[deviceId],
	Cur.[timestamp] as [Current], 
	Prv.[timestamp] as [Previous],
	convert(varchar, datediff (s, Prv.[timestamp], Cur.[timestamp]) / (60 * 60 * 24)) + ' : '
	+ convert(varchar, dateadd(s, datediff (s, Prv.[timestamp], Cur.[timestamp]), convert(datetime2, '0001-01-01')), 108) as [Difference]
--	 Cur.[timestamp] - Prv.[timestamp] as [Difference] 
from tblDifference Cur Left Outer Join tblDifference Prv
On Cur.RowNumber=Prv.RowNumber+1
WHERE Cur.[deviceId] = Prv.[deviceId]
--	AND (datediff (s, Prv.[timestamp], Cur.[timestamp]) > (6 * 60 * 60)) -- = seconds in 6 hours = 6h * 60 mins * 60 seconds
Order by Cur.[deviceId], Cur.[timestamp]

GO

--Create CTE - just the ones which are over 6 hours:
With tblDifference as
(
Select Row_Number() OVER (Order by [deviceId], [timestamp]) as RowNumber, [deviceId], [timestamp] from dbo.Packets
)
--Actual Query
Select ' '+ Cur.[deviceId],
	Cur.[timestamp] as [Current], 
	Prv.[timestamp] as [Previous],
	convert(varchar, datediff (s, Prv.[timestamp], Cur.[timestamp]) / (60 * 60 * 24)) + ' : '
	+ convert(varchar, dateadd(s, datediff (s, Prv.[timestamp], Cur.[timestamp]), convert(datetime2, '0001-01-01')), 108) as [Difference over 6 hours]
--	 Cur.[timestamp] - Prv.[timestamp] as [Difference] 
from tblDifference Cur Left Outer Join tblDifference Prv
On Cur.RowNumber=Prv.RowNumber+1
WHERE Cur.[deviceId] = Prv.[deviceId]
	AND (datediff (s, Prv.[timestamp], Cur.[timestamp]) > (6 * 60 * 60)) -- = seconds in 6 hours = 6h * 60 mins * 60 seconds
Order by Cur.[deviceId], Cur.[timestamp]
GO

