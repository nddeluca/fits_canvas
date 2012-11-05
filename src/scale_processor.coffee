ScaleProcessor = (algorithm) ->
  process: (fitsData, scaleData, min, max, width, height) ->
    algorithm(fitsData, scaleData, min, max, width, height)
