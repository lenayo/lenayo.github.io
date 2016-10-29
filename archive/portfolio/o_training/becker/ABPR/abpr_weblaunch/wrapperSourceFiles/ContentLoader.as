// Content Loader Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/27/04
// Last Edit Date: 02/11/05
// *** content loader class *****************************************
dynamic class ContentLoader extends MovieClip {
	// *** create class vars ****************************************
	var firstRun:Boolean;
	var targetScope;
	var mediaClip:MovieClip;
	var mediaObject:Object;
	var interactionClip:MovieClip;
	var interactionObject:Object;
	var bgClip:MovieClip;
	var bgObject:Object;
	var preloaderClip:MovieClip;
	var preloaderBgColor:Number;
	var preloaderRemoved:Boolean;
	var controllerClip:MovieClip;
	var prevMediaUrl:String;
	var prevInteractionUrl:String;
	var prevBgUrl:String;
	// vars to be inherited from the root
	var mainPath:String;
	var mediaContent:String;
	var mediaXPos:String;
	var mediaYPos:String;
	var mediaWidth:String;
	var mediaHeight:String;
	var interactionContent:String;
	var interactionXPos:String;
	var interactionYPos:String;
	var interactionWidth:String;
	var interactionHeight:String;
	var bgContent:String;
	var bgXPos:String;
	var bgYPos:String;
	var bgWidth:String;
	var bgHeight:String;
	var stream:String;
	var frameRate:String;
	var cacheFile:String;
	var useMediaController:String;
	var useMediaControllerTimeReadOut:String;
	var mediaControllerXOffSet:String;
	var mediaControllerYOffSet:String;
	var mediaControllerXPadding:String;
	var symbolUpColor:String;
	var symbolOverColor:String;
	var symbolPressedColor:String;
	var controllBtnUpOutlineColor:String;
	var controllBtnOverOutlineColor:String;
	var controllBtnPressedOutlineColor:String;
	var controllBtnUpFillColor:String;
	var controllBtnOverFillColor:String;
	var controllBtnPressedFillColor:String;
	var scrubberBtnUpOutlineColor:String;
	var scrubberBtnOverOutlineColor:String;
	var scrubberBtnPressedOutlineColor:String;
	var scrubberBtnUpFillColor:String;
	var scrubberBtnOverFillColor:String;
	var scrubberBtnPressedFillColor:String;
	var scrubberBgOutlineColor:String;
	var scrubberBgFillColor:String;
	var loadProgressFillColor:String;
	var loadProgressOutlineColor:String;
	var timeReadOutColor:String;
	// play list vars
	var playListCounter:Number = 0;
	var playListLength:Number;
	// connect speed passed from shell loader "gConnectSpeed"
	var connectSpeed:String;
	// band width list is passed in from wrapper xml class
	var bandwidthList:Array;
	// *** end class vars *******************************************
	// *** create class constructor *********************************
	public function ContentLoader() {
		// set first run
		firstRun = false;
		// create global watchers for wrapper apps
		_root.gMediaFileWatcher = new Object();
		// create class link scope
		targetScope = this;
	}
	// *** end class constructor ************************************
	// *** create init **********************************************
	public function init(bandwidthArray:Array, newMainPath:String) {
		this.preloaderContainer_mc._width = 0;
		this.preloaderContainer_mc._height = 0;
		// always clean up
		cleanUpWachers();
		// set preloader removed to false
		setPreloaderRemoved(false);
		// set vars
		bandwidthList = bandwidthArray;
		mainPath = newMainPath;
		// set the class vars and then load the content
		mediaContent = _root.mediaContent;
		mediaXPos = _root.mediaXPos;
		mediaYPos = _root.mediaYPos;
		mediaWidth = _root.mediaWidth;
		mediaHeight = _root.mediaHeight;
		interactionContent = _root.interactionContent;
		interactionXPos = _root.interactionXPos;
		interactionYPos = _root.interactionYPos;
		interactionWidth = _root.interactionWidth;
		interactionHeight = _root.interactionHeight;
		bgContent = _root.bgContent;
		bgXPos = _root.bgXPos;
		bgYPos = _root.bgYPos;
		bgWidth = _root.bgWidth;
		bgHeight = _root.bgHeight;
		stream = _root.stream;
		frameRate = _root.frameRate;
		cacheFile = _root.cacheFile;
		// controller vars
		useMediaController = _root.useMediaController;
		useMediaControllerTimeReadOut = _root.useMediaControllerTimeReadOut;
		mediaControllerXOffSet = _root.mediaControllerXOffSet;
		mediaControllerYOffSet = _root.mediaControllerYOffSet;
		mediaControllerXPadding = _root.mediaControllerXPadding;
		symbolUpColor = _root.symbolUpColor;
		symbolOverColor = _root.symbolOverColor;
		symbolPressedColor = _root.symbolPressedColor;
		controllBtnUpOutlineColor = _root.controllBtnUpOutlineColor;
		controllBtnOverOutlineColor = _root.controllBtnOverOutlineColor;
		controllBtnPressedOutlineColor = _root.controllBtnPressedOutlineColor;
		controllBtnUpFillColor = _root.controllBtnUpFillColor;
		controllBtnOverFillColor = _root.controllBtnOverFillColor;
		controllBtnPressedFillColor = _root.controllBtnPressedFillColor;
		scrubberBtnUpOutlineColor = _root.scrubberBtnUpOutlineColor;
		scrubberBtnOverOutlineColor = _root.scrubberBtnOverOutlineColor;
		scrubberBtnPressedOutlineColor = _root.scrubberBtnPressedOutlineColor;
		scrubberBtnUpFillColor = _root.scrubberBtnUpFillColor;
		scrubberBtnOverFillColor = _root.scrubberBtnOverFillColor;
		scrubberBtnPressedFillColor = _root.scrubberBtnPressedFillColor;
		scrubberBgOutlineColor = _root.scrubberBgOutlineColor;
		scrubberBgFillColor = _root.scrubberBgFillColor;
		loadProgressFillColor = _root.loadProgressFillColor;
		loadProgressOutlineColor = _root.loadProgressOutlineColor;
		timeReadOutColor = _root.timeReadOutColor;
		// reset play list counter
		playListCounter = 0;
		// get the connect speed
		if (gConnectSpeed == null) {
			connectSpeed = "high";
		} else {
			connectSpeed = gConnectSpeed;
		}
		// now set the main path with the propper bandwidth path
		switch (connectSpeed) {
		case "high" :
			mainPath += bandwidthList[2];
			break;
		case "med" :
			mainPath += bandwidthList[1];
			break;
		case "low" :
			mainPath += bandwidthList[0];
			break;
		}
		// now init the correct content
		initBgContent();
		initBgWatcher();
	}
	public function checkBgSkip() {
		var fileUrl:String = mainPath+getParamIndex(bgContent);
		var arg1 = (_root.interactionContent == null || _root.interactionContent == "");
		var arg2 = (_root.mediaContent == null || _root.mediaContent == "");
		if (findFileName(fileUrl) == findFileName(prevBgUrl)) {
			var arg3 = true;
		} else {
			var arg3 = false;
		}
		if (arg1 == true & arg2 == true & arg3 == true) {
			// only the bg is the same, skip the file
			return true;
		} else {
			// cleanup everything
			return false;
		}
	}
	public function initBgContent() {
		// unwatch this object
		bgObject.watcherObject.unwatch("loaded");
		var fileUrl:String = mainPath+getParamIndex(bgContent);
		var clipName:String = "bgObject_mc";
		var attachPath = targetScope;
		var fileWidth:Number = Number(getParamIndex(bgWidth));
		var fileHeight:Number = Number(getParamIndex(bgHeight));
		var fileXPos:Number = Number(getParamIndex(bgXPos));
		var fileYPos:Number = Number(getParamIndex(bgYPos));
		var streamFile:Boolean = Boolean(getParamIndex(stream));
		var cacheFile:Boolean = Boolean(getParamIndex(cacheFile));
		var forcePlay:Boolean = true;
		var autoPlay:Boolean = true;
		var autoLoad:Boolean = true;
		var frameRate:Number = Number(getSpeedChoice(getParamIndex(this.frameRate)));
		var startVolume:Number = 100;
		var depth:Number = 10;
		// check to see if we need to load this object
		if (findFileName(fileUrl) != findFileName(prevBgUrl) && getParamIndex(bgContent) != null) {
			bgObject = new CustomFileStream(fileUrl, attachPath, clipName, fileWidth, fileHeight, fileXPos, fileYPos, streamFile, cacheFile, forcePlay, autoPlay, autoLoad, frameRate, startVolume, depth);
			// map the mediaClip
			bgClip = bgObject.getTargetClip();
			// create the preloader if needed
			createPreloader(940, 551, 0, 0, getPreloaderBgColor());
			// link the preloader the file stream class
			initPreloader(bgObject.watcherObject, bgObject);
			// set the prevBgUrl
			prevBgUrl = fileUrl;
		} else if (getParamIndex(bgContent) == null) {
			// unwatch this object
			bgObject.watcherObject.unwatch("loaded");
			bgObject.cleanUp();
			// skip this file and go to the interaction object
			initInteractionContent();
			initInteractionWatcher();
		} else if (findFileName(prevBgUrl) == findFileName(fileUrl)) {
			// skip this file and go to the interaction object
			initInteractionContent();
			initInteractionWatcher();
		}
	}
	public function initBgWatcher() {
		bgObject.watcherObject.watch("loaded", bgWatcherHandler, [this]);
	}
	public function bgWatcherHandler(propName:String, oldVal, newVal, userData:Array) {
		var targetScope:Object = userData[0];
		if (propName == "loaded") {
			if (newVal == true) {
				// to stop a loop back for cached files
				// make sure not to do this if a file
				// loads too fast
				if (targetScope.getPreloaderRemoved() == false) {
					// I don't know why I have to unwatch this var
					// but for some reason the watcher is shared in
					// all class instances?
					targetScope.bgObject.watcherObject.unwatch("loaded");
					// once the bg is loaded load the next clip
					targetScope.initInteractionContent();
					targetScope.initInteractionWatcher();
				}
			}
		}
	}
	public function initInteractionContent() {
		// unwatch this object
		interactionObject.watcherObject.unwatch("loaded");
		var fileUrl:String = mainPath+getParamIndex(interactionContent);
		var clipName:String = "interactionObject_mc";
		var attachPath = targetScope;
		var fileWidth:Number = Number(getParamIndex(interactionWidth));
		var fileHeight:Number = Number(getParamIndex(interactionHeight));
		var fileXPos:Number = Number(getParamIndex(interactionXPos));
		var fileYPos:Number = Number(getParamIndex(interactionYPos));
		var streamFile:Boolean = Boolean(getParamIndex(stream));
		var cacheFile:Boolean = Boolean(getParamIndex(cacheFile));
		var forcePlay:Boolean = true;
		var autoPlay:Boolean = true;
		var autoLoad:Boolean = true;
		var frameRate:Number = Number(getSpeedChoice(getParamIndex(this.frameRate)));
		var startVolume:Number = 100;
		var depth:Number = 11;
		// check to see if we need to load this object
		if (findFileName(prevInteractionUrl) != findFileName(fileUrl) && getParamIndex(interactionContent) != null) {
			interactionObject = new CustomFileStream(fileUrl, attachPath, clipName, fileWidth, fileHeight, fileXPos, fileYPos, streamFile, cacheFile, forcePlay, autoPlay, autoLoad, frameRate, startVolume, depth);
			// map the mediaClip
			interactionClip = interactionObject.getTargetClip();
			// create the preloader if needed
			createPreloader(940, 551, 0, 0, getPreloaderBgColor());
			// link the preloader the file stream class
			initPreloader(interactionObject.watcherObject, interactionObject);
		} else if (getParamIndex(interactionContent) == null) {
			// unwatch this object
			interactionObject.watcherObject.unwatch("loaded");
			interactionObject.cleanUp();
			// skip this file and go to the media object
			initMediaContent();
			initMediaWatcher();
		} else if (findFileName(prevInteractionUrl) == findFileName(fileUrl)) {
			// skip this file and go to the interaction object
			initMediaContent();
			initMediaWatcher();
		}
		// recored the previous interaction url  
		prevInteractionUrl = fileUrl;
	}
	public function initInteractionWatcher() {
		interactionObject.watcherObject.watch("loaded", interactionWatcherHandler, [this]);
	}
	public function interactionWatcherHandler(propName:String, oldVal, newVal, userData:Array) {
		var targetScope:Object = userData[0];
		if (propName == "loaded") {
			if (newVal == true) {
				// I don't know why I have to unwatch this var
				// but for some reason I do.
				targetScope.interactionObject.watcherObject.unwatch("loaded");
				// once the interaction is loaded load the next clip
				targetScope.initMediaContent();
				targetScope.initMediaWatcher();
			}
		}
	}
	public function initMediaContent(forceReplay:Boolean) {
		// for error checking remove all watchers
		mediaObject.watcherObject.unwatch("playState");
		mediaObject.watcherObject.unwatch("bufferTime");
		// set file stream vars
		var fileUrl:String = mainPath+getParamIndex(this.mediaContent);
		var clipName:String = "mediaObject_mc";
		var attachPath = targetScope;
		var fileWidth:Number = Number(getParamIndex(this.mediaWidth));
		var fileHeight:Number = Number(getParamIndex(this.mediaHeight));
		var fileXPos:Number = Number(getParamIndex(this.mediaXPos));
		var fileYPos:Number = Number(getParamIndex(this.mediaYPos));
		var streamFile:Boolean = Boolean(getParamIndex(this.stream));
		var cacheFile:Boolean = Boolean(getParamIndex(this.cacheFile));
		var useMediaController:Boolean = getParamIndex(this.useMediaController);
		var useMediaControllerTimeReadOut:Boolean = getParamIndex(this.useMediaControllerTimeReadOut);
		var forcePlay:Boolean = true;
		var autoPlay:Boolean = true;
		var autoLoad:Boolean = true;
		var frameRate:Number = Number(getSpeedChoice(getParamIndex(this.frameRate)));
		var startVolume:Number = 100;
		var depth:Number = 12;
		// check to see if we need to load this object
		if (findFileName(prevMediaUrl) != findFileName(fileUrl) && getParamIndex(mediaContent) != null || forceReplay == true) {
			mediaObject = new CustomFileStream(fileUrl, attachPath, clipName, fileWidth, fileHeight, fileXPos, fileYPos, streamFile, cacheFile, forcePlay, autoPlay, autoLoad, frameRate, startVolume, depth);
			// map the mediaClip
			mediaClip = mediaObject.getTargetClip();
			// create the preloader if needed
			// on first run mask everything, else mask
			// changing content only
			if (firstRun == false) {
				createPreloader(940, 551, 0, 0, getPreloaderBgColor());
			} else {
				createPreloader(fileWidth, fileHeight, fileXPos, fileYPos, getPreloaderBgColor());
			}
			// link the preloader the file stream class
			initPreloader(mediaObject.watcherObject, mediaObject);
			// attach the controller if needed
			if (useMediaController == "true" || useMediaController == true) {
				createController(fileWidth, fileHeight, fileXPos, fileYPos, useMediaControllerTimeReadOut);
			} else {
				removeControllerClip();
			}
			// set the auto cc text if it is in the xml
			gSetAutoCCText(getParamIndex(this.mediaContent));
		} else if (getParamIndex(mediaContent) == null) {
			// unwatch this object
			mediaObject.watcherObject.unwatch("loaded");
			mediaObject.cleanUp();
			// extra error checking to remove preloader
			removePreloader();
		} else if (findFileName(prevMediaUrl) == findFileName(fileUrl)) {
			// do nothing for now
		}
		// set the first run to true for propper  
		// preloader positioning
		firstRun = true;
		// record the previous media url
		prevMediaUrl = fileUrl;
	}
	public function initMediaWatcher() {
		mediaObject.watcherObject.watch("playState", mediaWatcherHandler, [this]);
		mediaObject.watcherObject.watch("bufferTime", mediaWatcherHandler, [this]);
		if (mediaObject.getBytesLoaded() == mediaObject.getBytesTotal() && mediaObject.getBytesTotal() != undefined) {
			// unwatch this
			mediaObject.watcherObject.unwatch("bufferTime");
			// remove the preloader
			removePreloader();
		}
	}
	public function mediaWatcherHandler(propName:String, oldVal, newVal, userData:Array) {
		var targetScope:Object = userData[0];
		if (propName == "playState") {
			if (newVal == "finished") {
				// set the watcher var
				_root.gMediaFileWatcher.finished = true;
				// set the curr file finished var
				var tempArray:Array = targetScope.mediaClip._url.split("/");
				_root.wrapperWatcherObject.currFileFinished = tempArray[(tempArray.length-1)];
				// once the file has finished playing
				// check the video playlist and see
				// if we need to play another file
				targetScope.checkPlayList();
			}
			if (newVal == "playing") {
				if (targetScope.getPreloaderRemoved() != true) {
					// remove the preloader
					targetScope.removePreloader();
				}
			}
		}
		if (propName == "bufferTime") {
			if (newVal<=0 && targetScope.mediaObject.getBytesLoaded() != undefined) {
				// unwatch this
				targetScope.mediaObject.watcherObject.unwatch("bufferTime");
				// remove the preloader
				targetScope.removePreloader();
			}
		}
	}
	// *** end init *************************************************
	// *** create getters *******************************************
	public function getSpeedChoice(speedChoiceList):Number {
		var tempList:Array = speedChoiceList.split("^");
		if (gSpeedChoiceIndex == null) {
			_global.gSpeedChoiceIndex = 0;
		}
		// return the correct frame rate choice  
		var choice:Number = Number(tempList[gSpeedChoiceIndex]);
		return choice;
	}
	public function getPlayListLength() {
		playListLength = mediaContent.split("|").length-1;
		return playListLength;
	}
	public function getPreloaderRemoved():Boolean {
		return preloaderRemoved;
	}
	public function getPreloaderBgColor():Number {
		if (preloaderBgColor == null) {
			preloaderBgColor = 0xffffff;
		}
		return preloaderBgColor;
	}
	public function getMediaObjectFileName() {
		return mediaObject.getFileName();
	}
	// *** end getters **********************************************
	// *** create setters *******************************************
	public function setPreloaderRemoved(newVal:Boolean) {
		preloaderRemoved = newVal;
	}
	public function setPreloaderBgColor(newVal:Number) {
		preloaderBgColor = newVal;
	}
	// *** end setters **********************************************
	// *** create utility functions *********************************
	public function createController(fileWidth:Number, fileHeight:Number, fileXPos:Number, fileYPos:Number, useTimeReadOut:Boolean) {
		// create the controller clip
		if (controllerClip == null) {
			controllerClip = this.attachMovie("controller_mc", "controller_mc", 19);
		}
		controllerClip._visible = true;
		// create the color list for the controller
		var colorList:Object = new Object();
		colorList.symbolUpColor = symbolUpColor;
		colorList.symbolOverColor = symbolOverColor;
		colorList.symbolPressedColor = symbolPressedColor;
		//
		colorList.controllBtnUpOutlineColor = controllBtnUpOutlineColor;
		colorList.controllBtnOverOutlineColor = controllBtnOverOutlineColor;
		colorList.controllBtnPressedOutlineColor = controllBtnPressedOutlineColor;
		colorList.controllBtnUpFillColor = controllBtnUpFillColor;
		colorList.controllBtnOverFillColor = controllBtnOverFillColor;
		colorList.controllBtnPressedFillColor = controllBtnPressedFillColor;
		//
		colorList.scrubberBtnUpOutlineColor = scrubberBtnUpOutlineColor;
		colorList.scrubberBtnOverOutlineColor = scrubberBtnOverOutlineColor;
		colorList.scrubberBtnPressedOutlineColor = 0x000000;
		colorList.scrubberBtnUpFillColor = scrubberBtnUpFillColor;
		colorList.scrubberBtnOverFillColor = scrubberBtnOverFillColor;
		colorList.scrubberBtnPressedFillColor = scrubberBtnPressedFillColor;
		//
		colorList.scrubberBgOutlineColor = scrubberBgOutlineColor;
		colorList.scrubberBgFillColor = scrubberBgFillColor;
		// 
		colorList.loadProgressFillColor = loadProgressFillColor;
		colorList.loadProgressOutlineColor = loadProgressOutlineColor;
		colorList.timeReadOutColor = timeReadOutColor;
		// init color list
		controllerClip.init(mediaObject, colorList, useTimeReadOut);
		// set the x and y
		controllerClip._x = fileXPos;
		controllerClip._y = fileYPos+fileHeight;
		// set the size and padding
		controllerClip.setWidth(fileWidth-Number(getParamIndex(mediaControllerXPadding)));
		controllerClip._x += Number(getParamIndex(mediaControllerXOffSet))+(Number(getParamIndex(mediaControllerXPadding))/2);
		controllerClip._y += Number(getParamIndex(mediaControllerYOffSet));
	}
	public function removeControllerClip() {
		controllerClip._visible = false;
		//controllerClip.removeMovieClip();
	}
	public function createPreloader(width:Number, height:Number, x:Number, y:Number, bgColor:Number) {
		var pClip:MovieClip = this.preloaderContainer_mc;
		if (pClip._width != width || pClip._height != height || pClip._x != x || pClip._y != y) {
			preloaderClip = this.createEmptyMovieClip("preloaderContainer_mc", 20);
			// get the temp clip
			var tempClip:MovieClip = preloaderClip;
			// draw the box
			tempClip.beginFill(bgColor, 100);
			tempClip.moveTo(0, 0);
			tempClip.lineTo(width, 0);
			tempClip.lineTo(width, height);
			tempClip.lineTo(0, height);
			tempClip.lineTo(0, 0);
			tempClip.endFill();
			// move the box
			tempClip._x = x;
			tempClip._y = y;
			tempClip._width = width;
			tempClip._height = height;
			// attach the preloader in the temp clip
			tempClip.attachMovie("preloader_mc", "preloader_mc", 10);
			// now center it
			var tempClip2:MovieClip = tempClip["preloader_mc"];
			tempClip2._x = (width/2)-(tempClip2._width/2);
			tempClip2._y = (height/2)-(tempClip2._height/2);
		} else {
			// remap the preloader clip
			preloaderClip = this.preloaderContainer_mc;
		}
	}
	public function removePreloader() {
		var easeType:Object = mx.transitions.easing.Strong.easeOut;
		var startAlpha:Number = 100;
		var endAlpha:Number = 0;
		var transDuration:Number = 0.5;
		var tween1 = new mx.transitions.Tween(preloaderClip, "_alpha", easeType, startAlpha, endAlpha, transDuration, true);
		tween1.targetScope = this;
		tween1.onMotionFinished = function() {
			targetScope.preloaderClip.unloadMovie();
		};
		// set the preloader removed to true
		setPreloaderRemoved(true);
	}
	public function initPreloader(watcherObject:Object, streamClass:Object) {
		preloaderClip.preloader_mc.init(watcherObject, streamClass);
	}
	public function getParamIndex(param:String) {
		// get an item from the play list and if the index
		// is past the length, then return the last item
		var tempArray:Array = param.split("|");
		var arrayLength:Number = tempArray.length-1;
		var index:Number = playListCounter;
		if (index<=arrayLength) {
			return tempArray[index];
		} else {
			return tempArray[arrayLength];
		}
	}
	public function checkPlayList() {
		var playListLength:Number = getPlayListLength();
		if (playListCounter<playListLength) {
			// increment the counter and init the media content
			playListCounter++;
			initMediaContent();
			initMediaWatcher();
		} else if (playListCounter == playListLength) {
			// at the end of the play list do this
			if (_root.autoBlinkNextBtn == "true") {
				_root.blinkNextBtn();
			}
		}
	}
	public function replayPlayList() {
		playListCounter = 0;
		initMediaContent(true);
		initMediaWatcher();
	}
	public function findFileName(newVal:String) {
		var tempList:Array = newVal.split("/");
		var tempFileName:String = tempList[(tempList.length-1)];
		return tempFileName;
	}
	// *** end utility functions ************************************
	// *** clean up *************************************************
	public function cleanUp() {
		cleanUpWatchers();
		playListCounter = 0;
		bgClip.unloadMovie();
		delete bgObject;
		delete bgClip;
		interactionClip.unloadMovie();
		delete interactionObject;
		delete interactionClip;
		mediaClip.unloadMovie();
		delete mediaObject;
		delete mediaClip;
		preloaderClip.unloadClip();
		delete preloaderClip;
		// clean up the controller
		controllerClip.removeMovieClip();
		delete controllerClip;
		// remove the prevBgUrl, fileUrl
		prevMediaUrl = null;
		prevBgUrl = null;
		//fileUrl = null;
		// reset firstRun
		firstRun = false;
	}
	public function cleanUpWatchers() {
		bgObject.cleanUp();
		bgObject.watcherObject.unwatch("loaded");
		interactionObject.cleanUp();
		interactionObject.watcherObject.unwatch("loaded");
		mediaObject.cleanUp();
		mediaObject.watcherObject.unwatch("playState");
		mediaObject.watcherObject.unwatch("bufferTime");
	}
	// *** end clean up *********************************************
}
// *** end content loader class
