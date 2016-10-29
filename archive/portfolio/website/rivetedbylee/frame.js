if (parent.frames.length > 0)
{
	if (typeof parent.frames["rivetedframetest"] == "undefined")
	{	
		top.location.href = document.location.href
	}
}


if (parent.frames.length == 0 && document.location.search.indexOf("frameFlag=true") == -1)
{
	thispage = location.href.substring(location.href.lastIndexOf("/")+1,location.href.length)
	if (thispage == "" || thispage == null || typeof thispage == "undefined")
	{
		thispage = "default.asp"
	}
	if (document.location.search.length <= 0)
	{
		searchChar = "?"
	}
	else
	{
		searchChar = "&"
	}
	document.write(
	"<frameset cols='*,780,*' border='0' framespacing='0' frameborder='NO'>"
	+ "<frame src='black.html' name='rivetedframetest' marginheight='0' marginwidth='0' scrolling='NO' noresize>"
	+ "<frameset rows='*,445,*' border='0' framespacing='0' frameborder='NO'>"
	+ "<frame src='black.html' name='top' marginheight='0' marginwidth='0' scrolling='NO' noresize>"
	+ "<frame src='" + thispage + searchChar + "frameFlag=true' name='main' marginheight='0' marginwidth='0' scrolling='NO' noresize>"
	+ "<frame src='black.html' name='bottom' marginheight='0' marginwidth='0' scrolling='NO' noresize>"
	+ "<\/frameset>"
	+ "<frame src='black.html' name='right' marginheight='0' marginwidth='0' scrolling='NO' noresize>"
	+ "<\/frameset>"
	);
}


if (document.layers)
{
	origWidth = window.innerWidth
	origHeight = window.innerHeight
	window.onResize = fixTheDamnBugInNetscape
}
function fixTheDamnBugInNetscape ()
{
	if (origWidth != window.innerWidth || origHeight != window.innerHeight)
	{
		window.location.reload()
	}
}