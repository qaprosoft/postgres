FROM postgres:9.6

RUN apt-get update && apt-get -y install postgresql-9.6-cron

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
