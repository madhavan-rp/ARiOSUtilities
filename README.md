Purpose:
--------

ARiOSUtilities contains a number of targets for building static libraries with
some classes that we've found helpful. Some of the classes may appear client or
application specific. We've tried to make things as reusable as possible.

Building:
----------

All of the targets within the ARiOSUtilities project are ARC based. You will
need an ARC compatible compiler. The current settings are designed to use the
LLVM compiler available with the most recent release of XCode.

Submodules:
-----------------

One target (libARHelpers.a) within ARiOSUtilities depends on libGoogleAnalytics.a
which is provided by Google. It has been included as a submodule.

In order to build libARHelpers, you will need to initialize and update the
submodules.

	cd /path/to/ARiOSUtilities
	git submodule init
	git submodule update

Credits:
--------
ARiOSUtilities includes ideas/code from

* [Google](http://google.com)
* [Matthew Campbell](http://howtomakeiphoneapps.com)
* [Trevor Harmon](http://vocaro.com/trevor/blog/)
* [MGTwitterEngine](https://github.com/mattgemmell/MGTwitterEngine) by [Matt Gemmell](https://github.com/mattgemmell)