/*
 * Set measurements
 * For each ROI:
 * 	For each subject:
 * 		For each image:
 * 			Convert to 8-bit
 * 			Ask user to draw ROI
 * 			Save ROI as ID_Region_...
 * 			Measure ROI
 * 			Ask if done with subject
 * 		Save IDxROI file within ROI folder
 * 		Ask if done with ROI
 * 
 */
run("Clear Results");
roiManager("reset");

run("Set Measurements...", "area mean standard min display redirect=None decimal=3");

continueProcess = true;
continueID = true;
continueRegion = true;
continueImage = true;

do {
	region = getString("Specific brain region to be measured", "Unspecified");
	do {brainID = getString("Please provide current ID", "Unspecified");
		l = 1;
		do {
			waitForUser("Open next relevant image");
			run("8-bit");

			do {
				waitForUser("Draw ROI");
				roiManager("Add");
				indexROI = RoiManager.size - 1;
				roiManager("Select",indexROI);
				newName = brainID + "_"+ region + "_" + l;
				roiManager("rename", newName); 
				roiManager("Measure");
				l = l + 1;
				continueImage = getBoolean("Would you like to measure more ROIs on this image?");
			} while (continueImage == true);
			close();
			continueID = getBoolean("Would you like to continue with this ID?");
		} while (continueID == true);
		//save IDxROI
		waitForUser("Transfer measurements now.");
		dirOutput = getDirectory("Choose Output Directory"); 
		roiManager("save", dirOutput + region + "_" +brainID+".zip");
		saveAs("Results", dirOutput + region + "_" +brainID+".txt");
		run("Clear Results");
		roiManager("reset");
		continueRegion = getBoolean("Would you like to continue with this ROI?");
	} while (continueRegion == true);
	continueProcess = getBoolean("Would you like to continue?");
} while (continueProcess == true);


