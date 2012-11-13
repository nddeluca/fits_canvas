Canvas = require('./canvas')
scales = require('./scales')
ScaleProcessor = require('./scale_processor')
colors = require('./colors')
ColorProcessor = require('./color_processor')

class Display extends Canvas
  constructor: (container,desiredWidth,image) ->
    #Set up image data and information
    @imageData = image.data
    @imageWidth = image.width
    @imageHeight = image.height

    #Find scaled width, scale ratio,
    #and corresponding height (keeps same aspect ratio)
    #In addition use ~~ to truncat values for integer pixels
    scaledWidth = ~~desiredWidth
    @scaleRatio = @imageWidth/scaledWidth
    scaledHeight = ~~(@imageHeight/@scaleRatio)
    
    #Build buffers for scaling and coloring
    @buildScaleBuffers()
    @buildColorBuffers()
    
    #Set default scale and color
    @scale = scales.linear
    @color = colors.grayscale

    #Intialize scale and color processors
    @scaler = new ScaleProcessor(@scale)
    @colorer = new ColorProcessor(@color)

    #Call super to set up canvas and display buffers
    #This also sets @width and @height
    super container,scaledWidth,scaledHeight


  #This holds fits data with an applied scale (linear, log, etc)
  #All values should be 0 to 255 only
  buildScaleBuffers: ->
    @scaleBuffer = new ArrayBuffer(@imageWidth*@imageHeight)
    @scaleView8 = new Uint8ClampedArray(@scaleBuffer)
    undefined

  #Holds RGBA Array
  buildColorBuffers: ->
    @colorBuffer = new ArrayBuffer(@imageWidth*@imageHeight*4)
    @colorView8 = new Uint8ClampedArray(@colorBuffer)
    @colorView32 = new Uint32Array(@colorBuffer)
    undefined
  
  processImage: ->
    @scaler.process(@imageData,@scaleView8)
    @colorer.process(@scaleView8,@colorView32)

    invertCoeff = (@imageHeight - 1)*@imageWidth

    for x in [0..(@canvasWidth-1)]
      coeff = ~~(x*@scaleRatio) + invertCoeff
      for y in [0..(@canvasHeight-1)]
        @canvasView32[(@canvasWidth*y)+x] = @colorView32[coeff - (~~(y*@scaleRatio))*@imageWidth]
    undefined
    
module?.exports = Display
