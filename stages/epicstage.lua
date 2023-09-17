local angleshit = 1;
local anglevar = 1;


function onCreatePost()
    -- hiding healthbar
    setProperty('healthBarBG.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    -- setProperty('camHUD.visible', false)
    -- setProperty('notes.cameras', true)
    -- setProperty('strumLineNotes.cameras', true)
    
    end

function onCreate() 
    
    -- game over stuff
    setPropertyFromClass('GameOverSubstate','characterName', 'ds_gameover');
	setPropertyFromClass('GameOverSubstate','deathSoundName','no');
	setPropertyFromClass('GameOverSubstate','loopSoundName','no');
	setPropertyFromClass('GameOverSubstate','endSoundName','no');

    --colors for the door and bg to pick from
    colors = {'idle','black','blue','red'}
    positions = {'0.05','-0.05','-0.1','0.1'}
    color = 0
    color_bg = 0
    
    --grid background
    makeLuaSprite('gridbg','gridbg',-4000,-2500)
    scaleObject('gridbg',5,5)
    setScrollFactor('gridbg',0,0)
    addLuaSprite('gridbg',false)
    setProperty('gridbg.alpha','0.0')

    --color background
    makeAnimatedLuaSprite('bg','bg',-1500,-1750)
    addAnimationByPrefix('bg','idle','idle',12,false);
    addAnimationByPrefix('bg','black','black',12,false);
    addAnimationByPrefix('bg','blue','blue',12,false);
    addAnimationByPrefix('bg','red','red',12,false);
    objectPlayAnimation('bg','idle',true);
    scaleObject('bg',5,5)
    addLuaSprite('bg',false)

    --flashing face
    makeAnimatedLuaSprite('epic','epicface',-850,-400)
    addAnimationByPrefix('epic','bounce','bounce',12,false);
    objectPlayAnimation('epic','bounce',true);
	scaleObject('epic',2.3,2.3);
    setProperty('epic.alpha',0.5)
    addLuaSprite('epic',false);

    --door
    makeAnimatedLuaSprite('door','epicdoor',-1150,-250)
    addAnimationByPrefix('door','idle','idle',12,true);
    addAnimationByPrefix('door','black','black',12,true);
    addAnimationByPrefix('door','blue','blue',12,true);
    addAnimationByPrefix('door','red','red',12,true);
    addAnimationByPrefix('door','open','open',12,false);
    setScrollFactor('door',1,1);
	scaleObject('door',2.5,2.5);
    objectPlayAnimation('door','idle',true);
    addLuaSprite('door',false);

    --foreground ds
    makeLuaSprite('ds','ds',-1500,-1750)
    scaleObject('ds',5,5)
    addLuaSprite('ds',true)


end

function onBeatHit()

    --white flash / adding grid pattern (white flash is in other file)
    if curBeat >= 16 and curBeat <= 208 then
        setProperty('gridbg.alpha',1)
    else 
        setProperty('gridbg.alpha',0)
    end

    
        
    -- doing the color changes before the beat drop
    if curBeat == 112 or curBeat == 116 or curBeat == 120 or curBeat == 124 then
        color = color + 1 
        color_bg = color_bg + 1
        objectPlayAnimation('door',colors[color],true);
        objectPlayAnimation('bg',colors[color_bg],true)
        if color_bg >= #colors then color_bg = 0 end
        if color >= #colors then color = 0 end
    end

    if curBeat == 128 then
        objectPlayAnimation('door','idle',true);
        objectPlayAnimation('bg','idle',true)
    end

    
    -- camera zoom effects
    if curBeat == 112 then triggerEvent('Add Camera Zoom','-0.25','0') end -- repeat motif zoom out
    if curBeat == 112 or curBeat == 116 or curBeat == 120 or curBeat == 124 then triggerEvent('Add Camera Zoom','0.1','0') end -- repeat motif zoom in
    if curBeat == 128 then triggerEvent('Add Camera Zoom','-0.2','0') end -- repeat motif reset
    if curBeat == 142 then triggerEvent('Add Camera Zoom','0.5','0') end -- ah
    if curBeat == 143 then triggerEvent('Add Camera Zoom','-0.6','0') end -- yeah
    if curBeat == 144 then triggerEvent('Add Camera Zoom','0.3','0') end -- beat drop
    if curBeat == 206 then triggerEvent('Add Camera Zoom','-0.5','0') end -- ah 2 
    if curBeat == 207 then triggerEvent('Add Camera Zoom','0.1','0') end -- yeah 2
    if curBeat == 208 then triggerEvent('Add Camera Zoom','0.1','0') end -- reset beat stop
    if curBeat == 240 then triggerEvent('Add Camera Zoom','-0.1','0') end -- song end
    
    

    -- beat drop
    if curBeat>=144 and curBeat < 208 then
        color = color + 1 
        objectPlayAnimation('door',colors[color],true);
        if curBeat%2==0 then 
            objectPlayAnimation('bg',colors[color_bg],true)
            color_bg = color_bg + 1
            if color_bg >= #colors then color_bg = 0 end
        end
        objectPlayAnimation('epic','bounce',true);
        if color >= #colors then color = 0 end 


		if curBeat % 2 == 0 then -- i stole this from bbpanzu demoman song hahaaaaa fuck you
			angleshit = anglevar;
		else
			angleshit = -anglevar;
		end
		setProperty('camHUD.angle',angleshit*3)
		setProperty('camGame.angle',angleshit*3)
		doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
		doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
	else
		setProperty('camHUD.angle',0)
		setProperty('camHUD.x',0)
		setProperty('camHUD.x',0)
    end

    -- zooming camera back out and in and whatnot
    
        

    --resetting
    if curBeat == 208 then
        objectPlayAnimation('door','idle',true);
        objectPlayAnimation('bg','idle',true)
    end


    -- opening door
    if curBeat == 249 then
        objectPlayAnimation('door','open',true);
    end
    
    
end

function onStepHit()
    if curStep == 728 or curStep == 730 or curStep == 732 or curStep == 734 then triggerEvent('Add Camera Zoom','-0.1','0') end --high pitched portion of beat drop
    if curStep == 736 then triggerEvent('Add Camera Zoom','0.4','0') end

    if curStep >= 800 and curStep < 815 then
        triggerEvent('Add Camera Zoom',positions[math.random(#positions)],'0')
    end 
    if curStep == 815 then 
        triggerEvent('Set Camera Zoom','0.1','0') 
    end
    if curStep == 816 or curStep == 818 or curStep == 820 or curStep == 822 then
        triggerEvent('Add Camera Zoom','0.1','0') 
    end
end