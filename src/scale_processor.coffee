ScaleProcessor = (algorithm) ->
  process: (imageData, scaleData) ->
    algorithm(imageData, scaleData)

module?.exports = ScaleProcessor
