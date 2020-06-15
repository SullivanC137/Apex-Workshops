# Interactive reports and forms
Gebruik de create page wizard nogmaals om twee schermen te maken:</br>
Een Overzicht scherm (report) en een Formulier (form).</br>
Let op dat je dit keer kiest voor de INTERACTIVE report en weer NIET een modal form</br>
Stappen:</br>
- Klik op Create Page: Je komt dan in de create page wizard terecht.
- Kies voor Form
- Kies voor Report with Form on a Table → APEX genereert een overzicht en een formulier
- Kies voor interactive report: dit is het standaardoverzichtscherm voor rapporten en kan het meest aangepast worden.
  - Naam van het overzichtscherm: Employees
  - Naam van het formulier: Employee
  - Form page mode = "Normal"
  - Breadcrumb = "breadcrumb"
  - Parent Entry = "No parent entry"
  - Entry name = "Employees"
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

## Create Report and Form
![Report and Form](createReportAndForm.gif)

## Aanpassingen
Kolomnamen in de overzichten, veldnamen in de formulieren zijn nu nog hetzelfde als de tabel kolomnamen. </br>
Deze aanpassingen zullen op een later tijdstip volgen.