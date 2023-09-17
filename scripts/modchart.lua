function onSongStart()
    noteTweenX("NoteMove1",4,100,0.3,linear)
    noteTweenX("NoteMove2",5,200,0.3,linear)
    noteTweenX("NoteMove3",6,300,0.3,linear)
    noteTweenX("NoteMove4",7,400,0.3,linear)
end
function onUpdate(elapsed)
    for i=0,3 do
        noteTweenAlpha(i+16, i, math.floor(curStep/9000),0.3)
    end
end