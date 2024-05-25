
[General]
Version=1

[Preferences]
Username=
Password=2512
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=CUSTOMERS_PAYMENT
Count=400

[Record]
Name=PAYMENT_ID
Type=NUMBER
Size=6
Data=List(select payment_id from Payment)
Master=

[Record]
Name=TRAVELER_ID
Type=NUMBER
Size=6
Data=List(select traveler_id from Customers)
Master=

