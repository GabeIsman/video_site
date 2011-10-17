# THE TIMER
$ ->
	
	
	# DEFINE VARIABLES
	slide_width = $('.slide').width() + 30
	slides = $(".slide")
	number_of_slides = slides.length
	current_position = 0
	dots = $('.dot')	
	
	
	# DEFINE FUNCTIONS	
	# current position dots
	color_dots = ( current_position ) ->
		$(dots[current_position]).css
			'background-color': 'rgb(100,0,0)'
		for dot in dots
			unless dot == dots[current_position]
				$(dot).css
					'background-color': 'transparent'
	
	# manage position
	manage_position = ( current_position ) ->
		current_position = 0 if current_position > number_of_slides - 1
		current_position = number_of_slides - 1 if current_position < 0
		current_position
	
	# slide
	slide = ( current_position ) ->
		$('#slide-inner').animate
			'marginLeft': -( slide_width * current_position )
			1000
		$('.slide').children('.gloss, .slide-cover, hgroup, .slider-canvas').css
			'display': 'block'
		current_position
		
	# slide-right
	slide_right = ( current_position ) ->
		current_position += 1
		current_position = manage_position( current_position )
		current_position = slide( current_position )
		current_position
		
	#slide-left
	slide_left = ( current_position ) ->
		current_position -= 1
		current_position = manage_position( current_position )
		current_position = slide( current_position )
		current_position

	# the automate function
	automate = ( current_position ) ->
		current_position = slide_right( current_position )
		color_dots( current_position )	
		t = setTimeout( =>
			automate( current_position )
		,5000 )	
		$('.slide').click ->
			clearTimeout( t )
		$('.control').click ->
			clearTimeout( t )
		$('.dot').click ->
			clearTimeout( t )
			
	# left control functions
	$('#left-control').mousedown ->
		$(this).css
			'border-right': '40px solid rgba(100,0,0,.5)'
	$('#left-control').mouseup ->
		$(this).css
			'border-right': '40px solid rgba(255,255,255,1)'
	$('#left-control').click ->
		current_position -= 1
		current_position = manage_position( current_position )
		current_position = slide( current_position )
		color_dots( current_position)

	# right control functions	
	$('#right-control').mousedown ->
		$(this).css
			'border-left': '40px solid rgba(100,0,0,.5)'
	$('#right-control').mouseup ->
		$(this).css
			'border-left': '40px solid rgba(255,255,255,1)'
	$('#right-control').click ->
		current_position += 1
		current_position = manage_position( current_position )
		current_position = slide( current_position )
		color_dots( current_position)
		
	# dot control functions
	$('.dot').click ->
		current_position = $('.dot').index(this)
		current_position = slide( current_position )
		color_dots( current_position )
		


	# MAIN PROGRAM
	# create the slide-inner div
	slides.wrapAll('<div id="slide-inner"></div>')
	$('#slide-inner').css
		'width': number_of_slides * slide_width
			
	# set the first dot
	color_dots( current_position )
	
	# animate on a timer						
	t = setTimeout( =>
		automate( current_position )
	,5000)
	
	# stop the timer on click
	$('.slide').click ->
		clearTimeout( t )
	$('.control').click ->
		clearTimeout( t )
	$('.dot').click ->
		clearTimeout( t )