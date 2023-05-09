/*
Morgan Brooke-deBock
 May 4 2023
 
 Program to generate monthly calendars. Given an input month and year, the program will automatically generate the calendar for that month.
 The program is estentially hard-coded for weeks to start on Monday (maybe I should change this at some point).
 I did all of the date arthimetic myself without using a library (again, probably as mistake).
 
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
 */

float startYear;
float startMonth;

void setup() {

  size(2550, 1650);
  //size(1024, 1024);
  //fullScreen();
  background(255);

  startYear = 1901;
  startMonth = 1;
  frameRate(1);

  drawGrid(100, 100, 180, 100);
  drawDays(100, 100, 100, 60);
  drawHeading(12, 2023, 100);
  drawNumbers(12, 2023, 100, 100, 180, 100);
  drawBorder();
  save("DEC_2023.png");
}

void draw() {
  //background(255);
  //drawGrid(50, 50, 100, 50);
  //drawDays(50, 50, 60, 30);
  //drawHeading(startMonth, startYear, 60);
  //drawNumbers(startMonth, startYear, 50, 50, 100, 50);
  //drawBorder();

  //if (startYear < 2100) {
  //  if (startMonth < 12) {
  //    startMonth++;
  //  } else if (startMonth == 12) {
  //    startYear++;
  //    startMonth = 1;
  //  }
  //}
}

void drawGrid(float leftBuffer, float rightBuffer, float topBuffer, float botBuffer) {
  /*
    Draws a grid of boxes to the screen
   */
  float rectHeight = (height - topBuffer - botBuffer) / 5;
  float rectWidth = (width - leftBuffer - rightBuffer) / 7;

  stroke(0);
  strokeWeight(2);
  noFill();

  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 5; j++) {
      rect(leftBuffer + (i * rectWidth), topBuffer + (j * rectHeight), rectWidth, rectHeight);
    }
  }
}

void drawDays(float leftBuffer, float rightBuffer, float topBuffer, float textHeight) {
  /*
    Draws the weekday header to the screen
   */

  PFont font = createFont("Monospaced.bold", 40);
  float textWidth = (width - leftBuffer - rightBuffer) / 7;

  textAlign(CENTER);
  textFont(font);

  for (int i = 0; i < 7; i++) {
    fill(230);
    rect(leftBuffer + (i * textWidth), topBuffer, textWidth, textHeight);
    fill(0);

    String day = "";
    if (i==0) {
      day = "MON";
    } else if (i == 1) {
      day = "TUE";
    } else if (i == 2) {
      day = "WED";
    } else if (i == 3) {
      day = "THU";
    } else if (i == 4) {
      day = "FRI";
    } else if (i == 5) {
      day = "SAT";
    } else if (i == 6) {
      day = "SUN";
    }

    text(day, leftBuffer + (i * textWidth), topBuffer, textWidth, textHeight);
  }
}

void drawHeading(float m, float y, float topBuffer) {
  /*
    Draws the month and the year at the top of the screen
   */

  String outputString = "";

  // This block converts the inputted month from a number to a string
  String monthText = "ERROR";
  if (m == 1) {
    monthText = "JANUARY";
  } else if (m == 2) {
    monthText = "FEBRUARY";
  } else if (m == 3) {
    monthText = "MARCH";
  } else if (m == 4) {
    monthText = "APRIL";
  } else if (m == 5) {
    monthText = "MAY";
  } else if (m == 6) {
    monthText = "JUNE";
  } else if (m == 7) {
    monthText = "JULY";
  } else if (m == 8) {
    monthText = "AUGUST";
  } else if (m == 9) {
    monthText = "SEPTEMBER";
  } else if (m == 10) {
    monthText = "OCTOBER";
  } else if (m == 11) {
    monthText = "NOVEMBER";
  } else if (m == 12) {
    monthText = "DECEMBER";
  }

  // Convert the inputted year number to a string
  String yearText = String.valueOf(round(y));

  outputString = monthText + " " + yearText;

  textAlign(CENTER);
  PFont font = createFont("Monospaced.plain", 75);
  textFont(font);
  text(outputString, width/3, 0, width/3, topBuffer);
}

void drawNumbers(float m, float y, float leftBuffer, float rightBuffer, float topBuffer, float botBuffer) {
  int startingDay = round(computeWeekday(m, 1, y));
  int daysInMonth = 0;
  int currentDay = 1;
  currentDay -= startingDay;

  // This block sets the appropriate number of days in the month
  if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
    daysInMonth = 31;
  } else if (m == 4 || m == 6 || m == 9 || m == 11) {
    daysInMonth = 30;
  } else if (m == 2 && y % 4 == 0) {
    daysInMonth = 29;
  } else {
    daysInMonth = 28;
  }

  float rectHeight = (height - topBuffer - botBuffer) / 5;
  float rectWidth = (width - leftBuffer - rightBuffer) / 7;

  float pixelBuffer = 10;
  PFont font = createFont("Monospaced.bold", 40);

  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 7; j++) {
      if (currentDay > 0 && currentDay <= daysInMonth) {
        fill(0);
        textFont(font);
        textAlign(LEFT);
        text(String.valueOf(currentDay), leftBuffer + (j * rectWidth) + pixelBuffer, topBuffer + (i * rectHeight), rectWidth, rectHeight);
      } else {
        stroke(0);
        strokeWeight(2);
        fill(230);
        rect(leftBuffer + (j * rectWidth), topBuffer + (i * rectHeight), rectWidth, rectHeight);
      }
      currentDay++;
    }
  }

  if (currentDay < daysInMonth) {
    for (int i = 0; i < 2; i++) {
      stroke(0);
      strokeWeight(2);
      line(leftBuffer + (i * rectWidth), topBuffer + (4 * rectHeight) + rectHeight, leftBuffer + (i * rectWidth) + rectWidth, topBuffer + (4 * rectHeight));
      textFont(font);
      textAlign(RIGHT, BOTTOM);
      text(String.valueOf(currentDay + i), leftBuffer + (i * rectWidth) - pixelBuffer, topBuffer + (4 * rectHeight), rectWidth, rectHeight);
    }
  } else if (currentDay == daysInMonth) {
    for (int i = 0; i < 1; i++) {
      stroke(0);
      strokeWeight(2);
      line(leftBuffer + (i * rectWidth), topBuffer + (4 * rectHeight) + rectHeight, leftBuffer + (i * rectWidth) + rectWidth, topBuffer + (4 * rectHeight));
      textFont(font);
      textAlign(RIGHT, BOTTOM);
      text(String.valueOf(currentDay), leftBuffer + (i * rectWidth) - pixelBuffer, topBuffer + (4 * rectHeight), rectWidth, rectHeight);
    }
  }
}


void drawBorder() {
  /*
 Draws a border around the edge of the canvas.
   This will make it easier to cut out the 5.5x8.5 calendar from an 8.5x11 sheet of paper
   */

  noFill();
  stroke(0);
  strokeWeight(5);
  rect(0, 0, width, height);
}

float computeWeekday(float m, float d, float y) {
  float sum = 0;        //stores the sum of all calculations
  float yearOffset = 0; //store the starting day of the year
  float leapOffset = (y - 2001) / 4;

  // f_d stores the numbers days into the year at the start of each month
  // the year starts at zero
  int f_m = 0;
  if (m == 1) {
    f_m = 0;
  } else if (m == 2) {
    f_m = 31;
  } else if (m == 3) {
    f_m = 59;
  } else if (m == 4) {
    f_m = 90;
  } else if (m == 5) {
    f_m = 120;
  } else if (m == 6) {
    f_m = 151;
  } else if (m == 7) {
    f_m = 181;
  } else if (m == 8) {
    f_m = 212;
  } else if (m == 9) {
    f_m = 243;
  } else if (m == 10) {
    f_m = 273;
  } else if (m == 11) {
    f_m = 304;
  } else if (m == 12) {
    f_m = 334;
  }

  if (y % 4 == 0 && m > 2) {
    f_m = f_m + 1;
  }

  sum += f_m + d - 1;

  yearOffset = ((y - 2001) + floor( (y - 2001) / 4)) % 7;
  sum += yearOffset;
  sum  = sum % 7;

  if (sum < 0 && sum >= -6) {
    sum = sum + 7;
  }

  return sum;
}
