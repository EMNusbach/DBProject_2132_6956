
[General]
Version=1

[Preferences]
Username=
Password=2548
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=HIKING_TRAILS
Count=400

[Record]
Name=DURATION
Type=FLOAT
Size=22
Data=Random(1, 15)
Master=

[Record]
Name=FAMILY_FRIENDLY
Type=VARCHAR2
Size=50
Data=List('yes', 'no')
Master=

[Record]
Name=ACCESSIBILITY_INFO
Type=VARCHAR2
Size=255
Data=List('wheelchair accessible', 'not wheelchair accessible')
Master=

[Record]
Name=TRAIL_ID
Type=NUMBER
Size=6
Data=List(select trail_id from Trails)
Master=

