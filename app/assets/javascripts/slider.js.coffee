# THE SLIDER
slider = $("#slider")
slide_width = 503
slides = $(".slide")
number_of_slides = slides.length
current_position = 1
	
	
slides.wrapAll('<div id="slide-inner"></div>')
$('#slide-inner').css
	'width': number_of_slides * slide_width
	
automate_callback = ( current_position ) ->
	automate( current_position )
	
automate = ( current_position ) ->
	$('#slide-inner').animate
		'marginLeft': -( slide_width * current_position )
		1000
	if current_position < number_of_slides - 1
		current_position += 1
	else
		current_position = 0
	setTimeout( =>
		automate( current_position )
	,5000 )	
								
setTimeout( =>
	automate( current_position )
,5000)