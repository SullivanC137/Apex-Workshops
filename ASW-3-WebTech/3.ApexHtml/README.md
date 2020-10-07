# HTML in APEX
In deze module gaan we dieper in op de HTML die gegenereert wordt door APEX, opnieuw mbv een classic report.</br>
Maak een scherm onder "Administration" en noem het: application objects: een scherm met een classic report met query:
```SQL
select p.product_id,
       p.product_name, 
       p.product_description, 
       p.category, 
       decode(p.product_avail, 'Y','Yes','N','No') product_avail,
       p.list_price
from demo_product_info p
```
Dit scherm heet "Quick Order" en hangt onder het "Orders" menu item.</br>
1. Zorg ervoor dat kolom product id een link naar scherm 6 is om de product details te bekijken/ aan te passen.
2. Bekijk met inspect element van chrome developer tools de source van de link
3. Voeg een kolom toe om de product foto te tonen door de query te veranderen naar:
```SQL
select p.product_id,
       p.product_name, 
       p.product_description, 
       p.category, 
       decode(p.product_avail, 'Y','Yes','N','No') product_avail,
       p.list_price,
       dbms_lob.getlength(p.product_image) image
from demo_product_info p
```
  - Vergeet niet om de kolom type te wijzigen naar "Display Image" en de attributen: table name, blob column en primary key column in te vullen.
5. Bekijk met inspect element de source van de foto en kijk of je de elementen kan identificeren.
6. We gaan nu een knop in het overzicht toevoegen. Voeg een virtual column (rechtermuisklik) toe.
  - deze extra kolom moet een link zijn met URL: javascript:void(0);
  - In de link text: 
  ```HTML
  <button type="button" title="Add to cart" aria-label="Add to cart" class="t-Button t-Button--noLabel t-Button--icon"><span aria-hidden="true" class="t-Icon fa fa-cart-plus"></span></button>
  ```
7. Bekijk met inspect element de source van de knop en kijk of je de elementen kan identificeren.
8. Vergelijk het overzicht met de interactive report op scherm 3. Bekijk ook de query. Welke verschillen kun je opmerken?