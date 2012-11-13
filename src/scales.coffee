utils = require('./utils')

scales =
  linear: (fitsData, scaleData) ->
    min = utils.min(fitsData)
    max = utils.max(fitsData)
    range = max - min
    index = 0
    for i in [0..(scaleData.length - 1)]
      scaleData[i] = ~~(255*((fitsData[i] - min)/range))
    return

module?.exports = scales
