## SEARCH
Het doel van deze module is om een Zoekfunctionaliteit op het overzichtsscherm te bouwen.</br>
1. Voeg twee items toe aan je report region: een tekst veld "PXX_SEARCH_ENAME" en een knop "SEARCH" (SUBMIT)
2. Wijzig de query om gebruik te maken van deze zoekveld:
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
where ((instr(e.ename,:P2_SEARCH_ENAME) > 0 and :P2_SEARCH_ENAME is not null) or
       :P2_SEARCH_ENAME is null
       )
;
```
3. Voeg ook een zoekveld op departments toe, maar dit veld moet een select list zijn.
4. Voeg een RESET knop toe. Deze knop maakt alle zoekvelden leeg en laadt het scherm opnieuw.
5. Pas het overzicht aan dmv template options, kolomnamen etc.