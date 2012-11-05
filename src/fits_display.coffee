Display = require('./display')
Scales = require('./scales')
ScaleProcessor = require('./scale_processor')

FITS = require('fits')

class FitsDisplay extends Display
  constructor: (container,color,scale,desiredWidth,fitsFile) ->
    #Set up fits file and raw data
    fits = new FITS.File(fitsFile)
    image = fits.getDataUnit()
    @fitsData = image.getFrame()
    @fitsWidth = image.width
    @fitsHeight = image.height
    [@fitsMin, @fitsMax] = image.getExtremes()

    #Find scaled width, scale ratio,
    #and corresponding height (keeps same aspect ratio)
    #In addition use ~~ to truncat values for integer pixels
    scaledWidth = ~~desiredWidth
    @scaleRatio = @fitsWidth/scaledWidth
    scaledHeight = ~~(@fitsHeight/@scaleRatio)
    
    #Build buffers for scaling and coloring
    @buildScaleBuffers()
    @buildColorBuffers()
    
    #Call super to set up canvas and display buffers
    #This also sets @width and @height
    super container,scaledWidth,scaledHeight


  #This holds fits data with an applied scale (linear, log, etc)
  #All values should be 0 to 255 only
  buildScaleBuffers: ->
    @scaleBuffer = new ArrayBuffer(@fitsWidth*@fitsHeight)
    @scaleView8 = new Uint8ClampedArray(@scaleBuffer)

  #Holds RGBA Array
  buildColorBuffers: ->
    @colorBuffer = new ArrayBuffer(@fitsWidth*@fitsHeight*4)
    @colorView8 = new Uint8ClampedArray(@colorBuffer)
    @colorView32 = new Uint32Array(@colorBuffer)
  
  processImage: ->
    scaler = new ScaleProcessor Scales.linear
    scaler.process(@fitsData,@scaleView8,@fitsMin,@fitsMax,@fitsWidth,@fitsHeight)
    console.log @scaleView8

module?.exports = FitsDisplay
