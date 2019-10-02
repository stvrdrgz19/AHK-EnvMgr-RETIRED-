@echo off

schtasks /Create /SC WEEKLY /TN Push_EnvMgr_Metrics /TR C:\EnvMgr\CreateTaskSchedule.bat /ST 09:00:00 /SD 09/09/2019

REM PAUSE