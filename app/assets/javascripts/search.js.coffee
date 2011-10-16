$ ->
	$('#go-button').mousedown ->
		$(this).css
			'background-color': 'rgba(100,0,0,.5)'
	$('#go-button').mouseup ->
		$(this).css
			'background-color': 'rgba(255,255,255,.5)'