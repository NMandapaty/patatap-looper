class Reader
    constructor: ->
        @keyPresses = []
        @lastTimeStamp = 0

    addKey: (keyString, time) ->
        if time - @lastTimeStamp < 25 #multiple key press
            @keyPresses[@keyPresses.length - 1][0] += keyString
        else
            @keyPresses.push [keyString, time]

        @lastTimeStamp = time

    toHTML: ->
        @keyPresses.join "<br>"
        

$ -> 
    #Clear button clears text
    $('#clearButton').click ->
        do $('#test').empty

    #On key press, display key
    printing = off
    reader = new Reader()
    $(document).keypress (e) ->
        keyCode = e.which
        time = e.timeStamp

        if keyCode is 223 #ß (alt-s)
            printing = not printing
            if printing is off
                $('#test').append reader.toHTML()
            console.log "printing is now #{ if printing then "on" else "off" }"
        else if printing
            key = String.fromCharCode keyCode
            console.log "#{ key } = #{ keyCode } at #{ time }"
            reader.addKey key, time
