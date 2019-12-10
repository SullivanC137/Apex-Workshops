# Data validations, some business logic and graphs
In this module we will be adding some data validations and logic to our application. We will also end with a few graphs.
This module is mostly code along. Watch the trainer and then do it yourself.

### Requirements
Each runner can only have one result per event. This means:
1. When adding a new result we have to make sure that there are no results entered for this runner for our chosen event.
2. When updating a current result we have to make sure that there is exactly 1 result entered for this runner for our chosen event.
3. Error message: "A runner can only have one result entered for an event".

Instructions:
On your event result form:
1. Add a validation:
  * Name = "Unique runners result on insert"
  * Type = No rows returned (view help text).
  * When button pressed = CREATE
  * SQL Query: (replace 12 with your page number)
  ```` sql
  select 1
  from   event_results
  where  runner_id = :P12_RUNNER_ID
  and    event_id  = :P12_EVENT_ID
  ;
  ````
2. Add another validation:
  * Name = "Unique runners result on update"
  * Type = No rows returned (view help text).
  * When button pressed = UPDATE
  * SQL Query:
  ```` sql
  select 1
  from   event_results
  where  runner_id =  :P12_RUNNER_ID
  and    event_id  =  :P12_EVENT_ID
  and    id        != :P12_ID
  ;
  ````
3. Optional: Make the start time mandatory.

### Data validation on event result
A result must be entered in format: hh:mi:ss. (hours:minutes:seconds)
1. A user should visually be made aware of the expected format.
2. Error message: "Expected format = (hours:minutes:seconds)"

Instructions:
1. Add following text into Value Place Holder field for your start time and end time items:
> hh:mi:ss
2. Add a validation for start time:
  * Name = Start Time format OK
  * Type = SQL Expression
  * SQL Expression:
  ```` sql
  to_number(substr(:P12_START_TIME,1,2)) <= 24
  and
  substr(:P12_START_TIME,3,1) = ':'
  and
  to_number(substr(:P12_START_TIME,4,2)) <= 59
  and
  substr(:P12_START_TIME,6,1) = ':'
  and
  to_number(substr(:P12_START_TIME,7,2)) <= 59
  ````
  * Associated Item = P12_START_TIME
  * Server side condition = Item is NOT NULL
  * Item = P12_START_TIME
3. Do the same for end time

### Add two filters to your running reports: event, runner
Instructions:
Add a button bar to the breadcumb region position

### Extend your result report with running duration per runner
Edit your results report: change it from table based to query based with following query:
