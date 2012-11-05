class Display
  constructor: (@container,@width,@height) ->
    @canvasContainer = document.getElementById(@container)
    @canvas = document.createElement('canvas')
    @canvas.width = @width
    @canvas.height = @height
    @canvasContainer.appendChild(@canvas)
    @context = canvas.getContext('2d')

    @buildImageBuffers()
    
  buildImageBuffers: ->
    @displayData = @context.createImageData(@width,@height)
    @displayBuffer = new ArrayBuffer(@imageData.data.length)
    @displayView8 = new Uint8ClampedArray(@buffer)
    @dispayView32 = new Uint32Array(@buffer)

  draw: ->
    @displayData.data.set(buffView8)
    @context.putImageData(@displayData,0,0)

module?.exports = Display
