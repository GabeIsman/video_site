players = []

onYouTubePlayerReady = (playerID) ->
	console.log( playerID )
	console.log( "hello" )
	players[players.length] = document.getElementByID(playerID)
	1

players

