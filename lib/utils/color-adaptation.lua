function colorAdaptation(r, g, b, a)
  if r then
    r = r / 255
  end
  
  if g then
    g = g / 255
  end
  
  if b then
    b = b / 255
  end

  if a then
    a = a / 255
  end

  return {r, g or r, b or r, a or 1}
end