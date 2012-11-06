ColorProcessor = (algorithm) ->
  process: (scaleData,colorData) ->
    algorithm(scaleData,colorData)

module?.exports = ColorProcessor
