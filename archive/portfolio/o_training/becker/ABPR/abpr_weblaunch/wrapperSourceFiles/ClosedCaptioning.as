// ClosedCaptioning Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 1/17/05
// Last Edit Date: 02/11/05
// *** ClosedCaptioning class *********************************
dynamic class ClosedCaptioning extends MovieClip {
	// *** create class vars **********************************
	var ccState:String;
	var ccTextBox:MovieClip;
	var ccText:TextField;
	var sb:MovieClip;
	var toggleBtn:MovieClip;
	var ccActive:MovieClip;
	var varList:Array;
	// *** end class vars *************************************
	// *** create constructor *********************************
	public function ClosedCaptioning() {
		// map objects
		ccState = "closed";
		ccTextBox = this.ccTextBox_mc;
		ccText = ccTextBox.text_txt;
		sb = ccTextBox.sb_mc;
		toggleBtn = this.toggleBtn_mc;
		ccActive = toggleBtn.ccActive_mc;
		varList = new Array();
		// create button event
		toggleBtn.onRelease = function() {
			this._parent.toggleCCText();
		};
		// turn off the scroll bar
		sb._alpha = 0;
		setText("");
		// turn off the cc text box
		ccTextBox._visible = false;
	}
	// *** end constructor ************************************
	// *** create init ****************************************
	public function init() {
	}
	// *** end init *******************************************
	// *** create setters *************************************
	public function setText(newVal:String, varName:String) {
		ccText.html = true;
		ccText.htmlText = newVal;
		if ((newVal == "") || (newVal == null)) {
			ccText.htmlText = "";
		} else {
			if (ccText.maxscroll>1) {
				sb._alpha = 100;
			} else {
				sb._alpha = 0;
			}
			varList.push(varName);
		}
	}
	// *** end setters ****************************************
	// *** create utility functions ***************************
	public function toggleCCText() {
		if (ccState == "closed") {
			ccState = "open";
			openCCText();
		} else if (ccState == "open") {
			ccState = "closed";
			closeCCText();
		}
	}
	public function openCCText() {
		// tween the ccTextBox
		var easeType:Object = mx.transitions.easing.Strong.easeOut;
		var transDuration:Number = 0.75;
		ccTextBox._visible = true;
		var tween1 = new mx.transitions.Tween(ccTextBox, "_alpha", easeType, ccTextBox._alpha, 100, transDuration, true);
		var tween2 = new mx.transitions.Tween(ccActive, "_alpha", easeType, ccActive._alpha, 100, transDuration, true);
	}
	public function closeCCText() {
		// tween the ccTextBox
		var easeType:Object = mx.transitions.easing.Strong.easeOut;
		var transDuration:Number = 0.75;
		var tween1 = new mx.transitions.Tween(ccTextBox, "_alpha", easeType, ccTextBox._alpha, 0, transDuration, true);
		var tween2 = new mx.transitions.Tween(ccActive, "_alpha", easeType, ccActive._alpha, 0, transDuration, true);
		tween1.ts = this;
		tween1.onMotionFinished = function(){
			this.ts.ccTextBox._visible = false;
		}
	}
	// *** end utility functions ******************************
	// *** clean up *******************************************
	public function cleanUp() {
		for (var i = 0; i<varList.length; ++i) {
			delete _root[varList[i]];
		}
		setText("");
		varList = new Array();
	}
}
// *** end ClosedCaption class ********************************
