Scales =
  linear = (fitsData, scaleData, min, max, width, height) ->
    range = max - min
    index = 0
    for x in [0..(width-1)]
      for y in [0..(height-1)]
        index = y*width+x
        scaleData[index] = ~~(255*((fitsData[index] - min)/range))

module?.exports = Scales
