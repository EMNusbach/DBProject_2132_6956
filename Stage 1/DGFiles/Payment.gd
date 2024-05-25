
[General]
Version=1

[Preferences]
Username=
Password=2935
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PAYMENT
Count=5000

[Record]
Name=PAYMENT_ID
Type=NUMBER
Size=6
Data=Random(500000, 599999)
Master=

[Record]
Name=AMOUNT
Type=FLOAT
Size=22
Data=Random(40, 200) 
Master=

[Record]
Name=PAYMENT_DATE
Type=DATE
Size=
Data=Random(1/1/2020, 1/6/2024)
Master=

