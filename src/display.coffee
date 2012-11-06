class Display
  constructor: (@container,@width,@height) ->
    @canvasContainer = document.getElementById(@container)
    @canvas = document.createElement('canvas')
    @canvas.width = @width
    @canvas.height = @height
    @canvasContainer.appendChild(@canvas)
    @context = @canvas.getContext('2d')
    @buildImageBuffers()
    
  buildImageBuffers: ->
    @displayData = @context.createImageData(@width,@height)
    @displayBuffer = new ArrayBuffer(@displayData.data.length)
    @displayView8 = new Uint8ClampedArray(@displayBuffer)
    @displayView32 = new Uint32Array(@displayBuffer)
    return

  draw: ->
    @displayData.data.set(@displayView8)
    @context.putImageData(@displayData,0,0)
    return

module?.exports = Display
