initializeSciJavaParameters ( );
input = getDir("Choose input directory");
output_scaled = getDir("Choose output directory for scaled images");
output_8bit = getDir("Choose output directory for 8bit images");
output_crop = getDir("Choose output directory for cropped images");
output_thresholded = getDir("Choose output directory for thresholded images");

d = getNumber("Enter image length in pixels: ", 1408);
k = getNumber("Enter known length of image in microns: ", 1750);

threshold_min = getNumber("Enter min for threshold: ", 0);
threshold_max = getNumber("Enter max for threshold: ", 112);

x1 = getNumber("Enter x: ", 400);
y1 = getNumber("Enter y: ", 360);
x2 = getNumber("Enter w: ", 420);
y2 = getNumber("Enter h: ", 440);

function cropthreshold() {
print(i);
c1 = list[i];
open(input + c1);
run("Set Scale...", "distance=d known=k unit=microns");
saveAs("Tiff", output_scaled + c1);
close();
open(output_scaled + c1);
run("8-bit");
saveAs("Tiff", output_8bit + c1);
close();
open(output_8bit + c1);
//selectWindow(input + c1);
makeRectangle(x1, y1, x2, y2);
run("Crop");
saveAs("Tiff", output_crop + c1);
close();
open(output_crop + c1);
//selectWindow(output_crop + c1);
setAutoThreshold("Default dark");
//run("Threshold...");
setThreshold(threshold_min, threshold_max, "raw");
//setThreshold(0, 100);
setOption("BlackBackground", false);
run("Convert to Mask");
saveAs("Tiff", output_thresholded + c1 + "crop");
close();
}

setBatchMode(true);
list = getFileList(input);
for (i = 0; i < list.length; i++) {
	cropthreshold();
	close("*");
	}
setBatchMode(false);
