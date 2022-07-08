//The purpose of this macro is to determine a consistent threshold for images. 
continueProcess = true;
run("Clear Results");
roiManager("reset");
run("Close All");

run("Brightness/Contrast...");

while(continueProcess == true) {
	waitForUser("Open next relevant image. If first image, initiate ROI-1-click tool with 20 px x 20 px rectangle.");
	name = getTitle();

	run("Split Channels");

	//Channel 1
	selectWindow("C1-"+name);
	run("Maximize");
	waitForUser("Measure 10 background locations");

	y = 0;
	averagepx=(getResult("Mean",y)+getResult("Mean",y+1)+getResult("Mean",y+2)+getResult("Mean",y+3)+getResult("Mean",y+4)+getResult("Mean",y+5)+getResult("Mean",y+6)+getResult("Mean",y+7)+getResult("Mean",y+8)+getResult("Mean",y+9))/10;
	stdv=(getResult("StdDev",y)+getResult("StdDev",y+1)+getResult("StdDev",y+2)+getResult("StdDev",y+3)+getResult("StdDev",y+4)+getResult("StdDev",y+5)+getResult("StdDev",y+6)+getResult("StdDev",y+7)+getResult("StdDev",y+8)+getResult("StdDev",y+9))/10;

	//determine threshold at average + 4 x SD
	threshold = averagepx + 4*stdv;
	print("C1-"+name+": "+threshold);
	
	run("Clear Results");
	roiManager("reset");

	//channel 2
	selectWindow("C2-"+name);
	run("Maximize");
	waitForUser("Measure 10 background locations");

	averagepx=(getResult("Mean",y)+getResult("Mean",y+1)+getResult("Mean",y+2)+getResult("Mean",y+3)+getResult("Mean",y+4)+getResult("Mean",y+5)+getResult("Mean",y+6)+getResult("Mean",y+7)+getResult("Mean",y+8)+getResult("Mean",y+9))/10;
	stdv=(getResult("StdDev",y)+getResult("StdDev",y+1)+getResult("StdDev",y+2)+getResult("StdDev",y+3)+getResult("StdDev",y+4)+getResult("StdDev",y+5)+getResult("StdDev",y+6)+getResult("StdDev",y+7)+getResult("StdDev",y+8)+getResult("StdDev",y+9))/10;

	//determine threshold at average + 4 x SD
	threshold = averagepx + 4*stdv;
	print("C2-"+name+": "+threshold);
	
	run("Clear Results");
	roiManager("reset");

	//channel 3
	selectWindow("C3-"+name);
	run("Maximize");
	waitForUser("Measure 10 background locations");

	averagepx=(getResult("Mean",y)+getResult("Mean",y+1)+getResult("Mean",y+2)+getResult("Mean",y+3)+getResult("Mean",y+4)+getResult("Mean",y+5)+getResult("Mean",y+6)+getResult("Mean",y+7)+getResult("Mean",y+8)+getResult("Mean",y+9))/10;
	stdv=(getResult("StdDev",y)+getResult("StdDev",y+1)+getResult("StdDev",y+2)+getResult("StdDev",y+3)+getResult("StdDev",y+4)+getResult("StdDev",y+5)+getResult("StdDev",y+6)+getResult("StdDev",y+7)+getResult("StdDev",y+8)+getResult("StdDev",y+9))/10;

	//determine threshold at average + 4 x SD
	threshold = averagepx + 4*stdv;
	print("C3-"+name+": "+threshold);
	
	run("Clear Results");
	roiManager("reset");
	run("Close All");
	continueProcess = getBoolean("Would you like to continue?");
}
