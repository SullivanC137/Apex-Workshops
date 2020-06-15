# Classic reports and forms
Gebruik de create page wizard om twee schermen te maken:</br>
Een Overzicht scherm (report) en een Formulier (form).</br>
Dit doen we door in de wizard te kiezen voor optie: "Form" en dan "Report and Form" on a table</br>
Let op dat je kiest voor de classic report en NIET een modal form</br>
Stappen:</br>
- Klik op Create Page: Je komt dan in de create page wizard terecht.
- Kies voor Form
- Kies voor Report with Form on a Table → APEX genereert een overzicht en een formulier
- Kies voor Classic report: dit is het standaardoverzichtscherm voor rapporten en kan het meest aangepast worden.
  - Naam van het overzichtscherm: Employees
  - Naam van het formulier: Employee
  - Form page mode = "Normal"
  - Breadcrumb = "breadcrumb"
  - Parent Entry = "No parent entry"
  - Entry name = "Employees"
- Klik op next: Navigation Menu
  - Create a new navigation entry
  - New Navigation Menu Entry = "Employees (CR)" CR = 
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
## Zelf doen: Classic report en Form op tabel DEPT
- Doe hetzelfde voor tabel DEPT: maak een classic report en form op basis van tabel DEPT. Details:
  - Report and Form:
    - Naam van het overzichtscherm: Departments
    - Naam van het formulier: Department
    - Form page mode = "Normal"
    - Breadcrumb = "breadcrumb"
    - Parent Entry = "No parent entry"
    - Entry name = "Department"
  - Navigation Menu:
  - New Navigation Menu Entry = "Employees (CR)" CR = 
  - Parent Navigation Menu Entry = "- No parent selected -"


## Create Report and Form
![Report and Form](createReportAndForm.gif)

## Aanpassingen
Kolomnamen in de overzichten, veldnamen in de formulieren zijn nu nog hetzelfde als de tabel kolomnamen. </br>
Deze aanpassingen zullen op een later tijdstip volgen.