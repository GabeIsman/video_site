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

	# Color the Dots
	# Color the curent position dot
	color_dots = () ->
		$(dots).css
			'background-color': 'transparent'
		$(dots[current_position]).css
			'background-color': 'rgb(50,0,0)'
	color_dots()

	# animate on a timer						
	t = setTimeout( =>
		automate()
	,5000)


	# LISTENERS AND FUNCTIONS
	# The How To Slide Functions
	
	# Slide
	# Slide by first checking and managing the current position variable,
	# then animating the slide-inner div, and then reseting the display
	# on the every slide's children. Finally, we color the correct dot
	# and return the current position.
	slide = () ->
		current_position = 0 if current_position > number_of_slides - 1
		current_position = number_of_slides - 1 if current_position < 0	
		$('.current').find('.slide-inner').animate
			'margin-left': -( slide_width * current_position )
			1000
		$('.slide').children('.gloss, .slide-cover, hgroup, .slider-canvas').css
			'display': 'block'
		color_dots()
	
	# Slide Right
	# Slide right by incrimenting the current position variable and then
	# calling the slide function
	slide_right = () ->
		current_position += 1
		slide()
	
	# Slide Left
	# Slide left by deincrimenting the current position variable and then
	# calling the slide function
	slide_left = () ->
		current_position -= 1
		slide()


	# The When To Slide Functions		
	
	# The Automate Function
	# Slide right then wait five seconds before sliding right and calling itself.
	automate = () ->
		console.log "the automate function has been called."
		console.log "the current position was " + current_position
		slide_right()
		console.log "the current position is now " + current_position
		t = setTimeout( =>
			automate()
		,5000 )
	
	# Left Control Listener and Functions
	# When the left control is clicked, change the color of the button then
	# slide left. Finally, return the current position. Last we clear the timeout.
	$('.current > .left-control').live "mousedown", ->
		$(this).css
			'border-right': '40px solid rgb(50,0,0)'
	$('.current > .left-control').live "mouseup", ->
		$(this).css
			'border-right': '40px solid rgb(255,255,255)'	
	$('.current > .left-control').live "click", ->
		console.log "left control has been clicked"
		clearTimeout( t )
		console.log "timeout has been cleared"
		console.log "the current position was " + current_position
		slide_left()
		console.log "The current position is now: " + current_position

	# Right Control Listener and Functions
	# When the right control is clicked, change the color of the button then
	# slide right. Finally return the current position. Last we clear the timeout.
	$('.current > .right-control').live "mousedown", ->
		$(this).css
			'border-left': '40px solid rgb(50,0,0)'
	$('.current > .right-control').live "mouseup", ->
		$(this).css
			'border-left': '40px solid rgb(255,255,255)'	
	$('.current > .right-control').live "click", ->
		console.log "right control has been clicked"
		clearTimeout( t )
		console.log "timeout has been cleared"
		console.log "the current position was " + current_position
		slide_right()
		console.log "The current position is now: " + current_position
			
	# Clear Timeout Listers
	# When either a .control, .slide, .dot, or a .primary-header, stop the automation
		
	$('.slide').click ->
		clearTimeout( t )



	# The Dot Click Lister
	# First we find the position of the clicked dot, set that as the current position
	# and then slide to the new current position. Last, we clear the timeout
	$('.dot').click ->
		current_position = $('.dot').index(this)
		slide()
		clearTimeout( t )



	# TAB CLICK FUNCTION
	
	# Primary header click
	# on the click of the header, do a whole lot of things...
	$('.primary-header').click ->
		
		# clear the timeout, remove the current class from all slide-wrappers
		# then add the current class to the slider wrapper with the
		# same index as the clicked header.
		clearTimeout( t )
		$(".slider-wrapper").removeClass( "current" )
		this_index = $('.primary-header').index(this)
		$('.slider-wrapper').get(this_index).className += " current"		
	
		# redefine the variables
		slides = $('.current').find('.slide')
		slide_width = $('.slide').width() + 30
		number_of_slides = slides.length
		current_position = 0
		dots = $('.current').find('.dot')

		# set the current slide-inner div's width and color the first dot
		$('.current').find('.slide-inner').css
			'width': number_of_slides * slide_width
		color_dots()

		# begin animation						
		t = setTimeout( =>
			automate()
		,5000)
	
	
	# THE MAIN PROGRAM	


