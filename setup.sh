git clone https://github.com/spring-projects/spring-petclinic.git
cp spring-petclinic/src/main/resources/db/mysql/schema.sql sql/02.sql
cp spring-petclinic/src/main/resources/db/mysql/data.sql sql/03.sql

rm -rf spring-petclinic