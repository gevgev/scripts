-- BCP command:
-- C:\Users\ggevorgyan\Documents>bcp Clickstream..eventsLog format nul -f eventsLogSkipCol_Default.fmt -c -T
-- Link
-- https://msdn.microsoft.com/en-us/library/ms179250.aspx

USE Clickstream 
GO

BULK
INSERT dbo.Packets
FROM 'V:\git\go\src\github.com\gevgev\csbufferanalizer\output.csv'
WITH
(
FORMATFILE = 'C:\Users\ggevorgyan\Documents\PacketsSkipColId.fmt'
)
GO

SELECT TOP 100 * FROM dbo.Packets
GO

SELECT COUNT(*) FROM dbo.Packets
GO
