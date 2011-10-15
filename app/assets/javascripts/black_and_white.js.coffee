$(document).ready ->

	$('.slide').click ->
		$(this).children('canvas').css
			'display': 'none'
		$(this).children('hgroup').css
			'display': 'none'
		$(this).children('.gloss').css
			'display': 'none'	
	
	canvases = $('.slider-canvas')
	contexts = new Array()
	counter = 0
	for canvas in canvases
						
		image = $(canvas).siblings('img').get(0)		
	
		# get the canvas and context, and draw the image
		contexts[counter] = canvas.getContext( "2d" )
		context = contexts[counter]
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
		
		# incriment the counter for the indexing of contexts
		counter++
		
		# hover toggle the black and white filter		
		$(canvas).siblings().mouseenter ->
			contexts[counter].drawImage( image, 0, 0 )
		$(canvas).siblings().mouseout ->
			contexts[counter].putImageData(imageData, 0, 0);
		counter++
		

	

