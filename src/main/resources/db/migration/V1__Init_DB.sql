SELECT 'drop table if exists "' || tablename || '" cascade;' as pg_tbl_drop
FROM pg_tables
WHERE schemaname='public';

SELECT 'drop sequence if exists "' || relname || '" cascade;' as pg_sec_drop
FROM pg_class
WHERE relkind = 'S';

create sequence hibernate_sequence start 2 increment 1;

create table usr (
    id       BIGINT not null,
    password varchar(100) not null,
    role     varchar(20),
    username varchar(30) not null,
    CONSTRAINT pk_usr PRIMARY KEY (id)
);
