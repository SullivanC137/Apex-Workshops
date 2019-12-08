## Basics

This part covers extra navigation and shared components
Before we start, please download the example applications: f101, f102, f103, f104 and then download them into your workspace. Your new application ID does not have to match this one.

## Code along/Use handouts:

NAVIGATION
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

SHARED COMPONENTS
- Go to App Builder --> Shared Components or Page Designer --> Shared Components
- List of Values --> Create 
- From scratch --> Name = Gender M/F , Type = Static
- Display/Return = [{Male,M},{Female,F}]
- Use this newly created LOV in your volunteers pages by changing the gender field to an LOV field. Also do it on the report column
- For example: Select List. Pop-up, Radiobutton

ON YOUR OWN:
- Create a report and form on the runners and events tables
  * runners: 
   * report (interactive report).
     add this css in your inline css page details
```` css
img{
    width:100px;
    }
````
   * form (normal, not modal)
  * events: editable report
  * each with their own navigation link in the menu

CODE ALONG:
- Create a form page to add results to an event



