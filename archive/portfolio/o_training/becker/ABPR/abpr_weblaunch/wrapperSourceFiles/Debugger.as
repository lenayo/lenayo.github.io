// Debugger Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 01/15/05
// Last Edit Date: 01/16/05
// *** Debugger Class *********************************
dynamic class Debugger extends MovieClip {
	// *** declare class vars *************************
	var dataGrid_dg:MovieClip;
	var okBtn:MovieClip;
	var cancelBtn:MovieClip;
	var varsBtn:MovieClip;
	var logBtn:MovieClip;
	var objectLink:MovieClip;
	var fileDate:TextField;
	// *** end class vars *****************************
	// *** create constructor *************************
	public function Debugger() {
		// map class objectcs
		dataGrid_dg = this.dg_mc;
		okBtn = this.ok_mc;
		cancelBtn = this.cancel_mc;
		varsBtn = this.vars_mc;
		logBtn = this.log_mc;
		objectLink = this;
		fileDate = this.fileDate_txt;
	}
	// *** end constructor ****************************
	// *** create init ********************************
	public function init() {
		// create the btn events
		createBtnEvents();
		// set the file creation data text
		fileDate.text = "File Creation Date: "+gCreationDate;
		// init the vars field
		initVars();
	}
	public function initLog() {
		var myDp:Array = new Array();
		for (i in gErrorLog) {
			myDp.push({Name:gErrorLog[i].Time, Value:gErrorLog[i].ErrorCode});
		}
		dataGrid_dg.dataProvider = myDp;
	}
	public function initVars() {
		// create the dataprovider from the root values
		var myDp:Array = new Array();
		for (var i in _root) {
			if (typeof _root[i] == "string") {
				myDp.push({Name:i, Value:_root[i]});
			}
		}
		dataGrid_dg.dataProvider = myDp;
		// create the listener object
		listenerObject = new Object();
		listenerObject.change = function(eventObject) {
			// get the target and index
			var target = eventObject.target;
			var index = eventObject.target.selectedIndex;
			// update root values
			var label = target.getItemAt(index).Name;
			var value = target.getItemAt(index).Value;
			_root[label] = value;
			trace(label+" = "+_root[label]);
		};
		dataGrid_dg.addEventListener("change", listenerObject);
		// make data grid editable
		dataGrid_dg.editable = true;
		dataGrid_dg.getColumnAt(0).editable = false;
	}
	// *** end init ***********************************
	// *** create utility functions *******************
	public function createBtnEvents() {
		okBtn.onRelease = function() {
			_root.initContent();
			gToggleDebugger();
		};
		cancelBtn.onRelease = function() {
			gToggleDebugger();
		};
		varsBtn.onRelease = function() {
			this._parent.initVars();
		};
		logBtn.onRelease = function() {
			this._parent.initLog();
		};
	}
	// *** end utility functions **********************
}
// *** end Debugger Class *****************************
