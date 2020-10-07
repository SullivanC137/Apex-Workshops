# Javascript
Met javascript kunnen we het gedrag van de web page beinvloeden. In APEX doen we dat met dynamic actions.
1. Voeg een dynamic action toe om ervoor te zorgen dat het overzicht ververst nadat een product gewijzigd wordt.
  - dynamic action op de region, event: dialog closed
2. Plaats een knop "View Cart" op de region. Geef de knop een static id = view_cart. Voeg twee items toe: Total Price en Total Items.
3. Gebruik inspect element om de id's van deze objecten te vinden.
Voer een paar apex javascript api's uit op de items. Bijvoorbeeld: show, hide, enable, disable
https://docs.oracle.com/database/apex-5.1/AEAPI/apex-item.htm#AEAPI29446
```JS
apex.item('P24_TOTAL_PRICE').hide();
apex.item( "P24_TOTAL_PRICE" ).setStyle( "color", "red" );
apex.item( "P24_TOTAL_PRICE" ).setValue(852);
$s("P24_TOTAL_PRICE",456);
$v("P24_TOTAL_PRICE");
$("#P24_TOTAL_PRICE").val();
document.getElementById("P24_TOTAL_PRICE").value;
```
Probeer ook:
```JS
apex.message.showPageSuccess( "Changes saved!" );
```
```JS
apex.message.showErrors([
    {
        type:       "error",
        location:   "page",
        message:    "Page error has occurred!",
        unsafe:     false
    }
]);
```
3. Voeg een dynamic action toe om een melding te tonen als de "Add to cart" knop ingedrukt wordt.
  - voeg een css class toe aan de knop: btn-add-to-cart