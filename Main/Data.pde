class Data {
  Table table;
  TableRow row;

 Data(){

   table = new Table();

   table.addColumn("Diameter");
   table.addColumn("Distance");
   table.addColumn("Movement Time");
  }

 //Gem data i csv fil med kolonne navne
 void saveData(float targetDiameter, float distance, float movementTime, String subjectId) {

   TableRow row = table.addRow();
   //row.setInt("Trial Nr", trialNr);
   row.setFloat("Diameter",targetDiameter);
   row.setFloat("Distance", distance);
   row.setFloat("Movement Time", movementTime);
    ///gem den table som en csv fil
    saveTable(table, "data/"+ subjectId + ".csv");
  }

}
