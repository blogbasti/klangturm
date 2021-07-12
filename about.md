---
layout: page
title: About
permalink: /about/
---

Hamburg hat jetzt einen Klangturm und er steht im zentrumsnahen und vielfach außergewöhnlichen Stadtteil Veddel. Im 1952 wiederaufgebauten Turm der ev.-luth. Immanuelkirche läuten keine Glocken mehr, jetzt ertönen Klänge aus Lautsprechern.
Die Klangprogramme von 12 Künstler*innen und einer Schulklasse dienen wie Glockenschläge der Signalisierung der Uhrzeit.
Zu hören sind die Klänge vom 01.07.2021 bis 31.07.2022 täglich außer montags jeweils von 8 bis 20 Uhr im Viertelstundentakt.

Gefördert vom Musikfonds e. V. mit Projektmitteln der Beauftragten der Bundesregierung für Kultur und Medien,
von der Gwärtler-Stiftung sowie dem Verfügungsfonds des Stadtteilbeirats Hamburg-Veddel.

Hamburg now has a sound tower, and it is located in Veddel, a district close to the city centre that is unusual in many ways. In the tower of the Lutheran Immanuelkirche, which was rebuilt in 1952, the bells no longer ring; now sounds come from loudspeakers.
The sound programmes by 12 artists and a school class serve like chimes to signal the time.
The sounds can be heard from 01.07.2021 to 31.07.2022 every day except Mondays from 8 am to 8 pm at quarter-hourly intervals.

Funded by Musikfonds e.V. by means of the Federal Government Commissioner for Culture and the Media,
by Gwärtler Foundation as well as by Verfügungsfonds of the Hamburg-Veddel district council.

{%- if site.data.sponsors.show.in_about -%}

<br/>
  <div class="footer-sponsors">
  <p class="sponsors-title">Gefördert von:</p>
  {%- assign sponsors = site.data.sponsors.members -%}
  {%- for sponsor in sponsors -%}
  <img src="{{ sponsor.logo | relative_url }}" alt="{{ sponsor.name }}" style="{{ sponsor.style }}"/>
  {%- endfor -%}
  </div>

{%- endif -%}
