ColorProcessor = (algorithm) ->
  process: (scaledData,colorData,width,height) ->
    algorithm(scaledData,colorData,width,height)

module?.exports = ColorProcessor
