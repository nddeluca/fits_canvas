utils =
  max: (array) ->
    max = -Infinity
    length = array.length
    for i in [0..(length-1)]
      if array[i] > max
        max = array[i]
    return max

  min: (array) ->
    min = Infinity
    length = array.length
    for i in [0..(length-1)]
      if array[i] < min
        min = array[i]
    return min

module?.exports = utils
