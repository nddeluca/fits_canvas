utils =
  max: (array) ->
    max = -Infinity
    length = array.length
    for i in [0..(length-1)]
      if array[i] > max
        max = array[i]
      end
    end
    return max

  min: (array) ->
    min = Infinity
    length = array.length
    for i in [0..(length-1)]
      if array[i] < min
        min = array[i]
      end
    end
    return min

module?.exports = utils
