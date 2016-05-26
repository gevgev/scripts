USE Clickstream
GO

SELECT GETDATE(), COUNT(id)
FROM dbo.clickstreamEventsLog (NOLOCK)
--WHERE msoName = 'Mediacom-Moline'
--WHERE msoName = 'Click-Tacoma'

--   8,957,999 
--  29,969,999
-- 110,256,407
-- 2016-05-22 04:05:03.063	114,994,903
-- 2016-05-22 04:25:05.167	118,386,764
-- 2016-05-22 05:05:55.923	124,785,913
-- 2016-05-22 05:56:15.117	130,097,995
-- 2016-05-22 14:01:59.647	198,144,841
-- 2016-05-22 15:01:12.780	206,250,854
-- 2016-05-22 19:43:07.153	243,391,457
-- 2016-05-22 22:12:47.770	268,204,455 <-- two additional worker nodes just started 
-- (in about 30 minutes anouther two started) - 3:45pm.
-- 2016-05-23 00:00:38.397	  302,420,453
-- 2016-05-23 01:01:34.150	  322,928,006 (full hour for 5 workers, just 20 mln records, vs expected 50, ok 40)
-- 2016-05-23 03:00:17.707	  362,189,527
-- 2016-05-23 06:05:01.080	  421,454,417
-- 2016-05-23 07:30:33.400	  449,501,624
-- 2016-05-23 13:59:32.563	  578,947,930  6:30 hours, 130 mln. Still 20 mln per hour (7am?)
-- 2016-05-23 18:41:51.760	  667,339,897 almost 5 hours(4:40), less than 20 mln  (??)
-- 2016-05-23 21:44:42.513	  727,990,005 3 hours (3:05PM) = 60 mln, 20 mln per hour
-- 2016-05-24 04:06:09.787	  850,608,047 6 hours (9:35pm) = 123 mln, less than 20 mln
-- 2016-05-25 01:24:24.600	1,256,358,893 21+1=22.5 hours. ~ 408 mln, 18 mln per hour
-- 2016-05-25 19:13:51.203	1,314,090,914 <- final
--												1,314,090,914
-- click 5/23 duplicates deleted for all 5/23 =    22,963,110 row(s) affected)


-- 114,836,846

-- 9:44pm 5/23
-- 9:51am 5/24
-- 12:54pm

-- Click 05/20 - anyone? <-- yes, FTP in batch one. (click-nohup.out)
-- Click 05/22 - yes, next, for .147
-- Check for duplicates for Click 05/23, as a result of pause of #94.
--		If anything - just delete * for Click 5/23, and restart #94 (again) just for Click 5/23
-- expected completeions (94 is done)
--  8:20pm? - 147 <- completed
--  9:30pm -  14  <- completed
-- 10:45pm - 152, ftp <-- completed
-- 12:00am -  72 <-- completed

-- .152 (ftp)   - 0585 out of 0713, 04/29. 4/30 last. Maybe 5/22, no 5/23 yet
--				- 0784 out of 0909, 04/30. Potentially the last one. Maybe 5/22. There is already 05/23
--				- done up to 4/30. Failed on 5/1. Did not try 5/22 or 5/23. Good
-- 1:04			- started for 05/22-05/23. - I can stop any time if needed. 
-- 1:20			- 0020 out of 0770, 05/22. next 05/23
-- 2:30			- 0114 / 0770, 5-22 - no 05-23, will fail
-- 3:17			- 0175 / 0770 --> Mediacom 05/22
-- 4:27			- 0270 / 0770 --> Mediacom 05/22
-- 6:38			- 0426 / 0770 : 2 hours, ~80 per hour. 
-- 9:17			- 0652 / 0770 :  2:39 hours = ~ 85 per hour
-- 10:02		- 0755 / 0770 :  45 minutes, with speed of 137?!!
-- done in 1:20 hours? @10:30pm-11:00pm -? 10:08?
-- DONE ---

-- .94(slowest) - 0056 out of 0695, 05/04, 05/05 last
--				- 0326 out of 0652. 05/05, Last one
--				- 0561 out of 0652. 05/05 last one - almost
-- 1:20			- 0599 out of 0652. 05/05 last
-- 2:30 done	- DONE!!
-- 2:39			- started 05/23 -> Click 05/23 !!!
-- 3:04			- 0032 / 180
-- 4:26			- fixed the stopped on 110. Running now through run-csv.sh, 112 / 180
-- 6:39			- DONE!!! - potentially duplicates in Click 5/23. Maybe many.
-- .94 DONE ----

-- .147			- 0133 out of 0743, 05/09, 05/10 last
--				- 0380 out of 0744, 05/10, Last one
--				- 0647 out of 0744, 05/10, last one - almost
-- 1:24			- 0681 out of 0744, 05/10, last one
-- 3:00 done?	- 2:40 DONE!!!
-- 2:49			- Started Click 05/21 - 05/22 -> !! Removed 5/23 - as #94 also processes that
-- 2:51			- 0002 / 0202 - Click 5/21, next Click 5/22
-- 4:53			- 0152 / 0202 - Click 5/21, next Click 5/22	
--		Click 5/21 completed, now on Click 5/22	
-- 6:41			- 088  / 0202 - Click 5/22
-- done @8:30pm? maybe?
-- DONE -----

--  .72			- 0247 out of 0845, 05/14, 05/15 last
--				- 0386 out of 0825, 05/15, Last one
--				- 0638 out of 0825, 05/15, last one - almost
-- 1:25			- 0677 out of 0825, 05/15, last one
-- 2:41			- 0790 / 825
-- 4:45 done?	3:30 done?
-- 3:10 done
-- 3:15			started Mediacom 5/23 
-- 6:43			- 0252 / 745 Mediacom 5/23
-- 9:21			- 0512 / 745 - 2:38. 100 per hour = in 1.5 hour?
--10:04			- 0615 / 745 - 43 minutes, =137 per minute!!
-- done in 6 hours? @11:00 pm? Midnight? in 50 minutes = 10:55pm
-- 10:10 - 0633
-- 10:20 - 0663, 10 minutes = 30, 180 per hour? = in 25 minutes?
-- 10:30 - 0693, 30 in 10 minutes. 15 minutes
-- 10:45?
-- DONE --

--  .14			- 0236 out of 0651, 05/19, 05/21 last
--				- 0492 out of 0679, 05/20, 05/21 last
--  			- 0062 out of 0777, 05/21, Last one. Just started
--	1:30		- 0113 out of 0777, 05/21 last one
--  2:45		- 0232 / 0777 
--  plus 12 hours. be done after 2am -> Mediacom 05/21
--  6:44		- 0552 / 0777 (4 hours, 320, 80 per hour. = 2.5 more hours.
--  9:30pm done? <- DONE
--- DONE
