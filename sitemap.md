---
title: Site map
layout: about
permalink: sitemap.html
---

<!-- html comment, it's iterating the non post content only -->


{% for tag in page.tags %}
  <h3>  {{ tag }} </h3>
{% endfor %}


#### Static files

{% for file in site.static_files %}
  {% unless file.path contains 'schema-plugins' %}
    {% if file.path contains 'mcp' %}
- [{{ file.path }}]({{ file.path }})
    {% endif %}
  {% endunless %}
{% endfor %}


