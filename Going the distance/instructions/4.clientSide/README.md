# In the last part of this workshop we add some client side behaviour

Client side behaviour is mostly done trough dynamic actions. Apex generates Javascript based on your dynamic actions.Lets start with a few simple user requirements:

### Filtering Event results should not submit page
To achieve this we will add a dynamic action on the filter items
Instructions:
1. Result Page --> Page Builder (edit) --> Add a dynamic action on P11_EVENT_ID (change your page id)
2. Dynamic action details:
   * Name = on change event id
   * Event = change
   * Selection Type = Item(s)
   * True action = Refresh
     ** Selection Type = Region
     ** Region = Results
3. Save and Run
Do the same with the runner filter

You can also change the page behaviour by inserting Javascript code in other sections. For example another user requirement

### When scrolling down on the event results page, the search region should not dissapear from view
This can be done with a simple (yet undocumented) piece of code.
Instructions:
1. give your search region a static id: search
2. Add the following Javascript code to your page details in section: Javascript, execute when page loads.
```` javascript
$("#search").stickyWidget({toggleWidth:true});
````
3. save and run
