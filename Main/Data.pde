class Data {
  Table table;
  TableRow row;
  int countTrials = 0;
  int[] Subjects;
//Gem data i csv fil med kolonne navne
void saveData(int trialNr, float targetDiameter, float distance, float movementTime) {
   table = new Table();
   table.addColumn("Trial Nr");
   table.addColumn("Diameter");
   table.addColumn("Distance");
   table.addColumn("Movement Time");
   TableRow row = table.addRow();
   row.setInt("Trial Nr", trialNr);
   row.setFloat("Diameter",targetDiameter);
   row.setFloat("Distance", distance);
   row.setFloat("Movement Time", movementTime);
    ///gem den table som en csv fil
    saveTable(table, "data.csv");
  }
  void updateTrial(int trialNr){
    Subjects[countTrials] = trialNr + 1;
    countTrials++;
    
    
  }
}
