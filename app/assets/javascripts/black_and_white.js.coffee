$(document).ready ->

	# create a new image object
	image = new Image()
	image.src = "cropped-asian-hipster.jpg"
	
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
	$('#canvas-3').mouseenter ->
		context.drawImage( image, 0, 0 )
	$('#cavas-3').mouseout ->
		context.putImageData(imageData, 0, 0);
		
	# click to hide the canvas
	$('.gloss').click ->
		$('#canvas-3').css
		'display': 'none'
	$('#canvas-3').click ->
		$('#canvas-3').css
			'display': 'none'
