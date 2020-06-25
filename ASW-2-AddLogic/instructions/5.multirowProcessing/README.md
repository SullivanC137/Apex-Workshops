# Multi row processing
Multi row processing wordt out of the box ondersteund door APEX dmv Interactive Grids. Daarnaast kunnen we dit ook zelf implementeren door de APEX API's te gebruiken.

## Interactive Grid
Maak een nieuw scherm met een interactive Grid op tabel Employees. Navigation menu = Employees (IG). Gebruik EMPNO als PK.</br>
- Wijzig de kolomname
- Maak de deptno tot een select list en toon de naam van de afdeling
- Maak de manager Id ook tot een select list
- Wijzig bij de pk de default: sequence = EMP_SEQ

### Validatie
Voeg een validatie toe dat alleen salesmensen commissie mogen krijgen.
- editable region = Employees
- Name/Error message = Only Salesmen get commision
- Type = PL/SQL Expression
- Expression:
```SQL
(:DEPTNO = 30 and :COMM is not null and :COMM > 0) or
(:DEPTNO != 30 and (:COMM is null or :COMM = 0))
```
- Associated column = COMM

### Proces
Wanneer je voor een nieuwe employee geen manager invult moet de applicatie een willekeurige manager van dezelfde afdeling invullen.
Create Proces:
- naam = GET RANDOM MANAGER
- type = IG - Auto Row Processing
- Target Type = PL/SQL Code:
```SQL
begin
    case :APEX$ROW_STATUS
    when 'C' then
      with random_ordered_mgr as
      (select *
       from   emp
       where  deptno = :DEPTNO
       and    upper(job) = 'MANAGER'
       order by dbms_random.value
       )
      SELECT EMPNO
      INTO   :MGR
      FROM   random_ordered_mgr
      WHERE  rownum = 1
      AND    :MGR is null
      ;
    else null;
    end case;
exception
  when no_data_found then null;
end;
```
*Dit kan je ook met de default property van kolom MGR bereiken*


### Opdrachten
1. Voeg een validatie toe dat ervoor zorgt dat een medewerker geen manager van zijn manager kan zijn.
2. Alleen medewerkers met JOB = MANAGER moeten in de selectlist voorkomen
3. Bij salesmannen moet de applicatie een standaard waarde van 10 bij commissie invullen, als je dit niet zelf invult. Deze standaard waarde van 10 is een systeemparameter en kan tzt aangepast worden. Voeg deze functionaliteit toe dmv de default property bij een kolom.

## Custom bulk row processing
We gaan een functionaliteit toe voegen in de classic report om meerdere medewerkers tegelijk te verwijderen.</br>
1. Voeg hiervoor eerst drie knoppen toe:
- in de right column positie: ENABLE_BULK_DELETE, DISABLE_BULK_DELETE
- in de classic region: BULK_DELETE
2. Creeer een HIDDEN item: PXX_IND_BULK_DELETE_ENABLED
3. Voeg nog een kolom toe aan het overzicht door de query aan te vullen met:
```SQL
,      case when empno is not null then APEX_ITEM.CHECKBOX2(1,empno)
       else null
       end "Select"
```
Zorg ervoor dat bij deze kolom staat: Escape special characters = No
</br>
4. Voeg de volgende schermlogica toe: 
  - in eerste instantie is alleen de knop: ENABLE_BULK_DELETE zichtbaar, kolom met de selectlist, 
  - Als de gebruiker klikt op deze knop klikt word deze knop onzichtbaar en de rest wel zichtbaar.
  - De gebruiker moet vervolgens medewerkers kunnen verwijderen door op de BULK_DELETE knop te klikken.
  ```SQL
  FOR I in 1..APEX_APPLICATION.G_F01.COUNT LOOP
    DELETE FROM emp WHERE empno = to_number(APEX_APPLICATION.G_F01(i));
END LOOP;
  ``
  - TIP: vul een Y of N in PXX_IND_BULK_DELETE_ENABLED afhankelijk of de functionaliteit wel of niet enabled is. Gebruik ook de default waarde in de IND item

### Opdrachten
1. Voeg een nette foutmelding toe bij het verwijderen van de medewerkers.
2. Als een te verwijderen medewerker een manager is, update de medewerker van wie hij een manager is, geef hem een willekeurige manager van dezelfde afdeling, indien beschikbaar en verwijder dan de manager. (geen FK problemen)
3. Voeg een bulk functionaliteit toe om een percentage verhoging te geven. De gebruiker moet het percentage ergens kunnen invullen. Dit percentage mag niet lager dan 100% zijn.
