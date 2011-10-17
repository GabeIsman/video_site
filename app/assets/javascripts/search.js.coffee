$ ->
	$('#go-button').mousedown ->
		$(this).css
			'background-color': 'rgba(50,0,0,.75)'
	$('#go-button').mouseup ->
		$(this).css
			'background-color': 'rgba(255,255,255,.5)'