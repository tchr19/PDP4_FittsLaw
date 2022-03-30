class Data {
  Table table;
  int count = 0;
//Gem data i csv fil med kolonne navne
    Table table = loadTable("data.csv", "header");
void saveData(int trialNr, int targetDiameter, float clickToTargetDistance, float movementTime) {
  

   TableRow row = table.addRow();
    trialNr = row.setInt("Trial Nr");
    clickToTargetDistance = row.setFloat("Distance");
    targetDiameter = row.setInt("Diameter");
    movementTime = row.setFloat("Movement Time");

    }
  }
}
