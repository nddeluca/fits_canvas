ScaleProcessor = (algorithm) ->
  process: (fitsData, scaleData, min, max) ->
    algorithm(fitsData, scaleData, min, max)

module?.exports = ScaleProcessor
