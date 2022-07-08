dirInput = getDirectory("Choose Input Directory"); 
dirOutput = getDirectory("Choose Output Directory"); 

run("Close All");
setBatchMode("hide"); //speeds up program
x = 0;
list = getFileList(dirInput);
count = list.length;

for (i = 0; i < count; i ++) {
	pathIn = dirInput+list[x];
	open(pathIn);
	
	name = getTitle();
	run("Split Channels");

	dapi = "C1-"+name;
	OTR = "C2-"+name;
	V1aR = "C3-"+name;
	auto = "C4-"+name;

	selectWindow(dapi);
	run("Grays");
	run("Subtract Background...", "rolling=50");

	selectWindow(OTR);
	run("Cyan");
	run("Subtract Background...", "rolling=50");

	selectWindow(V1aR);
	run("Magenta");
	run("Subtract Background...", "rolling=50");

	selectWindow(auto);
	run("Green");
	run("Subtract Background...", "rolling=50");

	imageCalculator("Subtract create", OTR, auto);
	imageCalculator("Subtract create", V1aR, auto);

	selectWindow(OTR);
	close();
	selectWindow(V1aR);
	close();

	run("Merge Channels...", "c1=["+dapi+"] c2=[Result of "+OTR+"] c3=[Result of "+V1aR+"] c4=["+auto+"] create");

	
	pathOut = dirOutput+"Processed_"+list[x];
	saveAs(".tif", pathOut);
	run("Close All");
	print("Processed: "+name);
	x = x + 1;
}
print("Processing complete");