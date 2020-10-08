# CSS
Met CSS veranderen we het uiterlijk van onze page.</br>Voor deze oefeningen gebruiken we hetzelfde "Quick Order" scherm.
1. Gebruik inline css om alle foto's in dit overzicht te verkleinen. (32X32px)
  - inspect element op een foto
  - welke classes horen bij zo'n tabel cell?
  - gebruik:
  ```CSS
  .t-Report-cell img
  {
    width: 32px;
    height: 32px;
  }
  ```
2. Gebruik de theme roller om je applicatie header en de navigatie een andere kleur te geven. Bijvoorbeeld: #373737
  - Voor de navigatiekleuren: gebruik de configuratie bij theme roller
  - Voor de header: inspect element op de header. Kijk in chrome developer tools bij styles en wijzig de kleur naar wens. Kopieer deze style naar "custom css" in de theme roller.
  - Sla deze wijzigingen op als nieuwe theme: Bijv Vista(ASW Workshop)
3. We willen nu aan de gebruiker duidelijk maken dat hij op de rijen van dit overzicht kan klikken en wel in veld Description.
  - Geef het overzicht een static ID: products
  - Voeg de inline css toe:
  ``` CSS
  #products tbody tr td[headers="PRODUCT_DESCRIPTION"] { 
    cursor: pointer; 
  }
  ```
4. Als het product besteld kan worden willen we dit met een groene kleur duidelijk maken, zoniet een rode tekst. Gebruik de standaard Universal Theme kleuren voor success en danger.
  - Wijzig de sql query voor het overzicht naar:
  ```SQL
  select p.product_id,
       p.product_name, 
       p.product_description, 
       p.category, 
       decode(p.product_avail, 'Y','Yes','N','No') product_avail,
       p.list_price,
       dbms_lob.getlength(p.product_image) image,
       case p.product_avail
       when 'Y' then 'u-success-text'
       when 'N' then 'u-danger-text'
       else null
       end  css_class_prod_avail
  from demo_product_info p
  ```
  - kolom css_class_prod_avail is een hidden column. Hiermee kunnen we dynamisch een CSS class meegeven.
  - Vul bij HTML Expression attribuut van kolom PRODUCT_AVAIL de volgende html in:
  ```HTML
  <b><span class="#CSS_CLASS_PROD_AVAIL#">#PRODUCT_AVAIL#</span></b>
  ```
