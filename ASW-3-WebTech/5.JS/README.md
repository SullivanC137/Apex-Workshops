# Javascript
Met javascript kunnen we het gedrag van de web page beinvloeden. In APEX doen we dat met dynamic actions.
1. Voeg een dynamic action toe om ervoor te zorgen dat het overzicht ververst nadat een product gewijzigd wordt.
  - dynamic action op de region, event: dialog closed
2. Plaats een knop "View Cart" op de region. Geef de knop een static id = view_cart. Voeg twee items toe: Total Price en Total Items.
3. Gebruik inspect element om de id's van deze objecten te vinden.
Voer een paar apex javascript api's uit op de items. Bijvoorbeeld: show, hide, enable, disable
https://docs.oracle.com/database/apex-5.1/AEAPI/apex-item.htm#AEAPI29446
```JS
// apex js api's
apex.item('P24_TOTAL_PRICE').hide();
apex.item( "P24_TOTAL_PRICE" ).setStyle( "color", "red" );
apex.item( "P24_TOTAL_PRICE" ).setValue(852);
$s("P24_TOTAL_PRICE",456);
$v("P24_TOTAL_PRICE");
// jQuery
$("#P24_TOTAL_PRICE").val();
// pure javascript
document.getElementById("P24_TOTAL_PRICE").value;
```
Probeer ook:
```JS
apex.message.showPageSuccess( "Changes saved!" );
apex.message.hidePageSuccess();
apex.message.showErrors([
    {
        type:       "error",
        location:   "page",
        message:    "Page error has occurred!",
        unsafe:     false
    }
]);
apex.message.showErrors([
    {
        type:       "error",
        location:   "page",
        message:    "Another error has occurred!",
        unsafe:     false
    }
]);
apex.message.clearErrors();
```
3. Voeg een dynamic action toe om een melding te tonen als de "Add to cart" knop ingedrukt wordt.
  - voeg een css class toe aan de knop in het overzicht: btn-add-to-cart
  - maak een dynamic action gebruik jQuery Selector als Selection Type en JQuery Selector: .btn-add-to-cart

4. Gebruik een apex collection om de items in de cart tijdelijk op te slaan. De uitdaging hier is om de product id mee te sturen. 1 van de manieren is om een data attribute toe te voegen. Wijzig de link text van de knop naar:
```HTML
<button type="button" title="Add to cart" aria-label="Add to cart" class="t-Button t-Button--noLabel t-Button--icon btn-add-to-cart data-product_id=#PRODUCT_ID# "><span aria-hidden="true" class="t-Icon fa fa-cart-plus "></span></button>
```
  - maak een hidden item: PRODUCT_ID (not protected)
  - vul deze item met de product id als je op de knop klikt, gebruik een javascript expression
  ```JS
  this.triggeringElement.dataset.product_id
  ```
  - gebruik deze waarde om een apex collection te vullen.
  ```SQL
declare
  l_query           varchar2(3000);
  l_collection_name varchar2(30) := 'CART_CONTENT';
  cursor c_product_price(b_prod_id in number)
  is
  select list_price from demo_product_info
  where product_id = b_prod_id
  ;
  l_list_price demo_product_info.list_price%type;
begin
  if NOT APEX_COLLECTION.COLLECTION_EXISTS (l_collection_name) then
  APEX_COLLECTION.CREATE_COLLECTION
    (p_collection_name => l_collection_name);
  end if;
  open c_product_price(:P24_PRODUCT_ID);
  fetch c_product_price into l_list_price;
  close c_product_price;
  APEX_COLLECTION.ADD_MEMBER
    (p_collection_name => l_collection_name,
     p_n001            => :P24_PRODUCT_ID,
     p_n002            => l_list_price
    );
end;
```
  - Toon een nette melding: "Item added to cart"
  - Check in session of de items succesvol zijn toegevoegd.

Extra opdrachten:
5. Voeg een knop toe om de data in de apex collection te verwijderen
6. Vul de velden Total Products en Total List Price nadat items zijn toegevoegd/verwijderd.
7. Creer een pop up modal page met de inhoud van de shopping cart. Deze Page verschijnt als je op View cart klikt.

