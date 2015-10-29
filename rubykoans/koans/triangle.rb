# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  err_mess = "Illegal Triangle"
  x, y, z = [a, b, c].sort
  raise TriangleError, err_mess if x <= 0 || x + y <= z
  # no side can be zero or negative
  # and the sum of two sides must be greater than or equal to the third side
  [nil, :equilateral, :isosceles, :scalene][[x, y, z].uniq.size]
  # [x, y, z].uniq.size is 1 (one unique value for all sides / equilateral) if x = y = z
  # and value of position 1 of the left-hand array is returned.
  # the number of unique sides is 2 if isosceles, returning position 2's value
  # and there are 3 unique sides if scalene, returning position 3's value

end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
