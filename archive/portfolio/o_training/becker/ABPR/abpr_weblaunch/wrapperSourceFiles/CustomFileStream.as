// File Stream Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/13/04
// Last Edit Date: 11/28/04
// *** create the File Stream Class ***************************
dynamic class CustomFileStream extends Object {
	// *** create class vars **********************************
	var fileUrl:String;
	var attachPath:MovieClip;
	var clipName:String;
	var fileWidth:Number;
	var fileHeight:Number;
	var xPos:Number;
	var yPos:Number;
	var streamFile:Boolean;
	var cacheFile:Boolean;
	var forcePlay:Boolean;
	var autoPlay:Boolean;
	var autoLoad:Boolean;
	var movieClipLoader:MovieClipLoader;
	var targetClip:MovieClip;
	var bandwidth:Number;
	var loadTime:Number;
	var loadTimeElapsed:Number;
	var frameRate;
	var startVolume:Number;
	var soundObject:Sound;
	var bufferTime:Number;
	var bufferInterval;
	var playState:String;
	var frameAdvanceAmount:Number = 8;
	var intervalList:Array;
	var noResize:Boolean;
	var videoResized:Boolean = false;
	var fileBytesLoaded:Number;
	var fileBytesTotal:Number;
	var framesTotal:Number;
	var depth:Number;
	// create class watcher object
	var watcherObject:Object;
	var auxWatcherObject:Object;
	// *** end class vars *************************************
	// *** create constructor *********************************
	public function CustomFileStream(fileUrl:String, attachPath:MovieClip, clipName:String, fileWidth:Number, fileHeight:Number, xPos:Number, yPos:Number, streamFile:Boolean, cacheFile:Boolean, forcePlay:Boolean, autoPlay:Boolean, autoLoad:Boolean, frameRate, startVolume, depth:Number, noResize:Boolean) {
		// init arrays and objects so they are specific to the class
		watcherObject = new Object();
		auxWatcherObject = new Object();
		intervalList = new Array();
		// force update vars
		setFileUrl(fileUrl);
		setAttachPath(attachPath);
		setClipName(clipName);
		setFileWidth(fileWidth);
		setFileHeight(fileHeight);
		setXPos(xPos);
		setYPos(yPos);
		setStreamFile(streamFile);
		setCacheFile(cacheFile);
		setForcePlay(forcePlay);
		setAutoPlay(autoPlay);
		setAutoLoad(autoLoad);
		setFrameRate(Number(frameRate));
		setStartVolume(startVolume);
		setDepth(depth);
		setNoResize(noResize);
		// create the new clip
		buildLoaderClip();
		// put in a blank place holder, resize it and load a new clip
		move(xPos, yPos);
		// create the movie clip loader class instance
		buildMovieClipLoader();
		// now load the clip and track progress if needed
		if (autoLoad == true) {
			loadNewMovie();
		}
	}
	// *** end constructor ************************************
	// *** create init ****************************************
	// *** end init *******************************************
	// *** create getters *************************************
	public function getFileUrl():String {
		return fileUrl;
	}
	public function getFileName():String {
		// gets the file name from a url string
		var tempList:Array = getFileUrl().split("/");
		var tempFileName:String = tempList[(tempList.length-1)];
		return tempFileName;
	}
	public function getAttachPath():MovieClip {
		return attachPath;
	}
	public function getClipName():String {
		return clipName;
	}
	public function getFileWidth():Number {
		return fileWidth;
	}
	public function getFileHeight():Number {
		return fileHeight;
	}
	public function getXPos():Number {
		return xPos;
	}
	public function getYPos():Number {
		return yPos;
	}
	public function getStreamFile():Boolean {
		return streamFile;
	}
	public function getCacheFile():Boolean {
		return Boolean(cacheFile);
	}
	public function getForcePlay():Boolean {
		return forcePlay;
	}
	public function getAutoPlay():Boolean {
		return autoPlay;
	}
	public function getAutoLoad():Boolean {
		return autoLoad;
	}
	public function getStartVolume():Number {
		return startVolume;
	}
	public function getMovieClipLoader():MovieClipLoader {
		return movieClipLoader;
	}
	public function getTargetClip():MovieClip {
		return targetClip;
	}
	public function getBandwidth():Number {
		return bandwidth;
	}
	public function getLoadTime():Number {
		return loadTime;
	}
	public function getNoResize():Boolean {
		return noResize;
	}
	public function getLoadTimeElapsed():Number {
		var loadTimeElapsed:Number = getTimer()-getLoadTime();
		return loadTimeElapsed;
	}
	public function getBytesTotal():Number {
		if (fileBytesTotal == null) {
			fileBytesTotal = getTargetClip().getBytesTotal();
			//fileBytesTotal = 0;
		}
		return fileBytesTotal;
	}
	public function getBytesLoaded():Number {
		if (fileBytesLoaded == null) {
			fileBytesLoaded = getTargetClip().getBytesLoaded();
			//fileBytesLoaded = 0;
		}
		return fileBytesLoaded;
	}
	public function getFramesLoaded():Number {
		return getTargetClip()._framesloaded;
	}
	public function getFramesTotal():Number {
		return getTargetClip()._totalframes;
	}
	public function getSoundLevel():Number {
		return getSoundObject.getVolume();
	}
	public function getSoundObject():Sound {
		return soundObject;
	}
	public function getCurrentFrame():Number {
		var currFrame:Number = getTargetClip()._currentframe;
		if (isNaN(currFrame)) {
			return 0;
		} else {
			return currFrame;
		}
	}
	public function getDuration():Number {
		return getFramesTotal()/getFrameRate();
	}
	public function getFrameRate():Number {
		return frameRate;
	}
	public function getFPSLoadRate():Number {
		var loadTime:Number = getLoadTimeElapsed()/1000;
		var framesLoaded:Number = getFramesLoaded();
		var loadRate:Number = Math.round(framesLoaded/loadTime);
		if (loadRate == Infinity || loadRate<0) {
			loadRate = 0;
		}
		return loadRate;
	}
	public function getBufferTime():Number {
		return bufferTime;
	}
	public function getPlayState():String {
		return playState;
	}
	public function getFrameAdvanceAmount():Number {
		return frameAdvanceAmount;
	}
	public function getIntervalList():Array {
		return intervalList;
	}
	public function getVideoResized():Boolean {
		return videoResized;
	}
	public function getDepth():Number {
		if (depth == null) {
			depth = getAttachPath().getNextHighestDepth();
		}
		return depth;
	}
	// *** end getters ****************************************
	// *** create setters *************************************
	public function setFileUrl(newVal:String) {
		fileUrl = newVal;
	}
	public function setAttachPath(newVal:MovieClip) {
		attachPath = newVal;
	}
	public function setClipName(newVal:String) {
		clipName = newVal;
	}
	public function setFileWidth(newVal:Number) {
		fileWidth = newVal;
	}
	public function setFileHeight(newVal:Number) {
		fileHeight = newVal;
	}
	public function setXPos(newVal:Number) {
		xPos = newVal;
	}
	public function setYPos(newVal:Number) {
		yPos = newVal;
	}
	public function setStreamFile(newVal:Boolean) {
		streamFile = newVal;
	}
	public function setCacheFile(newVal:Boolean) {
		cacheFile = newVal;
	}
	public function setForcePlay(newVal:Boolean) {
		forcePlay = newVal;
	}
	public function setAutoPlay(newVal:Boolean) {
		autoPlay = newVal;
	}
	public function setAutoLoad(newVal:Boolean) {
		autoLoad = newVal;
	}
	public function setFrameRate(newVal:Number) {
		frameRate = newVal;
	}
	public function setStartVolume(newVal:Number) {
		startVolume = newVal;
	}
	public function setMovieClipLoader(newVal:MovieClipLoader) {
		movieClipLoader = newVal;
	}
	public function setTargetClip(newVal:MovieClip) {
		targetClip = newVal;
	}
	public function setBytesTotal(newVal:Number) {
		fileBytesTotal = newVal;
	}
	public function setBytesLoaded(newVal:Number) {
		fileBytesLoaded = newVal;
	}
	public function setFramesTotal(newVal:Number) {
		framesTotal = newVal;
	}
	public function setNoResize(newVal:Boolean) {
		noResize = newVal;
	}
	public function setSize(width:Number, height:Number) {
		var tempClip:MovieClip = getTargetClip();
		tempClip._width = width;
		tempClip._height = height;
	}
	public function move(x:Number, y:Number) {
		var tempClip:MovieClip = getTargetClip();
		tempClip._x = x;
		tempClip._y = y;
	}
	public function setBufferTime(newVal:Number) {
		if (newVal == Infinity || newVal == null) {
			newVal = null;
		}
		if (getBytesLoaded() == getBytesTotal()) {
			newVal = 0;
		}
		bufferTime = newVal;
		// update the buffer time to the watcher object
		watcherObject.bufferTime = newVal;
		auxWatcherObject.bufferTime = newVal;
	}
	public function setBandwidth(bytesLoaded:Number, bytesTotal:Number) {
		// get the time spent loading
		var timeElpased:Number = getLoadTimeElapsed();
		// calc the bandwidth for Kbytes per second
		bandwidth = (bytesLoaded/1024)/(timeElpased/1000);
		if (bandwidth == Infinity || bandwidth<0) {
			bandwidth = 0;
		}
	}
	public function setLoadTime(newVal:Number) {
		loadTime = newVal;
	}
	public function setSoundLevel(newVal:Number) {
		getSoundObject().setVolume(newVal);
	}
	public function setPlayState(newVal:String) {
		playState = newVal;
		// update the watcher object
		watcherObject.playState = newVal;
		auxWatcherObject.playState = newVal;
	}
	public function setFrameAdvanceAmount(newVal:Number) {
		frameAdvanceAmount = newVal;
	}
	public function setIntervalList(newVal) {
		intervalList.push(newVal);
	}
	public function setVideoResized(newVal:Boolean) {
		videoResized = newVal;
	}
	public function setDepth(newVal:Number) {
		depth = newVal;
	}
	// *** end setters ****************************************
	// *** create utility functions ***************************
	public function buildLoaderClip() {
		// lets make an empty movie clip, and put a place holder in it.
		getAttachPath().createEmptyMovieClip(getClipName(), getDepth());
		var tempClip:MovieClip = getAttachPath()[getClipName()];
		// put the placeholder in it
		tempClip.beginFill(0xff0000, 0);
		tempClip.moveTo(0, 0);
		tempClip.lineTo(getFileWidth(), 0);
		tempClip.lineTo(getFileWidth(), getFileHeight());
		tempClip.lineTo(0, getFileHeight());
		tempClip.lineTo(0, 0);
		tempClip.endFill();
		// set the target clip
		setTargetClip(tempClip);
	}
	public function buildMovieClipLoader() {
		var myLoader:MovieClipLoader = new MovieClipLoader();
		var myLoaderListener:Object = new Object();
		myLoader.addListener(myLoaderListener);
		myLoaderListener.classLink = this;
		myLoaderListener.onLoadComplete = function() {
			// a fail safe error check to stop this interval
			this.classLink.clearBufferInterval();
		};
		myLoaderListener.onLoadStart = function() {
			// set the load time to detect the bandwidth
			this.classLink.setLoadTime(getTimer());
			// create an interval to calc the buffer time
			this.classLink.createBufferInterval();
			// update the watcherObject
			this.classLink.watcherObject.loadStarted = true;
			this.classLink.auxWatcherObject.loadStarted = true;
		};
		myLoaderListener.onLoadError = function(targetClip:MovieClip, errorCode:String) {
			// pass the error code to the wrapper gErrorReport
			gErrorReport(errorCode, targetClip._url);
			trace(errorCode+" at "+targetClip._url);
		};
		myLoaderListener.onLoadProgress = function(targetClip:MovieClip, loadedBytes:String, totalBytes:String) {
			// update the bytesloaded and bytes total
			// direct reference will break 1 frame loads
			this.classLink.setBytesLoaded(loadedBytes);
			this.classLink.setBytesTotal(totalBytes);
			this.classLink.setFramesTotal(targetClip._totalframes);
			// when frame one has loaded resize the clip
			var framesLoaded:Number = targetClip._framesloaded;
			if (framesLoaded>=1 & this.classLink.getVideoResized() != true) {
				var framesTotal:Number = targetClip._totalframes;
				var targetWidth:Number = this.classLink.getFileWidth();
				var targetHeight:Number = this.classLink.getFileHeight();
				var clipWidth:Number = targetClip._width;
				var clipHeight:Number = targetClip._height;
				var noResize:Boolean = this.classLink.getNoResize();
				if (noResize != true) {
					// resize this clip
					this.classLink.setSize(this.classLink.getFileWidth(), this.classLink.getFileHeight());
					// stop this condition
					if (targetWidth == clipWidth || targetHeight == clipHeight) {
						this.classLink.setVideoResized(true);
						// create the sound object for this clip
						this.classLink.createSoundObject();
						// turn the clip back on
						this.classLink.getTargetClip()._alpha = 100;
					}
				}
			}
			// update the watcherObject
			this.classLink.watcherObject.bytesLoaded = loadedBytes;
			this.classLink.auxWatcherObject.bytesLoaded = loadedBytes;
			// set the bandwidth
			this.classLink.setBandwidth(loadedBytes, totalBytes);
		};
		myLoaderListener.onLoadInit = function(targetClip:MovieClip) {
			// resize this clip once again if needed
			if (this.classLink.getVideoResized() != true) {
				this.classLink.createForceResizeInterval();
			} else {
				targetClip._alpha = 100;
			}
			// set the loaded var on the watcherObject to true
			this.classLink.watcherObject.loaded = true;
			this.classLink.auxWatcherObject.loaded = true;
			// set the bufferTime to 0
			this.classLink.setBufferTime(0);
		};
		// set the link to the clip loader to other functions
		setMovieClipLoader(myLoader);
	}
	public function loadNewMovie() {
		// set the watcher object loaded var to false
		watcherObject.loaded = false;
		auxWatcherObject.loaded = false;
		// check to see if the file needs to be cached or not
		if (getCacheFile() == true) {
			getMovieClipLoader().loadClip(getFileUrl(), getTargetClip());
		} else {
			getMovieClipLoader().loadClip(getFileUrl(), getTargetClip());
			//getMovieClipLoader().loadClip(getFileUrl()+"?&"+random(100000), getTargetClip());
		}
		// reset the loaded state
		wacherObject.loaded = false;
		// set the play state
		setPlayState("stopped");
		// create the frame tracking interval
		createFrameTrackingInterval();
		// turn this clip off untill resize
		getTargetClip()._alpha = 0;
	}
	public function createSoundObject() {
		soundObject = new Sound(getTargetClip());
		// set the sound level for the object
		setSoundLevel(getStartVolume());
	}
	public function calcBufferTime(bufferType:String, targetScope:Object) {
		// returns the buffer time based upon bandwidth or fps load rate
		if (bufferType == "fps") {
			var fpsLoadRate:Number = targetScope.getFPSLoadRate();
			var frameRate:Number = targetScope.getFrameRate();
			var framesLeft:Number = targetScope.getFramesTotal()-targetScope.getFramesLoaded();
			var currFrame:Number = targetScope.getCurrentFrame();
			var unplayedFrames:Number = targetScope.getFramesTotal()-currFrame;
			var loadTime:Number = framesLeft/fpsLoadRate;
			var playTimeRemaining:Number = unplayedFrames/frameRate;
			if (targetScope.getStreamFile() == true) {
				var bufferTime:Number = loadTime-playTimeRemaining;
			} else if (targetScope.getStreamFile() == false) {
				var bufferTime:Number = loadTime;
			}
		} else if (bufferType == "bps") {
			var duration:Number = targetScope.getDuration();
			var tempBytesLoaded:Number = targetScope.getBytesLoaded();
			var tempBytesTotal:Number = targetScope.getBytesTotal();
			var bytesLeft:Number = tempBytesTotal-tempBytesLoaded;
			var tempBandwidth:Number = targetScope.getBandwidth();
			var loadingTime:Number = (bytesLeft/1024)/tempBandwidth;
			if (targetScope.getStreamFile() == true) {
				var tempBufferTime:Number = loadingTime-duration;
			} else if (targetScope.getStreamFile() == false) {
				var tempBufferTime:Number = loadingTime;
			}
		}
		// set the buffer time
		targetScope.setBufferTime(tempBufferTime);
		// if the buffer time is less zero stop the buffer interval
		if (tempBufferTime<=0) {
			targetScope.clearBufferInterval();
			// is auto play is true start this file
			if (targetScope.getAutoPlay() == true) {
				targetScope.play();
			}
		} else if (tempBufferTime>0) {
			// force stop the movie
			targetScope.stop();
		}
	}
	public function createBufferInterval() {
		if (bufferInterval != null) {
			clearInterval(bufferInterval);
		}
		if (getFramesTotal()>1) {
			bufferInterval = setInterval(calcBufferTime, 250, "fps", this);
		} else {
			bufferInterval = setInterval(calcBufferTime, 250, "bps", this);
		}
		// add this interval to the interval list for easy cleanup
		setIntervalList(bufferInterval);
	}
	public function clearBufferInterval() {
		clearInterval(bufferInterval);
		// if auto play is true, play the file
		if (getAutoPlay() == true & getCurrentFrame()<2) {
			this.play();
		}
	}
	public function createForceResizeInterval() {
		if (getNoResize() != true) {
			// jump start this process
			forceResize(this);
			resizeInterval = setInterval(forceResize, 10, this);
			// add this interval to the interval list for easy cleanup
			setIntervalList(resizeInterval);
		} else {
			getTargetClip()._alpha = 100;
		}
	}
	public function clearForceResizeInterval() {
		clearInterval(resizeInterval);
	}
	public function forceResize(targetScope) {
		var tempClip:MovieClip = targetScope.getTargetClip();
		targetScope.setSize(targetScope.getFileWidth(), targetScope.getFileHeight());
		if (tempClip._width == targetScope.getFileWidth() || tempClip._height == targetScope.getFileHeight()) {
			targetScope.clearForceResizeInterval();
			// turn the visibility back on for the target clip
			targetScope.getTargetClip()._alpha = 100;
		}
	}
	public function createFrameTrackingInterval() {
		if (frameTrackInterval != null) {
			clearInterval(frameTrackInterval);
		}
		frameTrackInterval = setInterval(frameTrack, 33, this);
		// add this interval to the interval list for easy cleanup
		setIntervalList(frameTrackInterval);
	}
	public function frameTrack(targetScope:Object) {
		var currFrame:Number = targetScope.getCurrentFrame();
		var totalFrames:Number = targetScope.getFramesTotal();
		if (currFrame == totalFrames && currFrame != 0) {
			clearInterval(frameTrackInterval);
			targetScope.setPlayState("finished");
		}
	}
	// *** end utility functions ******************************
	// *** create controll functions **************************
	public function play() {
		getTargetClip().play();
		setPlayState("playing");
		clearControllIntervals();
		// for error checking turn the alpha back on
		getTargetClip()._alpha = 100;
	}
	public function stop() {
		// do not let the movie be talked to if frame one isnt there
		if (getFramesLoaded()>=1) {
			getTargetClip().stop();
			setPlayState("stopped");
			clearControllIntervals();
		}
	}
	public function fastForward(targetScope) {
		var nextAdvanceFrame:Number = targetScope.getCurrentFrame()+targetScope.getFrameAdvanceAmount();
		if (nextAdvanceFrame>=targetScope.getFramesTotal()) {
			nextAdvanceFrame = targetScope.getFramesTotal()-1;
		}
		targetScope.getTargetClip().gotoAndStop(nextAdvanceFrame);
	}
	public function triggerFastForward() {
		fastForwardInterval = setInterval(fastForward, 1000/getFrameRate(), this);
		// add this interval to the interval list for easy cleanup
		setIntervalList(fastForwardInterval);
		// set the play state
		setPlayState("playing");
	}
	public function rewind(targetScope) {
		var prevAdvanceFrame:Number = targetScope.getCurrentFrame()-targetScope.getFrameAdvanceAmount();
		if (prevAdvanceFrame<1) {
			prevAdvanceFrame = 1;
		}
		targetScope.getTargetClip().gotoAndStop(prevAdvanceFrame);
	}
	public function triggerRewind() {
		rewindInterval = setInterval(rewind, 1000/getFrameRate(), this);
		// add this interval to the interval list for easy cleanup
		setIntervalList(rewindInterval);
		// set the play state
		setPlayState("playing");
	}
	public function reset() {
		getTargetClip().gotoAndStop(1);
		setPlayState("stopped");
	}
	public function clearControllIntervals() {
		clearInterval(fastForwardInterval);
		clearInterval(rewindInterval);
	}
	// *** end controll functions *****************************
	// *** create cleanUp *************************************
	public function cleanUp() {
		var tempList:Array = getIntervalList();
		for (var i = 0; i<tempList.length; ++i) {
			var tempInterval = tempList[i];
			clearInterval(tempInterval);
		}
		// kill any downloads
		if (getTargetClip() != null) {
			getMovieClipLoader().unloadClip(getTargetClip());
			unloadMovie(getTargetClip());
		}
	}
	// *** end cleanUp ****************************************
}
// *** end File Stream Class **********************************
