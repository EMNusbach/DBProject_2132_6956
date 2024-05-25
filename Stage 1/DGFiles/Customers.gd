
[General]
Version=1

[Preferences]
Username=
Password=2845
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=CUSTOMERS
Count=3000

[Record]
Name=TRAVELER_ID
Type=NUMBER
Size=6
Data=Random(300000, 399999)
Master=

[Record]
Name=TRAVELER_NAME
Type=VARCHAR2
Size=255
Data=FirstName ' ' LastName
Master=

[Record]
Name=TRAVELER_AGE
Type=NUMBER
Size=3
Data=Random(1, 100)
Master=

[Record]
Name=CONTACT_INFO
Type=NUMBER
Size=
Data='05' [0] '-' [000] '-' [0000]
Master=

[Record]
Name=NUMBER_OF_TRAVELERS
Type=NUMBER
Size=4
Data=Random(1, 100)
Master=

[Record]
Name=TRIP_DATE
Type=DATE
Size=
Data=Random(1/1/2020, 1/6/2024)
Master=

