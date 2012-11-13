class Canvas
  constructor: (@container,@canvasWidth,@canvasHeight) ->
    @canvasContainer = document.getElementById(@container)
    @canvas = document.createElement('canvas')
    @canvas.width = @canvasWidth
    @canvas.height = @canvasHeight
    @canvasContainer.appendChild(@canvas)
    @context = @canvas.getContext('2d')
    @buildImageBuffers()
    
  buildImageBuffers: ->
    @canvasData = @context.createImageData(@canvasWidth,@canvasHeight)
    @canvasBuffer = new ArrayBuffer(@displayData.data.length)
    @canvasView8 = new Uint8ClampedArray(@displayBuffer)
    @canvasView32 = new Uint32Array(@displayBuffer)
    return

  draw: ->
    @canvasData.data.set(@canvasView8)
    @context.putImageData(@canvasData,0,0)
    return

module?.exports = Canvas
