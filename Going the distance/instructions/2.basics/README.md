## Basics

This part covers extra navigation and shared components
Before we start, please download the example applications: f101, f102, f103, f104 and then download them into your workspace. Your new application ID does not have to match this one.

## Code along/Use handouts:

### NAVIGATION
- Change your Volunteers page, Page template to: Right side column
- Create a new region in this right side column called "More Tasks"
** Your new region should have an attribute: Position = Right side column
** Add a button to this region to naviagte to your "Volunteers multi row edit" page
** Button attributes:
  - Name = MULTI_ROW_EDIT
  - Button Position = Region Body
** Play around with your button template or attributes: for example: set style to: display as link
- Save and test yoour button navigation
Optional: add another button to go back to the home screen

### SHARED COMPONENTS
- Go to App Builder --> Shared Components or Page Designer --> Shared Components
- List of Values --> Create 
- From scratch --> Name = Gender M/F , Type = Static
- Display/Return = [{Male,M},{Female,F}]
- Use this newly created LOV in your volunteers pages by changing the gender field to an LOV field. Also do it on the report column
- For example: Select List. Pop-up, Radiobutton

### ON YOUR OWN/ WATCH THE TRAINER FIRST:
Read all following instructions first.
Create a report and form on the runners and events tables.
* for the reports, use an interactive report
* for the forms, use a normal non modal form for the runners and a modal form for the events.
* Remove unnecessary columns from the reports, set them to hidden. (id, audit columns)
* The runners report should have a column for their pictures. Use the "Display Image" column type for this. Add this css in your runners report page details to resize the pictures.
     ```` css
     img{
     width:100px;
     }
     ````
  *  report page should have its own navigation link in the menu

### CODE ALONG:
Create a form page to add results to an event.
1. Create a report and form on table event_results. Use Classic Report and modal form.
2. Use shared components (LOV) to show runner names and event names in the report and form.
  * LOV: Name = "Runner Name return ID" and type = Dynamic
  * Query:
  ```` sql
  select name||' '||the_date as d,
       id as r
  from events
  order by 1
  ````
  * LOV: Name = "Event Name return ID" and type = Dynamic
  * Query:
  ```` sql
  select name as d,
       id as r
  from events
  order by 1
  ````
3. In you results report page, change column "event id" from Plain text to "Plain text based on list of value"
4. Do the same for runner id
5. Use these LOV's to also change your result form page. Use PopUp LOV's








