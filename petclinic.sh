#!/bin/bash

echo "DBSERVERNAME=$DBSERVERNAME"
echo "DBUSERNAME=$DBUSERNAME"
echo "DBPASSWORD=$DBPASSWORD"

cd /app
mkdir config

sed -e "s/DBSERVERNAME/$DBSERVERNAME/" \
    -e "s/DBUSERNAME/$DBUSERNAME/" \
    -e "s/DBPASSWORD/$DBPASSWORD/" application.properties.tmplt >config/application.properties

cat config/application.properties

# Check DB connection is up

count=0
while !  nc -z -w3 $DBSERVERNAME 3306
do
  if (( count > 12 ))
  then
    echo "Failed to connect to database" 1>&2
    exit 1
  fi
	sleep 5
  (( count=count+1))
done

java -jar ./petclinic.jar
