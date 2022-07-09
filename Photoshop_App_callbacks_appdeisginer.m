classdef Photoshop < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        undoButton                      matlab.ui.control.Button
        ReloadButton                    matlab.ui.control.Button
        TabGroup                        matlab.ui.container.TabGroup
        HandlingImagesTab               matlab.ui.container.Tab
        WelcomePleaseloadanimagetostartLabel  matlab.ui.control.Label
        SaveAsButton                    matlab.ui.control.Button
        LoadanimageButton               matlab.ui.control.Button
        GeomatricOperationsTab          matlab.ui.container.Tab
        CropPanel                       matlab.ui.container.Panel
        CropButton                      matlab.ui.control.Button
        MirroringPanel                  matlab.ui.container.Panel
        VerticalButton                  matlab.ui.control.Button
        HorizontalButton                matlab.ui.control.Button
        RotationPanel                   matlab.ui.container.Panel
        RotatewithcropSlider            matlab.ui.control.Slider
        RotatewithcropSliderLabel       matlab.ui.control.Label
        RotatewithoutcropSlider         matlab.ui.control.Slider
        RotatewithoutcropSliderLabel    matlab.ui.control.Label
        Rotate90RightButton             matlab.ui.control.StateButton
        Rotate90LeftButton              matlab.ui.control.StateButton
        ResizePanel                     matlab.ui.container.Panel
        Image                           matlab.ui.control.Image
        Label_2                         matlab.ui.control.Label
        DragtoresizeSlider              matlab.ui.control.Slider
        DragtoresizeSliderLabel         matlab.ui.control.Label
        AffineTransformPanel            matlab.ui.container.Panel
        TranslationPanel                matlab.ui.container.Panel
        YTranslationEditField           matlab.ui.control.NumericEditField
        YTranslationLabel               matlab.ui.control.Label
        XTranslationEditField           matlab.ui.control.NumericEditField
        XTranslationLabel               matlab.ui.control.Label
        ShearPanel                      matlab.ui.container.Panel
        YShearEditField                 matlab.ui.control.NumericEditField
        YShearEditFieldLabel            matlab.ui.control.Label
        XShearEditField                 matlab.ui.control.NumericEditField
        XShearEditFieldLabel            matlab.ui.control.Label
        ChooseAffineTransformDropDown   matlab.ui.control.DropDown
        ChooseAffineTransformDropDownLabel  matlab.ui.control.Label
        ApplyTransformationButton       matlab.ui.control.Button
        PointOperationsTab              matlab.ui.container.Tab
        AutoSharpeningPanel             matlab.ui.container.Panel
        AutoSharpeningButton            matlab.ui.control.Button
        contrastPanel                   matlab.ui.container.Panel
        autocontrastButton              matlab.ui.control.StateButton
        Image3                          matlab.ui.control.Image
        DragtochangecontrastSlider      matlab.ui.control.Slider
        DragtochangecontrastSliderLabel  matlab.ui.control.Label
        HistogramEqualizationPanel      matlab.ui.container.Panel
        HistogramEqualizationButton     matlab.ui.control.Button
        BrightnessPanel                 matlab.ui.container.Panel
        DragtochangebrightnessSlider    matlab.ui.control.Slider
        DragtochangebrightnessSliderLabel  matlab.ui.control.Label
        Image2                          matlab.ui.control.Image
        NoiseOperationsTab              matlab.ui.container.Tab
        SaltPepperNoisePanel            matlab.ui.container.Panel
        RemoveNoiseButton_2             matlab.ui.control.Button
        RemovesaltpeppernoiseLabel      matlab.ui.control.Label
        ApplyButton_2                   matlab.ui.control.Button
        DensityEditField                matlab.ui.control.NumericEditField
        DensityEditFieldLabel           matlab.ui.control.Label
        Label_3                         matlab.ui.control.Label
        AddSaltPeppernoiseLabel         matlab.ui.control.Label
        GaussianNoisePanel              matlab.ui.container.Panel
        ChooseremovalmethodDropDown     matlab.ui.control.DropDown
        ChooseremovalmethodDropDownLabel  matlab.ui.control.Label
        RemoveNoiseButton               matlab.ui.control.Button
        RemoveGaussiannoiseLabel        matlab.ui.control.Label
        ApplyButton                     matlab.ui.control.Button
        VarianceEditField               matlab.ui.control.NumericEditField
        VarianceEditFieldLabel          matlab.ui.control.Label
        AddGaussiannoiseLabel           matlab.ui.control.Label
        EffectsTab                      matlab.ui.container.Tab
        AddTextPanel                    matlab.ui.container.Panel
        FontsizeSpinner                 matlab.ui.control.Spinner
        FontsizeSpinnerLabel            matlab.ui.control.Label
        ChooseColorButton               matlab.ui.control.Button
        FontDropDown                    matlab.ui.control.DropDown
        FontDropDownLabel               matlab.ui.control.Label
        CreatethetextButton             matlab.ui.control.Button
        AddTextEditField                matlab.ui.control.EditField
        AddTextEditFieldLabel           matlab.ui.control.Label
        ArtisticEffectsPanel            matlab.ui.container.Panel
        FlipGreenBlueButton             matlab.ui.control.Button
        FlipRedGreenButton              matlab.ui.control.Button
        FlipRedBlueButton               matlab.ui.control.Button
        PencilDrawingButton             matlab.ui.control.Button
        BlurButton                      matlab.ui.control.Button
        SinusoidalTransformationButton  matlab.ui.control.Button
        BlackWhiteButton                matlab.ui.control.Button
        NegativeButton                  matlab.ui.control.Button
        VintageButton                   matlab.ui.control.Button
        ImageAxis                       matlab.ui.control.UIAxes
    end


    properties (Access = public)
        Original_image % The most recent image we loaded
        Presented_image % The image that is currently shown in ze program
        Previous_image = {}; % The image that was shown before the current Presented_image
    end
    
    properties (Access = private)
        TextColor=[0,0,0]; % Color of added text, default - black
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadanimageButton
        function LoadanimageButtonPushed(app, event)
            [baseFileName, folder] = uigetfile({'*.*';'*.jpg';'*.png';'*.bmp';'*.tiff';'*.jpeg'},'Select an image');
            source = fullfile(folder, baseFileName);
            try
                app.Presented_image= imread(source);
                %Here we update the original image we've read
                app.Original_image=app.Presented_image;
                imshow(app.Presented_image, 'parent', app.ImageAxis)
                app.Previous_image ={};
                app.SaveAsButton.Enable=1; %We save only after we load an image (You can't save nothing)

                %-----------------------enable tools -----------------------
                % Get all the handles to everything we want to set in a single array.
                handleArray = [app.MirroringPanel, app.RotationPanel,app.ResizePanel , app.AffineTransformPanel, app.CropPanel];
                set(handleArray, 'Enable', 'on');
                app.ChooseAffineTransformDropDown.Value = 'Shear';
                app.ShearPanel.Enable = 'on';
                app.TranslationPanel.Enable = 'off';
                app.ReloadButton.Enable = 'on';
                app.undoButton.Enable = 'on';
                pointOperationsHanflers = [app.BrightnessPanel app.contrastPanel  app.HistogramEqualizationPanel];
                set(pointOperationsHanflers, 'Enable', 'on');
                app.GaussianNoisePanel.Enable='on';
                app.ArtisticEffectsPanel.Enable='on';
                app.AddTextPanel.Enable='on';
                app.AutoSharpeningPanel.Enable='on';
                app.SaltPepperNoisePanel.Enable='on';

               
            catch
                warning('Invalid file, format or directory.')
                msgbox('Invalid file or format, please try again please.')
            end
        end

        % Button pushed function: SaveAsButton
        function SaveAsButtonPushed(app, event)
            %            app.Previous_image{end+1}=app.Presented_image;
            try
                filter = {'.jpeg';'.png';'.jpg';'.jfif';'.bmp'};
                [file,path] = uiputfile(filter);
                fullpath = fullfile(path,file);
                imwrite(app.Presented_image,fullpath);
                msgbox('Successfuly Saved.')
            catch
                warning('Inavlid file or format, Please try again.')
                msgbox('invalid path, format or file please try again')
            end
        end

        % Value changed function: DragtoresizeSlider
        function DragtoresizeSliderValueChanged(app, event)
            value = app.DragtoresizeSlider.Value;
            app.Previous_image{end+1}=app.Presented_image;
            %Save the old sizes
            [old_Rows, old_Colms, ~]=size(app.Presented_image);
            %resize the image
            app.Presented_image=imresize(app.Presented_image,value);
            %Save the new sizes
            [new_Rows, new_Colms, ~]=size(app.Presented_image);
            diff_Rows=round((old_Rows-new_Rows)/2);
            diff_Colms=round((old_Colms-new_Colms)/2);
            if diff_Rows>0
                %Padding with zeros (in case the image becoming smaller - black background)
                app.Presented_image = padarray(app.Presented_image,[diff_Rows  diff_Colms],0,'both');
                %Resize back to old image
                app.Presented_image=imresize(app.Presented_image,[old_Rows old_Colms]);
            else
                app.Presented_image = imcrop(app.Presented_image,[-diff_Colms -diff_Rows old_Colms old_Rows]);
            end
            imshow(app.Presented_image ,'Parent',app.ImageAxis)
            app.DragtoresizeSlider.Value=1; %Return ze slider to the default location


        end

        % Value changed function: RotatewithcropSlider
        function RotatewithcropSliderValueChanged(app, event)
            value = app.RotatewithcropSlider.Value;
            app.Previous_image{end+1}=app.Presented_image;
            app.Presented_image=imrotate(app.Presented_image,value,'bilinear','crop');
            imshow(app.Presented_image,'Parent',app.ImageAxis);
            app.RotatewithcropSlider.Value=0;%Return ze slider to the default location
        end

        % Value changed function: RotatewithoutcropSlider
        function RotatewithoutcropSliderValueChanged(app, event)
            value = app.RotatewithoutcropSlider.Value;
            app.Previous_image{end+1}=app.Presented_image;
            app.Presented_image=imrotate(app.Presented_image,value,'bilinear','loose');
            imshow(app.Presented_image,'Parent',app.ImageAxis);
            app.RotatewithoutcropSlider.Value=0;%Return ze slider to the default location
        end

        % Button pushed function: HorizontalButton
        function HorizontalButtonPushed(app, event)
            app.Previous_image{end+1}=app.Presented_image;
            app.Presented_image=flip(app.Presented_image,2);
            imshow(app.Presented_image,'Parent',app.ImageAxis);
        end

        % Button pushed function: VerticalButton
        function VerticalButtonPushed(app, event)
            app.Previous_image{end+1}=app.Presented_image;
            app.Presented_image=flip(app.Presented_image,1);
            imshow(app.Presented_image,'Parent',app.ImageAxis);
        end

        % Button pushed function: ApplyTransformationButton
        function ApplyTransformationButtonPushed(app, event)
            app.Previous_image{end+1}=app.Presented_image;
            value = app.ChooseAffineTransformDropDown.Value;
            try
                switch value
                    case 'Shear'
                        xShear = double(app.XShearEditField.Value);
                        yShear = double(app.YShearEditField.Value);
                        matrix = [1 yShear 0 ; xShear 1 0 ; 0 0 1];
                        tform = affine2d(matrix);
                        app.Presented_image = imwarp(app.Presented_image, tform);
                        imshow(app.Presented_image,'Parent',app.ImageAxis);

                    case 'Translation'
                        xTranslation = double(app.XTranslationEditField.Value);
                        yTranslation = double(app.YTranslationEditField.Value);
                        matrix = [1 0 0 ; 0 1 0 ; xTranslation yTranslation 1];
                        tform = affine2d(matrix);
                        sameAsInput = affineOutputView(size(app.Presented_image),tform,'BoundsStyle','SameAsInput');
                        app.Presented_image = imwarp(app.Presented_image,tform,'OutputView',sameAsInput);
                        imshow(app.Presented_image,'Parent',app.ImageAxis);
                end
            catch
                warning('Inavlid input, Please try again.');
                msgbox('invalid input,  please try again');
            end

        end

        % Value changed function: Rotate90LeftButton
        function Rotate90LeftButtonValueChanged(app, event)
            app.Previous_image{end+1}=app.Presented_image;
            app.Presented_image=imrotate(app.Presented_image,90,'bilinear','loose');
            imshow(app.Presented_image, 'parent', app.ImageAxis);
        end

        % Value changed function: Rotate90RightButton
        function Rotate90RightButtonValueChanged(app, event)
            app.Previous_image{end+1}=app.Presented_image;
            app.Presented_image=imrotate(app.Presented_image,-90,'bilinear','loose');
            imshow(app.Presented_image, 'parent', app.ImageAxis);
        end

        % Value changed function: ChooseAffineTransformDropDown
        function ChooseAffineTransformDropDownValueChanged(app, event)
            value = app.ChooseAffineTransformDropDown.Value;
            switch value
                case 'Shear'
                    app.ShearPanel.Enable = 'on';
                    app.TranslationPanel.Enable = 'off';
                case 'Translation'
                    app.TranslationPanel.Enable = 'on';
                    app.ShearPanel.Enable ='off';
            end
        end

        % Button pushed function: ReloadButton
        function ReloadButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image = app.Original_image;
            imshow(app.Presented_image,'Parent',app.ImageAxis);
        end

        % Button pushed function: HistogramEqualizationButton
        function HistogramEqualizationButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            s = size(app.Presented_image,3);
            %the presented image is a rgb image if s ==3
            if s ==3

                hsv = rgb2hsv(app.Presented_image);
                v = hsv(:,:,3);
                v = histeq(v);
                hsv(:,:,3) = v;
                app.Presented_image = uint8(hsv2rgb(hsv)*255);
                imshow(app.Presented_image,'Parent',app.ImageAxis);
            else
                %the presented image is a grayscale image if s ==1
                app.Presented_image = histeq(app.Presented_image);
                imshow(app.Presented_image,'Parent',app.ImageAxis);
            end

        end

        % Value changed function: DragtochangebrightnessSlider
        function DragtochangebrightnessSliderValueChanged(app, event)
            brightness = app.DragtochangebrightnessSlider.Value;
            app.Previous_image{end+1} = app.Presented_image;

            % brightness operations is to add off
            newImage = uint8(double(app.Presented_image) + brightness);
            app.Presented_image = newImage;
            app.DragtochangebrightnessSlider.Value = 0;
            imshow(app.Presented_image,'Parent',app.ImageAxis);

        end

        % Value changed function: autocontrastButton
        function autocontrastButtonValueChanged(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            levels = stretchlim(app.Presented_image);
            app.Presented_image = imadjust( app.Presented_image, levels, [0 1]);
            imshow(app.Presented_image ,'Parent',app.ImageAxis);
        end

        % Value changed function: DragtochangecontrastSlider
        function DragtochangecontrastSliderValueChanged(app, event)
            contrast = app.DragtochangecontrastSlider.Value;
            app.Previous_image{end+1} = app.Presented_image;
            newImage = uint8(double(app.Presented_image)*contrast );
            app.Presented_image = newImage;
            app.DragtochangecontrastSlider.Value = 1;
            imshow(app.Presented_image,'Parent',app.ImageAxis);
        end

        % Button pushed function: undoButton
        function undoButtonPushed(app, event)
            try
                pre = app.Previous_image{end};
                app.Previous_image = app.Previous_image(1:end-1);
                app.Presented_image =pre;
                imshow(app.Presented_image,'Parent',app.ImageAxis);
            catch
                warning('Not possible.');
                msgbox('No more previous images');
            end
        end

        % Button pushed function: ApplyButton
        function ApplyButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            variance= app.VarianceEditField.Value;
            try
                %assume the Gaussian mean is 0
                app.Presented_image=imnoise(app.Presented_image,'gaussian',0, variance);
            catch
                warning('Operation failed');
                msgbox('Operation failed');
            end
            imshow(app.Presented_image, 'parent', app.ImageAxis);
        end

        % Button pushed function: RemoveNoiseButton
        function RemoveNoiseButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            value=app.ChooseremovalmethodDropDown.Value;

            switch value
                case 'Wiener'


                    for i=1:size(app.Presented_image,3)
                        app.Presented_image(:,:,i)=wiener2(app.Presented_image(:,:,i),[5,5]);

                    end
                    imshow(app.Presented_image, 'parent', app.ImageAxis);

                case 'Average'
                    %create average filter to remove gaussian noise
                    f = fspecial('average',3);
                    %if it is a true color, do filetration in all channels
                    app.Presented_image = imfilter(app.Presented_image ,f);
                    imshow(app.Presented_image, 'parent', app.ImageAxis);
            end
        end

        % Button pushed function: ApplyButton_2
        function ApplyButton_2Pushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            density= app.DensityEditField.Value;
            try

                app.Presented_image=imnoise(app.Presented_image,'salt & pepper',density);
            catch
                warning('Operation failed');
                msgbox('Operation failed');
            end
            imshow(app.Presented_image, 'parent', app.ImageAxis);


        end

        % Button pushed function: RemoveNoiseButton_2
        function RemoveNoiseButton_2Pushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;

            for i=1:size(app.Presented_image,3)
                app.Presented_image(:,:,i)=medfilt2(app.Presented_image(:,:,i)); %3x3 neighborhood

            end
            imshow(app.Presented_image, 'parent', app.ImageAxis);


        end

        % Button pushed function: AutoSharpeningButton
        function AutoSharpeningButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image=imsharpen(app.Presented_image);
            imshow(app.Presented_image, 'parent', app.ImageAxis);


        end

        % Button pushed function: CropButton
        function CropButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image=imcrop(app.ImageAxis);
            imshow(app.Presented_image, 'parent', app.ImageAxis);
        end

        % Button pushed function: VintageButton
        function VintageButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            try
                RedChannel = app.Presented_image(:, :, 1);
                GreenChannel = app.Presented_image(:, :, 2);
                BlueChannel = app.Presented_image(:, :, 3);
     
                NewRed= (RedChannel*0.393)+ (GreenChannel*0.769)+(BlueChannel*0.189);
                NewGreen= (RedChannel*0.349)+ (GreenChannel*0.686)+(BlueChannel*0.168);
                NewBlue=(RedChannel*0.272)+ (GreenChannel*0.534)+(BlueChannel*0.131);

                app.Presented_image= cat(3, NewRed,NewGreen,NewBlue);
                imshow(app.Presented_image, 'parent', app.ImageAxis)
            catch 
                 warning('Not possible to implement the effect on gray image.')
                 msgbox('Not possible to implement the effect on gray image.')
            end
        end

        % Button pushed function: NegativeButton
        function NegativeButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image=imcomplement(app.Presented_image);
            imshow(app.Presented_image, 'parent', app.ImageAxis);
        end

        % Button pushed function: BlackWhiteButton
        function BlackWhiteButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            channels=size(app.Presented_image,3);
            if(channels==3)
                app.Presented_image=rgb2gray(app.Presented_image);
            end
            app.Presented_image=imbinarize(app.Presented_image);
            app.Presented_image=255*uint8(app.Presented_image);

            imshow(app.Presented_image, 'parent', app.ImageAxis);


        end

        % Button pushed function: CreatethetextButton
        function CreatethetextButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            
            txt=app.AddTextEditField.Value;
            Font=app.FontDropDown.Value; %Font type
            FontSize=app.FontsizeSpinner.Value; %Font Size

            Point=drawpoint(app.ImageAxis);
            position=Point.Position; % x,y coordinates
            
            app.Presented_image=insertText(app.Presented_image,position,txt,'Font',Font,'FontSize',FontSize,'TextColor',app.TextColor,'BoxOpacity',0);
            imshow(app.Presented_image, 'parent', app.ImageAxis);


        end

        % Button pushed function: ChooseColorButton
        function ChooseColorButtonPushed(app, event)
            title='Please choose a color:';
           app.TextColor=round(255*uisetcolor(title));
          
        end

        % Button pushed function: SinusoidalTransformationButton
        function SinusoidalTransformationButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;

            nrows = size(app.Presented_image,1);
            ncols = size(app.Presented_image,2);

            a = ncols/12; % Try varying the amplitude of the sinusoid
            ifcn = @(xy) [xy(:,1), xy(:,2) + a*sin(2*pi*xy(:,1)/nrows)];
            tform = geometricTransform2d(ifcn);
            app.Presented_image = imwarp(app.Presented_image,tform);
            imshow(app.Presented_image, 'parent', app.ImageAxis);

        end

        % Callback function
        function BarrelTransformationButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image = imresize(app.Presented_image, [NaN, 1080]);
            f = waitbar(0,'Please wait...');
            nrows = size(app.Presented_image,1);
            ncols = size(app.Presented_image,2);

            [xi,yi] = meshgrid(1:ncols,1:nrows);
            xt = xi - ncols/2;
            yt = yi - nrows/2;
            
            waitbar(.33,f,'Processing your data');
            [theta,r] = cart2pol(xt,yt);
            a = 1; % Try varying the amplitude of the cubic term.
            rmax = max(r(:));
            s1 = r + r.^3*(a/rmax.^2);
            [ut,vt] = pol2cart(theta,s1);
            ui = ut + ncols/2;
            vi = vt + nrows/2;
            ifcn = @(c) [ui(:) vi(:)];
            waitbar(.67,f,'Processing your data');
            tform = geometricTransform2d(ifcn);
            app.Presented_image = imwarp(app.Presented_image,tform);
            imshow(app.Presented_image, 'parent', app.ImageAxis);
            waitbar(1,f,'Finishing');
            close(f);

        end

        % Callback function
        function PinCushionTransformationButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image = imresize(app.Presented_image, [NaN, 1080]);
            f = waitbar(0,'Please wait...');
            nrows = size(app.Presented_image,1);
            ncols = size(app.Presented_image,2);

            [xi,yi] = meshgrid(1:ncols,1:nrows);
            xt = xi - ncols/2;
            yt = yi - nrows/2;

            waitbar(.33,f,'Processing your data');
            [theta,r] = cart2pol(xt,yt);
            b = 0.4; % Try varying the amplitude of the cubic term.
            rmax = max(r(:));
            s = r - r.^3*(b/rmax.^2);
            [ut,vt] = pol2cart(theta,s);
            ui = ut + ncols/2;
            vi = vt + nrows/2;
            ifcn = @(c) [ui(:) vi(:)];
            waitbar(.67,f,'Processing your data');

            tform = geometricTransform2d(ifcn);
            app.Presented_image = imwarp(app.Presented_image,tform);
            imshow(app.Presented_image, 'parent', app.ImageAxis);
            waitbar(1,f,'Finishing');
            close(f);

        end

        % Button pushed function: BlurButton
        function BlurButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            app.Presented_image = imgaussfilt(app.Presented_image,7);
            imshow(app.Presented_image, 'parent', app.ImageAxis);


        end

        % Button pushed function: PencilDrawingButton
        function PencilDrawingButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            [~,~,channels] = size(app.Presented_image);
            %if it is an RGB image convert it to grayscale
            if channels ==3
                imag = rgb2gray(app.Presented_image);
            else
                imag = app.Presented_image;
            end
            filter =   [1 1 1 1 1 1;
                1 1 1 1 1 1;
                1 1 -8 -8 1 1;
                1 1 -8 -8 1 1;
                1 1 1 1 1 1;
                1 1 1 1 1 1]; % edges 8 2blocks
            imagf = imfilter( imag, filter, 'conv');
            imagf = 255-imagf;
            app.Presented_image = imagf;
            imshow(app.Presented_image, 'parent', app.ImageAxis);

        end

        % Button pushed function: FlipRedBlueButton
        function FlipRedBlueButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            [~,~,channels] = size(app.Presented_image);
            %if this is RGB image
            if channels == 3
                red = app.Presented_image(:,:,1); % red channel
                blue = app.Presented_image(:,:,3);
                app.Presented_image(:,:,1) = blue;
                app.Presented_image(:,:,3) = red;
                imshow(app.Presented_image, 'parent', app.ImageAxis);

            else
                warning('Not possible to implement the effect on gray image.');
                msgbox('Not possible to implement the effect on gray image.');
            end


        end

        % Button pushed function: FlipRedGreenButton
        function FlipRedGreenButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            [~,~,channels] = size(app.Presented_image);
            %if this is RGB image
            if channels == 3
                red = app.Presented_image(:,:,1); % red channel
                green = app.Presented_image(:,:,2);
                app.Presented_image(:,:,1) = green;
                app.Presented_image(:,:,2) = red;
                imshow(app.Presented_image, 'parent', app.ImageAxis);

            else
                warning('Not possible to implement the effect on gray image.');
                msgbox('Not possible to implement the effect on gray image.');
            end

        end

        % Button pushed function: FlipGreenBlueButton
        function FlipGreenBlueButtonPushed(app, event)
            app.Previous_image{end+1} = app.Presented_image;
            [~,~,channels] = size(app.Presented_image);
            %if this is RGB image
            if channels == 3
                green = app.Presented_image(:,:,2);
                blue = app.Presented_image(:,:,3); % red channel
                app.Presented_image(:,:,2) = blue;
                app.Presented_image(:,:,3) = green;
                imshow(app.Presented_image, 'parent', app.ImageAxis);

            else
                warning('Not possible to implement the effect on gray image.');
                msgbox('Not possible to implement the effect on gray image.');
            end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1188 958];
            app.UIFigure.Name = 'MATLAB App';

            % Create ImageAxis
            app.ImageAxis = uiaxes(app.UIFigure);
            title(app.ImageAxis, 'Current Image')
            zlabel(app.ImageAxis, 'Z')
            app.ImageAxis.XLimitMethod = 'tight';
            app.ImageAxis.YLimitMethod = 'tight';
            app.ImageAxis.Position = [181 413 880 474];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [2 -3 1187 387];

            % Create HandlingImagesTab
            app.HandlingImagesTab = uitab(app.TabGroup);
            app.HandlingImagesTab.Title = 'Handling Images';

            % Create LoadanimageButton
            app.LoadanimageButton = uibutton(app.HandlingImagesTab, 'push');
            app.LoadanimageButton.ButtonPushedFcn = createCallbackFcn(app, @LoadanimageButtonPushed, true);
            app.LoadanimageButton.Icon = 'Upload_ICON.jpg';
            app.LoadanimageButton.IconAlignment = 'top';
            app.LoadanimageButton.FontSize = 15;
            app.LoadanimageButton.FontWeight = 'bold';
            app.LoadanimageButton.Position = [206 185 120 98];
            app.LoadanimageButton.Text = 'Load an image';

            % Create SaveAsButton
            app.SaveAsButton = uibutton(app.HandlingImagesTab, 'push');
            app.SaveAsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveAsButtonPushed, true);
            app.SaveAsButton.Icon = 'SAVE ICON.jpg';
            app.SaveAsButton.IconAlignment = 'top';
            app.SaveAsButton.FontSize = 15;
            app.SaveAsButton.FontWeight = 'bold';
            app.SaveAsButton.Enable = 'off';
            app.SaveAsButton.Position = [425 185 104 98];
            app.SaveAsButton.Text = 'Save As...';

            % Create WelcomePleaseloadanimagetostartLabel
            app.WelcomePleaseloadanimagetostartLabel = uilabel(app.HandlingImagesTab);
            app.WelcomePleaseloadanimagetostartLabel.FontSize = 15;
            app.WelcomePleaseloadanimagetostartLabel.FontWeight = 'bold';
            app.WelcomePleaseloadanimagetostartLabel.Position = [32 318 294 22];
            app.WelcomePleaseloadanimagetostartLabel.Text = 'Welcome, Please load an image to start.';

            % Create GeomatricOperationsTab
            app.GeomatricOperationsTab = uitab(app.TabGroup);
            app.GeomatricOperationsTab.Title = 'Geomatric Operations';

            % Create AffineTransformPanel
            app.AffineTransformPanel = uipanel(app.GeomatricOperationsTab);
            app.AffineTransformPanel.Enable = 'off';
            app.AffineTransformPanel.TitlePosition = 'centertop';
            app.AffineTransformPanel.Title = 'Affine Transform';
            app.AffineTransformPanel.FontWeight = 'bold';
            app.AffineTransformPanel.FontSize = 15;
            app.AffineTransformPanel.Position = [755 2 431 360];

            % Create ApplyTransformationButton
            app.ApplyTransformationButton = uibutton(app.AffineTransformPanel, 'push');
            app.ApplyTransformationButton.ButtonPushedFcn = createCallbackFcn(app, @ApplyTransformationButtonPushed, true);
            app.ApplyTransformationButton.Position = [116 19 195 46];
            app.ApplyTransformationButton.Text = 'Apply Transformation';

            % Create ChooseAffineTransformDropDownLabel
            app.ChooseAffineTransformDropDownLabel = uilabel(app.AffineTransformPanel);
            app.ChooseAffineTransformDropDownLabel.HorizontalAlignment = 'right';
            app.ChooseAffineTransformDropDownLabel.Position = [30 280 166 22];
            app.ChooseAffineTransformDropDownLabel.Text = 'Choose Affine Transform	';

            % Create ChooseAffineTransformDropDown
            app.ChooseAffineTransformDropDown = uidropdown(app.AffineTransformPanel);
            app.ChooseAffineTransformDropDown.Items = {'Shear', 'Translation'};
            app.ChooseAffineTransformDropDown.ValueChangedFcn = createCallbackFcn(app, @ChooseAffineTransformDropDownValueChanged, true);
            app.ChooseAffineTransformDropDown.Position = [211 280 100 22];
            app.ChooseAffineTransformDropDown.Value = 'Shear';

            % Create ShearPanel
            app.ShearPanel = uipanel(app.AffineTransformPanel);
            app.ShearPanel.Enable = 'off';
            app.ShearPanel.TitlePosition = 'centertop';
            app.ShearPanel.Title = 'Shear';
            app.ShearPanel.FontWeight = 'bold';
            app.ShearPanel.Position = [18 162 188 99];

            % Create XShearEditFieldLabel
            app.XShearEditFieldLabel = uilabel(app.ShearPanel);
            app.XShearEditFieldLabel.HorizontalAlignment = 'right';
            app.XShearEditFieldLabel.Position = [11 40 56 22];
            app.XShearEditFieldLabel.Text = 'X - Shear';

            % Create XShearEditField
            app.XShearEditField = uieditfield(app.ShearPanel, 'numeric');
            app.XShearEditField.Limits = [-2 2];
            app.XShearEditField.Position = [82 40 100 22];

            % Create YShearEditFieldLabel
            app.YShearEditFieldLabel = uilabel(app.ShearPanel);
            app.YShearEditFieldLabel.HorizontalAlignment = 'right';
            app.YShearEditFieldLabel.Position = [11 8 56 22];
            app.YShearEditFieldLabel.Text = 'Y - Shear';

            % Create YShearEditField
            app.YShearEditField = uieditfield(app.ShearPanel, 'numeric');
            app.YShearEditField.Limits = [-2 2];
            app.YShearEditField.Position = [82 8 100 22];

            % Create TranslationPanel
            app.TranslationPanel = uipanel(app.AffineTransformPanel);
            app.TranslationPanel.Enable = 'off';
            app.TranslationPanel.TitlePosition = 'centertop';
            app.TranslationPanel.Title = 'Translation';
            app.TranslationPanel.FontWeight = 'bold';
            app.TranslationPanel.Position = [211 162 217 99];

            % Create XTranslationLabel
            app.XTranslationLabel = uilabel(app.TranslationPanel);
            app.XTranslationLabel.HorizontalAlignment = 'right';
            app.XTranslationLabel.Position = [10 40 83 22];
            app.XTranslationLabel.Text = 'X - Translation';

            % Create XTranslationEditField
            app.XTranslationEditField = uieditfield(app.TranslationPanel, 'numeric');
            app.XTranslationEditField.Position = [108 40 100 22];

            % Create YTranslationLabel
            app.YTranslationLabel = uilabel(app.TranslationPanel);
            app.YTranslationLabel.HorizontalAlignment = 'right';
            app.YTranslationLabel.Position = [11 8 82 22];
            app.YTranslationLabel.Text = 'Y - Translation';

            % Create YTranslationEditField
            app.YTranslationEditField = uieditfield(app.TranslationPanel, 'numeric');
            app.YTranslationEditField.Position = [107 8 100 22];

            % Create ResizePanel
            app.ResizePanel = uipanel(app.GeomatricOperationsTab);
            app.ResizePanel.Enable = 'off';
            app.ResizePanel.TitlePosition = 'centertop';
            app.ResizePanel.Title = 'Resize';
            app.ResizePanel.FontWeight = 'bold';
            app.ResizePanel.FontSize = 15;
            app.ResizePanel.Position = [1 180 279 182];

            % Create DragtoresizeSliderLabel
            app.DragtoresizeSliderLabel = uilabel(app.ResizePanel);
            app.DragtoresizeSliderLabel.HorizontalAlignment = 'right';
            app.DragtoresizeSliderLabel.FontSize = 15;
            app.DragtoresizeSliderLabel.Position = [86 -2 99 22];
            app.DragtoresizeSliderLabel.Text = 'Drag to resize';

            % Create DragtoresizeSlider
            app.DragtoresizeSlider = uislider(app.ResizePanel);
            app.DragtoresizeSlider.Limits = [0.1 2];
            app.DragtoresizeSlider.MajorTicks = [0.1 0.3 0.5 0.7 0.9 1.1 1.3 1.5 1.7 1.9];
            app.DragtoresizeSlider.ValueChangedFcn = createCallbackFcn(app, @DragtoresizeSliderValueChanged, true);
            app.DragtoresizeSlider.Position = [28 52 221 3];
            app.DragtoresizeSlider.Value = 1;

            % Create Label_2
            app.Label_2 = uilabel(app.ResizePanel);
            app.Label_2.FontSize = 13;
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [69 116 25 22];
            app.Label_2.Text = '';

            % Create Image
            app.Image = uiimage(app.ResizePanel);
            app.Image.Position = [98 79 85 70];
            app.Image.ImageSource = 'Resize_Icon.jpg';

            % Create RotationPanel
            app.RotationPanel = uipanel(app.GeomatricOperationsTab);
            app.RotationPanel.Enable = 'off';
            app.RotationPanel.TitlePosition = 'centertop';
            app.RotationPanel.Title = 'Rotation';
            app.RotationPanel.FontWeight = 'bold';
            app.RotationPanel.FontSize = 15;
            app.RotationPanel.Position = [282 0 326 362];

            % Create Rotate90LeftButton
            app.Rotate90LeftButton = uibutton(app.RotationPanel, 'state');
            app.Rotate90LeftButton.ValueChangedFcn = createCallbackFcn(app, @Rotate90LeftButtonValueChanged, true);
            app.Rotate90LeftButton.Icon = 'rotate 90 left.png';
            app.Rotate90LeftButton.IconAlignment = 'top';
            app.Rotate90LeftButton.Text = 'Rotate 90 Left';
            app.Rotate90LeftButton.Position = [60 244 94 60];

            % Create Rotate90RightButton
            app.Rotate90RightButton = uibutton(app.RotationPanel, 'state');
            app.Rotate90RightButton.ValueChangedFcn = createCallbackFcn(app, @Rotate90RightButtonValueChanged, true);
            app.Rotate90RightButton.Icon = 'rotate 90 Right.png';
            app.Rotate90RightButton.IconAlignment = 'top';
            app.Rotate90RightButton.Text = 'Rotate 90 Right';
            app.Rotate90RightButton.Position = [185 244 95 60];

            % Create RotatewithoutcropSliderLabel
            app.RotatewithoutcropSliderLabel = uilabel(app.RotationPanel);
            app.RotatewithoutcropSliderLabel.HorizontalAlignment = 'center';
            app.RotatewithoutcropSliderLabel.FontSize = 15;
            app.RotatewithoutcropSliderLabel.Position = [95 41 135 22];
            app.RotatewithoutcropSliderLabel.Text = 'Rotate without crop';

            % Create RotatewithoutcropSlider
            app.RotatewithoutcropSlider = uislider(app.RotationPanel);
            app.RotatewithoutcropSlider.Limits = [-180 180];
            app.RotatewithoutcropSlider.MajorTicks = [-180 -150 -120 -90 -60 -30 0 30 60 90 120 150 180];
            app.RotatewithoutcropSlider.ValueChangedFcn = createCallbackFcn(app, @RotatewithoutcropSliderValueChanged, true);
            app.RotatewithoutcropSlider.Position = [26 94 273 3];

            % Create RotatewithcropSliderLabel
            app.RotatewithcropSliderLabel = uilabel(app.RotationPanel);
            app.RotatewithcropSliderLabel.HorizontalAlignment = 'right';
            app.RotatewithcropSliderLabel.FontSize = 15;
            app.RotatewithcropSliderLabel.Position = [106 128 114 22];
            app.RotatewithcropSliderLabel.Text = 'Rotate with crop';

            % Create RotatewithcropSlider
            app.RotatewithcropSlider = uislider(app.RotationPanel);
            app.RotatewithcropSlider.Limits = [-180 180];
            app.RotatewithcropSlider.MajorTicks = [-180 -150 -120 -90 -60 -30 0 30 60 90 120 150 180];
            app.RotatewithcropSlider.ValueChangedFcn = createCallbackFcn(app, @RotatewithcropSliderValueChanged, true);
            app.RotatewithcropSlider.Position = [26 184 274 3];

            % Create MirroringPanel
            app.MirroringPanel = uipanel(app.GeomatricOperationsTab);
            app.MirroringPanel.Enable = 'off';
            app.MirroringPanel.TitlePosition = 'centertop';
            app.MirroringPanel.Title = 'Mirroring';
            app.MirroringPanel.FontWeight = 'bold';
            app.MirroringPanel.FontSize = 15;
            app.MirroringPanel.Position = [608 0 144 362];

            % Create HorizontalButton
            app.HorizontalButton = uibutton(app.MirroringPanel, 'push');
            app.HorizontalButton.ButtonPushedFcn = createCallbackFcn(app, @HorizontalButtonPushed, true);
            app.HorizontalButton.Icon = 'Horizontal_Mirroring.png';
            app.HorizontalButton.IconAlignment = 'top';
            app.HorizontalButton.Position = [14 235 107 69];
            app.HorizontalButton.Text = 'Horizontal';

            % Create VerticalButton
            app.VerticalButton = uibutton(app.MirroringPanel, 'push');
            app.VerticalButton.ButtonPushedFcn = createCallbackFcn(app, @VerticalButtonPushed, true);
            app.VerticalButton.Icon = 'Vertical_Mirroring.png';
            app.VerticalButton.IconAlignment = 'top';
            app.VerticalButton.Position = [14 95 106 73];
            app.VerticalButton.Text = 'Vertical';

            % Create CropPanel
            app.CropPanel = uipanel(app.GeomatricOperationsTab);
            app.CropPanel.Enable = 'off';
            app.CropPanel.TitlePosition = 'centertop';
            app.CropPanel.Title = 'Crop';
            app.CropPanel.FontWeight = 'bold';
            app.CropPanel.FontSize = 15;
            app.CropPanel.Position = [1 4 278 173];

            % Create CropButton
            app.CropButton = uibutton(app.CropPanel, 'push');
            app.CropButton.ButtonPushedFcn = createCallbackFcn(app, @CropButtonPushed, true);
            app.CropButton.Icon = 'CropIcon.png';
            app.CropButton.IconAlignment = 'top';
            app.CropButton.Position = [84 35 108 89];
            app.CropButton.Text = 'Crop';

            % Create PointOperationsTab
            app.PointOperationsTab = uitab(app.TabGroup);
            app.PointOperationsTab.Title = 'Point Operations';

            % Create BrightnessPanel
            app.BrightnessPanel = uipanel(app.PointOperationsTab);
            app.BrightnessPanel.Enable = 'off';
            app.BrightnessPanel.TitlePosition = 'centertop';
            app.BrightnessPanel.Title = 'Brightness';
            app.BrightnessPanel.FontWeight = 'bold';
            app.BrightnessPanel.FontSize = 15;
            app.BrightnessPanel.Position = [0 1 364 362];

            % Create Image2
            app.Image2 = uiimage(app.BrightnessPanel);
            app.Image2.Position = [136 218 85 81];
            app.Image2.ImageSource = 'brightness.png';

            % Create DragtochangebrightnessSliderLabel
            app.DragtochangebrightnessSliderLabel = uilabel(app.BrightnessPanel);
            app.DragtochangebrightnessSliderLabel.HorizontalAlignment = 'right';
            app.DragtochangebrightnessSliderLabel.FontSize = 15;
            app.DragtochangebrightnessSliderLabel.Position = [83 89 181 22];
            app.DragtochangebrightnessSliderLabel.Text = 'Drag to change brightness';

            % Create DragtochangebrightnessSlider
            app.DragtochangebrightnessSlider = uislider(app.BrightnessPanel);
            app.DragtochangebrightnessSlider.Limits = [-50 50];
            app.DragtochangebrightnessSlider.ValueChangedFcn = createCallbackFcn(app, @DragtochangebrightnessSliderValueChanged, true);
            app.DragtochangebrightnessSlider.Position = [37 177 295 3];

            % Create HistogramEqualizationPanel
            app.HistogramEqualizationPanel = uipanel(app.PointOperationsTab);
            app.HistogramEqualizationPanel.Enable = 'off';
            app.HistogramEqualizationPanel.TitlePosition = 'centertop';
            app.HistogramEqualizationPanel.Title = 'Histogram Equalization';
            app.HistogramEqualizationPanel.FontWeight = 'bold';
            app.HistogramEqualizationPanel.FontSize = 15;
            app.HistogramEqualizationPanel.Position = [740 2 196 361];

            % Create HistogramEqualizationButton
            app.HistogramEqualizationButton = uibutton(app.HistogramEqualizationPanel, 'push');
            app.HistogramEqualizationButton.ButtonPushedFcn = createCallbackFcn(app, @HistogramEqualizationButtonPushed, true);
            app.HistogramEqualizationButton.Icon = 'Histogram_Equalization.jpg';
            app.HistogramEqualizationButton.IconAlignment = 'top';
            app.HistogramEqualizationButton.Position = [29 135 137 88];
            app.HistogramEqualizationButton.Text = 'Histogram Equalization';

            % Create contrastPanel
            app.contrastPanel = uipanel(app.PointOperationsTab);
            app.contrastPanel.Enable = 'off';
            app.contrastPanel.TitlePosition = 'centertop';
            app.contrastPanel.Title = 'contrast';
            app.contrastPanel.FontWeight = 'bold';
            app.contrastPanel.FontSize = 15;
            app.contrastPanel.Position = [365 3 374 360];

            % Create DragtochangecontrastSliderLabel
            app.DragtochangecontrastSliderLabel = uilabel(app.contrastPanel);
            app.DragtochangecontrastSliderLabel.HorizontalAlignment = 'right';
            app.DragtochangecontrastSliderLabel.FontSize = 15;
            app.DragtochangecontrastSliderLabel.Position = [111 87 166 22];
            app.DragtochangecontrastSliderLabel.Text = 'Drag to change contrast';

            % Create DragtochangecontrastSlider
            app.DragtochangecontrastSlider = uislider(app.contrastPanel);
            app.DragtochangecontrastSlider.Limits = [0.1 2.2];
            app.DragtochangecontrastSlider.MajorTicks = [0.1 0.4 0.7 1 1.3 1.6 1.9 2.2];
            app.DragtochangecontrastSlider.ValueChangedFcn = createCallbackFcn(app, @DragtochangecontrastSliderValueChanged, true);
            app.DragtochangecontrastSlider.FontSize = 15;
            app.DragtochangecontrastSlider.Position = [29 180 295 3];
            app.DragtochangecontrastSlider.Value = 1;

            % Create Image3
            app.Image3 = uiimage(app.contrastPanel);
            app.Image3.Position = [160 220 69 76];
            app.Image3.ImageSource = 'contrast.png';

            % Create autocontrastButton
            app.autocontrastButton = uibutton(app.contrastPanel, 'state');
            app.autocontrastButton.ValueChangedFcn = createCallbackFcn(app, @autocontrastButtonValueChanged, true);
            app.autocontrastButton.Text = 'auto contrast';
            app.autocontrastButton.FontSize = 18;
            app.autocontrastButton.Position = [131 19 126 40];

            % Create AutoSharpeningPanel
            app.AutoSharpeningPanel = uipanel(app.PointOperationsTab);
            app.AutoSharpeningPanel.Enable = 'off';
            app.AutoSharpeningPanel.TitlePosition = 'centertop';
            app.AutoSharpeningPanel.Title = 'Auto - Sharpening';
            app.AutoSharpeningPanel.FontWeight = 'bold';
            app.AutoSharpeningPanel.FontSize = 15;
            app.AutoSharpeningPanel.Position = [935 3 248 360];

            % Create AutoSharpeningButton
            app.AutoSharpeningButton = uibutton(app.AutoSharpeningPanel, 'push');
            app.AutoSharpeningButton.ButtonPushedFcn = createCallbackFcn(app, @AutoSharpeningButtonPushed, true);
            app.AutoSharpeningButton.Icon = 'SharpenTool.png';
            app.AutoSharpeningButton.IconAlignment = 'top';
            app.AutoSharpeningButton.Position = [72 140 105 87];
            app.AutoSharpeningButton.Text = 'Auto Sharpening';

            % Create NoiseOperationsTab
            app.NoiseOperationsTab = uitab(app.TabGroup);
            app.NoiseOperationsTab.Title = 'Noise Operations';

            % Create GaussianNoisePanel
            app.GaussianNoisePanel = uipanel(app.NoiseOperationsTab);
            app.GaussianNoisePanel.Enable = 'off';
            app.GaussianNoisePanel.TitlePosition = 'centertop';
            app.GaussianNoisePanel.Title = 'Gaussian Noise';
            app.GaussianNoisePanel.FontWeight = 'bold';
            app.GaussianNoisePanel.FontSize = 15;
            app.GaussianNoisePanel.Position = [173 0 436 363];

            % Create AddGaussiannoiseLabel
            app.AddGaussiannoiseLabel = uilabel(app.GaussianNoisePanel);
            app.AddGaussiannoiseLabel.FontSize = 15;
            app.AddGaussiannoiseLabel.Position = [33 307 148 22];
            app.AddGaussiannoiseLabel.Text = 'Add Gaussian noise :';

            % Create VarianceEditFieldLabel
            app.VarianceEditFieldLabel = uilabel(app.GaussianNoisePanel);
            app.VarianceEditFieldLabel.HorizontalAlignment = 'right';
            app.VarianceEditFieldLabel.FontSize = 15;
            app.VarianceEditFieldLabel.Position = [28 268 64 22];
            app.VarianceEditFieldLabel.Text = 'Variance';

            % Create VarianceEditField
            app.VarianceEditField = uieditfield(app.GaussianNoisePanel, 'numeric');
            app.VarianceEditField.Limits = [0 1];
            app.VarianceEditField.Position = [107 268 100 22];
            app.VarianceEditField.Value = 0.01;

            % Create ApplyButton
            app.ApplyButton = uibutton(app.GaussianNoisePanel, 'push');
            app.ApplyButton.ButtonPushedFcn = createCallbackFcn(app, @ApplyButtonPushed, true);
            app.ApplyButton.FontSize = 15;
            app.ApplyButton.Position = [278 259 69 40];
            app.ApplyButton.Text = 'Apply';

            % Create RemoveGaussiannoiseLabel
            app.RemoveGaussiannoiseLabel = uilabel(app.GaussianNoisePanel);
            app.RemoveGaussiannoiseLabel.FontSize = 15;
            app.RemoveGaussiannoiseLabel.Position = [22 60 177 22];
            app.RemoveGaussiannoiseLabel.Text = 'Remove Gaussian noise :';

            % Create RemoveNoiseButton
            app.RemoveNoiseButton = uibutton(app.GaussianNoisePanel, 'push');
            app.RemoveNoiseButton.ButtonPushedFcn = createCallbackFcn(app, @RemoveNoiseButtonPushed, true);
            app.RemoveNoiseButton.FontSize = 15;
            app.RemoveNoiseButton.Position = [241 49 117 46];
            app.RemoveNoiseButton.Text = 'Remove Noise';

            % Create ChooseremovalmethodDropDownLabel
            app.ChooseremovalmethodDropDownLabel = uilabel(app.GaussianNoisePanel);
            app.ChooseremovalmethodDropDownLabel.HorizontalAlignment = 'right';
            app.ChooseremovalmethodDropDownLabel.FontSize = 15;
            app.ChooseremovalmethodDropDownLabel.Position = [25 155 169 22];
            app.ChooseremovalmethodDropDownLabel.Text = 'Choose removal method';

            % Create ChooseremovalmethodDropDown
            app.ChooseremovalmethodDropDown = uidropdown(app.GaussianNoisePanel);
            app.ChooseremovalmethodDropDown.Items = {'Wiener', 'Average'};
            app.ChooseremovalmethodDropDown.Position = [209 155 100 22];
            app.ChooseremovalmethodDropDown.Value = 'Wiener';

            % Create SaltPepperNoisePanel
            app.SaltPepperNoisePanel = uipanel(app.NoiseOperationsTab);
            app.SaltPepperNoisePanel.Enable = 'off';
            app.SaltPepperNoisePanel.TitlePosition = 'centertop';
            app.SaltPepperNoisePanel.Title = 'Salt & Pepper Noise';
            app.SaltPepperNoisePanel.FontWeight = 'bold';
            app.SaltPepperNoisePanel.FontSize = 15;
            app.SaltPepperNoisePanel.Position = [614 4 402 357];

            % Create AddSaltPeppernoiseLabel
            app.AddSaltPeppernoiseLabel = uilabel(app.SaltPepperNoisePanel);
            app.AddSaltPeppernoiseLabel.FontSize = 15;
            app.AddSaltPeppernoiseLabel.Position = [29 303 173 22];
            app.AddSaltPeppernoiseLabel.Text = 'Add Salt & Pepper noise:';

            % Create Label_3
            app.Label_3 = uilabel(app.SaltPepperNoisePanel);
            app.Label_3.FontSize = 15;
            app.Label_3.Position = [11 271 25 22];
            app.Label_3.Text = '';

            % Create DensityEditFieldLabel
            app.DensityEditFieldLabel = uilabel(app.SaltPepperNoisePanel);
            app.DensityEditFieldLabel.HorizontalAlignment = 'right';
            app.DensityEditFieldLabel.FontSize = 15;
            app.DensityEditFieldLabel.Position = [29 264 56 22];
            app.DensityEditFieldLabel.Text = 'Density';

            % Create DensityEditField
            app.DensityEditField = uieditfield(app.SaltPepperNoisePanel, 'numeric');
            app.DensityEditField.Limits = [0.05 0.5];
            app.DensityEditField.Position = [100 264 100 22];
            app.DensityEditField.Value = 0.05;

            % Create ApplyButton_2
            app.ApplyButton_2 = uibutton(app.SaltPepperNoisePanel, 'push');
            app.ApplyButton_2.ButtonPushedFcn = createCallbackFcn(app, @ApplyButton_2Pushed, true);
            app.ApplyButton_2.FontSize = 15;
            app.ApplyButton_2.Position = [274 255 73 40];
            app.ApplyButton_2.Text = 'Apply';

            % Create RemovesaltpeppernoiseLabel
            app.RemovesaltpeppernoiseLabel = uilabel(app.SaltPepperNoisePanel);
            app.RemovesaltpeppernoiseLabel.FontSize = 15;
            app.RemovesaltpeppernoiseLabel.Position = [29 189 203 22];
            app.RemovesaltpeppernoiseLabel.Text = 'Remove  salt & pepper noise:';

            % Create RemoveNoiseButton_2
            app.RemoveNoiseButton_2 = uibutton(app.SaltPepperNoisePanel, 'push');
            app.RemoveNoiseButton_2.ButtonPushedFcn = createCallbackFcn(app, @RemoveNoiseButton_2Pushed, true);
            app.RemoveNoiseButton_2.FontSize = 15;
            app.RemoveNoiseButton_2.Position = [254 178 114 46];
            app.RemoveNoiseButton_2.Text = 'Remove Noise';

            % Create EffectsTab
            app.EffectsTab = uitab(app.TabGroup);
            app.EffectsTab.Title = 'Effects';

            % Create ArtisticEffectsPanel
            app.ArtisticEffectsPanel = uipanel(app.EffectsTab);
            app.ArtisticEffectsPanel.Enable = 'off';
            app.ArtisticEffectsPanel.TitlePosition = 'centertop';
            app.ArtisticEffectsPanel.Title = 'Artistic Effects';
            app.ArtisticEffectsPanel.FontWeight = 'bold';
            app.ArtisticEffectsPanel.FontSize = 15;
            app.ArtisticEffectsPanel.Position = [1 4 689 359];

            % Create VintageButton
            app.VintageButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.VintageButton.ButtonPushedFcn = createCallbackFcn(app, @VintageButtonPushed, true);
            app.VintageButton.FontSize = 15;
            app.VintageButton.FontWeight = 'bold';
            app.VintageButton.Position = [42 256 106 40];
            app.VintageButton.Text = 'Vintage ';

            % Create NegativeButton
            app.NegativeButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.NegativeButton.ButtonPushedFcn = createCallbackFcn(app, @NegativeButtonPushed, true);
            app.NegativeButton.FontSize = 15;
            app.NegativeButton.FontWeight = 'bold';
            app.NegativeButton.Position = [42 165 106 37];
            app.NegativeButton.Text = 'Negative';

            % Create BlackWhiteButton
            app.BlackWhiteButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.BlackWhiteButton.ButtonPushedFcn = createCallbackFcn(app, @BlackWhiteButtonPushed, true);
            app.BlackWhiteButton.FontSize = 15;
            app.BlackWhiteButton.FontWeight = 'bold';
            app.BlackWhiteButton.Position = [42 77 110 37];
            app.BlackWhiteButton.Text = 'Black & White';

            % Create SinusoidalTransformationButton
            app.SinusoidalTransformationButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.SinusoidalTransformationButton.ButtonPushedFcn = createCallbackFcn(app, @SinusoidalTransformationButtonPushed, true);
            app.SinusoidalTransformationButton.FontSize = 15;
            app.SinusoidalTransformationButton.FontWeight = 'bold';
            app.SinusoidalTransformationButton.Position = [212 252 205 44];
            app.SinusoidalTransformationButton.Text = 'Sinusoidal Transformation';

            % Create BlurButton
            app.BlurButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.BlurButton.ButtonPushedFcn = createCallbackFcn(app, @BlurButtonPushed, true);
            app.BlurButton.FontSize = 15;
            app.BlurButton.FontWeight = 'bold';
            app.BlurButton.Position = [258 66 107 40];
            app.BlurButton.Text = 'Blur';

            % Create PencilDrawingButton
            app.PencilDrawingButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.PencilDrawingButton.ButtonPushedFcn = createCallbackFcn(app, @PencilDrawingButtonPushed, true);
            app.PencilDrawingButton.FontSize = 15;
            app.PencilDrawingButton.FontWeight = 'bold';
            app.PencilDrawingButton.Position = [247 153 123 43];
            app.PencilDrawingButton.Text = 'Pencil Drawing';

            % Create FlipRedBlueButton
            app.FlipRedBlueButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.FlipRedBlueButton.ButtonPushedFcn = createCallbackFcn(app, @FlipRedBlueButtonPushed, true);
            app.FlipRedBlueButton.FontSize = 15;
            app.FlipRedBlueButton.FontWeight = 'bold';
            app.FlipRedBlueButton.Position = [466 253 203 41];
            app.FlipRedBlueButton.Text = 'Flip Red & Blue';

            % Create FlipRedGreenButton
            app.FlipRedGreenButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.FlipRedGreenButton.ButtonPushedFcn = createCallbackFcn(app, @FlipRedGreenButtonPushed, true);
            app.FlipRedGreenButton.FontSize = 15;
            app.FlipRedGreenButton.FontWeight = 'bold';
            app.FlipRedGreenButton.Position = [466 153 197 41];
            app.FlipRedGreenButton.Text = 'Flip Red & Green';

            % Create FlipGreenBlueButton
            app.FlipGreenBlueButton = uibutton(app.ArtisticEffectsPanel, 'push');
            app.FlipGreenBlueButton.ButtonPushedFcn = createCallbackFcn(app, @FlipGreenBlueButtonPushed, true);
            app.FlipGreenBlueButton.FontSize = 15;
            app.FlipGreenBlueButton.FontWeight = 'bold';
            app.FlipGreenBlueButton.Position = [465 62 198 40];
            app.FlipGreenBlueButton.Text = 'Flip Green & Blue';

            % Create AddTextPanel
            app.AddTextPanel = uipanel(app.EffectsTab);
            app.AddTextPanel.Enable = 'off';
            app.AddTextPanel.TitlePosition = 'centertop';
            app.AddTextPanel.Title = 'Add Text';
            app.AddTextPanel.FontWeight = 'bold';
            app.AddTextPanel.FontSize = 15;
            app.AddTextPanel.Position = [698 4 485 359];

            % Create AddTextEditFieldLabel
            app.AddTextEditFieldLabel = uilabel(app.AddTextPanel);
            app.AddTextEditFieldLabel.HorizontalAlignment = 'right';
            app.AddTextEditFieldLabel.FontSize = 15;
            app.AddTextEditFieldLabel.FontWeight = 'bold';
            app.AddTextEditFieldLabel.Position = [278 221 69 22];
            app.AddTextEditFieldLabel.Text = 'Add Text';

            % Create AddTextEditField
            app.AddTextEditField = uieditfield(app.AddTextPanel, 'text');
            app.AddTextEditField.HorizontalAlignment = 'center';
            app.AddTextEditField.Position = [362 221 100 22];
            app.AddTextEditField.Value = 'Enter text here';

            % Create CreatethetextButton
            app.CreatethetextButton = uibutton(app.AddTextPanel, 'push');
            app.CreatethetextButton.ButtonPushedFcn = createCallbackFcn(app, @CreatethetextButtonPushed, true);
            app.CreatethetextButton.FontSize = 15;
            app.CreatethetextButton.FontWeight = 'bold';
            app.CreatethetextButton.Position = [223 102 120 45];
            app.CreatethetextButton.Text = 'Create the text';

            % Create FontDropDownLabel
            app.FontDropDownLabel = uilabel(app.AddTextPanel);
            app.FontDropDownLabel.HorizontalAlignment = 'right';
            app.FontDropDownLabel.FontSize = 15;
            app.FontDropDownLabel.FontWeight = 'bold';
            app.FontDropDownLabel.Position = [28 285 38 22];
            app.FontDropDownLabel.Text = 'Font';

            % Create FontDropDown
            app.FontDropDown = uidropdown(app.AddTextPanel);
            app.FontDropDown.Items = {'Times New Roman', 'David', 'Arial', 'Calibri'};
            app.FontDropDown.Position = [81 285 100 22];
            app.FontDropDown.Value = 'Times New Roman';

            % Create ChooseColorButton
            app.ChooseColorButton = uibutton(app.AddTextPanel, 'push');
            app.ChooseColorButton.ButtonPushedFcn = createCallbackFcn(app, @ChooseColorButtonPushed, true);
            app.ChooseColorButton.FontSize = 15;
            app.ChooseColorButton.FontWeight = 'bold';
            app.ChooseColorButton.Position = [86 209 121 33];
            app.ChooseColorButton.Text = 'Choose Color';

            % Create FontsizeSpinnerLabel
            app.FontsizeSpinnerLabel = uilabel(app.AddTextPanel);
            app.FontsizeSpinnerLabel.HorizontalAlignment = 'right';
            app.FontsizeSpinnerLabel.FontSize = 15;
            app.FontsizeSpinnerLabel.FontWeight = 'bold';
            app.FontsizeSpinnerLabel.Position = [278 293 71 22];
            app.FontsizeSpinnerLabel.Text = 'Font size';

            % Create FontsizeSpinner
            app.FontsizeSpinner = uispinner(app.AddTextPanel);
            app.FontsizeSpinner.Position = [364 293 100 22];
            app.FontsizeSpinner.Value = 50;

            % Create ReloadButton
            app.ReloadButton = uibutton(app.UIFigure, 'push');
            app.ReloadButton.ButtonPushedFcn = createCallbackFcn(app, @ReloadButtonPushed, true);
            app.ReloadButton.Icon = 'Upload_ICON.jpg';
            app.ReloadButton.FontSize = 15;
            app.ReloadButton.FontWeight = 'bold';
            app.ReloadButton.Enable = 'off';
            app.ReloadButton.Position = [34 870 108 37];
            app.ReloadButton.Text = 'Reload';

            % Create undoButton
            app.undoButton = uibutton(app.UIFigure, 'push');
            app.undoButton.ButtonPushedFcn = createCallbackFcn(app, @undoButtonPushed, true);
            app.undoButton.Icon = 'undo.png';
            app.undoButton.Enable = 'off';
            app.undoButton.Position = [34 810 113 35];
            app.undoButton.Text = 'undo';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Photoshop

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
