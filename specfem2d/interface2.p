#
# number of interfaces
#
 3
#
# for each interface below, we give the number of points and then x,z for each point
#
#
# interface number 1 (bottom of the mesh)
#
 2
 0 0
 6000 0
#
# interface number 2 (ocean bottom)
#
 2
    0 2880
 6000 2880
#
# interface number 3 (topography, top of the mesh)
#
 2
    0 4080
 6000 4080
#
# for each layer, we give the number of spectral elements in the vertical direction
#
#
# layer number 1 (bottom layer)
#
## DK DK the original 2000 Geophysics paper used nz = 90 but NGLLZ = 6
## DK DK here I rescale it to nz = 108 and NGLLZ = 5 because nowadays we almost always use NGLLZ = 5
 72
#
# layer number 2 (top layer)
#
 30
