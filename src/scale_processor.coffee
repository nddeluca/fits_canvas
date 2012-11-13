ScaleProcessor = (algorithm) ->
  process: (fitsData, scaleData) ->
    algorithm(fitsData, scaleData)

module?.exports = ScaleProcessor
