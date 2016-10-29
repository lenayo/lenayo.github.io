// Wrapper XML Class
// Author: Paul Nevins
// Client: Trio Media
// Start Creation Date: 11/15/04
// Last Edit Date: 07/21/05
// *** create the Wrapper XML Class ***************************
dynamic class WrapperXML extends Object {
	// *** create class vars **********************************
	var wrapperXML:XML;
	var mainPath:String;
	var bandwidthPath:String;
	var searchFile:String;
	// xml nodes
	var wrapperSettingsNode:XML;
	var topNavSettingsNode:XML;
	var courseMapSettingsNode:XML;
	var objectivesNode:XML;
	var courseMapNode:XML;
	var textSettingsNode:XML;
	var btnsNode:XML;
	var bottomNavSettingsNode:XML;
	var globalPageDataNode:XML;
	var modulesNode:XML;
	// page vars
	var currentPage:Number = 0;
	var currentModule:Number;
	var visitedPage:Number = 0;
	// create the watcher object
	var watcherObject:Object = new Object();
	// *** end class vars *************************************
	// *** create constructor *********************************
	public function WrapperXML() {
		// create the xml object
		wrapperXML = new XML();
	}
	// *** end constructor ************************************
	// *** create init ****************************************
	// *** end init *******************************************
	// *** create getters *************************************
	public function getXML() {
		return wrapperXML;
	}
	public function getWatcherObject() {
		return watcherObject;
	}
	public function getBytesTotal() {
		return getXML().getBytesTotal();
	}
	public function getBytesLoaded() {
		return getXML().getBytesLoaded();
	}
	public function getCourseHistoryId():String {
		return parseNodeParams(wrapperSettingsNode, "courseHistoryId");
	}
	public function getMainPath():String {
		return parseNodeParams(wrapperSettingsNode, "mainPath");
	}
	public function getBandwidthPaths():String {
		return parseNodeParams(wrapperSettingsNode, "bandwidthPaths");
	}
	public function getSecurityFile():String {
		return parseNodeParams(wrapperSettingsNode, "securtyFile");
	}
	public function getDataBase():String {
		return parseNodeParams(wrapperSettingsNode, "dataBase");
	}
	public function getCourseTitle():String {
		return parseNodeParams(wrapperSettingsNode, "courseTitle");
	}
	public function getPreloaderBgColor():String {
		return parseNodeParams(wrapperSettingsNode, "preloaderBgColor");
	}
	public function getForceBookMarkReturn():String {
		return parseNodeParams(wrapperSettingsNode, "forceBookMarkReturn");
	}
	public function getForceModuleOrder():String {
		return parseNodeParams(wrapperSettingsNode, "forceModuleOrder");
	}
	public function getUseClosedCaption():String {
		return parseNodeParams(wrapperSettingsNode, "useClosedCaption");
	}
	public function getUseExternalObjectives():String {
		return parseNodeParams(wrapperSettingsNode, "useExternalObjectives");
	}
	public function getLeftLogo():String {
		return parseNodeParams(topNavSettingsNode, "leftLogo");
	}
	public function getRightLogo():String {
		return parseNodeParams(topNavSettingsNode, "rightLogo");
	}
	public function getActiveBtns():String {
		return parseNodeParams(topNavSettingsNode, "activeBtns");
	}
	public function getNotesUrl():String {
		return parseNodeParams(topNavSettingsNode, "notesUrl");
	}
	public function getExtrasUrl():String {
		return parseNodeParams(topNavSettingsNode, "extrasUrl");
	}
	public function getHelpUrl():String {
		return parseNodeParams(topNavSettingsNode, "helpUrl");
	}
	public function getOverideMenuCellHeight():String {
		return parseNodeParams(topNavSettingsNode, "overideMenuCellHeight");
	}
	public function getMenuCellHeight():String {
		return parseNodeParams(topNavSettingsNode, "menuCellHeight");
	}
	public function getObjectivesPicUrl():String {
		return parseNodeParams(objectivesNode, "picUrl");
	}
	public function getObjectivesInstructionsSelectFolder():String {
		return parseNodeParams(objectivesNode, "instructionsSelectFolder");
	}
	public function getObjectivesInstructionsSelectNote():String {
		return parseNodeParams(objectivesNode, "instructionsSelectNote");
	}
	public function getObjectivesTitle():String {
		return parseNodeParams(objectivesNode, "title");
	}
	public function getObjectivesContent():String {
		return parseNodeParams(objectivesNode, "content");
	}
	public function getCourseMapColumnText(id:Number):String {
		return parseNodeParams(textSettingsNode, String("textSlot"+id));
	}
	public function getCourseMapTitle():String {
		return parseNodeParams(textSettingsNode, "title");
	}
	public function getShowScoreText():String {
		return parseNodeParams(textSettingsNode, "showScoreText");
	}
	public function getScoreText():String {
		return parseNodeParams(textSettingsNode, "scoreText");
	}
	public function getBtnNumberOveride(id:Number):String {
		return parseNodeParams(btnsNode.childNodes[id], "numberOveride");
	}
	public function getBtnThumbNailUrl(id:Number):String {
		return parseNodeParams(btnsNode.childNodes[id], "thumbnailUrl");
	}
	public function getBtnModuleTitle(id:Number):String {
		return parseNodeParams(btnsNode.childNodes[id], "title");
	}
	public function getBtnModuleDescription(id:Number):String {
		return parseNodeParams(btnsNode.childNodes[id], "description");
	}
	public function getBtnDuration(id:Number):Boolean {
		return parseNodeParams(btnsNode.childNodes[id], "duration");
	}
	public function getBtnShowScore(id:Number):Boolean {
		return parseNodeParams(btnsNode.childNodes[id], "showScore");
	}
	public function getBtnShowNotes(id:Number):Boolean {
		return parseNodeParams(btnsNode.childNodes[id], "showNotes");
	}
	public function getCurrentPageColor():String {
		return parseNodeParams(bottomNavSettingsNode, "currentPageColor");
	}
	public function getVisitedPageColor():String {
		return parseNodeParams(bottomNavSettingsNode, "visitedPageColor");
	}
	public function getUnvisitedPageColor():String {
		return parseNodeParams(bottomNavSettingsNode, "unvisitedPageColor");
	}
	public function getBtnRollOutColor():String {
		return parseNodeParams(textSettingsNode, "btnRollOutColor");
	}
	public function getBtnRollOverColor():String {
		return parseNodeParams(textSettingsNode, "btnRollOverColor");
	}
	public function getBtnDisabledColor():String {
		return parseNodeParams(textSettingsNode, "btnDisabledColor");
	}
	public function getReloadBtnText():String {
		return parseNodeParams(bottomNavSettingsNode, "reloadBtnText");
	}
	public function getBackBtnText():String {
		return parseNodeParams(bottomNavSettingsNode, "backBtnText");
	}
	public function getNextBtnText():String {
		return parseNodeParams(bottomNavSettingsNode, "nextBtnText");
	}
	public function getShowProgress():Boolean {
		return parseNodeParams(bottomNavSettingsNode, "showProgress");
	}
	public function getModuleLength():Number {
		return modulesNode.childNodes.length;
	}
	public function getModulePages(id:Number):Number {
		return modulesNode.childNodes[id].childNodes.length;
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
	public function getBtnList():Array {
		// get the temp list
		var tempList:Array = btnsNode.childNodes;
		// loop through the list
		for (var i = 0; i<tempList.length; ++i) {
			// add each param to the list
			tempList[i] = new Object();
			tempList[i].numberOveride = getBtnNumberOveride(i);
			tempList[i].thumbnailUrl = getBtnThumbNailUrl(i);
			tempList[i].title = getBtnModuleTitle(i);
			tempList[i].description = getBtnModuleDescription(i);
			tempList[i].duration = getBtnDuration(i);
			tempList[i].showScore = getBtnShowScore(i);
			tempList[i].showNotes = getBtnShowNotes(i);
		}
		// return the object list
		return tempList;
	}
	public function getModulePageTitles(targetModule:Number):Array {
		var tempArray:Array = new Array();
		for (var i = 0; i<modulesNode.childNodes[targetModule].childNodes.length; ++i) {
			var tempTitle:String = modulesNode.childNodes[targetModule].childNodes[i].attributes.title;
			// for special characters unescape the title
			tempTitle = unescape(tempTitle);
			tempArray[i] = new Object();
			if (tempTitle == null || tempTitle == "null" || tempTitle == "" || tempTitle == "undefined") {
				tempArray[i].label = "Page "+(i+1);
			} else {
				tempArray[i].label = (i+1)+": "+tempTitle;
			}
			tempArray[i].data = i;
		}
		// return the dataprovider list for the combo box
		return tempArray;
	}
	// *** end getters ****************************************
	// *** create setters *************************************
	public function setCurrentPage(newVal:Number) {
		currentPage = newVal;
	}
	public function setCurrentModule(newVal:Number) {
		// set the watcher object, but only if it is new
		if (currentModule != newVal) {
			watcherObject.newModule = newVal;
		}
		currentModule = newVal;
	}
	public function setVisitedPage(newVal:Number) {
		visitedPage = newVal;
	}
	// *** end setters ****************************************
	// *** create utility functions ***************************
	public function loadFile(targetFile:String) {
		// create a link back to this class
		var classLink:Object = this;
		// create new xml class instance
		var tempXml:XML = getXML();
		tempXml.load(targetFile);
		tempXml.onLoad = function(success:String) {
			if (success == true) {
				// parse the new xml
				classLink.parseWrapperXML();
				// map the xml nodes
				classLink.mapXmlNodes();
				// on load, stop the download interval
				clearInterval(trackDownloadInterval);
				// update the watcher
				classLink.getWatcherObject().loaded = true;
			} else {
				getURL("javaScript:alert('The xml file could not be found at "+targetFile+"')");
			}
		};
		// create a tracking script to track the download
		trackDownloadInterval = setInterval(trackDownload, 50, this);
	}
	public function trackDownload(targetScope:Object) {
		var bytesLoaded:Number = targetScope.getBytesLoaded();
		// update the watcher object vars
		var tempWatcher:Object = targetScope.getWatcherObject();
		tempWatcher.bytesLoaded = bytesLoaded;
	}
	public function parseWrapperXML() {
		// parse the xml
		var tempXml:XML = getXML();
		tempXml.ignoreWhite = true;
		var tempString:String = String(getXML());
		tempXml.parseXML(tempString);
	}
	public function mapXmlNodes() {
		var tempXml:XML = getXML();
		wrapperSettingsNode = tempXml.childNodes[0].childNodes[0];
		topNavSettingsNode = tempXml.childNodes[0].childNodes[1];
		courseMapSettingsNode = tempXml.childNodes[0].childNodes[2];
		objectivesNode = courseMapSettingsNode.childNodes[0];
		courseMapNode = courseMapSettingsNode.childNodes[1];
		textSettingsNode = courseMapNode.childNodes[0];
		btnsNode = courseMapNode.childNodes[1];
		bottomNavSettingsNode = tempXml.childNodes[0].childNodes[3];
		globalPageDataNode = tempXml.childNodes[0].childNodes[4];
		modulesNode = tempXml.childNodes[0].childNodes[5];
	}
	public function parseNodeParams(targetNode:XML, targetParam:String) {
		for (var i = 0; i<targetNode.childNodes.length; ++i) {
			var nodeName:String = targetNode.childNodes[i].attributes.name;
			var nodeValue:String = targetNode.childNodes[i].firstChild.nodeValue;
			if (nodeName == targetParam) {
				return nodeValue;
			}
		}
	}
	public function parsePageNode(targetNode:XML, moduleNumber:Number, pageNumber:Number) {
		var tempNode:XML = targetNode.childNodes[moduleNumber].childNodes[pageNumber];
		// make an object array to store the page results
		var tempArray:Array = new Array();
		// fill the array
		for (var i = 0; i<tempNode.childNodes.length; ++i) {
			// get the node values and names
			var nodeName:String = tempNode.childNodes[i].attributes.name;
			var nodeValue:String = tempNode.childNodes[i].firstChild.nodeValue;
			tempArray[i] = new Object();
			tempArray[i][nodeName] = nodeValue;
		}
		// return the array
		return tempArray;
	}
	public function gotoPage(moduleNumber:Number, pageNumber:Number, advanceType:Number) {
		if (advanceType != null) {
			var currPage:Number = getCurrentPage();
			var currModule:Number = getCurrentModule();
			var visitedPage:Number = getVisitedPage();
			var maxPages:Number = getModulePages(currModule)-1;
			var maxModules:Number = getModuleLength()-1;
			var returnToCourseMap:Boolean = false;
			if (advanceType == "next") {
				if (currPage<maxPages) {
					pageNumber = currPage+1;
					moduleNumber = currModule;
				} else if (currPage>=maxPages) {
					// optional looping script
					//if (currModule<maxModules) {
					//	moduleNumber = currModule+1;
					//} else if (currModule>=maxModules) {
					//	moduleNumber = 0;
					//}
					//pageNumber = 0;
					gGoToCourseMap();
					returnToCourseMap = true;
					break;
				}
			} else if (advanceType == "back") {
				if (currPage == 0) {
					gGoToCourseMap();
					returnToCourseMap = true;
					break;
				} else {
					pageNumber = currPage-1;
					moduleNumber = currModule;
				}
			} else if (advanceType == "reload") {
				pageNumber = currPage;
				moduleNumber = currModule;
			}
		}
		// if we are going back to the course map, don't do this 
		if (returnToCourseMap != true) {
			// set the page and module numbers 
			setCurrentModule(moduleNumber);
			setCurrentPage(pageNumber);
			// set the visited page
			if (pageNumber>=visitedPage) {
				setVisitedPage(pageNumber);
			}
			// put all the global data on the root 
			for (w=0; w<globalPageDataNode.childNodes.length; ++w) {
				var tempVar:String = globalPageDataNode.childNodes[w].attributes.name;
				var tempValue:String = globalPageDataNode.childNodes[w].firstChild.nodeValue;
				_root[tempVar] = tempValue;
			}
			// put all the page vars on the root
			for (i in parsePageNode(modulesNode, moduleNumber, pageNumber)) {
				for (k in parsePageNode(modulesNode, moduleNumber, pageNumber)[i]) {
					_root[k] = parsePageNode(modulesNode, moduleNumber, pageNumber)[i][k];
				}
			}
			// update the watcherObject newPageData listener
			getWatcherObject().newPageData = true;
		}
	}
	// *** end utility functions ******************************
	// *** create clean up ************************************
	// *** end clean up ***************************************
}
// *** end the Wrapper XML Class ******************************
