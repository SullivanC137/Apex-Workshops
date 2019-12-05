-- drop objects
drop table runners cascade constraints;
drop table events cascade constraints;
drop table event_results cascade constraints;

-- create tables
create table runners (
    id                             number not null constraint runners_id_pk primary key,
    first_name                     varchar2(255) not null,
    last_name                      varchar2(255) not null,
    date_of_birth                  date not null,
    gender                         varchar2(1) constraint runners_gender_cc
                                   check (gender in ('M','F')) not null,
    team_name                      varchar2(255),
    email                          varchar2(255),
    phone                          varchar2(30),
    address                        varchar2(4000),
    photo                          blob,
    photo_filename                 varchar2(512),
    photo_mimetype                 varchar2(512),
    photo_charset                  varchar2(512),
    photo_lastupd                  date,
    created                        date not null,
    created_by                     varchar2(255) not null,
    updated                        date not null,
    updated_by                     varchar2(255) not null
)
;

create table events (
    id                             number not null constraint events_id_pk primary key,
    name                           varchar2(255) not null,
    the_date                       date not null,
    total_distance                 number not null,
    created                        date not null,
    created_by                     varchar2(255) not null,
    updated                        date not null,
    updated_by                     varchar2(255) not null
)
;

create table event_results (
    id                             number not null constraint event_results_id_pk primary key,
    event_id                       number
                                   constraint event_results_event_id_fk
                                   references events on delete cascade,
    runner_id                      number
                                   constraint event_results_runner_id_fk
                                   references runners on delete cascade,
    start_time                     varchar2(20),
    end_time                       varchar2(20),
    created                        date not null,
    created_by                     varchar2(255) not null,
    updated                        date not null,
    updated_by                     varchar2(255) not null
)
;


-- triggers
create or replace trigger events_biu
    before insert or update 
    on events
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
end events_biu;
/

create or replace trigger runners_biu
    before insert or update 
    on runners
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
end runners_biu;
/

create or replace trigger event_results_biu
    before insert or update 
    on event_results
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
end event_results_biu;
/


-- indexes
create index event_results_i1 on event_results (event_id);
create index event_results_i2 on event_results (runner_id);
-- load data
 
insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623564984171903325799937209058,
    'Gricelda',
    'Luebbers',
    sysdate - 27,
    'M',
    'Demo Development',
    'gricelda.luebbers@aaab.com',
    'Eget Rhoncus Nonmolestie',
    '509 Cebrecos Street',
    null,
    'Fixed Asset Tracking',
    'Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    'Ullamcorper.Interdum et.',
    sysdate - 43
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623566193097722940429111915234,
    'Dean',
    'Bollich',
    sysdate - 79,
    'F',
    'Cloud Optimization',
    'dean.bollich@aaac.com',
    'Risusphasellus Vitae Ligula',
    '961 Tanquecitos Place',
    null,
    'Fault Rate Reduction',
    'Sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit.',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.',
    sysdate - 62
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623567402023542555058286621410,
    'Milo',
    'Manoni',
    sysdate - 42,
    'F',
    'New Feature Verification',
    'milo.manoni@aaad.com',
    'Amet Imperdiet Ex',
    '282 Dresden Street',
    null,
    'Shipping Process Review',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra.',
    'Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    sysdate - 49
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623568610949362169687461327586,
    'Laurice',
    'Karl',
    sysdate - 20,
    'M',
    'Documentation Review',
    'laurice.karl@aaae.com',
    'Sollicitudin Elementum Nulla',
    '444 Arrow Point Street',
    null,
    'Cloud Optimization',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    'Nulla.',
    sysdate - 50
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623569819875181784316636033762,
    'August',
    'Rupel',
    sysdate - 71,
    'M',
    'Fault Rate Reduction',
    'august.rupel@aaaf.com',
    'Tristique Ac Volutpat',
    '423 Bayou LOurse Street',
    null,
    'Preparation Of White Paper',
    'Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    'Commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.',
    sysdate - 23
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623571028801001398945810739938,
    'Salome',
    'Guisti',
    sysdate - 30,
    'F',
    'Documentation Review',
    'salome.guisti@aaag.com',
    'Commodo Dictum Lorem',
    '299 Maribel Street',
    null,
    'Buying Activity Analysis',
    'Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam.',
    'Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla.',
    sysdate - 13
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623572237726821013574985446114,
    'Lovie',
    'Ritacco',
    sysdate - 9,
    'F',
    'Cloud Optimization',
    'lovie.ritacco@aaah.com',
    'Vestibulum Lacinia Arcu',
    '898 Cogullos Place',
    null,
    'Shipping Process Review',
    'Proin sit amet massa eu lorem commodo.',
    'Posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    sysdate - 92
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623573446652640628204160152290,
    'Chaya',
    'Greczkowski',
    sysdate - 72,
    'F',
    'Six Sigma Introduction',
    'chaya.greczkowski@aaai.com',
    'Tristique Ac Volutpat',
    '325 Hambleton Street',
    null,
    'User Group Advertising',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante.',
    'Porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.',
    sysdate - 7
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623574655578460242833334858466,
    'Twila',
    'Coolbeth',
    sysdate - 57,
    'M',
    'Shipping Process Review',
    'twila.coolbeth@aaaj.com',
    'Eu Lorem Commodo',
    '60 Durango Blvd',
    null,
    'User Group Advertising',
    'Sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae;.',
    'In faucibus orci luctus et ultrices posuere cubilia Curae;.',
    sysdate - 67
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623575864504279857462509564642,
    'Carlotta',
    'Achenbach',
    sysdate - 27,
    'F',
    'Documentation Review',
    'carlotta.achenbach@aaak.com',
    'Vestibulum Lacinia Arcu',
    '197 Pontils Blvd',
    null,
    'Transfer To Manufacturing',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem.',
    'Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    sysdate - 52
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623577073430099472091684270818,
    'Jeraldine',
    'Audet',
    sysdate - 61,
    'F',
    'Data Loss Prevention',
    'jeraldine.audet@aaal.com',
    'Vitae Ligula Commodo',
    '415 Tenby Street',
    null,
    'Customer Satisfaction Improvement',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    'Quis consectetur mi venenatis nec. Donec convallis.',
    sysdate - 1
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623578282355919086720858976994,
    'August',
    'Arouri',
    sysdate - 2,
    'F',
    'Demo Development',
    'august.arouri@aaam.com',
    'Fames Ac Ante',
    '837 Greendale Place',
    null,
    'Course Development',
    'Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    sysdate - 12
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623579491281738701350033683170,
    'Ward',
    'Stepney',
    sysdate - 2,
    'M',
    'Six Sigma Introduction',
    'ward.stepney@aaan.com',
    'Ullamcorperinterdum Et Malesua',
    '98 Tosalnou Blvd',
    null,
    'Shipping Process Review',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis.',
    sysdate - 85
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623580700207558315979208389346,
    'Ayana',
    'Barkhurst',
    sysdate - 8,
    'F',
    'Customer Satisfaction Improvement',
    'ayana.barkhurst@aaao.com',
    'Etiam Cursus Porttitor',
    '519 Luxora Street',
    null,
    'Reduce Development Cost',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus.',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    sysdate - 67
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623581909133377930608383095522,
    'Luana',
    'Berends',
    sysdate - 61,
    'M',
    'Database Implementation',
    'luana.berends@aaap.com',
    'Ut Id Nulla',
    '868 Homeland Place',
    null,
    'Overseas Relocation',
    'Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae.',
    'Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in.',
    sysdate - 65
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623583118059197545237557801698,
    'Lecia',
    'Alvino',
    sysdate - 59,
    'F',
    'User Group Advertising',
    'lecia.alvino@aaaq.com',
    'Posuere Cubilia Curae;',
    '840 Arkdale Place',
    null,
    'Selection Of Construction Site',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id.',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio.',
    sysdate - 45
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623584326985017159866732507874,
    'Joleen',
    'Himmelmann',
    sysdate - 54,
    'F',
    'Energy Efficiency',
    'joleen.himmelmann@aaar.com',
    'Proin Sit Amet',
    '361 Friedensburg Street',
    null,
    'Inventory Optimization',
    'Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac.',
    'Posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus.',
    sysdate - 2
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623585535910836774495907214050,
    'Monty',
    'Kinnamon',
    sysdate - 68,
    'M',
    'Fixed Asset Tracking',
    'monty.kinnamon@aaas.com',
    'Eu Lorem Commodo',
    '154 Woodruff Blvd',
    null,
    'Buying Activity Analysis',
    'Pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et.',
    'Posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum.',
    sysdate - 1
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623586744836656389125081920226,
    'Dania',
    'Grizzard',
    sysdate - 6,
    'M',
    'Fault Rate Reduction',
    'dania.grizzard@aaat.com',
    'Posuere Cubilia Curae;',
    '375 Greendale Street',
    null,
    'Shipping Process Review',
    'Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac.',
    'Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623587953762476003754256626402,
    'Inez',
    'Yamnitz',
    sysdate - 21,
    'M',
    'Course Development',
    'inez.yamnitz@aaau.com',
    'Et Ultrices Posuere',
    '560 Woodruff Street',
    null,
    'Documentation Review',
    'Mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    'Id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet.',
    sysdate - 51
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623589162688295618383431332578,
    'Fidel',
    'Creps',
    sysdate - 46,
    'F',
    'Cloud Sales Planning',
    'fidel.creps@aaav.com',
    'Massa Eu Lorem',
    '446 Gonez Street',
    null,
    'Fixed Asset Tracking',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    'Elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.',
    sysdate - 66
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623590371614115233012606038754,
    'Luis',
    'Pothoven',
    sysdate - 24,
    'M',
    'Inventory Optimization',
    'luis.pothoven@aaaw.com',
    'Malesuada Fames Ac',
    '235 Castana Street',
    null,
    'Selection Of Construction Site',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    sysdate - 12
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623591580539934847641780744930,
    'Bernardo',
    'Phoenix',
    sysdate - 22,
    'F',
    'Database Implementation',
    'bernardo.phoenix@aaax.com',
    'Faucibus Ut Id',
    '478 Dinsmore Street',
    null,
    'Competitive Analysis',
    'Ac.',
    'Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    sysdate - 74
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623592789465754462270955451106,
    'Carolyne',
    'Centore',
    sysdate - 42,
    'F',
    'Fixed Asset Tracking',
    'carolyne.centore@aaay.com',
    'Sit Amet Massa',
    '187 Sugarloaf Blvd',
    null,
    'Cloud Sales Planning',
    'Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    'Id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis.',
    sysdate - 89
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623593998391574076900130157282,
    'Cornell',
    'Pratico',
    sysdate - 19,
    'M',
    'Transfer To Manufacturing',
    'cornell.pratico@aaaz.com',
    'Faucibus Orci Luctus',
    '36 Leiza Blvd',
    null,
    'Reduce Development Cost',
    'Mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    'Ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus.',
    sysdate - 98
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623595207317393691529304863458,
    'Sam',
    'Rueb',
    sysdate - 19,
    'M',
    'Integration Tool Evaluation',
    'sam.rueb@aaa0.com',
    'Nulla Placerat Iaculis',
    '699 Poza Rica Ave',
    null,
    'Cloud Sales Planning',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae.',
    'Elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus.',
    sysdate - 12
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623596416243213306158479569634,
    'Shakita',
    'Sablock',
    sysdate - 74,
    'F',
    'Fixed Asset Tracking',
    'shakita.sablock@aaa1.com',
    'Rhoncus Nonmolestie Sit',
    '841 El Rio Place',
    null,
    'Documentation Review',
    'Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    'Sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    sysdate - 24
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623597625169032920787654275810,
    'Sandy',
    'Heffren',
    sysdate - 53,
    'F',
    'Supplier Change',
    'sandy.heffren@aaa2.com',
    'In Massa Pharetra',
    '259 Aniches Street',
    null,
    'User Group Advertising',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate.',
    'Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    sysdate - 58
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623598834094852535416828981986,
    'Tressa',
    'Coppens',
    sysdate - 63,
    'M',
    'Availability Optimization',
    'tressa.coppens@aaa3.com',
    'Placerat Pellentesque Proin',
    '573 North Lilbourn Street',
    null,
    'Service Level Evaluation',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    sysdate - 38
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623600043020672150046003688162,
    'Shira',
    'Arocho',
    sysdate - 91,
    'M',
    'Course Development',
    'shira.arocho@aaa4.com',
    'Vitae Ligula Commodo',
    '602 Medical Lake Ave',
    null,
    'Buying Activity Analysis',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    'Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.',
    sysdate - 23
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623601251946491764675178394338,
    'Carter',
    'Sacarello',
    sysdate - 67,
    'F',
    'New Graduate Training',
    'carter.sacarello@aaa5.com',
    'Risusphasellus Vitae Ligula',
    '706 Mount Hood Village Ave',
    null,
    'Corporate Citizenship Efforts',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien.',
    'Sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante.',
    sysdate - 40
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623602460872311379304353100514,
    'Linda',
    'Merida',
    sysdate - 68,
    'F',
    'Course Development',
    'linda.merida@aaa6.com',
    'Ipsumprimis In Faucibus',
    '811 Marklesburg Place',
    null,
    'Customer Satisfaction Improvement',
    'Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    'Porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum.',
    sysdate - 81
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623603669798130993933527806690,
    'Winfred',
    'Sohn',
    sysdate - 6,
    'M',
    'Manual Review',
    'winfred.sohn@aaa7.com',
    'Pellentesque Proin Viverra',
    '883 Holiday Lakes Place',
    null,
    'Buying Activity Analysis',
    'Vulputate porttitor ligula. Nam.',
    'Posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi.',
    sysdate - 29
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623604878723950608562702512866,
    'Nestor',
    'Caparros',
    sysdate - 14,
    'F',
    'Reduce Development Cost',
    'nestor.caparros@aaa8.com',
    'Porttitor Tincidunt Vestibulum',
    '574 Iva Street',
    null,
    'Manual Review',
    'Elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis.',
    'Amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.',
    sysdate - 68
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623606087649770223191877219042,
    'Brooks',
    'Craker',
    sysdate - 66,
    'F',
    'Overseas Relocation',
    'brooks.craker@aaa9.com',
    'Proin Vulputate Placerat',
    '99 Kelliher Blvd',
    null,
    'Course Development',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada.',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus.',
    sysdate - 38
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623607296575589837821051925218,
    'Ruthann',
    'Nixa',
    sysdate - 44,
    'F',
    'Fixed Asset Tracking',
    'ruthann.nixa@aaba.com',
    'In Faucibus Ut',
    '172 Merviel Blvd',
    null,
    'Manual Review',
    'Faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    'Ullamcorper.Interdum et.',
    sysdate - 50
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623608505501409452450226631394,
    'Kenny',
    'Campobasso',
    sysdate - 94,
    'M',
    'Preparation Of White Paper',
    'kenny.campobasso@aabb.com',
    'Volutpat Risusphasellus Vitae',
    '161 Edie Blvd',
    null,
    'Documentation Review',
    'Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum.',
    'Amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam.',
    sysdate - 33
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623609714427229067079401337570,
    'Hildred',
    'Donnel',
    sysdate - 89,
    'M',
    'Transfer To Manufacturing',
    'hildred.donnel@aabc.com',
    'Commodo Dictum Lorem',
    '508 Varmonzey Street',
    null,
    'Transfer To Manufacturing',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae.',
    'Commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.',
    sysdate - 75
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623610923353048681708576043746,
    'Luther',
    'Ardinger',
    sysdate - 61,
    'F',
    'Inventory Optimization',
    'luther.ardinger@aabd.com',
    'Ipsumprimis In Faucibus',
    '815 Teslin Place',
    null,
    'Evaluation Of Compiler Performance',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra.',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    sysdate - 71
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623612132278868296337750749922,
    'Rhoda',
    'Hasfjord',
    sysdate - 49,
    'M',
    'Inventory Optimization',
    'rhoda.hasfjord@aabe.com',
    'Amet Massa Eu',
    '946 Villa Verde Place',
    null,
    'User Group Advertising',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo.',
    'Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam.',
    sysdate - 86
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623613341204687910966925456098,
    'Cori',
    'Ablin',
    sysdate - 6,
    'M',
    'Machine Translation Evaluation',
    'cori.ablin@aabf.com',
    'Porttitor Ligula Nam',
    '275 Bruni Street',
    null,
    'Six Sigma Introduction',
    'Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    'Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    sysdate - 26
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623614550130507525596100162274,
    'Reinaldo',
    'Feltner',
    sysdate - 24,
    'F',
    'Transfer To Manufacturing',
    'reinaldo.feltner@aabg.com',
    'Ligula Commodo Dictum',
    '698 Teslin Ave',
    null,
    'Competitive Analysis',
    'Sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante.',
    'Sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623615759056327140225274868450,
    'Coralee',
    'Acerno',
    sysdate - 51,
    'F',
    'Fault Rate Reduction',
    'coralee.acerno@aabh.com',
    'Ac Ante Ipsum',
    '294 Colome Street',
    null,
    'New Hire Training',
    'Sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem.',
    'Volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus.',
    sysdate - 26
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623616967982146754854449574626,
    'Katherine',
    'Tagg',
    sysdate - 4,
    'M',
    'New Feature Verification',
    'katherine.tagg@aabi.com',
    'Vitae Ligula Commodo',
    '618 Aberteifi Ave',
    null,
    'Data Loss Prevention',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    'Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    sysdate - 64
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623618176907966369483624280802,
    'Lenore',
    'Sullivan',
    sysdate - 97,
    'M',
    'New Hire Training',
    'lenore.sullivan@aabj.com',
    'Porttitor Ligula Nam',
    '727 La Porte Ave',
    null,
    'API Design',
    'Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu.',
    'Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh.',
    sysdate - 94
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623619385833785984112798986978,
    'erda',
    'Sheer',
    sysdate - 51,
    'F',
    'Course Development',
    'erda.sheer@aabk.com',
    'Massa Eu Lorem',
    '428 Wrigley Street',
    null,
    'Evaluation Of Compiler Performance',
    'Fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    'Sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit.',
    sysdate - 3
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623620594759605598741973693154,
    'Pete',
    'Chevis',
    sysdate - 78,
    'M',
    'Preparation Of White Paper',
    'pete.chevis@aabl.com',
    'Elit Vestibulum Eget',
    '408 Sherrodsville Street',
    null,
    'Customer Satisfaction Improvement',
    'Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.',
    'Pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    sysdate - 71
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623621803685425213371148399330,
    'Joseph',
    'Wilke',
    sysdate - 48,
    'F',
    'Demo Development',
    'joseph.wilke@aabm.com',
    'Lorem Commodo Ullamcorperinter',
    '35 Pontils Blvd',
    null,
    'Claim Reduction Plan',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque.',
    sysdate - 24
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623623012611244828000323105506,
    'Nella',
    'Rupnick',
    sysdate - 10,
    'F',
    'Reduce Development Cost',
    'nella.rupnick@aabn.com',
    'Commodo Dictum Lorem',
    '130 Fort Bridger Blvd',
    null,
    'Calculation Of Energy Consumption',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate.',
    'Sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae;.',
    sysdate - 28
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623624221537064442629497811682,
    'Azalee',
    'Goodwater',
    sysdate - 78,
    'M',
    'Database Implementation',
    'azalee.goodwater@aabo.com',
    'Faucibus Orci Luctus',
    '11 Timber Pines Blvd',
    null,
    'Availability Optimization',
    'Lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex.',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien.',
    sysdate - 86
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623625430462884057258672517858,
    'Stefany',
    'Waninger',
    sysdate - 25,
    'M',
    'Inventory Optimization',
    'stefany.waninger@aabp.com',
    'Ligula Nam Semper',
    '397 Santa Margarita Street',
    null,
    'Preparation Of White Paper',
    'Et.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    sysdate - 5
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623626639388703671887847224034,
    'Arron',
    'Waclawski',
    sysdate - 59,
    'M',
    'Night Call Reduction',
    'arron.waclawski@aabq.com',
    'Faucibus Ut Id',
    '960 Vinings Place',
    null,
    'Cloud Sales Planning',
    'Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    'Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames.',
    sysdate - 21
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623627848314523286517021930210,
    'Boyd',
    'Rearden',
    sysdate - 3,
    'F',
    'Fixed Asset Tracking',
    'boyd.rearden@aabr.com',
    'Lacinialectus Quis Consectetur',
    '132 Fort Bridger Blvd',
    null,
    'Calculation Of Energy Consumption',
    'In faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    'Mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    sysdate - 79
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623629057240342901146196636386,
    'Erasmo',
    'Riviera',
    sysdate - 92,
    'M',
    'New Graduate Training',
    'erasmo.riviera@aabs.com',
    'Ipsumprimis In Faucibus',
    '677 Arrow Point Ave',
    null,
    'Corporate Citizenship Efforts',
    'Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    'Amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    sysdate - 92
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623630266166162515775371342562,
    'Ambrose',
    'Hiday',
    sysdate - 88,
    'M',
    'Integration Tool Evaluation',
    'ambrose.hiday@aabt.com',
    'Eget Rhoncus Nonmolestie',
    '399 Medical Lake Street',
    null,
    'Availability Optimization',
    'Pellentesque. Proin viverra lacinialectus, quis.',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id.',
    sysdate - 39
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623631475091982130404546048738,
    'Horacio',
    'Rainbolt',
    sysdate - 82,
    'F',
    'Database Implementation',
    'horacio.rainbolt@aabu.com',
    'Mi Venenatis Nec',
    '235 Starrucca Street',
    null,
    'Overseas Relocation',
    'Et malesuada fames ac ante ipsum primis in.',
    'Commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    sysdate - 38
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623632684017801745033720754914,
    'Taylor',
    'Cauchon',
    sysdate - 31,
    'F',
    'Inventory Optimization',
    'taylor.cauchon@aabv.com',
    'Faucibus Ut Id',
    '307 Cantaloube Street',
    null,
    'Reduce Development Cost',
    'Arcu in massa pharetra, id mattis.',
    'Suscipit elementum sodales. Proin sit.',
    sysdate - 30
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623633892943621359662895461090,
    'Marc',
    'Domanski',
    sysdate - 79,
    'F',
    'Night Call Reduction',
    'marc.domanski@aabw.com',
    'Vulputate Porttitor Ligula',
    '286 Ixtapaluca Street',
    null,
    'Six Sigma Introduction',
    'Amet lectus. Nulla placerat iaculis.',
    'Pharetra, id mattis risus rhoncus.Cras vulputate porttitor.',
    sysdate - 69
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623635101869440974292070167266,
    'Kaylene',
    'Lusco',
    sysdate - 37,
    'M',
    'Course Development',
    'kaylene.lusco@aabx.com',
    'Massa Eu Lorem',
    '933 Berlencourt Place',
    null,
    'Manual Review',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    'Consectetur.',
    sysdate - 83
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623636310795260588921244873442,
    'Norris',
    'Michener',
    sysdate - 92,
    'M',
    'Buying Activity Analysis',
    'norris.michener@aaby.com',
    'Lacinialectus Quis Consectetur',
    '167 Koeking Blvd',
    null,
    'User Group Advertising',
    'Aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.',
    sysdate - 14
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623637519721080203550419579618,
    'Rob',
    'Kempt',
    sysdate - 64,
    'F',
    'Fixed Asset Tracking',
    'rob.kempt@aabz.com',
    'In Faucibus Orci',
    '76 Hartselle Blvd',
    null,
    'Machine Translation Evaluation',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu.',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    sysdate - 53
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623638728646899818179594285794,
    'Elaine',
    'Moncure',
    sysdate - 48,
    'F',
    'Supplier Change',
    'elaine.moncure@aab0.com',
    'Placerat Pellentesque Proin',
    '820 Carterville Place',
    null,
    'Claim Reduction Plan',
    'Sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.',
    sysdate - 74
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623639937572719432808768991970,
    'Joshua',
    'Disano',
    sysdate - 29,
    'M',
    'Selection Of Construction Site',
    'joshua.disano@aab1.com',
    'Sit Amet Imperdiet',
    '575 Aniches Street',
    null,
    'Course Development',
    'Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    'Faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum.',
    sysdate - 71
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623641146498539047437943698146,
    'Lai',
    'Kurtich',
    sysdate - 52,
    'M',
    'Documentation Review',
    'lai.kurtich@aab2.com',
    'Et Malesuada Fames',
    '242 Meslay Street',
    null,
    'Database Implementation',
    'Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec.',
    'Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate.',
    sysdate - 32
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623642355424358662067118404322,
    'Lucas',
    'Summerill',
    sysdate - 98,
    'M',
    'User Group Advertising',
    'lucas.summerill@aab3.com',
    'Pharetra Id Mattis',
    '991 Windsor Place Place',
    null,
    'New Hire Training',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus.',
    'Diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et.',
    sysdate - 47
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623643564350178276696293110498,
    'Vincent',
    'Hibberd',
    sysdate - 14,
    'M',
    'Competitive Analysis',
    'vincent.hibberd@aab4.com',
    'Placerat Iaculis Aliquam',
    '262 Oxwich Street',
    null,
    'Corporate Citizenship Efforts',
    'Fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    'Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623644773275997891325467816674,
    'Sharla',
    'Topper',
    sysdate - 83,
    'F',
    'Fault Rate Reduction',
    'sharla.topper@aab5.com',
    'Sapien Suscipit Tristique',
    '681 Arkdale Ave',
    null,
    'API Design',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et.',
    'Eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo.',
    sysdate - 83
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623645982201817505954642522850,
    'Andrew',
    'Schieferstein',
    sysdate - 91,
    'M',
    'Reduce Development Cost',
    'andrew.schieferstein@aab6.com',
    'Malesuada Fames Ac',
    '63 La Porte Blvd',
    null,
    'Manual Review',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit.',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada.',
    sysdate - 95
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623647191127637120583817229026,
    'Rey',
    'Wada',
    sysdate - 94,
    'F',
    'Preparation Of White Paper',
    'rey.wada@aab7.com',
    'Donec Convallis Sollicitudin',
    '571 Steger Street',
    null,
    'Competitive Analysis',
    'Placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet.',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien.',
    sysdate - 81
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623648400053456735212991935202,
    'Jonell',
    'Pecatoste',
    sysdate - 16,
    'F',
    'Customer Satisfaction Improvement',
    'jonell.pecatoste@aab8.com',
    'Ligula Commodo Dictum',
    '966 Neoskweskau Place',
    null,
    'New Feature Verification',
    'Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu.',
    'Nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec.',
    sysdate - 58
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623649608979276349842166641378,
    'Kurtis',
    'Parham',
    sysdate - 12,
    'M',
    'Selection Of Construction Site',
    'kurtis.parham@aab9.com',
    'Ex Etiam Cursus',
    '960 Kenmar Place',
    null,
    'Transfer To Manufacturing',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    'Placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum.',
    sysdate - 20
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623650817905095964471341347554,
    'Quinn',
    'Yerdon',
    sysdate - 43,
    'M',
    'Course Development',
    'quinn.yerdon@aaca.com',
    'Lorem Sit Amet',
    '907 Fustanes Place',
    null,
    'Buying Activity Analysis',
    'Diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo.',
    'Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu.',
    sysdate - 84
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623652026830915579100516053730,
    'Meg',
    'Vetterkind',
    sysdate - 48,
    'M',
    'Machine Translation Evaluation',
    'meg.vetterkind@aacb.com',
    'Tincidunt Vestibulum Ante',
    '757 Shongopovi Ave',
    null,
    'Documentation Review',
    'Sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit.',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    sysdate - 13
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623653235756735193729690759906,
    'Alex',
    'Binette',
    sysdate - 69,
    'M',
    'Corporate Citizenship Efforts',
    'alex.binette@aacc.com',
    'Rhoncus Nonmolestie Sit',
    '294 Camp Pendleton Street',
    null,
    'Demo Development',
    'Sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa.',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    sysdate - 56
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623654444682554808358865466082,
    'Ali',
    'Brengle',
    sysdate - 56,
    'M',
    'Git Migration',
    'ali.brengle@aacd.com',
    'Porttitor Tincidunt Vestibulum',
    '497 Varigny Street',
    null,
    'Machine Translation Evaluation',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 63
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623655653608374422988040172258,
    'Jaimee',
    'Gammons',
    sysdate - 52,
    'F',
    'Six Sigma Introduction',
    'jaimee.gammons@aace.com',
    'Rhoncuscras Vulputate Porttito',
    '276 Chesaning Street',
    null,
    'User Group Advertising',
    'Vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante.',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper.',
    sysdate - 58
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623656862534194037617214878434,
    'Alva',
    'Halajian',
    sysdate - 29,
    'M',
    'Customer Satisfaction Improvement',
    'alva.halajian@aacf.com',
    'Proin Sit Amet',
    '786 Sherrodsville Ave',
    null,
    'Transfer To Manufacturing',
    'Sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.',
    'In faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.',
    sysdate - 42
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623658071460013652246389584610,
    'Latoria',
    'Siprasoeuth',
    sysdate - 54,
    'M',
    'Overseas Relocation',
    'latoria.siprasoeuth@aacg.com',
    'In Massa Pharetra',
    '746 Mabel Ave',
    null,
    'Inventory Optimization',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra.',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    sysdate - 72
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623659280385833266875564290786,
    'Merlyn',
    'Summerford',
    sysdate - 15,
    'F',
    'Evaluation Of Compiler Performance',
    'merlyn.summerford@aach.com',
    'Commodo Ullamcorperinterdum Et',
    '941 El Ojo Place',
    null,
    'Participation Rate Improvement',
    'Elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 66
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623660489311652881504738996962,
    'Nelson',
    'Koschnitzki',
    sysdate - 21,
    'M',
    'Fault Rate Reduction',
    'nelson.koschnitzki@aaci.com',
    'Porttitor Tincidunt Vestibulum',
    '14 North Gates Blvd',
    null,
    'Availability Optimization',
    'Ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae.',
    'Nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet.',
    sysdate - 84
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623661698237472496133913703138,
    'Adeline',
    'Iannotti',
    sysdate - 22,
    'F',
    'Selection Of Construction Site',
    'adeline.iannotti@aacj.com',
    'Consectetur Mi Venenatis',
    '555 Huntingdon Street',
    null,
    'Claim Reduction Plan',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    'Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac.',
    sysdate - 47
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623662907163292110763088409314,
    'Saul',
    'Mokry',
    sysdate - 74,
    'M',
    'Preparation Of White Paper',
    'saul.mokry@aack.com',
    'Commodo Ullamcorperinterdum Et',
    '816 Fort Bridger Place',
    null,
    'Six Sigma Introduction',
    'Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    'Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    sysdate - 56
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623664116089111725392263115490,
    'Laveta',
    'Wida',
    sysdate - 55,
    'M',
    'Fixed Asset Tracking',
    'laveta.wida@aacl.com',
    'Porttitor Ligula Nam',
    '453 Burkesville Street',
    null,
    'Fault Rate Reduction',
    'Iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.',
    'Sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis.',
    sysdate - 80
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623665325014931340021437821666,
    'Dexter',
    'Petiet',
    sysdate - 76,
    'M',
    'Corporate Citizenship Efforts',
    'dexter.petiet@aacm.com',
    'Porttitor Tincidunt Vestibulum',
    '642 Tulancingo Ave',
    null,
    'Competitive Analysis',
    'Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut.',
    'Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo.',
    sysdate - 70
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623666533940750954650612527842,
    'Chet',
    'Morano',
    sysdate - 6,
    'F',
    'Demo Development',
    'chet.morano@aacn.com',
    'Lacinia Arcu In',
    '966 North Logan Place',
    null,
    'Documentation Review',
    'Orci.',
    'Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    sysdate - 28
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623667742866570569279787234018,
    'Jannie',
    'Thibideau',
    sysdate - 77,
    'F',
    'New Feature Verification',
    'jannie.thibideau@aaco.com',
    'In Massa Pharetra',
    '166 Point Marion Blvd',
    null,
    'API Design',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Tristique ac.',
    sysdate - 95
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623668951792390183908961940194,
    'Janey',
    'Fornell',
    sysdate - 36,
    'M',
    'Fault Rate Reduction',
    'janey.fornell@aacp.com',
    'Elementum Nulla Facilisi',
    '419 Stonefort Street',
    null,
    'Reduce Development Cost',
    'Rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum.',
    'Rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in.',
    sysdate - 72
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623670160718209798538136646370,
    'Gerda',
    'Bartha',
    sysdate - 54,
    'M',
    'Customer Satisfaction Improvement',
    'gerda.bartha@aacq.com',
    'Commodo Ullamcorperinterdum Et',
    '55 Arrow Point Blvd',
    null,
    'Database Implementation',
    'Rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur.',
    sysdate - 79
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623671369644029413167311352546,
    'Kristina',
    'Livshits',
    sysdate - 50,
    'F',
    'Six Sigma Introduction',
    'kristina.livshits@aacr.com',
    'Nulla Placerat Iaculis',
    '402 Ajarte Street',
    null,
    'User Group Advertising',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo.',
    'Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida.',
    sysdate - 31
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623672578569849027796486058722,
    'Matilda',
    'Toedebusch',
    sysdate - 82,
    'M',
    'Fault Rate Reduction',
    'matilda.toedebusch@aacs.com',
    'Vestibulum Lacinia Arcu',
    '672 Wadhams Ave',
    null,
    'Fixed Asset Tracking',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    'Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.',
    sysdate - 18
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623673787495668642425660764898,
    'Ami',
    'Dardar',
    sysdate - 57,
    'M',
    'Manual Review',
    'ami.dardar@aact.com',
    'Sodales Proin Sit',
    '643 Doraville Ave',
    null,
    'Preparation Of White Paper',
    'Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis.',
    'Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate.',
    sysdate - 60
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623674996421488257054835471074,
    'Desmond',
    'Lifschitz',
    sysdate - 8,
    'M',
    'Fault Rate Reduction',
    'desmond.lifschitz@aacu.com',
    'Vulputate Porttitor Ligula',
    '958 Orbazay Place',
    null,
    'Customer Satisfaction Improvement',
    'Porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.',
    'Proin sit amet massa eu lorem commodo.',
    sysdate - 29
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623676205347307871684010177250,
    'Marco',
    'Slivka',
    sysdate - 91,
    'F',
    'Claim Reduction Plan',
    'marco.slivka@aacv.com',
    'Amet Massa Eu',
    '609 North Troy Ave',
    null,
    'Service Level Evaluation',
    'Nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus.',
    'Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    sysdate - 57
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623677414273127486313184883426,
    'Danica',
    'Riogas',
    sysdate - 74,
    'F',
    'Git Migration',
    'danica.riogas@aacw.com',
    'Ipsumprimis In Faucibus',
    '282 Cantwell Street',
    null,
    'Claim Reduction Plan',
    'Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo.',
    'Ac.',
    sysdate - 84
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623678623198947100942359589602,
    'Cathey',
    'Salen',
    sysdate - 33,
    'F',
    'Corporate Citizenship Efforts',
    'cathey.salen@aacx.com',
    'Tristique Ac Volutpat',
    '573 Valdelacanal Street',
    null,
    'Overseas Relocation',
    'Pharetra, id mattis risus rhoncus.Cras vulputate porttitor.',
    'Faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623679832124766715571534295778,
    'Tabetha',
    'Florentino',
    sysdate - 74,
    'M',
    'User Group Advertising',
    'tabetha.florentino@aacy.com',
    'Arcu In Massa',
    '445 Hallering Street',
    null,
    'Energy Efficiency',
    'Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    'Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur.',
    sysdate - 45
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623681041050586330200709001954,
    'Daisy',
    'Liddicoat',
    sysdate - 58,
    'F',
    'Shipping Process Review',
    'daisy.liddicoat@aacz.com',
    'Vestibulum Eget Rhoncus',
    '372 Prompton Street',
    null,
    'Documentation Review',
    'Amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    'Cubilia Curae; Proin vulputate placerat.',
    sysdate - 89
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623682249976405944829883708130,
    'Jacklyn',
    'Niskala',
    sysdate - 43,
    'F',
    'Transfer To Manufacturing',
    'jacklyn.niskala@aac0.com',
    'Tincidunt Vestibulum Ante',
    '873 Bogart Place',
    null,
    'Fixed Asset Tracking',
    'Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.',
    'Risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin.',
    sysdate - 12
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623683458902225559459058414306,
    'Herb',
    'Tammen',
    sysdate - 48,
    'M',
    'Git Migration',
    'herb.tammen@aac1.com',
    'Sit Amet Imperdiet',
    '25 Longuenesse Blvd',
    null,
    'Competitive Analysis',
    'Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper.',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    sysdate - 81
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623684667828045174088233120482,
    'Verlie',
    'Ashland',
    sysdate - 54,
    'M',
    'Corporate Citizenship Efforts',
    'verlie.ashland@aac2.com',
    'Lacinia Arcu In',
    '827 Campodonico Place',
    null,
    'Course Development',
    'Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    sysdate - 88
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623685876753864788717407826658,
    'Jewel',
    'Clippard',
    sysdate - 12,
    'F',
    'Data Loss Prevention',
    'jewel.clippard@aac3.com',
    'Amet Lectus Nulla',
    '844 Yardville Place',
    null,
    'Integration Tool Evaluation',
    'Faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    'Sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    sysdate - 33
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623687085679684403346582532834,
    'Rudolph',
    'Bekerman',
    sysdate - 9,
    'F',
    'Corporate Citizenship Efforts',
    'rudolph.bekerman@aac4.com',
    'Ante Ipsumprimis In',
    '70 Stonefort Blvd',
    null,
    'Claim Reduction Plan',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 65
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623688294605504017975757239010,
    'Teisha',
    'Grimstead',
    sysdate - 66,
    'F',
    'Fault Rate Reduction',
    'teisha.grimstead@aac5.com',
    'Semper Diam Suscipit',
    '886 Conkling Park Place',
    null,
    'Shipping Process Review',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae.',
    'Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec.',
    sysdate - 61
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623689503531323632604931945186,
    'Scotty',
    'Goffredo',
    sysdate - 23,
    'M',
    'Fixed Asset Tracking',
    'scotty.goffredo@aac6.com',
    'Ipsumprimis In Faucibus',
    '958 Camp Pendleton Place',
    null,
    'Fixed Asset Tracking',
    'Cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.',
    'Id nulla ac sapien suscipit.',
    sysdate - 93
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623690712457143247234106651362,
    'Emmett',
    'Golz',
    sysdate - 91,
    'F',
    'Inventory Optimization',
    'emmett.golz@aac7.com',
    'Risusphasellus Vitae Ligula',
    '253 Bangor Street',
    null,
    'Competitive Analysis',
    'Elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.',
    'Sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin.',
    sysdate - 32
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623691921382962861863281357538,
    'Jewel',
    'Clippard',
    sysdate - 73,
    'M',
    'New Graduate Training',
    'jewel.clippard@aac8.com',
    'Massa Pharetra Id',
    '291 Keddie Street',
    null,
    'Night Call Reduction',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.',
    sysdate - 35
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623693130308782476492456063714,
    'Rudolph',
    'Bekerman',
    sysdate - 32,
    'M',
    'Manual Review',
    'rudolph.bekerman@aac9.com',
    'Malesuada Fames Ac',
    '876 Pembina Place',
    null,
    'Evaluation Of Compiler Performance',
    'Id mattis.',
    'Sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    sysdate - 83
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623694339234602091121630769890,
    'Teisha',
    'Grimstead',
    sysdate - 33,
    'F',
    'Release Cycle Change',
    'teisha.grimstead@aada.com',
    'Ex Etiam Cursus',
    '164 North Troy Blvd',
    null,
    'Preparation Of White Paper',
    'In massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id.',
    'In faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus.',
    sysdate - 85
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623695548160421705750805476066,
    'Scotty',
    'Goffredo',
    sysdate - 54,
    'F',
    'Corporate Citizenship Efforts',
    'scotty.goffredo@aadb.com',
    'Porttitor Ligula Nam',
    '563 Lynnfield Street',
    null,
    'Manual Review',
    'Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    'Et malesuada fames ac ante ipsum primis in.',
    sysdate - 55
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623696757086241320379980182242,
    'Emmett',
    'Golz',
    sysdate - 77,
    'M',
    'Fault Rate Reduction',
    'emmett.golz@aadc.com',
    'Sapien Suscipit Tristique',
    '764 Castana Ave',
    null,
    'Participation Rate Improvement',
    'Sodales. Proin sit amet massa eu.',
    'Sodales. Proin sit amet massa eu.',
    sysdate - 76
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623697966012060935009154888418,
    'Norman',
    'Lobregat',
    sysdate - 65,
    'F',
    'Course Development',
    'norman.lobregat@aadd.com',
    'In Faucibus Ut',
    '268 Sarp Street',
    null,
    'Demo Development',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo.',
    'Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut.',
    sysdate - 34
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623699174937880549638329594594,
    'Tim',
    'Blasingim',
    sysdate - 61,
    'F',
    'Integration Tool Evaluation',
    'tim.blasingim@aade.com',
    'Porttitor Tincidunt Vestibulum',
    '806 Talamanca Place',
    null,
    'Night Call Reduction',
    'Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames.',
    'Suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo.',
    sysdate - 62
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623700383863700164267504300770,
    'Brandy',
    'Genco',
    sysdate - 37,
    'F',
    'Claim Reduction Plan',
    'brandy.genco@aadf.com',
    'Nulla Ac Sapien',
    '852 Lock Haven Place',
    null,
    'New Hire Training',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    'Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem.',
    sysdate - 62
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623701592789519778896679006946,
    'Hung',
    'Pedroncelli',
    sysdate - 44,
    'F',
    'New Feature Verification',
    'hung.pedroncelli@aadg.com',
    'Amet Lectus Nulla',
    '978 Villoslada Place',
    null,
    'Selection Of Construction Site',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin.',
    'Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    sysdate - 42
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623702801715339393525853713122,
    'Verda',
    'Puchalla',
    sysdate - 16,
    'M',
    'Course Development',
    'verda.puchalla@aadh.com',
    'Primis In Faucibus',
    '95 Nomexy Blvd',
    null,
    'Selection Of Construction Site',
    'Sapien suscipit tristique ac.',
    'Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere.',
    sysdate - 89
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623704010641159008155028419298,
    'Norman',
    'Lobregat',
    sysdate - 44,
    'M',
    'Release Cycle Change',
    'norman.lobregat@aadi.com',
    'Ac Volutpat Risusphasellus',
    '91 Valdelacanal Blvd',
    null,
    'New Feature Verification',
    'Vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula.',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus.',
    sysdate - 85
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623705219566978622784203125474,
    'Tim',
    'Blasingim',
    sysdate - 13,
    'M',
    'Competitive Analysis',
    'tim.blasingim@aadj.com',
    'Eget Rhoncus Nonmolestie',
    '273 Yardville Street',
    null,
    'Fault Rate Reduction',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    sysdate - 33
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623706428492798237413377831650,
    'Brandy',
    'Genco',
    sysdate - 11,
    'F',
    'Customer Satisfaction Improvement',
    'brandy.genco@aadk.com',
    'Arcu In Massa',
    '498 Guijo Street',
    null,
    'Six Sigma Introduction',
    'Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 2
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623707637418617852042552537826,
    'Hung',
    'Pedroncelli',
    sysdate - 69,
    'M',
    'User Group Advertising',
    'hung.pedroncelli@aadl.com',
    'Vitae Ligula Commodo',
    '398 Bruni Street',
    null,
    'Competitive Analysis',
    'Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla.',
    'Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec.',
    sysdate - 4
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623708846344437466671727244002,
    'Verda',
    'Puchalla',
    sysdate - 59,
    'M',
    'Supplier Change',
    'verda.puchalla@aadm.com',
    'Sapien Suscipit Tristique',
    '354 Soursac Street',
    null,
    'Selection Of Construction Site',
    'Sapien suscipit tristique ac.',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante.',
    sysdate - 60
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623710055270257081300901950178,
    'Eustolia',
    'Temores',
    sysdate - 76,
    'M',
    'Energy Efficiency',
    'eustolia.temores@aadn.com',
    'Sit Amet Imperdiet',
    '183 Lookout Blvd',
    null,
    'Competitive Analysis',
    'Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex.',
    'Cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat.',
    sysdate - 82
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623711264196076695930076656354,
    'Jessika',
    'Doorn',
    sysdate - 41,
    'F',
    'Energy Efficiency',
    'jessika.doorn@aado.com',
    'Lectus Nulla Placerat',
    '954 Navamorales Place',
    null,
    'New Feature Verification',
    'Risus.Phasellus vitae ligula commodo, dictum lorem.',
    'Lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    sysdate - 52
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623712473121896310559251362530,
    'Marvis',
    'Chou',
    sysdate - 92,
    'F',
    'Fixed Asset Tracking',
    'marvis.chou@aadp.com',
    'Elit Vestibulum Eget',
    '997 Lynnfield Place',
    null,
    'Six Sigma Introduction',
    'Luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    'Amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    sysdate - 66
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623713682047715925188426068706,
    'Loyd',
    'Huckeba',
    sysdate - 14,
    'F',
    'Calculation Of Energy Consumption',
    'loyd.huckeba@aadq.com',
    'Vestibulum Lacinia Arcu',
    '177 Cochrane Blvd',
    null,
    'User Group Advertising',
    'Ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque.',
    'Vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.',
    sysdate - 34
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623714890973535539817600774882,
    'Leon',
    'Schoepfer',
    sysdate - 57,
    'M',
    'Shipping Process Review',
    'leon.schoepfer@aadr.com',
    'Proin Viverra Lacinialectus',
    '596 Dale Street',
    null,
    'Competitive Analysis',
    'Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae turpis. Lorem ipsum dolor.',
    'Commodo.',
    sysdate - 27
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623716099899355154446775481058,
    'Luigi',
    'Nored',
    sysdate - 24,
    'F',
    'Integration Tool Evaluation',
    'luigi.nored@aads.com',
    'Rhoncuscras Vulputate Porttito',
    '956 Cheriton Place',
    null,
    'Manual Review',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    'Ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623717308825174769075950187234,
    'Thaddeus',
    'Geneseo',
    sysdate - 3,
    'F',
    'Release Cycle Change',
    'thaddeus.geneseo@aadt.com',
    'Posuere Cubilia Curae;',
    '359 Mendota Heights Street',
    null,
    'Selection Of Construction Site',
    'Pharetra, id mattis risus rhoncus.Cras vulputate porttitor.',
    'Posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi.',
    sysdate - 40
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623718517750994383705124893410,
    'Casey',
    'Chestand',
    sysdate - 96,
    'M',
    'User Group Advertising',
    'casey.chestand@aadu.com',
    'Iaculis Aliquam Vestibulum',
    '651 Kelliher Ave',
    null,
    'Transfer To Manufacturing',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    sysdate - 61
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623719726676813998334299599586,
    'Pete',
    'Carvallo',
    sysdate - 1,
    'M',
    'Manual Review',
    'pete.carvallo@aadv.com',
    'Et Ultrices Posuere',
    '284 Homeland Street',
    null,
    'Supplier Change',
    'Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum.',
    'Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum.',
    sysdate - 66
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623720935602633612963474305762,
    'Angel',
    'Sakoda',
    sysdate - 3,
    'F',
    'Overseas Relocation',
    'angel.sakoda@aadw.com',
    'Orci Luctus Et',
    '619 El Ojo Ave',
    null,
    'Demo Development',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    'Quis consectetur mi venenatis nec. Donec convallis.',
    sysdate - 9
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623722144528453227592649011938,
    'Donnell',
    'Huttle',
    sysdate - 25,
    'M',
    'Night Call Reduction',
    'donnell.huttle@aadx.com',
    'In Faucibus Ut',
    '138 Marcus Hook Blvd',
    null,
    'Course Development',
    'Cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    'Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.',
    sysdate - 89
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623723353454272842221823718114,
    'Tyler',
    'Curlee',
    sysdate - 41,
    'F',
    'Fixed Asset Tracking',
    'tyler.curlee@aady.com',
    'Etiam Cursus Porttitor',
    '168 Muela Blvd',
    null,
    'Evaluation Of Compiler Performance',
    'Nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus.',
    sysdate - 69
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623724562380092456850998424290,
    'Markita',
    'Larner',
    sysdate - 27,
    'F',
    'Customer Satisfaction Improvement',
    'markita.larner@aadz.com',
    'Arcu In Massa',
    '387 Bloedel Street',
    null,
    'Fixed Asset Tracking',
    'Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum.',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus.',
    sysdate - 48
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623725771305912071480173130466,
    'Chante',
    'Parez',
    sysdate - 42,
    'M',
    'Overseas Relocation',
    'chante.parez@aad0.com',
    'Elementum Sodales Proin',
    '793 Maribel Ave',
    null,
    'Shipping Process Review',
    'Etiam.',
    'Eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis.',
    sysdate - 90
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623726980231731686109347836642,
    'Alvin',
    'Gagner',
    sysdate - 20,
    'M',
    'New Feature Verification',
    'alvin.gagner@aad1.com',
    'Quis Consectetur Mi',
    '208 Bayou LOurse Street',
    null,
    'Machine Translation Evaluation',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra.',
    'Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    sysdate - 95
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623728189157551300738522542818,
    'Richard',
    'Howard',
    sysdate - 22,
    'M',
    'Course Development',
    'richard.howard@aad2.com',
    'Ut Id Nulla',
    '142 Talamanca Blvd',
    null,
    'Participation Rate Improvement',
    'Nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.',
    'Elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum.',
    sysdate - 2
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623729398083370915367697248994,
    'Donna',
    'Foster',
    sysdate - 61,
    'F',
    'Preparation Of White Paper',
    'donna.foster@aad3.com',
    'Proin Sit Amet',
    '191 Huntingdon Blvd',
    null,
    'Fault Rate Reduction',
    'Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere.',
    'Suscipit.',
    sysdate - 70
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623730607009190529996871955170,
    'Ruth',
    'Robinson',
    sysdate - 90,
    'M',
    'Corporate Citizenship Efforts',
    'ruth.robinson@aad4.com',
    'Cubilia Curae; Proin',
    '538 Marrmot Point Street',
    null,
    'Git Migration',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    'Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec.',
    sysdate - 69
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623731815935010144626046661346,
    'William',
    'Diaz',
    sysdate - 73,
    'F',
    'Course Development',
    'william.diaz@aad5.com',
    'Placerat Pellentesque Proin',
    '233 Wadhams Street',
    null,
    'New Graduate Training',
    'Vestibulum ante ipsumprimis in.',
    'Orci.',
    sysdate - 7
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623733024860829759255221367522,
    'Susan',
    'Jenkins',
    sysdate - 31,
    'M',
    'Customer Satisfaction Improvement',
    'susan.jenkins@aad6.com',
    'Semper Diam Suscipit',
    '230 North Canton Street',
    null,
    'Six Sigma Introduction',
    'Suscipit elementum sodales. Proin.',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae.',
    sysdate - 56
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623734233786649373884396073698,
    'Carol',
    'Barnes',
    sysdate - 29,
    'F',
    'Customer Satisfaction Improvement',
    'carol.barnes@aad7.com',
    'Lacinia Arcu In',
    '394 North Lilbourn Street',
    null,
    'Release Cycle Change',
    'Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus.',
    'Ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    sysdate - 41
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623735442712468988513570779874,
    'Sarah',
    'Murphy',
    sysdate - 51,
    'F',
    'Claim Reduction Plan',
    'sarah.murphy@aad8.com',
    'Lacinialectus Quis Consectetur',
    '667 Sunny Side Ave',
    null,
    'Buying Activity Analysis',
    'Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida.',
    'Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel.',
    sysdate - 61
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623736651638288603142745486050,
    'Dorothy',
    'Gray',
    sysdate - 66,
    'M',
    'Integration Tool Evaluation',
    'dorothy.gray@aad9.com',
    'Primis In Faucibus',
    '463 Acigné Street',
    null,
    'Build Automation',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin.',
    'Lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus.',
    sysdate - 50
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623737860564108217771920192226,
    'Ruth',
    'Graham',
    sysdate - 95,
    'M',
    'Fixed Asset Tracking',
    'ruth.graham@aaea.com',
    'Ac Volutpat Risusphasellus',
    '332 Marrmot Point Street',
    null,
    'User Group Advertising',
    'Suscipit elementum sodales. Proin sit.',
    'Faucibus orci luctus et ultrices.',
    sysdate - 37
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623739069489927832401094898402,
    'Robert',
    'West',
    sysdate - 85,
    'F',
    'Claim Reduction Plan',
    'robert.west@aaeb.com',
    'Consectetur Mi Venenatis',
    '498 Castana Street',
    null,
    'Customer Satisfaction Improvement',
    'Cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et.',
    sysdate - 8
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623740278415747447030269604578,
    'Carol',
    'Metrick',
    sysdate - 90,
    'F',
    'Evaluation Of Compiler Performance',
    'carol.metrick@aaec.com',
    'Amet Lectus Nulla',
    '657 Point Marion Ave',
    null,
    'New Feature Verification',
    'Sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula.',
    'Lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu.',
    sysdate - 52
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623741487341567061659444310754,
    'Li',
    'Robleto',
    sysdate - 32,
    'F',
    'Git Migration',
    'li.robleto@aaed.com',
    'Id Nulla Ac',
    '183 Cheriton Blvd',
    null,
    'Course Development',
    'Tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    'Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac.',
    sysdate - 3
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623742696267386676288619016930,
    'Bert',
    'Takes',
    sysdate - 32,
    'F',
    'Competitive Analysis',
    'bert.takes@aaee.com',
    'In Massa Pharetra',
    '542 Gaudeissart Street',
    null,
    'New Graduate Training',
    'Id mattis risus rhoncus.Cras.',
    'Risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623743905193206290917793723106,
    'Son',
    'McLagan',
    sysdate - 19,
    'F',
    'Energy Efficiency',
    'son.mclagan@aaef.com',
    'Quis Consectetur Mi',
    '192 Sarp Blvd',
    null,
    'API Design',
    'Et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin.',
    'Amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    sysdate - 7
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623745114119025905546968429282,
    'Van',
    'Seaforth',
    sysdate - 47,
    'M',
    'Manual Review',
    'van.seaforth@aaeg.com',
    'Ut Id Nulla',
    '983 Inver Grove Heights Place',
    null,
    'Fixed Asset Tracking',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    'Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida.',
    sysdate - 65
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623746323044845520176143135458,
    'Florance',
    'Bateman',
    sysdate - 52,
    'F',
    'Database Implementation',
    'florance.bateman@aaeh.com',
    'In Massa Pharetra',
    '367 Fort Yukon Street',
    null,
    'Buying Activity Analysis',
    'Et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 25
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623747531970665134805317841634,
    'Bridgette',
    'Crevier',
    sysdate - 85,
    'M',
    'Fixed Asset Tracking',
    'bridgette.crevier@aaei.com',
    'Vitae Ligula Commodo',
    '392 Mendota Heights Street',
    null,
    'Demo Development',
    'Rhoncus.Cras vulputate porttitor ligula. Nam.',
    'Ipsum primis in faucibus. Ut id.',
    sysdate - 34
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623748740896484749434492547810,
    'Murray',
    'Vicario',
    sysdate - 71,
    'M',
    'Overseas Relocation',
    'murray.vicario@aaej.com',
    'Porttitor Tincidunt Vestibulum',
    '713 Tyddewi Ave',
    null,
    'Night Call Reduction',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec.',
    'Faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum.',
    sysdate - 73
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623749949822304364063667253986,
    'Loris',
    'Thibadeau',
    sysdate - 31,
    'M',
    'Corporate Citizenship Efforts',
    'loris.thibadeau@aaek.com',
    'Volutpat Risusphasellus Vitae',
    '336 Cogullos Street',
    null,
    'Six Sigma Introduction',
    'Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in.',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis.',
    sysdate - 65
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623751158748123978692841960162,
    'Lakia',
    'Fitzen',
    sysdate - 51,
    'F',
    'Supplier Change',
    'lakia.fitzen@aael.com',
    'Porttitor Tincidunt Vestibulum',
    '603 Sherrodsville Ave',
    null,
    'Claim Reduction Plan',
    'Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    sysdate - 94
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623752367673943593322016666338,
    'Angelo',
    'Carreon',
    sysdate - 68,
    'F',
    'Fault Rate Reduction',
    'angelo.carreon@aaem.com',
    'Dictum Lorem Sit',
    '782 Beaton Ave',
    null,
    'Documentation Review',
    'In faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus.',
    'Pellentesque. Proin viverra lacinialectus, quis.',
    sysdate - 36
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623753576599763207951191372514,
    'Collene',
    'Guderjahn',
    sysdate - 37,
    'F',
    'Fault Rate Reduction',
    'collene.guderjahn@aaen.com',
    'Sapien Suscipit Tristique',
    '319 Pedruel Street',
    null,
    'Energy Efficiency',
    'Elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam.',
    'Ac ante ipsum primis in faucibus. Ut id nulla ac sapien.',
    sysdate - 51
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623754785525582822580366078690,
    'Trenton',
    'Stoermer',
    sysdate - 46,
    'F',
    'Claim Reduction Plan',
    'trenton.stoermer@aaeo.com',
    'Nonmolestie Sit Amet',
    '929 Medical Lake Place',
    null,
    'Build Automation',
    'Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 23
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623755994451402437209540784866,
    'Barry',
    'Tolliver',
    sysdate - 7,
    'M',
    'Availability Optimization',
    'barry.tolliver@aaep.com',
    'Vulputate Porttitor Ligula',
    '115 Darby Blvd',
    null,
    'Demo Development',
    'Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    'Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper.',
    sysdate - 33
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623757203377222051838715491042,
    'Lloyd',
    'Shackley',
    sysdate - 38,
    'M',
    'Customer Satisfaction Improvement',
    'lloyd.shackley@aaeq.com',
    'Lectus Nulla Placerat',
    '478 Luxora Street',
    null,
    'Selection Of Construction Site',
    'Sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh sapien, hendrerit quis varius eget, malesuada vitae.',
    'Primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis.',
    sysdate - 50
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623758412303041666467890197218,
    'Luciano',
    'Lingenfelter',
    sysdate - 48,
    'M',
    'New Feature Verification',
    'luciano.lingenfelter@aaer.com',
    'Massa Eu Lorem',
    '76 Guyuria Blvd',
    null,
    'Corporate Citizenship Efforts',
    'Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec.',
    'Convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.',
    sysdate - 38
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623759621228861281097064903394,
    'Edmund',
    'Hikel',
    sysdate - 37,
    'F',
    'Claim Reduction Plan',
    'edmund.hikel@aaes.com',
    'Pellentesque Proin Viverra',
    '138 Taylor Landing Blvd',
    null,
    'Reduce Development Cost',
    'Ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec.',
    'Ut.',
    sysdate - 31
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623760830154680895726239609570,
    'Jolene',
    'Johannesen',
    sysdate - 10,
    'F',
    'Fault Rate Reduction',
    'jolene.johannesen@aaet.com',
    'Vestibulum Lacinia Arcu',
    '937 Brazos Bend Place',
    null,
    'Database Implementation',
    'Dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque.',
    'Rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat.',
    sysdate - 36
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623762039080500510355414315746,
    'Raymon',
    'Survant',
    sysdate - 6,
    'F',
    'Shipping Process Review',
    'raymon.survant@aaeu.com',
    'Posuere Cubilia Curae;',
    '615 Lemoore Station Ave',
    null,
    'Demo Development',
    'Consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget.',
    'Pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum.',
    sysdate - 22
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623763248006320124984589021922,
    'Reyes',
    'Paczkowski',
    sysdate - 34,
    'F',
    'Service Level Evaluation',
    'reyes.paczkowski@aaev.com',
    'Elementum Sodales Proin',
    '800 Cedar Park Place',
    null,
    'Fixed Asset Tracking',
    'Volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.',
    'Aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 19
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623764456932139739613763728098,
    'Freddie',
    'Kirkhart',
    sysdate - 29,
    'M',
    'Corporate Citizenship Efforts',
    'freddie.kirkhart@aaew.com',
    'Faucibus Ut Id',
    '507 Dinsmore Street',
    null,
    'Overseas Relocation',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada.',
    'Orci.',
    sysdate - 97
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623765665857959354242938434274,
    'Jamison',
    'Scrobola',
    sysdate - 70,
    'M',
    'New Graduate Training',
    'jamison.scrobola@aaex.com',
    'In Massa Pharetra',
    '283 Coron Street',
    null,
    'Buying Activity Analysis',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis.',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur.',
    sysdate - 91
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623766874783778968872113140450,
    'Rasheeda',
    'Teegarden',
    sysdate - 34,
    'F',
    'Cloud Optimization',
    'rasheeda.teegarden@aaey.com',
    'Ligula Nam Semper',
    '859 Ixtapaluca Place',
    null,
    'Preparation Of White Paper',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis.',
    'Ligula. Nam semper diam suscipit elementum sodales.',
    sysdate - 11
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623768083709598583501287846626,
    'Haywood',
    'Burd',
    sysdate - 96,
    'M',
    'Six Sigma Introduction',
    'haywood.burd@aaez.com',
    'Lectus Nulla Placerat',
    '323 Wakefield Street',
    null,
    'Six Sigma Introduction',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    'Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    sysdate - 8
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623769292635418198130462552802,
    'Eldon',
    'Lannon',
    sysdate - 12,
    'M',
    'Release Cycle Change',
    'eldon.lannon@aae0.com',
    'Lacinia Arcu In',
    '271 Filley Street',
    null,
    'New Graduate Training',
    'Tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    'Sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit.',
    sysdate - 64
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623770501561237812759637258978,
    'Marissa',
    'Pontius',
    sysdate - 55,
    'M',
    'Git Migration',
    'marissa.pontius@aae1.com',
    'Nulla Facilisi In',
    '274 Huntingdon Street',
    null,
    'Buying Activity Analysis',
    'Imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    'Fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    sysdate - 77
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623771710487057427388811965154,
    'Otha',
    'Murton',
    sysdate - 84,
    'M',
    'Overseas Relocation',
    'otha.murton@aae2.com',
    'Amet Lectus Nulla',
    '650 Bargas Ave',
    null,
    'Preparation Of White Paper',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio.',
    'Id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex.',
    sysdate - 84
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623772919412877042017986671330,
    'Dannie',
    'McCoin',
    sysdate - 79,
    'F',
    'Cloud Optimization',
    'dannie.mccoin@aae3.com',
    'Ex Etiam Cursus',
    '619 Niaux Ave',
    null,
    'Fault Rate Reduction',
    'Ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis.',
    'Non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac.',
    sysdate - 67
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623774128338696656647161377506,
    'Trey',
    'Gorham',
    sysdate - 14,
    'F',
    'Corporate Citizenship Efforts',
    'trey.gorham@aae4.com',
    'Proin Viverra Lacinialectus',
    '378 Trafford Street',
    null,
    'Preparation Of White Paper',
    'Malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem.',
    sysdate - 25
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623775337264516271276336083682,
    'Nanci',
    'Bunt',
    sysdate - 19,
    'F',
    'Cloud Optimization',
    'nanci.bunt@aae5.com',
    'Cursus Porttitor Tincidunt',
    '536 Vilachá Street',
    null,
    'Course Development',
    'Lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin.',
    'Arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis.',
    sysdate - 65
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623776546190335885905510789858,
    'Will',
    'Parliman',
    sysdate - 61,
    'M',
    'Documentation Review',
    'will.parliman@aae6.com',
    'Porttitor Tincidunt Vestibulum',
    '509 Manzanillo Street',
    null,
    'Fixed Asset Tracking',
    'Amet, imperdiet ex. Etiam cursus porttitor tincidunt.',
    'Faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque.',
    sysdate - 29
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623777755116155500534685496034,
    'Justin',
    'Dorff',
    sysdate - 49,
    'F',
    'User Group Advertising',
    'justin.dorff@aae7.com',
    'In Faucibus Ut',
    '530 Xico Street',
    null,
    'Evaluation Of Compiler Performance',
    'Sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae;.',
    'Arcu in massa pharetra, id mattis.',
    sysdate - 55
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623778964041975115163860202210,
    'Wyatt',
    'Tschache',
    sysdate - 53,
    'F',
    'Fixed Asset Tracking',
    'wyatt.tschache@aae8.com',
    'Ac Ante Ipsum',
    '372 Monfort Heights Street',
    null,
    'Integration Tool Evaluation',
    'Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    'Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec nibh.',
    sysdate - 78
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623780172967794729793034908386,
    'Chong',
    'Carpinelli',
    sysdate - 64,
    'F',
    'Database Implementation',
    'chong.carpinelli@aae9.com',
    'Elit Vestibulum Eget',
    '76 Mascaras Blvd',
    null,
    'Cloud Optimization',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra.',
    'Quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit.',
    sysdate - 44
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623781381893614344422209614562,
    'Adan',
    'Lamica',
    sysdate - 59,
    'F',
    'Preparation Of White Paper',
    'adan.lamica@aafa.com',
    'Rhoncuscras Vulputate Porttito',
    '736 Woodruff Ave',
    null,
    'Inventory Optimization',
    'Ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada.',
    'Sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices.',
    sysdate - 74
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623782590819433959051384320738,
    'Beckie',
    'Lagrenade',
    sysdate - 93,
    'M',
    'Fault Rate Reduction',
    'beckie.lagrenade@aafb.com',
    'Ex Etiam Cursus',
    '551 Valmy Street',
    null,
    'Service Level Evaluation',
    'Volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus.',
    'Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida.',
    sysdate - 36
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623783799745253573680559026914,
    'Jacques',
    'Bartash',
    sysdate - 86,
    'M',
    'Fixed Asset Tracking',
    'jacques.bartash@aafc.com',
    'Tristique Ac Volutpat',
    '643 Cedar Park Ave',
    null,
    'Availability Optimization',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    'Ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique.',
    sysdate - 46
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623785008671073188309733733090,
    'Buster',
    'Landin',
    sysdate - 14,
    'M',
    'Availability Optimization',
    'buster.landin@aafd.com',
    'Lorem Sit Amet',
    '774 De Pue Ave',
    null,
    'Customer Satisfaction Improvement',
    'Id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet.',
    'Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in.',
    sysdate - 98
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623786217596892802938908439266,
    'Kendrick',
    'McMurtrey',
    sysdate - 10,
    'F',
    'Buying Activity Analysis',
    'kendrick.mcmurtrey@aafe.com',
    'Sapien Suscipit Tristique',
    '850 Corona Place',
    null,
    'Course Development',
    'Quis consectetur mi venenatis nec. Donec convallis.',
    'Fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur.',
    sysdate - 81
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623787426522712417568083145442,
    'Jerrell',
    'Kereluk',
    sysdate - 71,
    'F',
    'User Group Advertising',
    'jerrell.kereluk@aaff.com',
    'Lorem Sit Amet',
    '8 Marklesburg Blvd',
    null,
    'Fault Rate Reduction',
    'Elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam.',
    'Diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo.',
    sysdate - 57
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623788635448532032197257851618,
    'Monroe',
    'Braylock',
    sysdate - 69,
    'F',
    'Calculation Of Energy Consumption',
    'monroe.braylock@aafg.com',
    'Amet Massa Eu',
    '93 Donadillo Blvd',
    null,
    'Night Call Reduction',
    'Massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum.',
    'Id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet.',
    sysdate - 89
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623789844374351646826432557794,
    'Anderson',
    'Keaffaber',
    sysdate - 33,
    'F',
    'Buying Activity Analysis',
    'anderson.keaffaber@aafh.com',
    'Ligula Commodo Dictum',
    '808 Monserrat Place',
    null,
    'Transfer To Manufacturing',
    'Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor.',
    'Suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis.',
    sysdate - 6
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623791053300171261455607263970,
    'Love',
    'Whistlehunt',
    sysdate - 90,
    'F',
    'Corporate Citizenship Efforts',
    'love.whistlehunt@aafi.com',
    'Sit Amet Massa',
    '525 Orrville Street',
    null,
    'New Hire Training',
    'Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis.',
    'Mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus.',
    sysdate - 86
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623792262225990876084781970146,
    'Petrina',
    'Gummo',
    sysdate - 98,
    'M',
    'Fixed Asset Tracking',
    'petrina.gummo@aafj.com',
    'Malesuada Fames Ac',
    '4 Camp Pendleton Blvd',
    null,
    'Six Sigma Introduction',
    'Posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi.',
    'Vestibulum ante ipsumprimis in faucibus orci luctus et.',
    sysdate - 17
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623793471151810490713956676322,
    'Jeremiah',
    'Nuanes',
    sysdate - 64,
    'F',
    'Inventory Optimization',
    'jeremiah.nuanes@aafk.com',
    'Pharetra Id Mattis',
    '462 West Millgrove Street',
    null,
    'Six Sigma Introduction',
    'Ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis.',
    'Semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in.',
    sysdate - 59
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623794680077630105343131382498,
    'Shon',
    'Capetl',
    sysdate - 61,
    'M',
    'Fault Rate Reduction',
    'shon.capetl@aafl.com',
    'Amet Massa Eu',
    '274 El Rio Street',
    null,
    'Participation Rate Improvement',
    'Elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis.',
    'Pellentesque. Proin viverra lacinialectus, quis.',
    sysdate - 59
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623795889003449719972306088674,
    'Chasidy',
    'Fetui',
    sysdate - 76,
    'F',
    'Fault Rate Reduction',
    'chasidy.fetui@aafm.com',
    'Malesuada Fames Ac',
    '197 Aranzueque Blvd',
    null,
    'User Group Advertising',
    'Vestibulum eget rhoncus non,molestie sit amet lectus. Nulla placerat iaculis aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    'Venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra.',
    sysdate - 20
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623797097929269334601480794850,
    'Dorsey',
    'Arking',
    sysdate - 12,
    'M',
    'Preparation Of White Paper',
    'dorsey.arking@aafn.com',
    'Lorem Commodo Ullamcorperinter',
    '517 New Rockford Street',
    null,
    'Build Automation',
    'Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In sollicitudin nisi mi, pharetra gravida ex semper ut.Donec.',
    'Sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin.',
    sysdate - 62
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623798306855088949230655501026,
    'Dagny',
    'Bumatay',
    sysdate - 28,
    'M',
    'Cloud Sales Planning',
    'dagny.bumatay@aafo.com',
    'Tincidunt Vestibulum Ante',
    '936 Valmy Place',
    null,
    'New Graduate Training',
    'Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    'Placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum.',
    sysdate - 33
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623799515780908563859830207202,
    'Elden',
    'Arancibia',
    sysdate - 99,
    'F',
    'Manual Review',
    'elden.arancibia@aafp.com',
    'Eget Rhoncus Nonmolestie',
    '488 Quintana Street',
    null,
    'Service Level Evaluation',
    'Elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus.',
    'Eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 41
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623800724706728178489004913378,
    'Broderick',
    'Dourado',
    sysdate - 23,
    'M',
    'Participation Rate Improvement',
    'broderick.dourado@aafq.com',
    'Donec Convallis Sollicitudin',
    '453 Acigné Street',
    null,
    'Build Automation',
    'Tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit.',
    'Id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet.',
    sysdate - 97
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623801933632547793118179619554,
    'Elden',
    'Bufton',
    sysdate - 68,
    'F',
    'Documentation Review',
    'elden.bufton@aafr.com',
    'Nam Semper Diam',
    '302 Hambleton Street',
    null,
    'Availability Optimization',
    'Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien.',
    'Aliquam. Vestibulum lacinia arcu in massa pharetra, id mattis risus rhoncus.Cras vulputate porttitor ligula. Nam semper diam suscipit elementum sodales. Proin sit amet massa eu lorem commodo ullamcorper.Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla.',
    sysdate - 64
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623803142558367407747354325730,
    'Chassidy',
    'Hinderaker',
    sysdate - 86,
    'M',
    'Documentation Review',
    'chassidy.hinderaker@aafs.com',
    'Ante Ipsum Primis',
    '554 Montverde Street',
    null,
    'New Graduate Training',
    'Curae; Proin vulputate placerat pellentesque. Proin viverra lacinialectus, quis consectetur mi.',
    'Orci luctus et ultrices posuere cubilia Curae; Proin vulputate placerat pellentesque. Proin viverra.',
    sysdate - 61
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623804351484187022376529031906,
    'Broderick',
    'Faur',
    sysdate - 94,
    'F',
    'Fault Rate Reduction',
    'broderick.faur@aaft.com',
    'Ipsumprimis In Faucibus',
    '447 Caamouco Street',
    null,
    'Documentation Review',
    'Viverra lacinialectus, quis consectetur mi venenatis nec. Donec convallis sollicitudin elementum. Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in vestibulum tellus. In.',
    'Et malesuada fames ac ante ipsum primis in faucibus. Ut id nulla ac sapien suscipit tristique ac volutpat risus.Phasellus vitae ligula commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum ante ipsumprimis in faucibus orci.',
    sysdate - 99
);

insert into runners (
    id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    team_name,
    email,
    phone,
    address,
    photo,
    photo_filename,
    photo_mimetype,
    photo_charset,
    photo_lastupd
) values (
    202897259623805560410006637005703738082,
    'Jewel',
    'Ginnery',
    sysdate - 96,
    'M',
    'Customer Satisfaction Improvement',
    'jewel.ginnery@aafu.com',
    'Tincidunt Vestibulum Ante',
    '252 Varmonzey Street',
    null,
    'Claim Reduction Plan',
    'Commodo, dictum lorem sit amet, imperdiet ex. Etiam cursus porttitor tincidunt. Vestibulum.',
    'Nulla facilisi. In posuere blandit leoeget malesuada. Vivamus efficitur ipsum tellus, quis posuere mi maximus vitae. Quisque tortor odio, feugiat eget sagittisvel, pretium ut metus. Duis et commodo arcu, in.',
    sysdate - 85
);

commit;
-- load data
-- load data
 
insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623806769335826251634878444258,
    'Overseas Relocation',
    sysdate - 48,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623807978261645866264053150434,
    'Six Sigma Introduction',
    sysdate - 36,
    42000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623809187187465480893227856610,
    'New Hire Training',
    sysdate - 56,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623810396113285095522402562786,
    'Night Call Reduction',
    sysdate - 58,
    21000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623811605039104710151577268962,
    'Claim Reduction Plan',
    sysdate - 23,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623812813964924324780751975138,
    'Availability Optimization',
    sysdate - 70,
    5000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623814022890743939409926681314,
    'Integration Tool Evaluation',
    sysdate - 68,
    42000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623815231816563554039101387490,
    'Claim Reduction Plan',
    sysdate - 38,
    5000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623816440742383168668276093666,
    'Integration Tool Evaluation',
    sysdate - 67,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623817649668202783297450799842,
    'New Graduate Training',
    sysdate - 35,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623818858594022397926625506018,
    'Six Sigma Introduction',
    sysdate - 59,
    42000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623820067519842012555800212194,
    'Course Development',
    sysdate - 91,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623821276445661627184974918370,
    'Release Cycle Change',
    sysdate - 2,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623822485371481241814149624546,
    'Fault Rate Reduction',
    sysdate - 1,
    10000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623823694297300856443324330722,
    'Supplier Change',
    sysdate - 60,
    42000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623824903223120471072499036898,
    'Git Migration',
    sysdate - 14,
    42000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623826112148940085701673743074,
    'Corporate Citizenship Efforts',
    sysdate - 49,
    5000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623827321074759700330848449250,
    'Energy Efficiency',
    sysdate - 1,
    21000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623828530000579314960023155426,
    'Inventory Optimization',
    sysdate - 47,
    21000
);

insert into events (
    id,
    name,
    the_date,
    total_distance
) values (
    202897259623829738926398929589197861602,
    'Reduce Development Cost',
    sysdate - 89,
    5000
);

declare
  cursor random_name
  is
    with team_names_0
    as
    (
    select 'Cats              ' team_name from dual union all
    select 'Lizards           ' team_name from dual union all
    select 'Tortoises         ' team_name from dual union all
    select 'Wanderers         ' team_name from dual union all
    select 'Yellows           ' team_name from dual union all
    select 'Yellow Jackets    ' team_name from dual union all
    select 'Yellow Legs       ' team_name from dual union all
    select 'United            ' team_name from dual union all
    select 'Athletic          ' team_name from dual union all
    select 'Yellow Cats       ' team_name from dual union all
    select 'Yellow Lizards    ' team_name from dual union all
    select 'Yellow Tortoises  ' team_name from dual union all
    select 'Yellow Wanderers  ' team_name from dual union all
    select 'Kind Cats         ' team_name from dual union all
    select 'Kind Lizards      ' team_name from dual union all
    select 'Kind Tortoises    ' team_name from dual union all
    select 'Kind Wanderers    ' team_name from dual union all
    select 'Brunette Cats     ' team_name from dual union all
    select 'Brunette Lizards  ' team_name from dual union all
    select 'Brunette Tortoises' team_name from dual union all
    select 'Brunette Wanderers' team_name from dual union all
    select 'Fluffy Cats       ' team_name from dual union all
    select 'Fluffy Lizards    ' team_name from dual union all
    select 'Fluffy Tortoises  ' team_name from dual union all
    select 'Fluffy Wanderers  ' team_name from dual
    ), names_random as
    (select trim(team_name) name
      from team_names_0
      order by dbms_random.value
    ) select *
      from names_random
      where rownum = 1
      ;
  begin
    for runner in (select id
                   from   runners
                   ) loop
      for rn in random_name loop
        update runners
        set    team_name = rn.name
        -- clear photo fields
        ,      photo_filename = null
        ,      photo_mimetype = null
        ,      photo_charset  = null
        ,      photo_lastupd  = null
         -- ages between 12 and 58Z
        ,      date_of_birth  = date_of_birth 
                              - dbms_random.value
                                 ((12*365),(58*365))
        ,      phone          = substr
                                  (substr
                                    (id,dbms_random.value(1,6)
                                     )
                                     ,1,8)
        where  id = runner.id
        ;
      end loop;
    end loop;       
end;
/

declare
  cursor random_town
  is
    with town_names as
    (select trim(town_name) name from
    (
    select 'Oconto (US)         ' town_name from dual union all
    select 'Palm Springs (US)   ' town_name from dual union all
    select 'Tunbridge Wells (UK)' town_name from dual union all
    select 'New Milton (UK)     ' town_name from dual union all
    select 'Shreveport (US)     ' town_name from dual union all
    select 'Hobart (AU)         ' town_name from dual union all
    select 'Virginia Beach (US) ' town_name from dual union all
    select 'Ilminster (UK)      ' town_name from dual union all
    select 'Loughton (UK)       ' town_name from dual union all
    select 'Susanville (US)     ' town_name from dual
    ) order by dbms_random.value
    )select * from town_names fetch first 1 rows only
    ;
  begin
    for event in (select id
                   from  events
                   ) loop
      for rt in random_town loop
        update events
        set    name = (total_distance/1000)||'K - '||rt.name
        ,      the_date = (sysdate - dbms_random.value(20,500))
        where  id = event.id
        ;
      end loop;
    end loop;       
end;
/

declare
  l_group_count integer := 0;
  l_counter     integer := 0;
  l_start_time  event_results.start_time%type;
  l_avg_time5k  number := (1/24/60) * 37;  --37 min
begin
for event in (select id,total_distance from events) loop
  l_group_count := dbms_random.value(5,10);
  l_counter     := 0;
  l_start_time  := lpad((ceil(dbms_random.value(6,9))||':00:00'),8,'0');
 for i in 1..dbms_random.value(50,150) loop
    l_counter    := l_counter + 1;
    l_start_time := case when (l_counter > l_group_count)
                         then substr(l_start_time,1,3)||lpad((to_number(substr(l_start_time,4,2) + 1)),2,'0')||':00'
                         else l_start_time
                         end;
    l_counter   := case when (l_counter > l_group_count)
                        then 0
                        else l_counter
                        end;
    insert into event_results
    (event_id
    ,runner_id
    ,start_time
    ,end_time
    ) values
    (event.id,
     (select id
      from   (select * 
              from   runners
              order by dbms_random.value()
              )
      fetch first 1 rows only
     ),
     l_start_time
     ,
     case event.total_distance
     when 5000 
     then to_char
           ((to_date(
              (to_char(sysdate,'dd-mm-yyyy')||' '||l_start_time),'dd-mm-yyyy hh:mi:ss') + (1/24/60) * dbms_random.value(25,40))
            ,'hh:mi:ss'
           )
     when 10000 
     then to_char
           ((to_date(
              (to_char(sysdate,'dd-mm-yyyy')||' '||l_start_time),'dd-mm-yyyy hh:mi:ss') + (1/24/60) * dbms_random.value(45,100))
            ,'hh:mi:ss'
           )
     when 21000 
     then to_char
           ((to_date(
              (to_char(sysdate,'dd-mm-yyyy')||' '||l_start_time),'dd-mm-yyyy hh:mi:ss') + (1/24/60) * dbms_random.value(70,170))
            ,'hh:mi:ss'
           )
     when 42000 
     then to_char
           ((to_date(
              (to_char(sysdate,'dd-mm-yyyy')||' '||l_start_time),'dd-mm-yyyy hh:mi:ss') + (1/24/60) * dbms_random.value(270,355))
            ,'hh:mi:ss'
           )
     else null
     end
     );
 end loop;
end loop;
end;
/

commit;
