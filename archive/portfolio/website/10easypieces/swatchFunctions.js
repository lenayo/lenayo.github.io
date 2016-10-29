var loaded = false;

function loadSwatch (ref) {
	var tempobj;
	tempobj = new Image();
	tempobj.src = ref;
	return tempobj;
}

function changeSwatch (num) {
	if (document.layers) {
		document.layers[divName].document.images[imgName].src = imgList[num].src;
	} else {
		document.images[imgName].src = imgList[num].src;
	}
}

function nextSwatch () {
	if (!loaded) {return false}
	curNum = (curNum<imgLen) ? curNum+1 : 0 ;
	changeSwatch (curNum);
}

function previousSwatch () {
	if (!loaded) {return false}
	curNum = (curNum>0) ? curNum-1 : imgLen ;
	changeSwatch (curNum);
}

