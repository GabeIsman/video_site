$ ->
	$('#go-button').mousedown ->
		$(this).css
			'background-color': 'rgba(50,0,0,.75)'
	$('#go-button').mouseup ->
		$(this).css
			'background-color': 'rgba(255,255,255,.5)'
	$('#search-form').focus ->
		$(this).attr('value','')
	$('#search-form').blur ->
		$(this).attr('value','search')
