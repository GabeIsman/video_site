(function() {
  $(document).ready(function() {
    var canvas, context, data, i, image, imageData, luminosity, _ref;
    image = new Image();
    image.src = "cropped-asian-hipster.jpg";
    canvas = document.getElementById("canvas-3");
    context = canvas.getContext("2d");
    canvas.width = image.width;
    canvas.height = image.height;
    context.drawImage(image, 0, 0);
    imageData = context.getImageData(0, 0, canvas.width, canvas.height);
    data = imageData.data;
    for (i = 0, _ref = data.length; i <= _ref; i += 4) {
      luminosity = (data[i] * 0.21) + (data[i + 1] * 0.71) + (data[i + 2] * 0.07);
      data[i] = luminosity;
      data[i + 1] = luminosity;
      data[i + 2] = luminosity;
    }
    context.putImageData(imageData, 0, 0);
    $('#canvas-3').mouseenter(function() {
      return context.drawImage(image, 0, 0);
    });
    $('#cavas-3').mouseout(function() {
      return context.putImageData(imageData, 0, 0);
    });
    return $('#canvas-3').click(function() {
      return $('#canvas-3').css({
        'display': 'none'
      });
    });
  });
}).call(this);
