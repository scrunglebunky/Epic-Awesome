function onCreate()
    makeLuaSprite('whiteFlash','',0,400)
    makeGraphic('whiteFlash',1280,100,'FFFFFF')
    setProperty('whiteFlash.scale.x', 12)
    setProperty('whiteFlash.scale.y', 12)
    setProperty('whiteFlash.alpha', 0)
    addLuaSprite('whiteFlash', true);
    setObjectCamera('whiteFlash', 'hud')
end

function whiteFlashEvent()
    setProperty('whiteFlash.alpha', 1)
    runTimer('whiteFlashEvent', 0.1)
end

function onTimerCompleted(tag, l, ll)
    if tag == 'whiteFlashEvent' then
        doTweenAlpha('byebye', 'whiteFlash', 0, 0.5, 'linear');
    end
end

function onBeatHit()
    if curBeat == 16 or (curBeat >= 16 and (curBeat-16)%32==0 and curBeat <= 144) or (curBeat >= 144 and curBeat <= 208 and curBeat%2==0) then
        whiteFlashEvent()
    end
end