# Introduction
This part consists of a quick tour and a code along.

### Tour:
* Log into your apex workspace
  Optional: Create a user with your own username

* Main tabs: App Builder, SQL Workshop, Team Development and App Gallery
  We will mostly be using
  * App Builder: import and create
  * SQL Workshop: Object Browser, SQL commands and Quick SQL
  
### Our first app (code along):
1. Click on create
1. Click New Application
1. Enter a name for your application. eg: race event manager/race manager/cool runnings
   * choose an appearance (use side menu)
   * Click Create Application
1. Click Run application and login with your apex username and password

### Continue Tour:
- Edit Page -> Page designer
- Three Main Blocks
- Components: regions/items etc
  * region types
  * attributes
- run page

### Code along:
1. edit the region in the breadcrumb bar. Add following text into source block:
```` html
  <p> An application to manage racing events, runners and results.</p>
````
  Save and run

2. add a Static region in the content body section
  * Title = About
  * add following text to source:
```` html
    This application is built as part of an introductory Oracle Apex Workshop, compliments of Qualogy Caribbean. </br>The workshop can be downloaded at <a href="https://github.com/SullivanC137/Apex-Workshops" target="_blank"> Github</a>. </br>If you have any more questions after this workshop, just send an <a href="mailto:sullivan.kromosoeto@outlook.com?&subject=Question%20about%20the%20APEX%20workshop&body=Hi%20Sullivan%2C%0A%0AI%20have%20the%20following%20question%20about%20that%20last%20apex%20workshop.%0A%0A%3Cyour%20question%3E%0A%0ARegards%2C%0A%3Cyour%20name%3E%0A">email to Sullivan Kromosoeto</a>.
````
  * Save and run your page
  
### Continue Tour / code along
- SQL Workshop:
  * Object browser: tables
  * SQL commands: test a few queries:
```` sql
    --
    select name
    ,      the_date
    ,      total_distance
    from   events;
    --
    select first_name
    ,      last_name
    ,      team_name
    ,      gender
    ,      date_of_birth
    ,      floor
            ((sysdate - date_of_birth)/365) as age
    from   runners;
    --
    select r.first_name
    ,      r.last_name
    ,      r.gender
    ,      r.team_name
    ,      e.name as event_name
    ,      e.total_distance
    ,      er.start_time
    ,      er.end_time
    from   runners r
    join   event_results er on r.id = er.runner_id
    join   events e on e.id = er.event_id;
    --
````

### Lets extend our app
- SQL Workshop --> Utilities --> Quick SQL:
add text:
````
  # auditcols: true
  # drop     : true
  volunteers
    first_name /nn
    last_name  /nn
    date_of_birth /nn
    gender vc1 /nn  /check M, F
    email
    phone
    duties vc100
 ````
- Save script
- Review and run


-Check if your table has been created
* with object browser
* with sql script
Try an insert:
--
  INSERT INTO volunteers (
    first_name,
    last_name,
    date_of_birth,
    gender
  ) VALUES (
    'John',
    'Doe',
    '13-DEC-1984',
    'M'
  );
-- in sql workshop:
select * 
from   volunteers;
--

Lets build some pages on this new table
(form + report) - the no code way:
**1. App Builder --> <your app> --> Create Page
**2. Choose Form --> Report With Form
**3. Classic Report, Report name: Volunteers, Form name: Volunteer, Form mode: Normal
**4. Create a new navigation: Volunteers
**5. Local Database, Table: Volunteers, Show all columns except the audit columns
**6. Primary Key Column: ID
**7. Create then run your page. Test it by entering and editing a few volunteers
** Optional: play around with the settings/names

(editable report) - also no code
**1. Page Designer --> Create Page
**2. Form --> Eidtable Interactive Grid
**3. Name: Multi Row Edit Volunteers
**4. Create a new navigation entry --> select Volunteers as Parent
**5. Table: Volunteers, Primary Key: ID
**6. Create and run page. Test by editing a few volunteers
** Optional: hide the create update columns
