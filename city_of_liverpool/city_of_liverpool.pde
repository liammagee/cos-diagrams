
Table circlesData;

String[][] subdomains = {

  {"Wealth & Distribution", "Technology & Infrastructure", "Labour & Welfare", "Consumption & Use", "Accounting & Regulation", "Exchange & Transfer", "Production & Resourcing"}, 

  {"Materials & Energy", "Water & Air", "Flora & Fauna", "Habitat & Settlements", "Built-Form & Transport", "Embodiment & Sustenance", "Emissions & Waste"}, 

  {"Identity & Engagement", "Creativity & Recreation", "Memory & Projection", "Beliefs & Ideas", "Gender & Generations", "Enquiry & Learning", "Wellbeing & Health"}, 

  {"Ethics & Accountability", "Dialogue & Reconciliation", "Security & Accord", "Representation & Negotiation", "Communication & Critique", "Law & Justice", "Organization & Governance"        }
};

float ox = 0, oy = 0, axisLength = 0, radius = 0;

void setup() {

  // Set the size
  size(800, 600);

  // Key points
  ox = width / 2;
  oy = height / 2;
  axisLength = oy * 0.9;
  radius = axisLength * 1.6;


  // General parameters
  background(255);
  stroke(0);
  noFill();

  // Draw lines
  strokeWeight(2.0);
  line(ox - axisLength, oy, ox + axisLength, oy);
  line(ox, oy - axisLength, ox, oy + axisLength);

  // Draw circles
  stroke(80);
  strokeWeight(1.0);
  arc(ox, oy, radius, radius, 0, PI * 2);

  // Load data - first save the Excel file in the current folder as "CSV" file type.
  circlesData = loadTable("./Critial_Issues_Data_March29_Forum.csv", "header");

  // Show subdomains
  String []economy = subdomains[0];
  String []ecology = subdomains[1];
  String []politics = subdomains[2];
  String []culture = subdomains[3];

  // Iterate through disability data
  Iterable<TableRow> disability = circlesData.matchRows("Disability", "Group");
  Table disabilityTable = new Table();
  disabilityTable.setColumnTitles(circlesData.getColumnTitles());
  for ( TableRow row : disability ) {
    disabilityTable.addRow(row);
    //println(row.getString("Critical Issue") + ": " + row.getString("No. of times- Disability"));
  }

  // Iterate through subdomains

  textSize(16);
  fill(0, 102, 153);
  translate(ox, oy);
  rotate(0);  
  
  
  float pieInc = PI / 2 * 1 / 7;
  textAlign(RIGHT);
  drawDomain(economy, disabilityTable, 0, pieInc, -100);
  textAlign(LEFT);
  drawDomain(ecology, disabilityTable, PI + PI / 2, pieInc, 100);
  drawDomain(politics, disabilityTable, 0, pieInc, 100);
  textAlign(RIGHT);
  drawDomain(culture, disabilityTable, PI + PI / 2, pieInc, -100);
  
  
  /*
  for (int i = 0; i < economy.length; i++) {
    String sd = economy[i];
    //float r += pieInc;
    rotate(pieInc);
    
    
    int rowCounter = 0;
    Iterable<TableRow> rows = disabilityTable.matchRows(sd, "Sub Domain");

    int entries = 0;
    for (TableRow row : rows ) {
      entries++;
    }
    
    for (TableRow row : rows ) {
      String ci = row.getString("Critical Issue");
      float r2 = pieInc * rowCounter / entries;
      rotate(r2);  
      text(ci, - 100, 0);
      //println(ci,  - 100, 0);
      rotate(-r2);  
      rowCounter ++;
    }
    //rotate( - r);
  }
  */
  translate(-ox, -oy);

  for ( TableRow row : disabilityTable.rows() ) {

    //println(row.getString("Critical Issue") + ": " + row.getString("No. of times- Disability"));
  }
}

// Show a domain
void drawDomain(String[] domain, Table table, float startingPoint, float pieInc, float textOrigin) {
  rotate(startingPoint);
  for (int i = 0; i < domain.length; i++) {
    String sd = domain[i];
    
    int rowCounter = 0;
    Iterable<TableRow> rows = table.matchRows(sd, "Sub Domain");

    int entries = 0;
    for (TableRow row : rows ) {
      entries++;
    }
    line(0, 0, radius / 2 * ( startingPoint / abs(startingPoint) ), 0);
    
    for (TableRow row : rows ) {
      String ci = row.getString("Critical Issue");
      float r2 = pieInc * rowCounter / entries;
      rotate(r2);  
      text(ci, textOrigin, 0);
      rotate(-r2);  
      rowCounter ++;
    }
    rotate(pieInc);

  }
  rotate(-startingPoint - PI / 2);
}

// Draw real time
void draw() {
}

// Capture mouse event and save a screen shot
void mousePressed() {
  saveFrame("./circles-XXXX.png");
}

// Capture keyboard event and save a screen shot
void keyPressed() {
  saveFrame("./circles-XXXX.png");
}