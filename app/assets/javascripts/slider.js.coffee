$ ->

	# add the "current" class to the first slider-wrapper
	$("#slider-wrapper-1").addClass( "current" )
		
	# SET EVERYTHING
	# define variables
	slides = $('.current').find('.slide')
	slide_width = $('.slide').width() + 30
	number_of_slides = slides.length
	current_position = 0
	dots = $('.current').find('.dot')

	# alter the slide-inner div
	$('.current').find('.slide-inner').css
		'width': number_of_slides * slide_width



	# HOW TO SLIDE FUNCTIONS
	# manage position
	manage_position = ( current_position ) ->
		current_position = 0 if current_position > number_of_slides - 1
		current_position = number_of_slides - 1 if current_position < 0
		current_position

	# slide
	slide = ( current_position ) ->
		$('.current').find('.slide-inner').animate
			'margin-left': -( slide_width * current_position )
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



	# WHEN TO SLIDE FUNCTIONS		
	# left control functions
	$('.current').children('.left-control').mousedown ->
		$(this).css
			'border-right': '40px solid rgb(50,0,0)'
	$('.current').children('.left-control').mouseup ->
		$(this).css
			'border-right': '40px solid rgb(255,255,255)'
	$('.current').children('.left-control').click ->
		current_position -= 1
		current_position = manage_position( current_position )
		current_position = slide( current_position )
		color_dots( current_position)

	# right control functions	
	$('.current').children('.right-control').mousedown ->
		$(this).css
			'border-left': '40px solid rgb(50,0,0)'
	$('.current').children('.right-control').mouseup ->
		$(this).css
			'border-left': '40px solid rgb(255,255,255)'
	$('.current').children('.right-control').click ->
		current_position += 1
		current_position = manage_position( current_position )
		current_position = slide( current_position )
		color_dots( current_position)

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



	# DOT FUNCTIONS
	# current position dots
	color_dots = ( current_position ) ->
		$(dots[current_position]).css
			'background-color': 'rgb(50,0,0)'
		for dot in dots
			unless dot == dots[current_position]
				$(dot).css
					'background-color': 'transparent'
					
	# dot control functions
	$('.dots-wrapper').css
		'width': (dots.length * 50) - 34
	$('.dot').click ->
		current_position = $('.dot').index(this)
		current_position = slide( current_position )
		color_dots( current_position )



	# on click, remove all instances of the "current" class
	# and add it to the slider-wrapper with the same index as the tab
	# that was clicked
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
	
	# stop the timer on click
	$('.slide').click ->
		clearTimeout( t )
	$('.control').click ->
		clearTimeout( t )
	$('.dot').click ->
		clearTimeout( t )