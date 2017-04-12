md "c:\MongoDB\data\db"
md "c:\MongoDB\data\log\"


copy "C:\RAD-Alicia\Data\mongod.log" "c:\MongoDB\data\log\mongod.log"

copy "C:\RAD-Alicia\Data\mongod.cfg" "C:\Program Files\MongoDB\Server\3.4\mongod.cfg"
pause
"C:\Program Files\MongoDB\Server\3.4\bin\mongod.exe" --config "C:\Program Files\MongoDB\Server\3.4\mongod.cfg" --install
pause

net start MongoDB