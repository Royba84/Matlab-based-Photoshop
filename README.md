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

13) Gaussian noise - 
