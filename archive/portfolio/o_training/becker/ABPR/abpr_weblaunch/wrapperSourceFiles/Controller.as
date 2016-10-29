// Controller Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 01/02/05
// Last Edit Date: 01/02/05
// *** create the Controller Class ***************************
dynamic class Controller extends MovieClip {
	// *** create class vars *********************************
	var symbolUpColor:Number;
	var symbolOverColor:Number;
	var symbolPressedColor:Number;
	//
	var controllBtnUpOutlineColor:Number;
	var controllBtnOverOutlineColor:Number;
	var controllBtnPressedOutlineColor:Number;
	var controllBtnUpFillColor:Number;
	var controllBtnOverFillColor:Number;
	var controllBtnPressedFillColor:Number;
	//
	var scrubberBtnUpOutlineColor:Number;
	var scrubberBtnOverOutlineColor:Number;
	var scrubberBtnPressedOutlineColor:Number;
	var scrubberBtnUpFillColor:Number;
	var scrubberBtnOverFillColor:Number;
	var scrubberBtnPressedFillColor:Number;
	//
	var scrubberBgOutlineColor:Number;
	var scrubberBgFillColor:Number;
	// 
	var loadProgressFillColor:Number;
	var loadProgressOutlineColor:Number;
	//
	var targetClass:Object;
	var colorList:Object;
	//
	var sliderPercent:Number;
	// graphic objects
	var rrBtn:MovieClip;
	var playBtn:MovieClip;
	var ffBtn:MovieClip;
	var scrubber:MovieClip;
	var sBtn:MovieClip;
	var sArea:MovieClip;
	var sLoadOutline:MovieClip;
	var sLoadBar:MovieClip;
	var sFill:MovieClip;
	var sOutline:MovieClip;
	var timeReadOut:TextField;
	// interval list for easy clean up
	var intervalList:Array;
	var timeTrackInterval;
	// event vars
	var pressed:Boolean;
	var useTimeReadOut:Boolean;
	// *** end class vars ************************************
	// *** create constructor ********************************
	public function Controller() {
		// map mc objects
		rrBtn = this.rrBtn_mc;
		playBtn = this.playBtn_mc;
		ffBtn = this.ffBtn_mc;
		scrubber = this.scrubber_mc;
		sBtn = scrubber.scrubberBtn_mc;
		sArea = scrubber.area_mc;
		sLoadOutline = this.scrubber.loadOutline_mc;
		sLoadBar = this.scrubber.loadProgress_mc;
		sFill = this.scrubber.fill_mc;
		timeReadOut = this.time_txt;
		sOutline = this.scrubber.outline_mc;
		// init the inteval list
		intervalList = new Array();
		// set the clean up trigger
		this.onUnload = function() {
			this.cleanUp();
		};
	}
	// *** end constructor ***********************************
	// *** create init ***************************************
	public function init(classLink:Object, newColorList:Object, newUseTimeReadOut:Boolean) {
		// record the class link and color list
		targetClass = classLink;
		if (colorList == null) {
			colorList = newColorList;
			// init the color objects
			colorObject(rrBtn.outline_mc, getControllBtnUpOutlineColor());
			colorObject(rrBtn.fill_mc, getControllBtnUpFillColor());
			colorObject(rrBtn.symbol_mc, getSymbolUpColor());
			colorObject(playBtn.outline_mc, getControllBtnUpOutlineColor());
			colorObject(playBtn.fill_mc, getControllBtnUpFillColor());
			colorObject(playBtn.symbol_mc, getSymbolUpColor());
			colorObject(ffBtn.outline_mc, getControllBtnUpOutlineColor());
			colorObject(ffBtn.fill_mc, getControllBtnUpFillColor());
			colorObject(ffBtn.symbol_mc, getSymbolUpColor());
			colorObject(sBtn.outline_mc, getScrubberBtnUpOutlineColor());
			colorObject(sBtn.fill_mc, getScrubberBtnUpFillColor());
			colorObject(sLoadOutline, getLoadProgressOutlineColor());
			colorObject(sLoadBar, getLoadProgressFillColor());
			colorObject(sOutline, getScrubberBgOutlineColor());
			colorObject(sFill, getScrubberBgFillColor());
			colorObject(timeReadOut, getTimeReadOutColor());
		}
		// create the btn events
		createBtnEvents();
		// create class watcher
		createClassWatcher(targetClass);
		// set the useTimeReadOut
		useTimeReadOut = newUseTimeReadOut;
	}
	// *** end init ******************************************
	// *** create getters ************************************
	public function getSymbolUpColor():Number {
		return colorList.symbolUpColor;
	}
	public function getSymbolOverColor():Number {
		return colorList.symbolOverColor;
	}
	public function getSymbolPressedColor():Number {
		return colorList.symbolPressedColor;
	}
	public function getControllBtnUpOutlineColor():Number {
		return colorList.controllBtnUpOutlineColor;
	}
	public function getControllBtnOverOutlineColor():Number {
		return colorList.controllBtnOverOutlineColor;
	}
	public function getControllBtnPressedOutlineColor():Number {
		return colorList.controllBtnPressedOutlineColor;
	}
	public function getControllBtnUpFillColor():Number {
		return colorList.controllBtnUpFillColor;
	}
	public function getControllBtnOverFillColor():Number {
		return colorList.controllBtnOverFillColor;
	}
	public function getControllBtnPressedFillColor():Number {
		return colorList.controllBtnPressedFillColor;
	}
	public function getScrubberBtnUpOutlineColor():Number {
		return colorList.scrubberBtnUpOutlineColor;
	}
	public function getScrubberBtnOverOutlineColor():Number {
		return colorList.scrubberBtnOverOutlineColor;
	}
	public function getScrubberBtnPressedOutlineColor():Number {
		return colorList.scrubberBtnPressedOutlineColor;
	}
	public function getScrubberBtnUpFillColor():Number {
		return colorList.scrubberBtnUpFillColor;
	}
	public function getScrubberBtnOverFillColor():Number {
		return colorList.scrubberBtnOverFillColor;
	}
	public function getScrubberBtnPressedFillColor():Number {
		return colorList.scrubberBtnPressedFillColor;
	}
	public function getScrubberBgOutlineColor():Number {
		return colorList.scrubberBgOutlineColor;
	}
	public function getScrubberBgFillColor():Number {
		return colorList.scrubberBgFillColor;
	}
	public function getLoadProgressFillColor():Number {
		return colorList.loadProgressFillColor;
	}
	public function getLoadProgressOutlineColor():Number {
		return colorList.loadProgressOutlineColor;
	}
	public function getTimeReadOutColor():Number {
		return colorList.timeReadOutColor;
	}
	public function getFramesLoaded():Number {
		return targetClass.getFramesLoaded();
	}
	public function getFramesTotal():Number {
		return targetClass.getFramesTotal();
	}
	public function getPercentLoaded():Number {
		return getFramesTotal()/getFramesLoaded();
	}
	public function getSliderPercent():Number {
		return sliderPercent;
	}
	public function getUseTimeReadOut():Boolean {
		return useTimeReadOut;
	}
	// *** end getters ***************************************
	// *** create setters ************************************
	public function setSliderPercent(newVal:Number) {
		sliderPercent = tempPercent;
	}
	public function setPlayBtnState(newVal:String) {
		if (newVal == "playing") {
			this.playBtn.gotoAndStop("play");
		} else if (newVal == "stopped") {
			this.playBtn.gotoAndStop("pause");
		}
	}
	public function setPressedState(newVal:Boolean) {
		if (newVal == true) {
			// stop the file stream class
			targetClass.stop();
		} else if (newVal == false) {
			// clear out the calc drag interval
			clearInterval(this.sliderInterval);
			// tell the file to play again
			targetClass.play();
		}
		pressed = newVal;
	}
	// *** end setters ***************************************
	// *** create btn events *********************************
	public function createBtnEvents() {
		//
		rrBtn.onPress = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnPressedOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnPressedFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolPressedColor());
			// trigger rewind
			this._parent.targetClass.triggerRewind();
		};
		rrBtn.onRelease = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnOverOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnOverFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolOverColor());
			// tell the movie to play
			this._parent.targetClass.play();
		};
		rrBtn.onReleaseOutside = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUpOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
			// tell the movie to play
			this._parent.targetClass.play();
		};
		rrBtn.onRollOver = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnOverOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnOverFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolOverColor());
		};
		rrBtn.onRollOut = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUpOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
		};
		//
		playBtn.onPress = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnPressedOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnPressedFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolPressedColor());
		};
		playBtn.onRelease = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUplineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
			// toggle the play state
			this._parent.togglePlayState();
		};
		playBtn.onReleaseOutside = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUpOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
		};
		playBtn.onRollOver = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnOverOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnOverFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolOverColor());
		};
		playBtn.onRollOut = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUpOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
		};
		//
		ffBtn.onPress = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnPressedOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnPressedFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolPressedColor());
			// trigger fast forward
			this._parent.targetClass.triggerFastForward();
		};
		ffBtn.onRelease = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnOverOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnOverFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolOverColor());
			// tell the movie to play
			this._parent.targetClass.play();
		};
		ffBtn.onReleaseOutside = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUpOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
			// tell the movie to play
			this._parent.targetClass.play();
		};
		ffBtn.onRollOver = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnOverOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnOverFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolOverColor());
		};
		ffBtn.onRollOut = function() {
			this._parent.colorObject(this.outline_mc, this._parent.getControllBtnUpOutlineColor());
			this._parent.colorObject(this.fill_mc, this._parent.getControllBtnUpFillColor());
			this._parent.colorObject(this.symbol_mc, this._parent.getSymbolUpColor());
		};
		//
		sBtn.onPress = function() {
			this._parent._parent.colorObject(this.outline_mc, this._parent._parent.getScrubberBtnPressedOutlineColor());
			this._parent._parent.colorObject(this.fill_mc, this._parent._parent.getScrubberBtnPressedFillColor());
			// set this pressed state to true
			this._parent._parent.setPressedState(true);
			// stop tracking the play head
			this._parent._parent.clearTrackingInterval();
			// still track the time
			this._parent._parent.createTimeTrackInterval();
			// start drag
			this._parent._parent.dragObject(this, this._parent._parent.sArea);
		};
		sBtn.onRelease = function() {
			this._parent._parent.colorObject(this.outline_mc, this._parent._parent.getScrubberBtnOverOutlineColor());
			this._parent._parent.colorObject(this.fill_mc, this._parent._parent.getScrubberBtnOverFillColor());
			// stop drag
			stopDrag();
			clearInterval(this._parent._parent.sliderInterval);
			// set this pressed state to false
			this._parent._parent.setPressedState(false);
		};
		sBtn.onReleaseOutside = function() {
			this._parent._parent.colorObject(this.outline_mc, this._parent._parent.getScrubberBtnUpOutlineColor());
			this._parent._parent.colorObject(this.fill_mc, this._parent._parent.getScrubberBtnUpFillColor());
			// stop drag
			stopDrag();
			clearInterval(this._parent._parent.sliderInterval);
			// set this pressed state to false
			this._parent._parent.setPressedState(false);
		};
		sBtn.onRollOver = function() {
			this._parent._parent.colorObject(this.outline_mc, this._parent._parent.getScrubberBtnOverOutlineColor());
			this._parent._parent.colorObject(this.fill_mc, this._parent._parent.getScrubberBtnOverFillColor());
		};
		sBtn.onRollOut = function() {
			this._parent._parent.colorObject(this.outline_mc, this._parent._parent.getScrubberBtnUpOutlineColor());
			this._parent._parent.colorObject(this.fill_mc, this._parent._parent.getScrubberBtnUpFillColor());
		};
		//
		sArea.onPress = function() {
			// move the btn
			var tempBtn:MovieClip = this._parent._parent.sBtn;
			tempBtn._x = this._parent._xmouse-(tempBtn._width/2);
			// set this pressed state to true
			this._parent._parent.setPressedState(true);
			// stop tracking the play head
			this._parent._parent.clearTrackingInterval();
			// still track the time
			this._parent._parent.createTimeTrackInterval();
			// drag the play head
			this._parent._parent.dragObject(tempBtn, this);
		};
		sArea.onRelease = function() {
			stopDrag();
			clearInterval(this._parent._parent.sliderInterval);
			// set this pressed state to false
			this._parent._parent.setPressedState(false);
		};
		sArea.onReleaseOutside = function() {
			stopDrag();
			clearInterval(this._parent._parent.sliderInterval);
			// set this pressed state to false
			this._parent._parent.setPressedState(false);
		};
	}
	// *** end btn events ************************************
	// *** create utility functions **************************
	public function togglePlayState() {
		var currPlayState:String = targetClass.getPlayState();
		if (currPlayState == "playing") {
			targetClass.stop();
		} else if (currPlayState == "stopped") {
			targetClass.play();
		}
	}
	public function createClassWatcher(targetClass:Object) {
		targetClass.auxWatcherObject.watch("playState", checkPlayState, [this]);
		targetClass.auxWatcherObject.watch("bytesLoaded", checkPlayState, [this]);
		targetClass.auxWatcherObject.watch("loaded", checkPlayState, [this]);
	}
	public function checkPlayState(propName:String, oldVal, newVal, argsList:Array) {
		var targetScope:MovieClip = argsList[0];
		if (propName == "playState") {
			switch (newVal) {
			case "playing" :
				targetScope.setPlayBtnState("playing");
				targetScope.createTrackingInterval();
				targetScope.createTimeTrackInterval();
				break;
			case "stopped" :
				targetScope.setPlayBtnState("stopped");
				targetScope.clearTrackingInterval();
				targetScope.clearTimeTrackInterval();
				break;
			case "finished" :
				targetScope.setPlayBtnState("stopped");
				targetScope.clearTrackingInterval();
				targetScope.clearTimeTrackInterval();
				// set the trackPlayHead
				targetScope.trackPlayHead(targetScope);
				break;
			}
		}
		if (propName == "bytesLoaded") {
			targetScope.calcDownload();
		}
		if (propName == "loaded") {
			if (newVal == true) {
				targetScope.calcDownload();
			}
		}
	}
	public function createTimeTrackInterval() {
		if (this.timeTrackInterval != null) {
			clearInterval(this.timeTrackInterval);
		}
		this.timeTrackInterval = setInterval(timeTrack, 100, this);
		// add this interval to the list for easy clean up on unload
		this.intervalList.push(this.timeTrackInterval);
	}
	public function clearTimeTrackInterval() {
		clearInterval(this.timeTrackInterval);
	}
	public function timeTrack(targetScope) {
		var currFrame:Number = targetScope.targetClass.getCurrentFrame();
		var framesTotal:Number = targetScope.targetClass.getFramesTotal();
		var frameRate:Number = targetScope.targetClass.getFrameRate();
		var secondsElapsed:Number = Math.floor(currFrame/frameRate);
		var minutesElapsed:Number = Math.floor(secondsElapsed/60);
		var secondsRemainder:Number = secondsElapsed-(60*minutesElapsed);
		var totalSeconds:Number = Math.floor(framesTotal/frameRate);
		var totalMinutes:Number = Math.floor(totalSeconds/60);
		var totalSecondsRemainder:Number = totalSeconds-(60*totalMinutes);
		var cS:String;
		var cM:String;
		var tS:String;
		var tM:String;
		// format the time
		if (secondsRemainder<10) {
			cS = "0"+secondsRemainder;
		} else {
			cS = String(secondsRemainder);
		}
		if (minutesElapsed<10) {
			cM = "0"+minutesElapsed;
		} else {
			cM = String(minutesElapsed);
		}
		//
		if (totalSecondsRemainder<10) {
			tS = "0"+totalSecondsRemainder;
		} else {
			tS = String(totalSecondsRemainder);
		}
		if (totalMinutes<10) {
			tM = "0"+totalMinutes;
		} else {
			tM = String(totalMinutes);
		}
		// set the time
		var newTime:String = cM+":"+cS+"/"+tM+":"+tS;
		targetScope.timeReadOut.text = newTime;
	}
	public function createTrackingInterval() {
		if (this.trackingInterval != null) {
			clearInterval(this.trackingInterval);
		}
		this.trackingInterval = setInterval(trackPlayHead, 100, this);
		// add this interval to the list for easy clean up on unload
		this.intervalList.push(this.trackingInterval);
	}
	public function clearTrackingInterval() {
		clearInterval(this.trackingInterval);
	}
	public function trackPlayHead(targetScope) {
		var currFrame:Number = targetScope.targetClass.getCurrentFrame();
		var framesTotal:Number = targetScope.targetClass.getFramesTotal();
		var percentPlayed:Number = currFrame/framesTotal;
		// move the play head
		var startX:Number = targetScope.sLoadOutline._x;
		var areaWidth:Number = targetScope.sLoadOutline._width-targetScope.sBtn._width;
		var endX:Number = startX+(areaWidth*percentPlayed);
		targetScope.sBtn._x = endX;
	}
	public function calcDownload() {
		var framesLoaded:Number = targetClass.getFramesLoaded();
		var framesTotal:Number = targetClass.getFramesTotal();
		var percentLoaded:Number = framesLoaded/framesTotal;
		var loadWidth:Number = sLoadOutline._width;
		var newWidth:Number = loadWidth*percentLoaded;
		sLoadBar._width = newWidth;
		sArea._width = newWidth;
	}
	public function colorObject(targetObject:Object, newColor:Number) {
		var tempColor:Color = new Color(targetObject);
		tempColor.setRGB(newColor);
	}
	public function dragObject(dragClip:MovieClip, boundsClip:MovieClip) {
		// drag the clip
		dragClip.startDrag(false, boundsClip._x, boundsClip._y, boundsClip._x+boundsClip._width-dragClip._width, boundsClip._y);
		// start the interval to track the drag percent
		if (this.sliderInterval != null) {
			clearInterval(this.sliderInterval);
		}
		this.sliderInterval = setInterval(calcDragPercent, 100, this, dragClip, sLoadOutline);
		// add this interval to the interval list
		intervalList.push(this.sliderInterval);
	}
	public function calcDragPercent(targetScope:MovieClip, dragClip:MovieClip, boundsClip:MovieClip) {
		// calc the drag percent and set it
		var travelAmount:Number = dragClip._x-boundsClip._x;
		var maxTravelAmount:Number = boundsClip._width-dragClip._width;
		var tempPercent:Number = travelAmount/maxTravelAmount;
		targetScope.setSliderPercent(tempPercent);
		// now scrub the video
		targetScope.scrubVideo(tempPercent);
	}
	public function scrubVideo(newPercent:Number) {
		var totalFrames:Number = targetClass.getFramesTotal();
		var newFrame:Number = Math.ceil(totalFrames*newPercent);
		// to stop end frame actions from triggering
		// only go to the last frame -1
		if (newFrame>=totalFrames) {
			newFrame = totalFrames-1;
		}
		targetClass.getTargetClip().gotoAndStop(newFrame);
	}
	public function move(x:Number, y:Number) {
		this._x = x;
		this._y = y;
	}
	public function setWidth(width:Number) {
		var widthXOffSet:Number;
		if (getUseTimeReadOut() == "true") {
			timeReadOut._visible = true;
			widthXOffSet = 60+timeReadOut._width;
			// move all items
			rrBtn._x = 0+timeReadOut._width;
			playBtn._x = rrBtn._x+rrBtn._width;
			ffBtn._x = playBtn._x+40;
			scrubber._x = ffBtn._x;
			// start the interval to track time
			createTimeTrackInterval();
		} else {
			timeReadOut._visible = false;
			widthXOffSet = 60;
			// move all items
			rrBtn._x = 0;
			playBtn._x = rrBtn._x+rrBtn._width;
			ffBtn._x = playBtn._x+40;
			scrubber._x = ffBtn._x;
		}
		if (width>widthXOffSet) {
			var tempWidth = width-widthXOffSet;
			sLoadOutline._width = tempWidth;
			sFill._width = tempWidth;
			sOutline._width = tempWidth;
			sLoadBar._width = 2;
		}
	}
	// *** end utility functions *****************************
	// *** clean up ******************************************
	public function cleanUp() {
		for (i=0; i<intervalList.length; ++i) {
			clearInterval(intervalList[i]);
		}
		cleanUpWatchers();
	}
	public function cleanUpWatchers() {
		targetClass.auxWatcherObject.unwatch("playState");
		targetClass.auxWatcherObject.unwatch("bytesLoaded");
		targetClass.auxWatcherObject.unwatch("loaded");
	}
	// *** end clean up **************************************
}
// *** end Controller Class **********************************
