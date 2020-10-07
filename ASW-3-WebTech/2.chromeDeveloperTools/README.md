# Chrome developer tools
De Chrome webbrowser geeft je de mogelijkheid om de source van elke website, dus ook van APEX web applicaties, te bekijken.</br>
Opdrachten:
1. installeer op je eigen ontwikkelomgeving de sample database applicatie (packaged -> applications -> samples)
2. Maak een scherm onder "Administration" en noem het: application objects: een scherm met een classic report met query:
```SQL
select object_id
,      object_name
,      object_type
,      created
from   user_objects
```
3. Gebruik de inspect element tool en noem de verschillen in html/css tussen dit scherm en hetzelfde scherm in applicatie 111 (oude theme).
