// Bottom Nav Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/26/04
// Last Edit Date: 07/21/05
// *** bottom nav class *****************************************
dynamic class BottomNav extends Object {
	// *** create class vars ************************************
	var goToPage:MovieClip;
	var moduleProgress:MovieClip;
	var moduleStatus:TextField;
	var progressClip;
	var progressHolder:MovieClip;
	var volumeControl:MovieClip;
	var volumeStatus:TextField;
	var muteBtn:MovieClip;
	var sliderBtn:MovieClip;
	var sliderArea:MovieClip;
	var navBtns:MovieClip;
	var reloadBtn:MovieClip;
	var backBtn:MovieClip;
	var nextBtn:MovieClip;
	var cc:MovieClip;
	var currentPageColor:Number;
	var visitedPageColor:Number;
	var unvisitedPageColor:Number;
	var volumeObject:Sound;
	var lastVolumeLevel:Number = 100;
	var currentModule:Number;
	var currentPage:Number;
	var visitedPage:Number;
	var tween1;
	// *** end class vars ***************************************
	// *** create constructor ***********************************
	public function BottomNav() {
		// map objects
		goToPage = this.goToPage_mc;
		moduleProgress = this.moduleProgress_mc;
		progressHolder = moduleProgress.btmNavProgressHolder_mc;
		moduleStatus = moduleProgress.progress_txt;
		volumeControl = this.volumeControl_mc;
		volumeStatus = volumeControl.status_txt;
		muteBtn = volumeControl.muteSymbol_mc;
		sliderBtn = volumeControl.slider_mc;
		sliderArea = volumeControl.sliderArea_mc;
		navBtns = this.btmNavBtns_mc;
		reloadBtn = navBtns.reloadBtn_mc;
		backBtn = navBtns.backBtn_mc;
		nextBtn = navBtns.nextBtn_mc;
		cc = this.cc_mc;
		_global.gBtmNavScope = this;
		_global.gSyncVolume = function() {
			_global.gBtmNavScope.setVolume(_global.gBtmNavScope.lastVolumeLevel);
		};
		// turn off the cc since it is not active yet
		//cc._visible = false;
		// create the global volume
		volumeObject = new Sound(_root);
	}
	// *** end constructor **************************************
	// *** create init ******************************************
	public function init() {
		// create the progress bar
		createProgressBar();
		// create the volumeBtnEvents
		createVolumeControlBtnEvents();
		// init the audio text
		volumeStatus.text = "AUDIO\nON";
		// color the color key
		initColorKey();
		// create the nav btn events
		createReloadBtnEvents();
		createBackBtnEvents();
		createNextBtnEvents();
		createGoToPageBtnEvents();
	}
	public function initColorKey() {
		var tempColor1:Color = new Color(moduleProgress.colorKey1_mc);
		var tempColor2:Color = new Color(moduleProgress.colorKey2_mc);
		var tempColor3:Color = new Color(moduleProgress.colorKey3_mc);
		tempColor1.setRGB(getVisitedPageColor());
		tempColor2.setRGB(getCurrentPageColor());
		tempColor3.setRGB(getUnvisitedPageColor());
	}
	// *** end init *********************************************
	// *** create getters ***************************************
	public function getCurrentPageColor():Number {
		return currentPageColor;
	}
	public function getVisitedPageColor():Number {
		return visitedPageColor;
	}
	public function getUnvisitedPageColor():Number {
		return unvisitedPageColor;
	}
	public function getLastVolumeLevel():Number {
		return lastVolumeLevel;
	}
	public function getCurrentModule():Number {
		return currentModule;
	}
	public function getCurrentPage():Number {
		return currentPage;
	}
	public function getVisitedPage():Number {
		return visitedPage;
	}
	// *** end setters ******************************************
	// *** create setters ***************************************
	public function setCurrentPageColor(newColor:Number) {
		currentPageColor = newColor;
	}
	public function setVisitedPageColor(newColor:Number) {
		visitedPageColor = newColor;
	}
	public function setUnvisitedPageColor(newColor:Number) {
		unvisitedPageColor = newColor;
	}
	public function setVolume(newVal:Number) {
		volumeObject.setVolume(newVal);
		// *** Note: just added for mp3 sound control
		_global.gEmbedSound.setVolume(newVal);
		_global.gMediaPlayBack.volume = newVal;
	}
	public function setLastVolumeLevel(newVal:Number) {
		lastVolumeLevel = newVal;
	}
	public function setCurrentPage(newVal:Number) {
		progressClip.setCurrentPage(newVal);
		currentPage = newVal;
		setModuleStatus();
	}
	public function setVisitedPage(newVal:Number) {
		progressClip.setVisitedPage(newVal);
		visitedPage = newVal;
	}
	public function setPagesTotal(newVal:Number) {
		progressClip.setPagesTotal(newVal);
	}
	public function setCurrentModule(newVal:Number) {
		currentModule = newVal;
	}
	public function setModuleStatus() {
		moduleStatus.text = "Page "+progressClip.getCurrentPage()+" of "+progressClip.getPagesTotal()+" at Module "+getCurrentModule();
		// check to see if the next button is disabled
		checkNextBtnState();
	}
	public function setReloadBtnText(newVal:String) {
		reloadBtn.text_txt.html = true;
		reloadBtn.text_txt.htmlText = newVal;
	}
	public function setBackBtnText(newVal:String) {
		backBtn.text_txt.html = true;
		backBtn.text_txt.htmlText = newVal;
	}
	public function setNextBtnText(newVal:String) {
		nextBtn.text_txt.html = true;
		nextBtn.text_txt.htmlText = newVal;
	}
	// *** end setters ******************************************
	// *** create utility functions *****************************
	public function createProgressBar() {
		progressClip = new ModuleProgressBar(moduleProgress, "progressBar_mc", 1, (progressHolder._width-2), (progressHolder._height-1.5), (progressHolder._x+0.5), (progressHolder._y+0.5), getCurrentPageColor(), getVisitedPageColor(), getUnvisitedPageColor(), 0x333333, 0, 0, 1);
		setModuleStatus();
	}
	public function updateProgressBar(currPage:Number, visitedPage:Number, pagesTotal:Number, currModule:Number) {
		setPagesTotal(pagesTotal);
		setCurrentPage(currPage+1);
		setVisitedPage(visitedPage+1);
		setCurrentModule(currModule+1);
		// update the text
		setModuleStatus();
	}
	public function dragSlider() {
		sliderBtn.startDrag(false, sliderArea._x, sliderArea._y-2, sliderArea._width+sliderArea._x-sliderBtn._width, sliderArea._y-2);
	}
	public function releaseSlider() {
		stopDrag();
	}
	public function calcDragPercent() {
		var travelAmount:Number = sliderBtn._x-sliderArea._x;
		var travelWidth:Number = sliderArea._width-sliderBtn._width;
		var travelPercent:Number = travelAmount/travelWidth;
		setLastVolumeLevel(travelPercent*100);
		setVolume(travelPercent*100);
	}
	public function createVolumeControlBtnEvents() {
		sliderBtn.onPress = function() {
			this._parent._parent.resetVolume();
			this._parent._parent.dragSlider();
			this.pressed = true;
			this._parent._parent.volumeStatus.text = "AUDIO\nON";
		};
		sliderBtn.onRelease = function() {
			this._parent._parent.releaseSlider();
			this.pressed = false;
		};
		sliderBtn.onReleaseOutside = function() {
			this._parent._parent.releaseSlider();
			this.pressed = false;
		};
		sliderBtn.onMouseMove = function() {
			if (this.pressed == true) {
				this._parent._parent.calcDragPercent();
			}
		};
		muteBtn.onRelease = function() {
			if (this.muteIndicator_mc._visible == true) {
				this._parent._parent.muteVolume();
			} else if (this.muteIndicator_mc._visible == false) {
				this._parent._parent.resetVolume();
			}
		};
		sliderArea.onPress = function() {
			this._parent._parent.resetVolume();
			this._parent._parent.sliderBtn._x = this._parent._xmouse;
			this._parent._parent.dragSlider();
			this.pressed = true;
			this._parent._parent.volumeStatus.text = "AUDIO\nON";
		};
		sliderArea.onRelease = function() {
			this._parent._parent.releaseSlider();
			this.pressed = false;
		};
		sliderArea.onReleaseOutside = function() {
			this._parent._parent.releaseSlider();
			this.pressed = false;
		};
		sliderArea.onMouseMove = function() {
			if (this.pressed == true) {
				this._parent._parent.calcDragPercent();
			}
		};
	}
	public function createReloadBtnEvents() {
		reloadBtn.btn_btn.enabled = true;
		reloadBtn.btn_btn.onPress = function() {
		};
		reloadBtn.btn_btn.onRelease = function() {
			this._parent._parent._parent.stopAllTweens();
			gReloadPage();
		};
		reloadBtn.btn_btn.onReleaseOutside = function() {
		};
		reloadBtn.btn_btn.onRollOver = function() {
		};
		reloadBtn.btn_btn.onRollOut = function() {
		};
		reloadBtn._alpha = 100;
	}
	public function disableReloadBtnEvents() {
		reloadBtn.btn_btn.enabled = false;
		reloadBtn._alpha = 60;
	}
	public function createBackBtnEvents() {
		backBtn.btn_btn.enabled = true;
		backBtn.btn_btn.onPress = function() {
		};
		backBtn.btn_btn.onRelease = function() {
			this._parent._parent._parent.stopAllTweens();
			gGoToPage(null, null, "back");
		};
		backBtn.btn_btn.onReleaseOutside = function() {
		};
		backBtn.btn_btn.onRollOver = function() {
		};
		backBtn.btn_btn.onRollOut = function() {
		};
		backBtn._alpha = 100;
	}
	public function disableBackBtnEvents() {
		backBtn.btn_btn.onPress;
		backBtn._alpha = 60;
	}
	public function createNextBtnEvents() {
		nextBtn.btn_btn.enabled = true;
		nextBtn.btn_btn.onPress = function() {
		};
		nextBtn.btn_btn.onRelease = function() {
			this._parent._parent._parent.stopAllTweens();
			gGoToPage(null, null, "next");
		};
		nextBtn.btn_btn.onReleaseOutside = function() {
		};
		nextBtn.btn_btn.onRollOver = function() {
		};
		nextBtn.btn_btn.onRollOut = function() {
		};
		nextBtn._alpha = 100;
	}
	public function disableNextBtnEvents() {
		nextBtn.btn_btn.enabled = false;
		nextBtn._alpha = 60;
	}
	public function createGoToPageBtnEvents() {
		goToPage.btn_btn.enabled = true;
		goToPage.btn_btn.onPress = function() {
		};
		goToPage.btn_btn.onRelease = function() {
			var inputText:TextField = this._parent.input_txt;
			if (inputText.text != "" || inputText.text != null) {
				var newPage:Number = Number(inputText.text)-1;
				gGoToPage(null, newPage, null);
			}
		};
		goToPage.btn_btn.onReleaseOutside = function() {
		};
		goToPage.btn_btn.onRollOver = function() {
		};
		goToPage.btn_btn.onRollOut = function() {
		};
		goToPage._alpha = 100;
	}
	public function disableGoToPageBtnEvents() {
		goToPage.btn_btn.enabled = false;
		goToPage._alpha = 60;
	}
	public function resetVolume() {
		setVolume(getLastVolumeLevel());
		muteBtn.muteIndicator_mc._visible = true;
		volumeStatus.text = "AUDIO\nON";
	}
	public function muteVolume() {
		setVolume(0);
		muteBtn.muteIndicator_mc._visible = false;
		volumeStatus.text = "AUDIO\nOFF";
	}
	public function checkNextBtnState() {
		if (_root.disableNextBtn == "true") {
			if (getCurrentPage()>=getVisitedPage()) {
				disableNextBtnEvents();
			} else if (getCurrentPage()<getVisitedPage()) {
				createNextBtnEvents();
			}
		} else {
			createNextBtnEvents();
		}
	}
	// *** end utility functions ********************************
	// *** blink buttons ****************************************
	public function blinkNextBtn() {
		blinkGraphic(nextBtn);
		createNextBtnEvents();
	}
	public function blinkBackBtn() {
		blinkGraphic(backBtn);
	}
	public function blinkGraphic(targetItem:MovieClip) {
		// clean up all tweens
		stopAllTweens();
		// tween the targetItem
		var easeType:Object = mx.transitions.easing.Strong.easeOut;
		var transDuration:Number = 0.5;
		var startAlpha:Number = 100;
		var endAlpha:Number = 65;
		tween1 = new mx.transitions.Tween(targetItem, "_alpha", easeType, startAlpha, endAlpha, transDuration, true);
		tween1.onMotionFinished = function() {
			this.yoyo();
		};
	}
	public function stopAllTweens() {
		tween1.rewind();
		tween1.reverse();
		tween1.stop();
		tween1 = null;
		// reset all btns to 100 alpha
		nextBtn._alpha = 100;
		backBt._alpha = 100;
	}
	// *** end blink buttons ************************************
	// *** clean up *********************************************
	public function cleanUp() {
		stopAllTweens();
	}
	// *** end clean up *****************************************
}
// *** end bottom nav class *************************************
