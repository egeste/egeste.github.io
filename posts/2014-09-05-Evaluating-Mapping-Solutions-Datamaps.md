Evaluating Mapping Solutions - Datamaps
=======================================

One of the more difficult tasks in data visualization is dealing with maps. Not having the mathematical background in calculus and trigonometry can make this task seem almost impossible, and while there are are tons of fantastic libraries that make this task easier, doing anything custom requires some deep diving.

In this post I will be evaluating [Datamaps](http://datamaps.github.io/), a chloropleth rendering utility based on the beautiful d3. The goal is to create a "hitmap" to display the current user's inferred location as well as update to show the location of new visitors in real time. I have not yet found an analytics API suitable for this task, but first thing's first - we need a map.

Getting things off the ground
-----------------------------

First, let's load all our libs into the Oraculum container to make them easily accessible in the same fashion we do in Oraculum-core: [cat /coffee/libs.coffee](#!cat /coffee/libs.coffee). To render the map, we'll create `HitmapComposer.ControllerMixin` to compose `Hitmap.View` after the `beforeAction` of our `Index.Controller`, as can be seen by executing [cat /coffee/controllers/mixins/hitmap-composer.coffee](#!cat /coffee/controllers/mixins/hitmap-composer.coffee).
