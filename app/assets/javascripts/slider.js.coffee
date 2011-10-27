$ ->

	# SET EVERYTHING
	# Add classes
	# Add the class "current" to the first slider-wrapper
	$("#slider-wrapper-1").addClass( "current" )
		
	# define variables
	slides = $('.current').find('.slide')
	slide_width = $('.slide').width() + 30
	number_of_slides = slides.length
	current_position = 0
	dots = $('.current').find('.dot')

	# alter elements
	# set the size of the dot wrapper div
	$('.dots-wrapper').css
		'width': (dots.length * 50) - 34
	# alter the slide-inner div
	$('.current').find('.slide-inner').css
		'width': number_of_slides * slide_width


	# LISTENERS AND FUNCTIONS
	# The How To Slide Functions
	
	# Slide
	# Slide by first checking and managing the current position variable,
	# then animating the slide-inner div, and then reseting the display
	# on the every slide's children. Finally, we color the correct dot
	# and return the current position.
	slide = ( current_position ) ->
		current_position = 0 if current_position > number_of_slides - 1
		current_position = number_of_slides - 1 if current_position < 0	
		$('.current').find('.slide-inner').animate
			'margin-left': -( slide_width * current_position )
			1000
		$('.slide').children('.gloss, .slide-cover, hgroup, .slider-canvas').css
			'display': 'block'
		color_dots( current_position)
		current_position
	
	# Slide Right
	# Slide right by incrimenting the current position variable and then
	# calling the slide function
	slide_right = ( current_position ) ->
		current_position += 1
		current_position = slide( current_position )
	
	# Slide Left
	# Slide left by deincrimenting the current position variable and then
	# calling the slide function
	slide_left = ( current_position ) ->
		current_position -= 1
		current_position = slide( current_position )



	# The When To Slide Functions		
	
	# The Automate Function
	# Slide right then wait five seconds before sliding right and calling itself.
	automate = ( current_position ) ->
		current_position = slide_right( current_position )
		t = setTimeout( =>
			automate( current_position )
		,5000 )
	
	# Left Control Listener and Functions
	# When the left control is clicked, change the color of the button then
	# slide left. Finally, return the current position.
	$('.current').children('.left-control').mousedown ->
		$(this).css
			'border-right': '40px solid rgb(50,0,0)'
	$('.current').children('.left-control').mouseup ->
		$(this).css
			'border-right': '40px solid rgb(255,255,255)'	
	$('.current').children('left-control').click ->
		current_position = slide_left( current_position )
	current_position

	# Right Control Listener and Functions
	# When the right control is clicked, change the color of the button then
	# slide left. Finally return the current position.
	$('.current').children('.right-control').mousedown ->
		$(this).css
			'border-left': '40px solid rgb(50,0,0)'
	$('.current').children('.right-control').mouseup ->
		$(this).css
			'border-left': '40px solid rgb(255,255,255)'	
	$('.current').children('.right-control').click ->
		current_position = slide_right( current_position )
	current_position
			
	# Clear Timeout Listers
	# When either a .control, .slide, .dot, or a .primary-header, stop the automation
	$('.control').click ->
		clearTimeout( t )
	$('.dot').click ->
		clearTimeout( t )
	$('.slide').click ->
		clearTimeout( t )
	$('.primary-header').click ->
		clearTimeout( t )

	# The Dot Click Lister
	# First we find the position of the clicked dot, set that as the current position
	# and then slide with the new current position.
	$('.dot').click ->
		current_position = $('.dot').index(this)
		current_position = slide( current_position )



	# Misc. Functions
	# Color the curent position dot
	
	color_dots = ( current_position ) ->
		$(dots).css
			'background-color': 'transparent'
		$(dots[current_position]).css
			'background-color': 'rgb(50,0,0)'



	# TAB CLICK FUNCTION
	$('.primary-header').click ->
		$(".slider-wrapper").removeClass( "current" )
		this_index = $('.primary-header').index(this)
		console.log( this_index )
		console.log( $('.slider-wrapper').get(this_index) )
		$('.slider-wrapper').get(this_index).className += " current"		
		# define your variables
		slides = $('.current').find('.slide')
		slide_width = $('.slide').width() + 30
		number_of_slides = slides.length
		current_position = 0
		dots = $('.current').find('.dot')
		# alter the slide-inner div
		$('.current').find('.slide-inner').css
			'width': number_of_slides * slide_width
		# set the first dot
		color_dots( current_position )
		# animate on a timer						
		t = setTimeout( =>
			automate( current_position )
		,5000)
	# set the first dot
	color_dots( current_position )
	# animate on a timer						
	t = setTimeout( =>
		automate( current_position )
	,5000)	


