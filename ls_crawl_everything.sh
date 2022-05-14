#!/bin/bash

# Does simple curl calls to warm the Litespeed Cache with different
# variants (webp, ismobile, lighthouse)
# Support WordPress Yoast sitemap format atleast (I don't know how
# common this structure is elsewhere)

if [[ $# -eq 0 ]] ; then
    echo "run ls_crawl_everyhing https://example.com/sitemap_index.xml"
    exit 0
fi

cache_page() {
    echo "Caching $1 for desktop browser"
    curl -s -o /dev/null -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" $1

    echo "Caching $1 for pagespeed"
    curl -s -o /dev/null -H "user-agent: Mozilla/5.0 (Linux; Android 7.0; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4695.0 Mobile Safari/537.36 Chrome-Lighthouse" -H "*/*" -H "Accept-language: en-US" $1
    
    echo "Caching $1 for iPhone"
    curl -s -o /dev/null -H "user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 15_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" -H "Accept-language: en-GB,en;q=0.9" $1
}

sitemaps=$(curl -s $1 | awk -v FS="(<loc>|</loc>)" '{print $2}')

for sitemap in $sitemaps
do
    urls=$(curl -s $sitemap | awk -v FS="(<loc>|</loc>)" '{print $2}')
    for url in $urls
    do
        cache_page $url
    done
done