utils = require('./utils')

scales =
  linear: (imageData, scaleData) ->
    min = utils.min(imageData)
    max = utils.max(imageData)
    range = max - min
    index = 0
    for i in [0..(scaleData.length - 1)]
      scaleData[i] = ~~(255*((imageData[i] - min)/range))
    undefined

module?.exports = scales
