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
	imageDatas = new Array()
	images = new Array()
	counter = 0
	
	
	for something in canvases
						
		images[counter] = $(something).siblings('img').get(0)
		image = images[counter]
	
		# get the canvas and context, and draw the image
		contexts[counter] = something.getContext( "2d" )
		context = contexts[counter]
		something.width = image.width
		something.height = image.height
		context.drawImage( image, 0, 0 )

		# get the image data
		imageDatas[counter] = context.getImageData( 0, 0, something.width, something.height )
		imageData = imageDatas[counter]
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
				
		# incriment the counter
		counter++
		
	###		
	for i in [0..canvases.length] by 1
		$canvas[i].parent().mouseenter ->
			image = images[i]
			context = contexts[i]
			context.drawImage( image, 0, 0 )
		$canvas[i].parent().mouseout ->
			imageData = imageDatas[x]
			context = contexts[i]
			context.putImageData( imageData, 0, 0 )
	###
	$(canvases[0]).parent().mouseenter ->
		x = 0
		image = images[x]
		context = contexts[x]
		context.drawImage( image, 0, 0 )
	$(canvases[0]).parent().mouseout ->
		x = 0
		imageData = imageDatas[x]
		context = contexts[x]
		context.putImageData( imageData, 0, 0 )
	$(canvases[1]).siblings().mouseenter ->
		x = 1
		image = images[x]
		context = contexts[x]
		context.drawImage( image, 0, 0)
	$(canvases[1]).siblings().mouseout ->
		x = 1
		imageData = imageDatas[x]
		context = contexts[x]
		context.putImageData( imageData, 0, 0 )
	$(canvases[2]).siblings().mouseenter ->
		x = 2
		image = images[x]
		context = contexts[x]
		context.drawImage( image, 0, 0 )
	$(canvases[2]).siblings().mouseout ->
		x = 2
		imageData = imageDatas[x]
		context = contexts[x]
		context.putImageData( imageData, 0, 0 )	