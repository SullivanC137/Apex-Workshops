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

commit;