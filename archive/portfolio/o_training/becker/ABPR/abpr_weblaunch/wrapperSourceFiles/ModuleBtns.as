// ModuleBtns Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/18/04
// Last Edit Date: 02/11/05
// *** module btns class *****************************************
dynamic class ModuleBtns extends Object {
	// *** declare class vars ************************************
	var moduleBtn:MovieClip;
	var progressHolder:MovieClip;
	var btnList:Array = new Array();
	var rollOverColor:Number;
	var rollOutColor:Number;
	var disabledColor:Number;
	var currentPageColor:Number;
	var visitedPageColor:Number;
	var unvisitedPageColor:Number;
	// *** end class vars ****************************************
	// *** create constructor ************************************
	public function ModuleBtns() {
		// map objects
		moduleBtn = this.moduleBtn_mc;
		progressHolder = moduleBtn.progressHolder_mc;
		_global.gModBtnScope = this;
	}
	// *** end constructor ***************************************
	// *** create init *******************************************
	public function init(newList:Array) {
		// loop through the array
		for (var i = 0; i<newList.length; ++i) {
			// duplicate the space each btn
			moduleBtn.duplicateMovieClip("moduleBtn"+i+"_mc", 10+i);
			// set a temp link to it
			var tempClip:MovieClip = this["moduleBtn"+i+"_mc"];
			// add each clip to the btn list
			btnList[i] = tempClip;
			// build the text in the new clip
			for (var k in newList[i]) {
				var tempVal:String = newList[i][k];
				switch (k) {
				case "numberOveride" :
					if (newVal == undefined) {
						tempClip.number_txt.html = false;
						tempClip.number_txt.text = i+1;
					} else {
						tempClip.number_txt.html = true;
						tempClip.number_txt.htmlText = tempVal;
					}
					break;
				case "thumbnailUrl" :
					tempClip.thumbnail_mc.bg_mc.loadMovie(tempVal);
					break;
				case "title" :
					tempClip.title_txt.autoSize = true;
					tempClip.title_txt.htmlText = tempVal;
					break;
				case "description" :
					tempClip.description_txt.autoSize = true;
					tempClip.description_txt.htmlText = tempVal;
					break;
				case "duration" :
					tempClip.duration_txt.htmlText = tempVal;
					break;
				case "showScore" :
					if (tempVal == "true") {
						tempClip.score_mc._visible = true;
					} else {
						tempClip.score_mc._visible = false;
					}
					break;
				case "showNotes" :
					if (tempVal == "true") {
						tempClip.notesBtn_mc._visible = true;
					} else {
						tempClip.notesBtn_mc._visible = false;
					}
					break;
				}
			}
			// after filling in the text lets size it
			tempClip.descriptionTitleBg_mc._height = tempClip.title_txt._height+4;
			tempClip.description_txt._y = tempClip.title_txt._y+tempClip.title_txt._height+4;
			// set the bg height to the new height of the clip
			tempClip.bg_mc._height = tempClip._height;
			tempClip.bgDesign_mc._height = tempClip._height;
			// now space it 10 pixels from the last one
			if (i == 0) {
				var prevClip:MovieClip = tempClip;
			} else {
				var tempId:String = "moduleBtn"+(i-1)+"_mc";
				var prevClip:MovieClip = this[tempId];
				tempClip._y = prevClip._y+prevClip._height+10;
			}
			// now build the module progress bar in the temp clip
			tempClip.mpb = new ModuleProgressBar(tempClip, "progressBar_mc", 1, progressHolder._width, progressHolder._height, progressHolder._x, progressHolder._y, getCurrentPageColor(), getVisitedPageColor(), getUnvisitedPageColor(), 0x333333, 0, 0, 1);
		}
		// get rid of the original clip
		moduleBtn._visible = false;
		// create the btn events
		createBtns();
		// color all btns
		colorAllBtns();
	}
	// *** end init **********************************************
	// *** create getters ****************************************
	public function getBtnList():Array {
		return btnList;
	}
	public function getCurrentPageColor():Number {
		return currentPageColor;
	}
	public function getVisitedPageColor():Number {
		return visitedPageColor;
	}
	public function getUnvisitedPageColor():Number {
		return unvisitedPageColor;
	}
	public function getRollOverColor():Number {
		return rollOverColor;
	}
	public function getRollOutColor():Number {
		return rollOutColor;
	}
	public function getDisabledColor():Number {
		return disabledColor;
	}
	// *** end getters ********************************************
	// *** create setters *****************************************
	public function setRollOverColor(newColor:Number) {
		rollOverColor = newColor;
	}
	public function setRollOutColor(newColor:Number) {
		rollOutColor = newColor;
	}
	public function setDisabledColor(newColor:Number) {
		disabledColor = newColor;
	}
	public function setCurrentPageColor(newColor:Number) {
		currentPageColor = newColor;
	}
	public function setVisitedPageColor(newColor:Number) {
		visitedPageColor = newColor;
	}
	public function setUnvisitedPageColor(newColor:Number) {
		unvisitedPageColor = newColor;
	}
	public function setCurrentPage(id:Number, newVal:Number) {
		if (newVal == undefined) {
			newVal = 0;
			this["moduleBtn"+id+"_mc"].mpb.setCurrentPage(newVal);
		} else {
			this["moduleBtn"+id+"_mc"].mpb.setCurrentPage(newVal+1);
		}
		this["moduleBtn"+id+"_mc"].currentPage = newVal;
	}
	public function setVisitedPage(id:Number, newVal:Number) {
		if (newVal == undefined) {
			newVal = 0;
			this["moduleBtn"+id+"_mc"].mpb.setVisitedPage(newVal);
		} else {
			this["moduleBtn"+id+"_mc"].mpb.setVisitedPage(newVal+1);
		}
		this["moduleBtn"+id+"_mc"].visitedPage = newVal;
		// if the visited page = pages total, turn on the checkmark
		if ((newVal+1) == this["moduleBtn"+id+"_mc"].pagesTotal) {
			this["moduleBtn"+id+"_mc"].checkMark_mc._alpha = 100;
		}
	}
	public function setPagesTotal(id:Number, newVal:Number) {
		this["moduleBtn"+id+"_mc"].mpb.setPagesTotal(newVal);
		this["moduleBtn"+id+"_mc"].pagesTotal = newVal;
	}
	// *** end setters *******************************************
	// *** create utility functions ******************************
	public function createBtns() {
		var tempList:Array = getBtnList();
		for (var i = 0; i<tempList.length; ++i) {
			// create a transparent clip over each btn
			var tempClip:MovieClip = tempList[i];
			tempClip.createEmptyMovieClip("btn_mc", 10+i);
			// size it
			tempClip.btn_mc.beginFill(0xFF0000, 0);
			tempClip.btn_mc.moveTo(0, 0);
			tempClip.btn_mc.lineTo(400, 0);
			tempClip.btn_mc.lineTo(400, tempClip._height);
			tempClip.btn_mc.lineTo(0, tempClip._height);
			tempClip.btn_mc.lineTo(0, 0);
			tempClip.btn_mc.endFill();
			// set an id for each clip
			tempClip.id = i;
			// create btn events for each btn
			createBtnEvents(tempClip.btn_mc);
		}
	}
	public function disableBtnEvent(btnId:Number) {
		var tc:MovieClip = getBtnList()[btnId];
		tc.activated = false;
		trace("disableBtnEvent = "+btnId);
		tc._alpha = 65;
	}
	public function enableBtnEvent(btnId:Number) {
		trace("enableBtnEvent = "+btnId);
		var tc:MovieClip = getBtnList()[btnId];
		tc._alpha = 100;
		tc.activated = true;
	}
	public function createBtnEvents(targetClip:MovieClip) {
		targetClip.onPress = function() {
			colorBg(this._parent.id, "rollOut");
		};
		targetClip.onRelease = function() {
			colorBg(this._parent.id, "rollOut");
			trace("this.activated = "+this._parent.activated);
			if (this._parent.activated != false) {
				trace("gWrapperXml.getForceBookMarkReturn() = "+gWrapperXml.getForceBookMarkReturn());
				// check and see if forceBookMarkReturn is true or not
				if ((gWrapperXml.getForceBookMarkReturn() == "true" || gWrapperXml.getForceBookMarkReturn() == "on") || this._parent.currentPage == 0) {
					gGoToPage(this._parent.id, this._parent.currentPage);
				} else {
					gDisplayAlert("Bookmark Info", "You have page "+(this._parent.currentPage+1)+" in module "+(this._parent.id+1)+" bookmarked.  Press \"Restart\" to start the module over again or press \"Continue\" to return to the bookmarked page.", "restartModule", "goToBookMark", "Restart", "Continue", this._parent.id, this._parent.currentPage, 75);
				}
			} else {
				_global.gDisplayAlert("Module Order Inforced!", "You must finish each preceeding module to continue on.", "ok", null, null, null, null, null, 75);
			}
		};
		targetClip.onReleaseOutside = function() {
			this._parent._parent.colorBg(this._parent.id, "rollOut");
		};
		targetClip.onRollOver = function() {
			this._parent._parent.colorBg(this._parent.id, "rollOver");
		};
		targetClip.onRollOut = function() {
			this._parent._parent.colorBg(this._parent.id, "rollOut");
		};
	}
	public function disableBtn(id:Number) {
		getBtnList()[id]._visible = false;
	}
	public function enableBtn(id:Number) {
		getBtnList()[id]._visible = true;
	}
	// *** end utiltiy functions **********************************
	public function colorBg(id:Number, colorType:String) {
		var tempColor:Color = new Color(getBtnList()[id].bg_mc);
		switch (colorType) {
		case "rollOver" :
			tempColor.setRGB(getRollOverColor());
			break;
		case "rollOut" :
			tempColor.setRGB(getRollOutColor());
			break;
		case "disabled" :
			tempColor.setRGB(getDisabledColor());
			break;
		}
	}
	function colorAllBtns() {
		for (var i = 0; i<getBtnList().length; ++i) {
			var tempColor = new Color(getBtnList()[i].bg_mc);
			tempColor.setRGB(getRollOutColor());
		}
	}
	// *** create clean up ***************************************
	// *** end clean up ******************************************
}
// *** end module btns class *************************************
