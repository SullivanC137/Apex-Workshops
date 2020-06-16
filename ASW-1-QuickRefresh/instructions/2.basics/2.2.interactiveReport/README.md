# Interactive reports and forms
Gebruik de create page wizard nogmaals om twee schermen te maken:</br>
Een Overzicht scherm (report) en een Formulier (form).</br>
Let op dat je dit keer kiest voor de INTERACTIVE report, NIET een modal form en GEEN Breadcrumb</br>
Stappen:</br>
- Klik op Create Page: Je komt dan in de create page wizard terecht.
- Kies voor Form
- Kies voor Report with Form on a Table → APEX genereert een overzicht en een formulier
- Kies voor interactive report: dit is het standaardoverzichtscherm voor rapporten en kan het meest aangepast worden.
  - Naam van het overzichtscherm: Employees
  - Naam van het formulier: Employee
  - Form page mode = "Normal"
- Klik op next: Navigation Menu
  - Create a new navigation entry
  - New Navigation Menu Entry = "Employees (IR)"
  - Parent Navigation Menu Entry = "- No parent selected -"
- Klik Next: Data Source
  - Table/View Name = EMP
  - Select Column(s) to be shown in Report → Zorg ervoor dat alle kolommen rechts in de shuttle zijn
- Kilik next: Form Page
  - Primary Key Type: "Select Primary Key Column(s)"
  - Select Column(s) to be included in Form → Zorg ervoor dat alle kolommen rechts in de shuttle staan
  - Primary Key Column 1 = "EMPNO"
  - Source for Primary Key Column 1 = "EMP_SEQ"
- Klik op Create
- Run de applicatie/het scherm

## Gegenereerde componenten
Dmv de wizards genereert APEX componenten op basis van de gekozen entiteiten en ingevulde attributen.</br>
Enkele componenten/component typen:</br>
- Schermen (type )
- Regions → schermdelen, bijvoorbeeld report of form
- Items → velden op het scherm, bijvoorbeeld text veld
  - APEX heeft verschillende typen Regions/Items
  - Elke Region/Item type kan andere properties hebben
- Processes → code om data te verwerken / logica uit te voeren
- Branches → navigatie instellingen.
- navigation menu → hoofd navigatie. Te bezichtigen of aanpassen via: Shared Components.

## Gebruikte features
Tot nu toe hebben we gebruik gemaakt van de Application Builder, Shared Components, Page Designer en de developer toolbar.

### Opdrachten
Gebruik bovenstaande features om zelf de volgende vragen te beantwoorden.</br>
1. Op welke twee manieren kun je naar shared components navigeren?
2. Navigeer naar de Navigation Menu en wijzig twee iconen. Page Designer → Shared Components → Navigation Menu → Desktop Navigation Menu → Klik een willekeurige rij → Wijzig veld Image/Class.
3. Navigeer naar een formulier (bijvoorbeeld Employee) en bekijk de Page Designer (via Eidt Page knop op de Developer Toolbar). </br>
    - a. Welke drie processen zijn automatisch gegenereerd en waarvoor dienen ze?
    - b. Op dit scherm kun je weg navigeren door op te slaan (CREATE,SAVE) of te annuleren (CANCEL). Hoe is dat in dit scherm geimplementeerd?
    - c. Welke item types zijn op dit scherm?
    - d. Wijzig één of meerdere veldnamen.
4. Navigeer naar een classic report (Bijvoorbeeld Employees(CR)) en bekijk de Page Designer.</br>
    - a. Op welke twee manieren kun je naar het formulier navigeren en hoe is dat geimplementeerd?
    - b. Wijzig één of meerdere kolomnamen.
    - c. Wijzig de naam van het overzicht naar "Employee Overview"
    - d. Welke region types zijn op dit scherm?
5. Navigeer naar een Interactive Report (Bijvoorbeeld Employees (IR)) en bekijk de page designer. Noem enkele verschillen met de classic report.

