// Top Nav Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/18/04
// Last Edit Date: 07/21/05
// *** top nav class *****************************************
dynamic class TopNav extends Object {
	// *** create object links and vars ****************************
	var leftLogo:MovieClip;
	var rightLogo:MovieClip;
	var courseMapBtn:MovieClip;
	var notesBtn:MovieClip;
	var extrasBtn:MovieClip;
	var helpBtn:MovieClip;
	var minimizeBtn:MovieClip;
	var exitBtn:MovieClip;
	var courseTitle:TextField;
	var moduleTitle:TextField;
	var moduleMenu:MovieClip;
	var comboBox:MovieClip;
	// *** end object links and vars *******************************
	// *** create constructor **************************************
	public function TopNav() {
		// update object links
		leftLogo = this.logo1_mc;
		rightLogo = this.logo2_mc;
		courseMapBtn = this.courseMapBtn_mc;
		notesBtn = this.notesBtn_mc;
		extrasBtn = this.extrasBtn_mc;
		helpBtn = this.helpBtn_mc;
		minimizeBtn = this.minimizeBtn_mc;
		exitBtn = this.exitBtn_mc;
		courseTitle = this.courseTitle_txt;
		moduleTitle = this.moduleTitle_txt;
		moduleMenu = this.moduleMenu_mc;
		//comboBox = moduleMenu.comboBox_cb;
		moduleMenu._alpha = 0;
		_root.attachMovie("moduleMenu_mc", "moduleMenu_mc", 987);
		_root.moduleMenu_mc._x = moduleMenu._x;
		_root.moduleMenu_mc._y = moduleMenu._y;
		comboBox = _root.moduleMenu_mc.comboBox_cb;
		moduleMenu = _root.moduleMenu_mc;
		trace("comboBox = "+comboBox);
		trace("comboBox._x = "+comboBox._x);
	}
	// *** end constructor *****************************************
	// *** create init *********************************************
	// *** end init ************************************************
	// *** create getters ******************************************
	public function getTargetBtn(id:String) {
		var targetBtn:MovieClip;
		switch (id) {
		case "courseMap" :
			targetBtn = courseMapBtn;
			break;
		case "notes" :
			targetBtn = notesBtn;
			break;
		case "extras" :
			targetBtn = extrasBtn;
			break;
		case "help" :
			targetBtn = helpBtn;
			break;
		case "minimize" :
			targetBtn = minimizeBtn;
			break;
		case "exit" :
			targetBtn = exitBtn;
			break;
		}
		return targetBtn;
	}
	// *** end getters *********************************************
	// *** create setters ******************************************
	public function setActiveBtnList(stringList:String) {
		// disable all btns
		disableAllTopNavBtns();
		// make the string list an array
		var tempArray:Array = stringList.split("|");
		// loop through the list and re-enable the active ones
		for (var i = 0; i<tempArray.length; ++i) {
			enableTopNavBtn(tempArray[i]);
		}
		// create the btn events
		createTopNavBtnsEvents();
	}
	public function setCourseTitle(newVal:String) {
		courseTitle.htmlText = newVal;
	}
	public function setModuleTitle(newVal:String) {
		moduleTitle.htmlText = newVal;
	}
	public function setModuleMenuVisibility(newVal:Boolean) {
		moduleMenu._visible = newVal;
	}
	public function setModuleMenuIndex(newVal:Number) {
		comboBox.setSelectedIndex(newVal);
	}
	public function setComboBoxData(newArray:Array) {
		// turn it on
		setModuleMenuVisiblility(true);
		// set the dataProvider for the comboBox
		comboBox.dataProvider = newArray;
		// make the call back object listener
		var cbLO:Object = new Object();
		cbLO.change = function(infoObject) {
			var tempIndex:Number = infoObject.target.getSelectedIndex();
			// go to the new page
			gGoToPage(null, tempIndex, null);
		};
		comboBox.setStyle("themeColor", 0xcccccc);
		comboBox.setStyle("color", 0x666666);
		comboBox.setStyle("fontFamily", "Arial");
		comboBox.addEventListener("change", cbLO);
	}
	public function setMenuCellHeight(newHeight:Number) {
		// Sets the size of the rowHeight for the List component inside the combox component.
		comboBox.dropdown.rowHeight = Number(newHeight);
		// Tell the cellRenderer for the List component inside the combox component to use our class.
		comboBox.dropdown.cellRenderer = "MultiLineCell";
	}
	// *** end setters *********************************************
	// *** utility functions ***************************************
	public function loadLeftLogo(newUrl:String) {
		leftLogo.placeHolder_mc.loadMovie(newUrl);
	}
	public function loadRightLogo(newUrl:String) {
		rightLogo.placeHolder_mc.loadMovie(newUrl);
	}
	public function createTopNavBtnsEvents() {
		// *** courseMap btn ***************************************
		courseMapBtn.btn_btn.onPress = function() {
		};
		courseMapBtn.btn_btn.onRelease = function() {
			gGoToCourseMap();
		};
		courseMapBtn.btn_btn.onReleaseOutside = function() {
		};
		courseMapBtn.btn_btn.onRollOver = function() {
		};
		courseMapBtn.btn_btn.onRollOut = function() {
		};
		// *** end courseMap btn ***********************************
		// *** notesBtn btn ***************************************
		notesBtn.btn_btn.onPress = function() {
		};
		notesBtn.btn_btn.onRelease = function() {
			_root.openPopUp(gWrapperXml.getNotesUrl());
		};
		notesBtn.btn_btn.onReleaseOutside = function() {
		};
		notesBtn.btn_btn.onRollOver = function() {
		};
		notesBtn.btn_btn.onRollOut = function() {
		};
		// *** end courseMap btn ***********************************
		// *** extrasBtn btn ***************************************
		extrasBtn.btn_btn.onPress = function() {
		};
		extrasBtn.btn_btn.onRelease = function() {
			_root.openPopUp(gWrapperXml.getExtrasUrl());
		};
		extrasBtn.btn_btn.onReleaseOutside = function() {
		};
		extrasBtn.btn_btn.onRollOver = function() {
		};
		extrasBtn.btn_btn.onRollOut = function() {
		};
		// *** end extras btn ***********************************
		// *** helpBtn btn ***************************************
		helpBtn.btn_btn.onPress = function() {
		};
		helpBtn.btn_btn.onRelease = function() {
			_root.openPopUp(gWrapperXml.getHelpUrl());
		};
		helpBtn.btn_btn.onReleaseOutside = function() {
		};
		helpBtn.btn_btn.onRollOver = function() {
		};
		helpBtn.btn_btn.onRollOut = function() {
		};
		// *** end helpBtn btn ***********************************
		// *** minimizeBtn btn ***************************************
		minimizeBtn.btn_btn.onPress = function() {
		};
		minimizeBtn.btn_btn.onRelease = function() {
			getURL("javascript:minimize()");
		};
		minimizeBtn.btn_btn.onReleaseOutside = function() {
		};
		minimizeBtn.btn_btn.onRollOver = function() {
		};
		minimizeBtn.btn_btn.onRollOut = function() {
		};
		// *** end minimizeBtn btn ***********************************
		// *** exitBtn btn *******************************************
		exitBtn.btn_btn.onPress = function() {
		};
		exitBtn.btn_btn.onRelease = function() {
			getURL("javascript:window.close()");
		};
		exitBtn.btn_btn.onReleaseOutside = function() {
		};
		exitBtn.btn_btn.onRollOver = function() {
		};
		exitBtn.btn_btn.onRollOut = function() {
		};
		// *** end exitBtn btn ***************************************
	}
	public function enableTopNavBtn(id:String) {
		var targetBtn:MovieClip = getTargetBtn(id);
		targetBtn._alpha = 100;
		targetBtn.btn_btn.enabled = true;
	}
	public function disableTopNavBtn(id:String) {
		var targetBtn:MovieClip = getTargetBtn(id);
		targetBtn._alpha = 50;
		targetBtn.btn_btn.enabled = false;
	}
	public function disableAllTopNavBtns() {
		disableTopNavBtn("courseMap");
		disableTopNavBtn("notes");
		disableTopNavBtn("extras");
		disableTopNavBtn("help");
		disableTopNavBtn("minimize");
		disableTopNavBtn("exit");
	}
	// *** end utility functions *************************************
}
// *** end top nav class ***************************************
