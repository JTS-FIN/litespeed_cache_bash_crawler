# litespeed_cache_bash_crawler
A simple script to crawl the pages defined in sitemap_index.xml, goal to warm the LiteSpeed Cache.

Since LiteSpeed Cache for WordPress keeps different variations it does multiple request to make
all cache variants warm. Currently 3 variants:
* Desktop
* Mobile
* Google Pagespeed/LightHouse

All with webp support. So it doesn't make cache version for browsers that don't support webp
(I assume those number of users using browsers without webp support are marginal these days).
