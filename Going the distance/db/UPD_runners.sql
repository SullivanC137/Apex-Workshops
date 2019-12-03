
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

commit;