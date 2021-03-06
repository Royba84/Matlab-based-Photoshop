# MATLAB based Photoshop 

GUI explanation:

 # First tab - Handling images:

1) Loading image to the workspace - ![image](https://user-images.githubusercontent.com/105777016/178099278-b61e41a3-6ee3-4b69-9d6e-ee31e803055b.png)

As long as  image was not uploaded to the workspace - all the other contents & features are not functioning (disabled).

Loading image will be done in the following way:
- Press the button.
- Pick the relevant image in the prompt (as shown below):
![image](https://user-images.githubusercontent.com/105777016/178099315-06fe00a1-43d6-4d4a-98cf-7d5b5efee3d9.png)
- Finally, click on "open" and then the image will be shown on the axis in the application center:
![image](https://user-images.githubusercontent.com/105777016/178099331-19867216-5d22-4fde-a81e-e2170b2899a4.png)

In order to implement this content I used the following MATLAB functions: imread() ; imshow().

2) Save Image from the workspace - ![image](https://user-images.githubusercontent.com/105777016/178099386-6ff82926-ec8e-4fe9-8757-19cc37de5aa2.png)

Saving image will be done in the following way:
- Press the button "Save as..."
- Afterwards the following prompt will pop, the user will have to choose the path to save the image or by navigating windows folders + the user has to choose the file name in the appropriate section:
![image](https://user-images.githubusercontent.com/105777016/178099433-fda6183b-4c3b-40f7-9ef5-2e3eccaa766e.png)

- Finally, the user has to click on "Save".

In order to implement this content I used the following MATLAB function: imwrite().

 *Note* - From now on, for each content listed, the whole actions and changes will be presented in the workspace on top of the axis (in the application main window).
 
 # Second tab - Geometric operations:
 
 3) Image resize - by scrolling a slider, the image size can be changed (enlarged/minimized) times the value that was chosen with the cursor - ![image](https://user-images.githubusercontent.com/105777016/178099551-382ecaae-b30b-47b6-b69d-5a809d4027ca.png)

In order to implement this content I used the following MATLAB function: imresize() + if the user choose to minize the image I padded with '0' (black background) the background using padarray().

4) Image rotation - ![image](https://user-images.githubusercontent.com/105777016/178099651-8aa58128-57eb-4c3b-a4e7-88a8ee9eb40e.png)

 can be made in a few ways:
- 90 degrees clockwise.
- 90 degrees counterclockwise.
- 180 degrees for each direction with crop.
- 180 degrees for each direction without crop.

In order to implement this content I used the following MATLAB function: imrotate().

5) Vertical & Horizontal Mirroring - ![image](https://user-images.githubusercontent.com/105777016/178099691-fdb3aa9f-6701-4991-8dbc-b075d57e8fbc.png)

The user has to press the kind of mirroring he wants (vertical / horizontal)

In order to implement this content I used the following MATLAB function: flip().


6) Affine Transform - ![image](https://user-images.githubusercontent.com/105777016/178099734-50a59940-6140-4752-9f15-067f4331292f.png)

 The user can choose between 2 kinds of affinic transormations:
 1) Shear - values range [2,-2].
 2) Translation - values range - limitless.
 
 *Note* - after loading the image into the workspace, shear transformation will be chosen as default.
 The user can choose between the options using the drop down menu:
 ![image](https://user-images.githubusercontent.com/105777016/178100272-84ea8b04-77dd-40fc-8b2d-122acbe52a9c.png)
 According to the users choice, the application will enable accordingly the relevant section for the chosen transformation.
 After picking the kind of transformation, the use can enter custom values in the "Edit" field according to the legal values mentioned before.
 If the user enters a value that violate those who were set - an error message will be presented on the screen where he will be ordered to change values.
 Finally, the user has to click on "Apply Transformation".
 
In order to implement this content I used the following MATLAB function: affine2d() which calculates the chosen transformation and being called by imwrap().


 
7) Image crop - ![image](https://user-images.githubusercontent.com/105777016/178100384-51fd03ef-8032-4205-9532-9752f6d05377.png)

Image cropping will be made by click the "crop" button. 
After the button was clicked, the user will have to choose a ROI (Region of intrest) by dragging the cursor (when the left key is pressed) on the axis.
Finally, in order to confirm the crop, the user has to double-click on the axis.

In order to implement this content I used the following MATLAB function: imcrop().


 # Third tab - Point/Pixel operations:
 
 8) Brightness - ![image](https://user-images.githubusercontent.com/105777016/178100477-fe4ac96f-8e57-4fc9-bc88-46d4f255d730.png)
 
 The image brightness can be changed by dragging the slider.
 The change is made by adding offset to the pixels shade on all channels.
 It is worth to mention that there is no deviation from the range [0-255], RGB values.
 
 
 9) Contrast - ![image](https://user-images.githubusercontent.com/105777016/178100545-d134eb7d-dcd9-40d1-869c-6ba9c8f2885f.png)

 The image contrast can be changed by dragging the slider or by pressing "Auto - contrast" button.
 "Auto - contrast" is recommended when the image shades are not streching to all 0-255 range, this function enables this kind of strech in all channels.
 In order to change the contrast using a slider I multiplied the value we changed in the pixel on the whole channels.
 
 In order to implement this content I used the following MATLAB function: imadjust().

10) Histogram Equalization - ![image](https://user-images.githubusercontent.com/105777016/178100656-cf073807-352f-4d73-94c8-b9617c34bb78.png)

After pressing the button, the image shown on the axis is being converted to HSV color domain.
The histogram equlization is being made in the V (Value) component and there is use in histeq() function.
Afterwards the image is being converted back to RGB color domain and I made sure there is no deviation from the [0-255] range.

*Note* - If the image is in gray scale, the histogram equalization is being made only on 1 channel using histeq().



11) Auto Sharpening - ![image](https://user-images.githubusercontent.com/105777016/178100727-b8983aac-f0bf-4c8c-bdc9-dfff18e64151.png)

After pressing the button, a sharper image will be presented on the axis so that the edges are bolder.
In order to implement this content I used the following MATLAB function: imsharpen().


 # Fourth tab - Noise operations:
 
 12) Salt & Pepper noise - ![image](https://user-images.githubusercontent.com/105777016/178100779-c8d9e599-f053-42b5-a339-334386b62ae7.png)

In order to add salt & pepper noise to the image the user has to type in the edit field the noise density which varies from 0.05 to 0.5 (default - 0.05).
Afterwards the user has to click "Apply".
The user can also remove the noise by pressing "Remove noise".

To implement the noise I used imnoise() which gets the noise density from the edit field value entered by the user and to remove the noise I used median filter - medfilt2() which filters across all the channels.

13) Gaussian noise - ![image](https://user-images.githubusercontent.com/105777016/178100875-e2320bad-581d-4797-8c15-3c6694f895e5.png)

In order to add gausian noise to the image the user has to type the variance value in the edit field. the default value is 0.01 and the range is between 0 to 1.
Eventually the user has to press "Apply".
In order to remove gaussian noise I implemented 2 methods which can be chosen from the drop-down menu:

![image](https://user-images.githubusercontent.com/105777016/178100918-d4235cd5-2cd2-4d89-9758-d55366c891da.png)

Using average filter or Wiener filter.
Using imnoise() I produced the gaussian noise (with the string ' gaussian' as function input).

Wiener filter - In order to create him i used the function wiener2() which gets the noisy image as input, the filter dimensions are 5x5.
Average filter - In order to creat him I used the function fspecial() which gets the string 'average' as input (and the noisy image of course), the filter dimensions are 3x3.



 # Fifth tab - Effects:
 
 
 14) Atistic effects - ![image](https://user-images.githubusercontent.com/105777016/178101022-311b0dfb-0535-4f0a-981a-c7759a1db0cf.png)

  1) Vintage - Converting the input image into an "old fashioned" style. In case that the image is in RGB format it is converted to a "golden" image and if the image is gray scale, the user will be notified an error that gray image can't be "vintaged".

Implementation - In order to make the vintage effect, I seperated the RGB channels changed their values and reunited them.

  2) Negative - After pressing on the negative button, a complementary image will be created that complement the original pixel values from the original image.
If the image is in gray scale the following operation is made : 255-pixel_value= complementary_value.
If the image is in RGB format, the operation above is being done for each channel seperately (R.G.B).

Implementation - used the function imcomplement().

  3) Black & White - Converting the original image to "Black & white".
In case that the image in RGB format, first there is conversion to grayscale using the function rgb2gray(). 
If the image is grayscale the image is being binarized using imbinarize() (this step is being made to RGB image too after being converted to gray).

  4) Sinusoaidal Transformation - Effect which allows to convert the image to sinusoaidal view which gives "waving flag" effect.
This effect was made using sinusoaidal transformation as i wrote this specific lines of code:
![image](https://user-images.githubusercontent.com/105777016/178101251-3551f3a0-5505-47d3-8965-e76abca0f8c2.png)

This effect was implemented using geometrictransform2d() for the sinusoaidal transformation and imwrap() to apply the transformation on our image.

  5) Pencil drawing - Converts the image to "Pencil drawing" effect. 
The principle behind this effect is "edge detection". If the image is in RGB format it is being converted to grayscale. If it is already in grayscale we will keep it as it is and create the following filter:

![image](https://user-images.githubusercontent.com/105777016/178101316-3d4ce5a6-bbcd-4eb4-98a6-62bbd854ac64.png)

This filter is being used on our image using imfilter() which using convolution.
After the convolution, again the same calculation we saw on the negative effect is being made:
255-pixel_value=complementary_value.

  6) Blur - Allows to blur the original image.
Was implemented using imgaussfilt(). The function gets the image we want to blur with the standard deviation of '7'.

  7) Flip Red & Blue - Effect that flips between R and B color channels.
If the image is in RGB format it is being divided to the 3 channels and simply I swap between the blue and red channels and unite them afterwards.
*Note* - This effect can't take place on grayscale image (obviously because there are no Red and Blue color channels .. ;-) )

  8) Flip Green & Blue - Same as (7) but this time i swap between the Green and blue color channels.


# 15) Special effect : Add Text 

![image](https://user-images.githubusercontent.com/105777016/178101500-2b006107-3c4c-42f1-90b5-e8189a8bc464.png)


The user has to pick the desired font from the drop-down menu: (default - Times New Roman)

![image](https://user-images.githubusercontent.com/105777016/178101502-0b95a9e9-8068-4923-b474-11e3ab81fc5c.png)

Afterwards, the user has to pick the font size using the spiner (the value can be typed directly or be changed using the up/down arrow buttons). (defualt size - 50)
And then the user has to choose the text color by clicking on "Choose color" button.
The following window will pop-up: (default text color - black)
![image](https://user-images.githubusercontent.com/105777016/178101547-a4f9b7a7-e24f-4825-844b-105b069ee6e6.png)

Next, the user has to type the desired text in the field "Enter text here".
After pressing the button "Create the text" the user has to place the cursor in the desired location he wants to add the text on the top of the image.

Eventually the text will be assimilated in the original image.

In order to implement this effect I used the function insertText() which gets as input the parameters chosen by the user (font type, font size, color etc...)



Complementary contents:

Those contents are not so special but yet are crucial for the solid functioning of the application and deserved to be shown:

1) Reload - This button allows the user to return the original image that was loaded BEFORE all the changes that were made. actually it is a speedy way to reload that same picture to start over, this in order to make the application ease to use.
It was implemented by storing the original image right after loading her in the first time inside the variable - "app.Original_image".

2) Undo - This button as his name might imply allows the user to cancel the last (or few last) actions that were made to quickly handle mistakes while editing.
It is possible to return to the original image (by clicking a while.. for that we have the reload button). If one clicked and returned to the original image and tries to click again an error message will be presented which says : "No more previous images".

In order to implement this button i used cell array. With the program initiation a cell array is created empty and saved inside the variable "app.Previous_image".
Before making any new action within the application, the current image that shown on the axis is being stored inside the cell array in a way that the last image shown is the first to be accessed in case of button invoke:

![image](https://user-images.githubusercontent.com/105777016/178101880-e8c46662-3add-482c-b139-33adf4ab8294.png)

after cliking "undo" the last image is being called from the cell array and stored in temporary variable "pre", the last saved image in the cell array is being deleted and the image stored in "pre" is being showed on the screen:

![image](https://user-images.githubusercontent.com/105777016/178101930-314a36e2-97f9-4e08-80d9-17bd69b56f6a.png)

3) The main screen - "axis":

![image](https://user-images.githubusercontent.com/105777016/178101948-5a6aa395-b735-46b9-98c1-9e42d8df2d57.png)

In order to show what I do on the screen i used a graphic tool names "axis", within the application callbacks it is called : "app.ImageAxis".
In order to link between the axis to our actions I saved the new image that operation was made on her inside the variable : "app.Presented_image".
After the operation was done the new image will be shown on the axis - meaning on the screen :

![image](https://user-images.githubusercontent.com/105777016/178102002-1d43e833-b1c9-403d-aa4e-909153f3dcd3.png)



The END
Hopefully you will find those explanations helpful.
Roy.
