class Data {
 // Table table;
  int count = 0;
//Gem data i csv fil med kolonne navne
    Table table = loadTable("data.csv", "header");
void saveData(int trialNr, int targetDiameter, float clickToTargetDistance, float movementTime) {

   TableRow row = table.addRow();
   // trialNr = row.setInt("Trial Nr");
    row.setFloat("Distance", click);
    targetDiameter = row.setInt("Diameter");
    movementTime = row.setFloat("Movement Time");
    }
    saveTable(table, "data.csv");
}

//PrintWriter file;
//Table table;
//TableRow newRow;

//Instantier et table object til at gemme data
    //table = new Table();
    //table.addColumn("ID");
    //table.addColumn("Question");
    //table.addColumn("Answer");
    ////Brug for loop til at gemme værdi i under hvert kolonne
    //for(int i = 0; i<=9;i++) {
    //  newRow = table.addRow();
    //  newRow.setInt("ID", i + 1);
    //  newRow.setString("Question", questions[i]);
    //  newRow.setInt("Answer", ratings.get(i));
    //  //Print bruges blot til at holde øje
    //  println(i);
    //}
    ////Lav til sidst en row med sus score
    //newRow = table.addRow();
    //newRow.setString("answer","SUS score: " + score);
    ////gem den table som en csv fil
    //saveTable(table, "data.csv");
    ////Tilføj en exit knap
    //cp5.addButton("Exit").setPosition(200,50).setSize(100,50);
