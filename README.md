# OSMUK Walkers Map

A possible OSMUK walkers' map, implemented using [Tangram](https://github.com/tangrams/tangram). Just a very basic implementation at the moment, with a basic "Landranger-like" style and no attempt at optimisation or caching (for now...), but even still, recent developments in [PostGIS](https://postgis.net) means that a rough-and-ready MVT tile server with multiple layer support can be written in under 60 lines.

## Developing

Developers wanted! To turn this into a really nice map it would be great to get input from expert cartographers, and of course to turn this from a proof-of-concept into a full site, web designers and UX experts are needed. Or, just contribute to the client- or server-side code! PRs gladly accepted.

## What's needed

To work on the code you'll need an environment with:

- Web server
- PHP
- Postgres and PostGIS 3+
- An OSM database populated with [osm2pgsql](https://osm2pgsql.org)

Tangram is linked from a CDN, so does not need to be installed.

## Working demo

A working demo is available [here](http://35.177.54.109). It covers only West Susex, Hampshire, Wiltshire, Surrey, Buckinghamshire and Cumbria. No search facility as yet but you can supply `lat` and `lon` query string variables and it will locate to that position.

## Thanks!

Thanks to OSMUK for providing server space to host the demo.
