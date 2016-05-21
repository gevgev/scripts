-- BCP command:
-- C:\Users\ggevorgyan\Documents>bcp Clickstream..eventsLog format nul -f eventsLogSkipCol_Default.fmt -c -T
-- Link
-- https://msdn.microsoft.com/en-us/library/ms179250.aspx

USE Clickstream 
GO

BULK
INSERT dbo.VodEvents
FROM 'V:\git\go\src\github.com\gevgev\csbufferanalizer\vodLog-2016-04-14.csv'
WITH
(
FORMATFILE = 'C:\Users\ggevorgyan\Documents\skipVodColSkipIdCol.fmt'
)
GO

SELECT * FROM VodEvents
GO

