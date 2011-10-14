$(document).ready ->
	
	# THE SLIDER
	slider = $("#slider")
	slide_width = 503
	slides = $(".slide")
	number_of_slides = slides.length
	current_position = 1
		
		
	slides.wrapAll('<div id="slide-inner"></div>')
	$('#slide-inner').css
		'width': number_of_slides * slide_width
		
	automate_callback = ->
		automate( current_position )		
	
	
	automate = ( current_position ) ->
		$('#slide-inner').animate
			'marginLeft': -( slide_width * current_position )
			1000
		if current_position < number_of_slides - 1
			current_position += 1
		else
			current_position = 0	
		setTimeout automate_callback, 5000
		
		

						
						
	setTimeout automate_callback, 5000
	
	
	
	
			
	# click to hide the canvas
	$('#canvas-3').parent().click ->
		$('#canvas-3').css
			'display': 'none'
		$('#canvas-3').siblings('hgroup').css
			'display': 'none'
		$('#canvas-3').siblings('.gloss').css
			'display': 'none'

	# create a new image object
	# image = new Image()
	# image.src = "cropped-asian-hipster.jpg"
	image = document.getElementById( "image-3" )
	image.width = 460
	image.height = 380
	
	# get the canvas and context, and draw the image
	canvas = document.getElementById( "canvas-3" )
	context = canvas.getContext( "2d" )
	canvas.width = image.width
	canvas.height = image.height
	context.drawImage( image, 0, 0 )

	# get the image data
	imageData = context.getImageData( 0, 0, canvas.width, canvas.height )
	data = imageData.data

	# create the black and white filter
	for i in [0..data.length] by 4
		luminosity = ( ( data[ i ] * 0.21 ) + ( data[ i + 1 ] * 0.71 ) + ( data[ i + 2 ] * 0.07 ) )
		# avg = (data[ i ] + data[ i + 1 ] + data[ i + 2 ]) / 3
		data[ i ] = luminosity
		data[ i + 1 ] = luminosity
		data[ i + 2 ] = luminosity

	# apply the black and white filter
	context.putImageData(imageData, 0, 0);
	
	# hover toggle the black and white filter
	$('#canvas-3').siblings().mouseenter ->
		context.drawImage( image, 0, 0 )
	$('#canvas-3').siblings().mouseout ->
		context.putImageData(imageData, 0, 0);
		

	

