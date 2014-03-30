# Ember boilerplate

Simple structure to get the tooling out of the way.

`npm i && grunt`

* `grunt`, the default task install dependencies with bower, build the
  app in development mode and connect to a livereload server.
* `grunt server` opens a browser and connect to a livereload server.
* `grunt build-dev` concatenates libraries and put them in
  `build/assets/vendor.js`, compiles ember templates, build one js
  file for the application using browserify and generate the `index.html`
  from the jade template.
* `grunt prod` do the same as `build-dev` but uses minified versions of the
  libraries and minify the application javascript and the index.
