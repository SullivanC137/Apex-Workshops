# Component templates
In de UT applicatie heb je gezien dat je bij vrijwel elke component de template options kunt aanpassen</br>
In deze module zullen we de template van regions, items en buttons aanpassen.</br>
Een overzicht van alle component templates vind je in de UT applicatie → Reference → Component Templates

## Region Template
1. Navigeer naar een Formulier, Employee (Normal, niet Modal) en open deze in de page designer.
2. Pas de template van de form region aan:
  - Template = Standard (zo laten)
  - Klik op template options en wijzig:
    - Item size = Large
    - Label alignment = Left
  - Opslaan en runnen
## Button Template
3. Pas de template configuratie van de knoppen aan:
  - Button Template = Text with Icon
  - Icon CSS Classes:
    - CANCEL: fa-undo-arrow
    - DELETE: fa-trash-o
    - SAVE: fa-save-as
    - CREATE: fa-plus-square-o
  - Template Options:
    - CANCEL: Icon Position = Left, Size = Large
    - DELETE: Icon Position = Left, Size = Large, Type = Danger
    - SAVE:   Icon Position = Right, Size = Large
    - CREATE: Icon Position = Right, Size = Large, Type = Succes (LET OP: Hot = No)
