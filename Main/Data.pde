class Data {
  Table table;
  TableRow row;

 Data(){

   table = new Table();
   table.addColumn("Trial Nr");
   table.addColumn("Diameter");
   table.addColumn("Distance");
   table.addColumn("ID");
   table.addColumn("Movement Time");
  }

 //Gem data i csv fil med kolonne navne
 void saveData(int trialNum, float targetDiameter, float distance, float movementTime, String subjectId) {

   TableRow row = table.addRow();
   row.setInt("Trial Nr",trialNum);
   row.setFloat("Diameter",targetDiameter);
   row.setFloat("Distance", distance);
   row.setDouble("ID", (float)(double)(Math.log((distance/targetDiameter)+1) / Math.log(2)));
   row.setFloat("Movement Time", movementTime);
    ///gem den table som en csv fil
    saveTable(table, "data/"+ subjectId + ".csv");
  }

}
