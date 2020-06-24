# Custom processing.
in APEX kunnen we onze eigen PL/SQL logica toevoegen. We doen dit aan de hand van twee functionaliteiten die we toevoegen aan de applicatie.</br>
Pas eerst je overzichtsscherm aan:
- wijzig de page template naar: Right Side column
- Voeg een static region in de right side column toe en noem het: Tasks
- voeg twee knoppen toe:
  - CHANGE_EMP_DEP
  - ADD_DEP_W_EMP


## Switch departments for multiple employees
In dit deel van de training bouwen we een modal page waar de gebruiker 1 of meerdere werknemers in één keer in een andere afdeling kan plaatsen.</br>
Stappen:
1. Maak een Blank Modal page:
  - Naam: Move employees to another department
  - Voeg de knoppen CANCEL(Dyn Act) en SAVE(submit) toe
2. Zorg ervoor dat knoppen:
  - CHANGE_EMP_DEP deze modal page opent.
  - CANCEL deze modal page sluit
3. Voeg de velden "New Department" en "Employees to move" toe aan een nieuwe region in de modal page.
  - New department = Select list met alle department namen, return = depno
  - Employees to move = Shuttle Item met alle medewerkers die niet in "New department" zitten. (cascading, based on prev item)
  ```SQL
  -- NEW DEP LOV
  select dname  d
  ,      deptno r
  from   dept
  order by dname
  ;
  -- EMPS LOV
  select ename d
  ,      empno r  
  from   emp
  where  deptno != :PXX_NEW_DEPT
  order by ename
  ;
  ````
4. Maak een proces die de afdeling van de gekozen medewerkers update.</br>
```SQL
declare
    l_vc_arr2    APEX_APPLICATION_GLOBAL.VC_ARR2;
    l_count      pls_integer := 0;
begin
  l_vc_arr2 := apex_util.string_to_table(:P5_EMPS);
  for i in 1 .. l_vc_arr2.count loop
  apex_debug.message('updating empno '||l_vc_arr2(i));
  update emp
  set    deptno = :P5_NEW_DEPT
  where empno = l_vc_arr2(i)
  ;
  l_count := l_count + 1;
  end loop;
  apex_debug.message(l_count||' employees updated');
end;
```
- on button pressed SAVE
- Hier hebben we gebruik gemaakt van twee APEX API PACKAGES: *apex_util* en *apex_debug*. Waarvoor? Hoe controleren we de debug messages?
5. Voeg een proces toe om de modal dialog te sluiten na het opslaan
6. Voeg een Dynamic action toe om het overzicht te verversen na de SAVE actie.


### opdrachten (indien genoeg tijd)
1. Maak beide velden verplicht.
2. wijzig de shuttle zodanig dat je in de lijst kunt zien in welke afdeling de medewerkers zitten.
3. Zorg ervoor dat een willekeurige manager van de nieuwe afdeling aan de medewerker gekoppeld wordt, als de afdeling een manager heeft.
4. Medewerkers met JOB = 'PRESIDENT' kunnen niet op deze manier van afdeling wijzigen.


## Create department with employees
Met behulp van een wizard kan de gebruiker een afdeling inclusief medewerkers toevoegen. De wizard bestaat uit de volgende stappen
1. create department → de gebruiker vult de gegevens van de medewerker in
2. add employee → de gebruiker kan één of meerdere medewerkers toevoegen
3. overview → voordat de gebruiker opslaat wordt eerst een overzicht getoond van wat opgeslagen wordt
</br>
Stappen:
1. Create Page met de Create Page wizard en kies voor "Wizard".
  - Name = Create complete department
  - Aantal schermen = 3
  - Page Mode = Modal
  - geen Navigation entry
2. Vul de naam van de pages in.
3. Zorg ervoor dat de knop in de right column navigeert naar je eerste scherm in de wizard. Als je op de knop drukt moet ook alle info op de wizard schermen verdwijnen.
4. Kopieer de items uit het departments scherm en het employee scherm naar het eerste en tweede scherm van de wizard.
  - de PK itemss hoeven niet in de wizard worden opgenomen
  - manager veld hoeft ook niet erbij
  - item source type = null
5. Voeg een knop toe in het cretae Employee scherm
  - Name = ADD_ANOTHER
  - Type = Submit
  - Voeg een branch toe dat naar hetzelfde scherm navigeert als je op deze knop drukt
6. Voeg een proces toe die gerund wordt als je op knop NEXT of ADD_ANOTHER klikt
```SQL
declare
  l_collection_name varchar2(30) := 'NEW_EMP_ROW';
begin
  if NOT APEX_COLLECTION.COLLECTION_EXISTS (l_collection_name) then
  APEX_COLLECTION.CREATE_COLLECTION
    (p_collection_name => l_collection_name);
  end if;
  APEX_COLLECTION.ADD_MEMBER
    (p_collection_name => l_collection_name,
     p_c001            => :P7_ENAME,
     p_c002            => :P7_JOB,
     p_d001            => :P7_HIREDATE,
     p_n001            => :P7_SAL,
     p_n002            => :P7_COMM
    );
 end;
--APEX_COLLECTION.DELETE_COLLECTION(l_collection_name);
```
6. Maak op de overview page een classic report:</br>
```SQL
select c001 ename
,      c002 job
,      d001 hiredate
,      n001 salary
,      n002 commision
,      :P6_DNAME department
,      :P6_LOC   location
from   apex_collections
where  collection_name = 'NEW_EMP_ROW'
;
```
7. Zet op de overview page ook twee processes:
- insert department
```SQL
-- insert departments, button = finish
insert into dept
(deptno
,dname
,loc
) values
(dept_seq.nextval
,:P6_DNAME
,:P6_LOC
);
--
:P2_SEARCH_DEPTNO := DEPT_SEQ.CURRVAL;
```
- insert employees, button = finish
```SQL
-- insert employees
insert into emp
(empno
,ename
,job
,hiredate
,sal
,comm
,deptno
)
select emp_seq.nextval
,      c001     ename
,      c002      job
,      d001      hiredate
,      n001      salary
,      n002      commision
,      dept_seq.currval department
from   apex_collections
where  collection_name = 'NEW_EMP_ROW'
;
```

7. Voeg ook een Branch toe naar je Hoofd overzichtscherm en verwijder de close dialog.
8. Voeg op het eerste wizard scherm: create department een pre-rendering process om de collectie te verwijderen:
```SQL
declare
  l_collection_name varchar2(30) := 'NEW_EMP_ROW';
begin
  if APEX_COLLECTION.COLLECTION_EXISTS (l_collection_name) then
  APEX_COLLECTION.DELETE_COLLECTION(l_collection_name);
 end if;
 end;
```
</br>

## Opdrachten
1. Welke functionaliteiten ontbreken in de wizard? Hoe zou je ze implementeren?
2. Toon een succes melding na het invoeren van de medewerkers. Het aantal ingevoerde medewerkers moet ook zichtbaar zijn. Gebruik hiervoor de plsql api APEX_LANG
