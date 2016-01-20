class Reader
    constructor: ->
        @keyPresses = []
        @lastKeyPress = ""
        @lastTimeStamp = 0

    addKeyPress: (keyString, time) ->
        if time - @lastTimeStamp < 25 #multiple key press
            @keyPresses[@keyPresses.length - 1][0] += keyString
        else
            diff = if @lastTimeStamp is 0 then 0 else time - @lastTimeStamp
            if @lastKeyPress
                @keyPresses.push [@lastKeyPress, diff]

        @lastTimeStamp = time
        @lastKeyPress = keyString

    toHTML: ->
        @keyPresses.join "<br>"
        
$ -> 
    clearFunc = =>
        do $('#test').empty
        @reader = new Reader()

    #On key press, display key
    printing = off
    @reader = new Reader()
    $(document).keypress (e) ->
        keyCode = e.which
        time = e.timeStamp

        if keyCode is 223 #ß (alt-s)
            printing = not printing
            if printing is off
                $('#test').append @reader.toHTML()
            console.log "printing is now #{ if printing then "on" else "off" }"
        else if printing
            key = String.fromCharCode keyCode
            console.log "#{ key } = #{ keyCode } at #{ time }"
            @reader.addKeyPress key, time
        else if keyCode is 12 #Ctrl-l
            do clearFunc

    #Clear button clears text
    $('#clearButton').click clearFunc

