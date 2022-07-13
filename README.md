# Summer-Research-2022

## Introduction
This is the GitHub for the iOS team on Centre College's 2022 Summer Research. Here, you'll find basic information on each of the files here as well as what is needed for running the code within this repository. 

## Summer Research Project 2022
This is the primary folder for the research project; it contains the primary contents of the app, and is regularly updated from our work in XCode. You need XCode to open it and run it in a simulator. 

We were unable to add OpenCV directly to the GitHub, as the amount of files needed to upload made it entirely too much for us to feasibly push it here. As a result, you will have to download OpenCV and add it to the Frameworks on your own. This is how:

1. Go to [OpenCV's site](https://opencv.org) and navigate to **Library** and then to **Releases**.
2. Download **version 3.4.0**, which may take a few minutes. At the time of writing, version 3.4.0 was on the fifth page of results; but it may be farther inside.
3. Once it is done downloading, find the file (it will be in your Downloads folder, or if you're on Safari, it will be accessible on the upper right hand corner of the browser. If you're on Chrome, it will likely appear in a pop-up bar at the bottom of the browser) and drag it onto the Desktop. It should be a file named **opencv2.framework**.
4. Open this repository in XCode if you haven't already.
5. Drag the opencv2.framework file into the **Frameworks** folder on the left side of the screen in XCode. 
6. Now, at the top of the Navigator on the left side of the screen, click on the top line that reads **Summer Research Project 2022**. (It may be shortened as a result of how long the name is.)
7. Navigate to **Build Settings** which can be found at the top of the center part of the screen. Click on **All** directly under it, which shows all build settings (Basic and Customized may omit some build settings from view). Lastly, on the left side of the middle of the screen, click on **Summer Research Project 2022** underneath **Targets**. (Again, it may be shortened because of the length of the name.)
8. Now; Under **Architectures** on the center of the screen, find **Excluded Architectures** and expand it. Click on **Debug** and click on the **plus sign in a circle (+)** that appears.
9. Where it says **Any SDK**, click on that and find **Any iOS Simulator** on the pop-up that appears. 
10. To the right, click on the empty space and type **arm64** and press **Enter**. Without doing this, an error reading `building for iOS Simulator, but linking in object file built for iOS, for architecture arm64` would appear whenever you attempted to build this app. 
11. To test, run the app. If everything was done correctly, it should say **Build Succeeded**. If not, it will say **Build Failed**, and may display an error message. If that occurs, you may have to re-do some of the steps outlined here.

## Camera-Test
This folder contains an earlier test for opening the camera and taking pictures within an app utilizing Swift. 

## avgRGB
This file is an early test for finding the average red, green, and blue values within a given image. This code was modified and adapted into the `analyzePixels` function, which can be found in the **Summer Research Project 2022** folder. This test file would also remove any overly dark pixels, to reduce the effects of shadows or user error on the results of the function. This can be downloaded and opened in an XCode Playground.

## csv-test.playground.zip
This file is an early test to read the contents of a CSV file into a Struct defined within the function itself. This was made with usage in the app's Past Test View in mind; however, it has not yet been implemented in the app yet because we are still working on writing these structs back into the CSV file. This can be downloaded and opened in an XCode Playground. 
