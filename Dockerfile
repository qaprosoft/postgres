FROM postgres:9.6

RUN apt-get update && apt-get -y install postgresql-9.6-cron
