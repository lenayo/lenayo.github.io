// Course History Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/28/04
// Last Edit Date: 11/28/04
// *** create the course history class ***************************
dynamic class CourseHistory extends MovieClip {
	// *** create class vars *************************************
	var history_so:SharedObject;
	// *** end class vars ****************************************
	// *** create constructor ************************************
	public function CourseHistory() {
	}
	// *** create init *******************************************
	public function init(id:String, modList:Array) {
		// create the shared object for this class
		history_so = SharedObject.getLocal(id);
		// populate the shared object
		for (i=0; i<modList.length; ++i) {
			// check to see if data already exists
			if (history_so.data.module0.visitedPage == null) {
				history_so.data["module"+i] = new Object();
				var tempDataSlot = history_so.data["module"+i];
				tempDataSlot.visitedPage;
				tempDataSlot.currentPage;
				tempDataSlot.pagesTotal = modList[i];
			}
		}
		history_so.flush();
	}
	// *** end init **********************************************
	// *** end constructor ***************************************
	// *** create getters ****************************************
	public function getCurrentPage(id:Number) {
		return history_so.data["module"+id].currentPage;
	}
	public function getVisitedPage(id:Number) {
		return history_so.data["module"+id].visitedPage;
	}
	// *** end getters *******************************************
	// *** create setters ****************************************
	public function setCurrentPage(id:Number, newVal:Number) {
		history_so.data["module"+id].currentPage = newVal;
	}
	public function setVisitedPage(id:Number, newVal:Number) {
		if (newVal>=getVisitedPage(id)) {
			history_so.data["module"+id].visitedPage = newVal;
		}
	}
	// *** end setters *******************************************
	// *** create utility functions ******************************
	// *** end utlility functions ********************************
	// *** clean up **********************************************
	// *** end clean up ******************************************
}
// *** end the course history class ******************************
