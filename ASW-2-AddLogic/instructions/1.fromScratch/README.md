# From Scratch
In deze module maken we opnieuw een overzicht en formulieren, alleen maken we GEEN gebruik van de page wizard.

## The report
Het doel is om een overzicht te tonen van alle afdelingen en medewerkers, inclusief afdelingen zonder medewerkers.</br>
Stappen:
1. Maak een leeg scherm en noem het Department Employees
- Create page
- Kies voor blank page
- Naam Page: Department overview
- Normal, niet modal
- geen breadcrumbs
- Nieuwe navigation menu, zelfde naam als scherm, willekeurige icon

2. Maak een nieuwe region in dit scherm.
- Position: Content Body
- Type = Classic report
- Naam: Departments and Employees
- Query:
```SQL
select d.deptno
,      d.dname
,      d.loc
,      e.empno
,      e.ename
,      e.job
,      e.mgr
,      e.hiredate
,      e.sal
,      e.comm
from   dept d
left join   emp  e on d.deptno = e.deptno
;
```
- Wijzig naar eigen inzicht kolomnamen, template options en dergelijke

## Form 1: Employees
Maak een simpele formulier op tabel departments:</br>
Stappen:
1. Maak een leeg scherm en noem het Department
- Create Page
- Blank Page
2. Maak een Static Region en noem het: Department met de volgende items van het type Database Column:
- PXX_DEPTNO, een hidden item
- PXX_DNAME, text field
- PXX_LOC, text field
3. Voeg een proces toe om data op te halen:
- naam: Fetch row of table DEPT
- rechtermuis klik op processes, bij "Pre-Rendering"
- process point: before header (after header kan ook)
- Automatic row fetch
- Vul tabel en PK info in
4. Voeg een process toe om data te verwerken:
- rechtermuisklik op Processes
- naam: Process row of table DEPT
- process point: Processing
- Automatic Row Processing (DML)
- Vul tabel en PK info in
5. Voeg een process toe om de PK op te halen:
- naam: get PK
- Source
```SQL
if :P3_DEPTNO is null then
  :P3_DEPTNO := DEPT_SEQ.nextval;
end if;
```
- Zorg ervoor dat de "get PK" voor de DML processing gaat.</br>

6. Voeg de knoppen toe
- CREATE → submit actie, Database action = INSERT
- SAVE → submit actie, Database action = UPDATE
- CANCEL → redirect terug naar het gemaakte overzichtsscherm
- DELETE → submit actie, Database action = DELETE
- rechtermuis klik op je region → klik add button
7. Voeg branch toe: nadat CREATE , SAVE , DELETE gedrukt zijn moet de applicatie terug navigeren naar het overzichtsscherm
- rechtermuisklik op After Processing
- Naam: Go To PXX after DML
8. Voeg in de report page een knop toe om naar dit scherm te navigeren.
9. Gebruik kolomnaam DNAME (Department name) als navigatie om naar department formulier te navigeren (edit)
10. Test door afdelingen toe te voegen.
</br>

## Form 2 Employees
Maak een simpele formulier, maar gebruik nu de page wizard. Voeg ook op dezelfde manier navigatie toe via kolom EMployee name (edit) een een Create Employee knop (create).</br> 
