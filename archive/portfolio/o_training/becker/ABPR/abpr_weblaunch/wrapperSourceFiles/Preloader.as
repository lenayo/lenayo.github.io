// Preloader Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/27/04
// Last Edit Date: 11/28/04
// *** preloader loader class ***************************************
dynamic class Preloader extends MovieClip {
	// *** create preloader vars ************************************
	var targetClass:Object;
	// *** end preloader vars ***************************************
	// *** create constructor ***************************************
	public function Preloader() {
	}
	// *** end constructor ******************************************
	// *** create init **********************************************
	public function init(watcherObject:Object, targetClass:Object) {
		// set the target class
		setTargetClass(targetClass);
		// create the wacher events
		createWatchers(watcherObject);
		// reset the loader bar
		resetLoaderBar();
	}
	// *** end init *************************************************
	// *** create getters *******************************************
	public function getTargetClass() {
		return targetClass;
	}
	// *** end getters **********************************************
	// *** create setters *******************************************
	public function setTargetClass(newVal:Object) {
		targetClass = newVal;
	}
	public function setEventText(newVal:String) {
		eventText_txt.text = newVal;
	}
	// *** end setters **********************************************
	// *** create utiltiy functions *********************************
	public function createWatchers(targetObject:Object) {
		targetObject.watch("bytesLoaded", watcherHandler, [this]);
	}
	public function watcherHandler(propName:String, oldVal, newVal, userData:Array) {
		var targetScope:MovieClip = userData[0];
		switch (propName) {
		case "bytesLoaded" :
			// update the status text
			targetScope.setEventText("please wait...loading");
			// update the download text
			targetScope.downloadText_txt.text = "loading "+Math.round(newVal/1024)+" Kbs of "+Math.round(targetScope.getTargetClass().getBytesTotal()/1024)+" Kbs";
			// update the connection rate text
			targetScope.connectionText_txt.text = "connection rate: "+Math.round(targetScope.getTargetClass().getBandwidth())+" Kbps";
			// update the buffer time
			targetScope.timeText_txt.text = "time remaining: "+Math.round(targetScope.getTargetClass().getBufferTime())+" seconds";
			// update the loader bar
			targetScope.updateLoaderBar(newVal);
			break;
		}
	}
	public function updateLoaderBar(bytesLoaded:Number) {
		// calc the percent loaded
		var percentLoaded:Number = bytesLoaded/getTargetClass().getBytesTotal();
		// set the width of the fill bar
		var newWidth:Number = this.outline_mc._width*percentLoaded;
		// apply it
		this.fill_mc._width = newWidth;
	}
	public function resetLoaderBar() {
		fill_mc._width = 1;
	}
	// *** end utiltiy functions ************************************
	// *** create clean up ******************************************
	// *** end clean up *********************************************
}
// *** end preloader class ******************************************
