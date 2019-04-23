def plotline(x1, y1, x2, y2):

    x = x1
    y = y1
    dx = abs(x2-x1)
    dy = abs(y2-y1)
    s1 = int((x2-x1)/dx)
    s2 = int((y2-y1)/dy)

    print("s1", s1, "s2", s2)

    swap = 0
    if dy > dx:
        t = dx
        dx = dy
        dy = dx
        swap = 1

    e = 2*dy-dx
    a = 2*dy
    b = 2*dy-2*dx
    print(x, y)
    i = 1
    while (i <= dx):
        if e < 0:
            if swap:
                y = y + s2
            else:
                x = x+s1
            e = e+a
        else:
            y = y+s2
            x = x+s1
            e = e+b
        print(x, y)
        i += 1


plotline(1, 10, 4, 1)
