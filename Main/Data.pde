class Data {
  Table table;
  TableRow row;
  int countTrials = 0;

void createTable() {
  table = new Table();
  table.addColumn("Diameter");
  table.addColumn("Distance");
  table.addColumn("Movement Time");
}
//Gem data i csv fil med kolonne navne
void saveData(float targetDiameter, float distance, float movementTime) {
  
   row = table.addRow();
   row.setFloat("Diameter",targetDiameter);
   row.setFloat("Distance", distance);
   row.setFloat("Movement Time", movementTime);
    ///gem den table som en csv fil
    saveTable(table, "data.csv");
  }

}
