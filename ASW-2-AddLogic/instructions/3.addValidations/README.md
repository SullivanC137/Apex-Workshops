# Validations
Validaties zijn regels waaraan de data op het scherm moet voldoen. Dit kunnen we bereiken door validatie logica (code) te schrijven of door het ontwerp van ons scherm aan te passen.</br>
Navigeer voor deze module naar de Employees form en open deze in de page designer.</br>

## Schermontwerp
De volgende regels kunnen afgedwongen worden door het schermontwerp aan te passen.
1. De manager moet van de gekozen afdeling zijn.
  - cascading select list
  - juiste volgorde
  - cascading parent LOV
  - gebruik de help tekst
2. Hiredate moet vandaag of in de toekomst zijn. Wijzig de (minimum date = +0d) settings in het datum veld.

## CODE
Alleen medewerkers van de afdeling SALES mogen commissie krijgen.
- rechtermuisklik op validations → Click Create Validation → Name = SALES gets commission
- PLSQL expression:
```SQL
(nvl(:P4_COMM,0) >= 0 and :P4_DEPTNO = 30) or (:P4_DEPTNO != 30)
```
- Error message: Sales people get commission.
- associated itm = PXX_COMM

## Opdrachten
implementeer de volgende validaties:
1. Voor salesmannen geldt dat hun hiredate minimaal 1 week in de toekomst moet zijn.
2. Alle velden behalve commissie en manager zijn verplicht.
3. Alle medewerkers van afdeling research moeten een manager hebben.
4. Een medewerker kan geen manager zijn van zijn manager.
