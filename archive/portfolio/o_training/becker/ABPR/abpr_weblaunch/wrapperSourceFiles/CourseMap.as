// CourseMap Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/18/04
// Last Edit Date: 11/18/04
// *** course map class *****************************************
dynamic class CourseMap extends Object {
	// *** create class vars ****************************************
	var courseObjectives:MovieClip;
	var courseObjectivesPic:MovieClip;
	var courseMapBtns:MovieClip;
	var courseMapTopBar:MovieClip;
	var courseMapBar2:MovieClip;
	var courseMapBtmBar:MovieClip;
	var scrollPane:MovieClip;
	// *** end vars *************************************************
	// *** create constructor ***************************************
	public function CourseMap() {
		// set object links
		courseObjectives = this.courseObjectives_mc;
		courseObjectivesPic = courseObjectives.pic_mc;
		courseMapBtns = this.courseMapBtns_mc;
		courseMapTopBar = courseMapBtns.topBar_mc;
		courseMapBar2 = courseMapBtns.bar2_mc;
		courseMapBtmBar = courseMapBtns.btmBar_mc;
		scrollPane = courseMapBtns.scrollPane_sp;
	}
	// *** end constructor ******************************************
	// *** create init **********************************************
	// *** end init *************************************************
	// *** create getters *******************************************
	// *** end getters **********************************************
	// *** create setters *******************************************
	public function setObjectivesTitle(newVal:String) {
		courseObjectives.title_txt.htmlText = newVal;
	}
	public function setObjectivesContent(newVal:String) {
		courseObjectives.content_txt.htmlText = newVal;
	}
	public function setCourseMapTitle(newVal:String) {
		courseMapTopBar.text_txt.htmlText = newVal;
	}
	public function setCourseMapSlotText(id:Number) {
		courseMapBar2["slot"+id+"_txt"].htmlText = gWrapperXml.getCourseMapColumnText(id);
	}
	public function setScoreText(newText:String, newScore:Number) {
		if (gWrapperXml.getShowScoreText() == true) {
			courseMapBtmBar.text_txt.htmlText = newText+": "+newScore;
		} else {
			courseMapBtmBar.text_txt.htmlText = "";
		}
	}
	// *** end setters **********************************************
	// *** create utility functions *********************************
	public function skinScrollBars(newColor:Color) {
		courseObjectives.scrollBar_sb.setStyle("themeColor", newColor);
	}
	public function skinScrollPane(newColor:Color) {
		scrollPane.setStyle("themeColor", newColor);
		scrollPane.setStyle("borderCapColor", newColor);
		scrollPane.setStyle("borderColor", newColor);
		scrollPane.setStyle("buttonColor", newColor);
		scrollPane.setStyle("highlightColor", newColor);
		scrollPane.setStyle("shadowCapColor", newColor);
		scrollPane.setStyle("shadowColor", newColor);
	}
	public function loadObjectivesPic(newUrl:String){
		courseObjectivesPic.loadMovie(newUrl);
	}
	// *** end utility functions ************************************
	// *** create clean up ******************************************
	// *** end clean up *********************************************
}
// *** end course map class *************************************
