
[General]
Version=1

[Preferences]
Username=
Password=2911
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=EMPLOYEE_AT_TRAIL
Count=400

[Record]
Name=EMPLOYEE_ID
Type=NUMBER
Size=6
Data=List(select employee_id from employees)
Master=

[Record]
Name=TRAIL_ID
Type=NUMBER
Size=6
Data=List(select trail_id from trails)
Master=

