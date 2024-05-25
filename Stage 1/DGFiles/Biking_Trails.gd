
[General]
Version=1

[Preferences]
Username=
Password=2446
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=BIKING_TRAILS
Count=400

[Record]
Name=LENGTH
Type=NUMBER
Size=5
Data=Random(1, 10)
Master=

[Record]
Name=TERRAIN_DESCRIPTION
Type=VARCHAR2
Size=255
Data=List('rocky', 'smooth', 'hilly', 'flat')
Master=

[Record]
Name=RENTAL_ON_SITE
Type=VARCHAR2
Size=50
Data=List('yes', 'no')
Master=

[Record]
Name=TRAIL_ID
Type=NUMBER
Size=6
Data=List(select trail_id from Trails)
Master=

