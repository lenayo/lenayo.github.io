// Module Progress Bar Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/20/04
// Last Edit Date: 11/20/04
// *** create the Module Progress Bar Class ***************************
dynamic class ModuleProgressBar extends Object {
	// *** create class vars ***************************************
	var attachPath:MovieClip;
	var targetClip:MovieClip;
	var clipName:String;
	var width:Number;
	var height:Number;
	var currentColor:Color;
	var visitedColor:Color;
	var unvisitedColor:Color;
	var dividerColor:Color;
	var pagesTotal:Number;
	var currentPage:Number;
	var visitedPage:Number;
	var currentClip:MovieClip;
	var visitedClip:MovieClip;
	var unvisitedClip:MovieClip;
	// *** end class vars ******************************************
	// *** create constructor **************************************
	public function ModuleProgressBar(attachPath:MovieClip, clipName:String, depth:Number, width:Number, height:Number, x:Number, y:Number, currentColor:Number, visitedColor:Number, unvisitedColor:Number, dividerColor:Number, pagesTotal:Number, currentPage:Number, visitedPage:Number) {
		// build the holder
		attachPath.createEmptyMovieClip(clipName, depth);
		// get the temp clip
		var tempAttachPath:MovieClip = attachPath[clipName];
		// build the unvisited box
		unvisitedClip = buildBox(tempAttachPath, "unvisited_mc", 10, width, height, unvisitedColor);
		// build the visited box
		visitedClip = buildBox(tempAttachPath, "visited_mc", 11, width, height, visitedColor);
		// build the current box
		currentClip = buildBox(tempAttachPath, "current_mc", 12, width, height, currentColor);
		// set the class vars
		setWidth(width);
		setHeight(height);
		setTargetClip(tempAttachPath);
		// set the current page and visited page to default
		setPagesTotal(pagesTotal);
		setCurrentPage(currentPage);
		setVisitedPage(visitedPage);
		// move the bar
		move(x, y);
	}
	// *** end constructor *****************************************
	// *** create init *********************************************
	// *** end init ************************************************
	// *** create getters ******************************************
	public function getWidth():Number {
		return width;
	}
	public function getHeight():Number {
		return height;
	}
	public function getTargetClip():MovieClip {
		return targetClip;
	}
	public function getCurrentPage():Number{
		return currentPage;
	}
	public function getVisitedPage():Number{
		return visitedPage;
	}
	public function getPagesTotal():Number{
		return pagesTotal;
	}
	// *** end getters *********************************************
	// *** create setters ******************************************
	public function setWidth(newVal:Number) {
		width = newVal;
	}
	public function setHeight(newVal:Number) {
		height = newVal;
	}
	public function setPagesTotal(newVal:Number) {
		pagesTotal = newVal;
	}
	public function setCurrentPage(newVal:Number) {
		currentPage = newVal;
		var tempPercent:Number = currentPage/pagesTotal;
		// adjust the current clip size
		currentClip._width = width*tempPercent;
		// draw the divider
		//drawDivider(currentClip, 0x333333);
	}
	public function setVisitedPage(newVal:Number) {
		visitedPage = newVal;
		var tempPercent:Number = visitedPage/pagesTotal;
		// adjust the visited clip size
		visitedClip._width = width*tempPercent;
		// draw the divider
		//drawDivider(visitedClip, 0x333333);
	}
	public function setTargetClip(newVal:MovieClip) {
		targetClip = newVal;
	}
	// *** end setters *********************************************
	// *** create utility functions ********************************
	public function buildBox(attachPath:MovieClip, clipName:String, newDepth:Number, width:Number, height:Number, newColor:Number) {
		// make the place holder
		attachPath.createEmptyMovieClip(clipName, newDepth);
		// get the temp clip
		var tempClip:MovieClip = attachPath[clipName];
		// draw the box
		tempClip.beginFill(newColor, 100);
		tempClip.moveTo(0, 0);
		tempClip.lineTo(width, 0);
		tempClip.lineTo(width, height);
		tempClip.lineTo(0, height);
		tempClip.lineTo(0, 0);
		// return the clip link
		return tempClip;
	}
	public function drawDivider(attachPath:MovieClip, lineColor:Number) {
		// make the place holder
		attachPath.createEmptyMovieClip("divider_mc", 100);
		// get the temp clip
		var tempClip:MovieClip = attachPath["divider_mc"];
		// draw the line
		tempClip.moveTo(attachPath._width, -5);
		tempClip.lineStyle(1, lineColor, 100);
		tempClip.lineTo(attachPath._width, attachPath._height+5);
	}
	public function move(x:Number, y:Number) {
		var tempClip:MovieClip = getTargetClip();
		tempClip._x = x;
		tempClip._y = y;
	}
	// *** end utility functions ***********************************
	// *** clean up ************************************************
	// *** end clean up ********************************************
}
// *** end the Module Progress Bar Class ******************************
