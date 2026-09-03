-- source: steam id 2551954944 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944
function botton(boolVariable,bx,by,bw,bh,textWhenOn,colorTextWhenOnRed,colorTextWhenOnGreen,colorTextWhenOnBlue,bgColorTextWhenOnRed,bgColorTextWhenOnGreen,bgColorTextWhenOnBlue,textWhenOff,colorTextWhenOffRed,colorTextWhenOffGreen,colorTextWhenOffBlue,bgColorTextWhenOffRed,bgColorTextWhenOffGreen,bgColorTextWhenOffBlue)
	if boolVariable
		then
		screen.setColor(bgColorTextWhenOnRed,bgColorTextWhenOnGreen,bgColorTextWhenOnBlue)
		screen.drawRectF(bx, by, bw, bh)
		screen.setColor(colorTextWhenOnRed,colorTextWhenOnGreen,colorTextWhenOnBlue)
		screen.drawTextBox(bx, by, bw, bh, textWhenOn,0,0)
		else
		screen.setColor(bgColorTextWhenOffRed,bgColorTextWhenOffGreen,bgColorTextWhenOffBlue)
		screen.drawRectF(bx, by, bw, bh)
		screen.setColor(colorTextWhenOffRed,colorTextWhenOffGreen,colorTextWhenOffBlue)
		screen.drawTextBox(bx, by, bw, bh, textWhenOff,0,0)
	end
end
function onTick()
	w,h=input.getNumber(1),input.getNumber(2)
	inputX,inputY=input.getNumber(3),input.getNumber(4)
	isPressed1=input.getBool(1)
	laserDistance=input.getNumber(14)

	sliderX,sliderY,sliderW,sliderH=w-9,0,9,h--slider fov position&dimension
	fov=sliderOut

	--buttons
	if isPressed1 and inputX<sliderX
 	  then
  	     if inputY<9 
   	    	then 
    	        if inputX<(w/2-4)
    	        	then 
       	        	if irButtonCtrl
        	       		then 
        	         		irButton = not irButton
         	         		irButtonCtrl = false
         	       end
       	    else
        	       if laserButtonCtrl
        	        	then 
                    		laserButton = not laserButton
                    		laserButtonCtrl = false
         	      end
            end
       		 else
            if inputY>(h-9)
            then
                if inputX<(w/2-4)
                then
                if stabilizerButtonCtrl
                then 
                    stabilizerButton = not stabilizerButton
                    stabilizerButtonCtrl = false
                end
                else
                if trackingButtonCtrl
                then 
                    trackingButton = not trackingButton
                    trackingButtonCtrl = false
                end
                end
            end
      		  end
		else
        irButtonCtrl=true
        laserButtonCtrl=true
        stabilizerButtonCtrl=true
        trackingButtonCtrl=true
	end

	output.setBool(1, irButton)
	output.setBool(2, laserButton)
	output.setBool(3, stabilizerButton)
	output.setBool(4, trackingButton)
	output.setBool(5, dataSend)
end

function onDraw()
	w=screen.getWidth()
	h=screen.getHeight()

	if w==32
		then iS1="ir" iS0="ir" lS1="ls" lS0="ls" sS1="st" sS0="st" tS1="tr" tS0="tr"
		else
			if w==64
				then iS1="ir on" iS0="ir no" lS1="laser" lS0="laser" sS1="stbz" sS0="stbz" tS1="track" tS0="track"
				else
					if w==96
						then iS1="ir on" iS0="ir off" lS1="laser on" lS0="laser" sS1="stbz on" sS0="stbz off" tS1="track on" 							 tS0="track"
						else
							if w==160
								then iS1="night vision" iS0="infrared off" lS1="laser on" lS0="laser off" sS1="stabilized on" 									 sS0="stabilized off" tS1="tracking on" tS0="tracking off"
								else
									if w==288
										then iS1="night vision" iS0="infrared off" lS1="laser on" lS0="laser off" sS1="stabilized on" 											sS0="stabilized off" tS1="tracking on" tS0="tracking off"
									end
							end
					end
			end
	end

	--ui-Button
	botton(irButton,0,0, sliderX/2,9, iS1, 0,0,0, 255,255,255, iS0, 255,0,0, 10,10,10)--ir
	botton(laserButton,sliderX/2,0, sliderX/2,9, lS1, 0,0,0, 0,255,0, lS0, 255,0,0, 10,10,0)--lsr
	botton(stabilizerButton,0,h-9, sliderX/2,9, sS1, 0,0,0, 0,255,0, sS0, 255,0,0, 10,0,0)--stb
	botton(trackingButton,sliderX/2,h-9, sliderX/2,9, tS1, 0,0,0, 0,255,0, tS0, 255,0,0, 10,0,0)--trk
	
	--HUD Frame
	screen.setColor(20,20,20)
	screen.drawLine(w-9, 0, w-9, h)
	screen.drawLine(0, 9, w-9, 9)
	screen.drawLine(0, h-9, w-9, h-9)
	screen.drawLine(w/2-4, 0, w/2-4, 9)
	screen.drawLine(w/2-4, h-9, w/2-4, h)
	--
	
end