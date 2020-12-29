# OSMUK Walkers Map

A possible OSMUK walkers' map, implemented using [Tangram](https://github.com/tangrams/tangram). Just a very basic implementation at the moment, with a basic "Landranger-like" style and no attempt at optimisation or caching (for now...), but even still, recent developments in [PostGIS](https://postgis.net) means that a rough-and-ready MVT tile server with multiple layer support can be written in under 60 lines.

## Developing

Developers wanted! To turn this into a really nice map it would be great to get input from expert cartographers, and of course to turn this from a proof-of-concept into a full site, web designers and UX experts are needed. Or, just contribute to the client- or server-side code! PRs gladly accepted.

See the intended features list below for ideas of what you can work on.

## Intended features

These are the intended features of a "version 1.0", obviously few of these are implemented just yet, hence the call for contributions!

My vision is to produce something like [Freemap Slovakia](https://freemap.sk).

- Cartography optimised for countryside walking and hiking, highlighting the unique features of the England and Wales countryside access system (rights of way types, permissive paths, access land, etc) as well as features such as stiles, gates, field boundaries etc.
- A user-friendly and appealing interface.
- View information about points of interest when clicked, for example, does a pub offer real ale? What are the opening times of a cafe? Information about a viewpoint or site of historical interest. Live train or bus times from stations or bus stops. And so on...
- Ability to add, edit and delete notes of interest to walkers, such as nice views, interesting nature and wildlife, path blockages, direction-finding, muddy or overgrown paths, problem animals, etc. 
- Add and view photos.
- Report problems to councils, perhaps via FixMyStreet.
- 3D topographical view. This will be relatively straightforward thanks to software such as [A-Frame Tangram Terrain Component](https://www.npmjs.com/package/aframe-tangram-terrain-component).
- Anything else? Please create an issue.

## What's needed

To work on the code you'll need an environment with:

- Node.js 14+ 
- Postgres and PostGIS 3+
- An OSM database populated with [osm2pgsql](https://osm2pgsql.org)

Tangram is linked from a CDN, so does not need to be installed.

## Working demo

A working demo is available [here](http://35.177.54.109). It covers only West Sussex, Hampshire, Wiltshire, Surrey, Buckinghamshire and Cumbria. No search facility as yet but you can supply `lat` and `lon` query string variables and it will locate to that position.

## Thanks!

Thanks to OSMUK for providing server space to host the demo.
