
[General]
Version=1

[Preferences]
Username=
Password=2964
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=BIKERS_ON_TRAIL
Count=400

[Record]
Name=TRAVELER_ID
Type=NUMBER
Size=6
Data=List(select traveler_id from Customers)
Master=

[Record]
Name=TRAIL_ID
Type=NUMBER
Size=6
Data=List(select trail_id from trails)
Master=

