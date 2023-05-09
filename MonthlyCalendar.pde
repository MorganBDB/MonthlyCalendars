/*
Morgan Brooke-deBock
 May 4 2023
 
 Program to generate monthly calendars. Given an input month and year, the program will automatically generate the calendar for that month.
 The program is estentially hard-coded for weeks to start on Monday (maybe I should change this at some point).
 I did all of the date arthimetic myself without using a library (again, probably as mistake).
  */

float startYear;
float startMonth;

void setup() {

  size(2550, 1650);
  background(255);

  startYear = 1901;
  startMonth = 1;
  frameRate(1);

  drawGrid(100, 100, 180, 100);
  drawDays(100, 100, 100, 60);
  drawHeading(12, 2023, 100);
  drawNumbers(12, 2023, 100, 100, 180, 100);
  drawBorder();
}

void draw() {
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
