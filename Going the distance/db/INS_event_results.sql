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
