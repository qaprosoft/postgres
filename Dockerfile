FROM kubedb/postgres:9.6-v2

ENV PG_CRON_VERSION=1.1.3

RUN apk add --no-cache --virtual .build-deps build-base ca-certificates openssl tar \
    && wget -O /pg_cron.tgz https://github.com/citusdata/pg_cron/archive/v$PG_CRON_VERSION.tar.gz \
    && tar xvzf /pg_cron.tgz && cd pg_cron-$PG_CRON_VERSION \
    && sed -i.bak -e 's/-Werror//g' Makefile \
    && sed -i.bak -e 's/-Wno-implicit-fallthrough//g' Makefile \
    && make && make install \
    && cd .. && rm -rf pg_cron.tgz && rm -rf pg_cron-*

RUN sed -r -i "s/[#]*\s*(shared_preload_libraries)\s*=\s*'(.*)'/\1 = 'pg_cron,\2'/;s/,'/'/" /scripts/primary/postgresql.conf \
    && echo "cron.database_name = 'postgres'" >> /scripts/primary/postgresql.conf
