# MonthlyCalendars

 This is a program to generate monthly calendars. Given an input month and year, the program will automatically generate the calendar for that month.
 The program is estentially hard-coded for weeks to start on Monday (maybe I should change this at some point).
 I did all of the date arthimetic myself without using a library (again, probably as mistake).
 
 I wrote this program for my own personal use, so I won't make any promises about whether or not it will be helpful to anyone else.
 
 The process of drawing the calendars is handled by five separate functions, which I will describe here.
 
 (1)
 drawGrid(leftBuffer, rightBuffer, topBuffer, botBuffer)
 This function draws a blank 7x5 grid onto the canvas. The aspect ratio of each cell in the grid will automatically scale based on the aspect ratio of the canvas.
 This function is hard-coded to produce a grid with a certain stroke width and color. To modify these things, the function itself must be modified.
 
 inputs:
 leftBuffer (float) : controls the distance between the left edge of the canvas and the left edge of the grid. Distance is measured inpixels.
 rightBuffer (float): controls the distance between the right edge of the canvas and the right edge of the grid. Distance is measured in pixels.
 topBuffer (float)  : controls the distance between the top edge of the canvas and the top edge of the grid. Distance is measured in pixels.
 botBuffer (float)  : controls the distance between the bottom edge of the canvas and the bottom edge of the grid. Distance is measured in pixels.
 
 (2)
 drawDays(leftBuffer, rightBuffer, topBuffer, textHeight)
 This function draws a 7x1 grid to the canvas. Within each cell of the grid the days of the week are drawn. This days of the week are
 hard-coded to start with Monday on the left and end with Sunday on the right (MAYBE CHANGE IN THE FUTURE).
 
 inputs:
 leftBuffer (float) : controls the distance between the left edge of the canvas and the left edge of the header. Distance is measured in pixels.
 rightBuffer (float): controls the distance between the right edge of the canvas and the right edge of the header. Distance is measured in pixels.
 topBuffer (float)  : controls the distance between the top edge of the canvas and the top edge of the header. Distance is measured in pixels.
 textHeight (float) : controls the height of the header. Height is measured in pixels.
 
 In order for the calendar to draw correctly, the left and right buffers passed into the drawGrid function should match the left and right headers passed into the drawDays function.
 Also, to avoid overlaps, the total distance of the header from the top edge (topBuffer + textHeight) should be less than the value of topBuffer passed into the drawGrid function.
 
 (3)
 drawHeading(m, y, topBuffer)
 This function draws the month and year of the calendar to the top of the page. This function is hard-coded to draw the text box in the middle third of the screen.
 
 inputs:
 m (float): the input month. Should be an integer between 1 and 12 inclusive.
 y (float): the input year. Should be a year between 1901 and 2099 inclusive.
 topBuffer (float): The distance between the bottom of the header and the top edge of the canvas. Note that this topBuffer varible has different meaning than it has in the other functions.
 
 (4)
 drawNumbers(m, y, leftBuffer, rightBuffer, topBuffer, botBuffer)
 This function draws the day numbers into the grid in their correct spots. It also handles instances where there are too many days to fit into the 7x5 grid. In this case, a diagonal line will be
 drawn across the bottom left cell of the grid and two different day numbers will be drawn the cell (one number on each side of the line). Additionally, the function be shade in unused grid cells with a gray color.
 
 inputs:
 m (float) : the input month. Should be an integer between 1 and 12 inclusive.
 y (float) : the input year. Should be a year between 1901 and 2099 inclusive.
 leftBuffer (float) : controls the distance between the left edge of the canvas and the left edge of the grid. Distance is measured inpixels.
 rightBuffer (float): controls the distance between the right edge of the canvas and the right edge of the grid. Distance is measured in pixels.
 topBuffer (float)  : controls the distance between the top edge of the canvas and the top edge of the grid. Distance is measured in pixels.
 botBuffer (float)  : controls the distance between the bottom edge of the canvas and the bottom edge of the grid. Distance is measured in pixels.
 
 For the numbers to render in the correct locations, the buffer values passed into the drawNumbers function should be exactly the same as the numbers passed into the drawGrid function.
 
 (5)
 computeWeekday(m, d, y)
 This function takes any input date between 1/1/1901 and 12/31/2099 and calculates the weekday for that date. It doesn't work beyond the date range because the function
 does not take into account the fact that leap years are skipped if the year is a multiple of 100 but not a multiple of 400. This function is used as a helper function in the
 drawNumbers function. The function returns an integer number (as a float) between 0 and 6 inclusive. 0 Corresponds to Monday and 6 corresponds to Sunday.
 
 inputs:
 m (float) : the input month
 d (float) : the input day
 y (float) : the input year
 
 For math reasons, the functions inputs should be floats and not ints.
 
 (6)
 drawBorder()
 This function simply draws a black border around the edge of the canvas. The stroke weight can be changed by modifying the function. I made this function because I intend to print these calendars with
 8.5x5.5 dimensions onto 8.5x11 paper. The black border around the edge of the canvas will make it easier to exactly cut the calendar out.
