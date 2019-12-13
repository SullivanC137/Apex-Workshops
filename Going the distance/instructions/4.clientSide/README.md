# In the last part of this workshop we add some client side behaviour

Client side behaviour is mostly done through dynamic actions. Apex generates Javascript based on your dynamic actions.
Lets start with a few simple user requirements:

### Filtering Event results should not submit page
To achieve this we will add a dynamic action on the filter items
Instructions:
1. Result Page --> Page Builder (edit) --> Add a dynamic action on P11_EVENT_ID (change your page id)
2. Dynamic action details:
   * Name = on change event id
   * Event = change
   * Selection Type = Item(s)
   * True action = Refresh
     * Selection Type = Region
     * Region = Results
3. Save and Run
Do the same with the runner filter

You can also change the page behaviour by inserting Javascript code in other sections. For example another user requirement

### When scrolling down on the event results page, the search region should not disappear from view
This can be done with a simple (yet undocumented) piece of code.
Instructions:
1. Give your search region a static id: search
2. Add the following Javascript code to your page details in section: Javascript, execute when page loads.
```` javascript
$("#search").stickyWidget({toggleWidth:true});
````
3. save and run

### When entering a new result, the user wants to use the current filter settings
Whenever a filter is used, we can use the values to insert a new result, saving the user a few clicks.
Instructions:
1. Change the link target of the Create button on the results page. Link the event_id and runner_id of both pages.
2. save and run
Now the user knows that when a result is found in the report, he cannot insert a result anymore for that runner in the same event. Lets help him by disabling this Create button when there is no data found.
Instructions:
1. Add a static id to your results region: results
2. Create a dynamic action on the results region
   * NAme = on refresh region disable create button if data found
   * Event = after refresh
   * Region = results
   * Section: Client-side Condition
      * Type = Javascript Expression
      * Javascript Expression:
      ```` javascript
      $('#report_results').find('td.t-Report-cell').length > 0;
      ````
      * True Action:
         * type = disable
         * selection type = button
         * button = CREATE
      * Opposite False action
 3. Save and run
   
