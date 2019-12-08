-- drop objects
drop table volunteers cascade constraints;

-- create tables
create table volunteers (
    id                             number not null constraint volunteers_id_pk primary key,
    first_name                     varchar2(255) not null,
    last_name                      varchar2(255) not null,
    date_of_birth                  date not null,
    gender                         varchar2(1)  constraint volunteers_gender_cc
                                   check (gender in ('M','F')) not null,
    email                          varchar2(255),
    phone                          varchar2(30),
    duties                         varchar2(100),
    created                        date not null,
    created_by                     varchar2(255) not null,
    updated                        date not null,
    updated_by                     varchar2(255) not null
)
;


-- triggers
create or replace trigger volunteers_biu
    before insert or update 
    on volunteers
    for each row
begin
    if :new.id is null then
        :new.id := to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
    if inserting then
        :new.created := sysdate;
        :new.created_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := nvl(sys_context('APEX$SESSION','APP_USER'),user);
end volunteers_biu;
/

-- load data
