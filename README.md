MATLAB based Photoshop

GUI explanation:

First tab - Handling images:

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
 
 
