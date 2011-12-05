Purpose:
--------

ARiOSUtilities contains a number of targets for building static libraries with
some classes that we've found helpful. Some of the classes may appear client or
application specific. We've tried to make things as reusable as possible.

Building/Linking/Adding to your project:
----------

All of the targets within the ARiOSUtilities project are ARC based. You will
need an ARC compatible compiler. The current settings are designed to use the
LLVM compiler available with the most recent release of XCode.

There are a few steps to get your project to build and link the libraries.

* Add the ARiOSUtilities.xcodeproj file to your Xcode project
* Add the libraries that you would like to use to Build Phases -> Target Dependencies in your project's project file
* Add the libraries that you would like to use to Build Phases -> Link Binary With Libraries in your project's project file
* Add $(BUILT\_PRODUCTS\_DIR)/../ARiOSUtilities and $(BUILT\_PRODUCTS\_DIR)/../../ARiOSUtilities to the Header Search Paths section of your project file

Dependencies:
-----------------

libARGoogleAnalytics.a within ARiOSUtilities depends on libGoogleAnalytics.a which is provided by Google. libGoogleAnalytics.a has been included as a submodule.

In order to build libARGoogleAnalytics, you will need to initialize and update the submodules.

	cd /path/to/ARiOSUtilities
	git submodule init
	git submodule update

libGoogleAnalytics.a has additional dependencies on libsqlite3.dylib and CFNetwork.framework. Add them to Build Phases -> Link Binary With Libraries in your project's project file.

libARHelpers.a within ARiOSUtilities depends on AudioToolbox.framework. Add it to Build Phases -> Link Binary With Libraries in your project's project file.

Credits:
--------
ARiOSUtilities includes ideas/code from

* [Google](http://google.com)
* [Matthew Campbell](http://howtomakeiphoneapps.com)
* [Trevor Harmon](http://vocaro.com/trevor/blog/)
* [MGTwitterEngine](https://github.com/mattgemmell/MGTwitterEngine) by [Matt Gemmell](https://github.com/mattgemmell)