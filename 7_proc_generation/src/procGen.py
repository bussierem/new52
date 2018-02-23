"""
NOTES:

Basic Binary-Space Partition Algorithm:
  DEFINITIONS:
    Zone:  Rooms and Halls - represents a section of the grid
      Origin (x,y coords of top-left unit)
      Width (in units)
      Height (in units)
    Min Width/Height for a Room:  minW, minH
    Room:  A zone of at least 4x4 units size
    Hall:  A zone with 1 dimension limited to 1-3 units
  FUNCTION Split_Section(Section):
    Pick horizontal or vertical split
    Pick split_point (x for vertical, y for horizontal)
      Limit split point to (2 + min) <= split_point <= (BORDER - min - 2)
        the "2" is for space on both sides of the room for Halls
    Make 2 child sections on Section, assign each one of the new Zones
  FUNCTION Find_Overlap(A, B, horizontal):
    if horizontal:
      list out y coords of all side units for A and B
    else:
      list out x coords of all side units for A and B
    return unique list of similar coords across both lists
  FUNCTION Connect_Rooms(left, right):
    if (room A's bottom side is < room B's top side): [vertical hall]
      overlap = Find_Overlap(A.bottom, B.top)
      rand_range = rand(1,3)
      rand_start(0, len(overlap) - 3)
      build room (rand_start, A.y) to (rand_start+rand_range, B.y)
    elif (room A's right side is < room B's left side): [horizontal hall]
      overlap = Find_Overlap(A.bottom, B.top)
      rand_range = rand(1,3)
      rand_start(0, len(overlap) - 3)
      build room (A.x, rand_start) to (B.x, rand_start+rand_range)

  ---------------------
  Given dungeon of size (Width = Dw, Height = Dh, Area = Da):
    root = dungeon
    cur = root
    split_section(cur)
      split "cur" into "left" and "right"
      Build_Room(cur)
      split_section(left)
      split_section(right)
    CONNECTING ROOMS:
    for each section with children:
      Connect_Rooms(leftChild, rightChild)
      Connect Rooms(parent, [left OR right])
""
