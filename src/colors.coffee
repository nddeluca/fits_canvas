colors =
  grayscale: (scaleData,colorData) ->
    for i in [0..(scaleData.length-1)]
      value = scaleData[i]
      colorData[i] = (255 << 24) | (value << 16) | (value << 8) | value
    return

module?.exports = colors
