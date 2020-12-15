
import java.sql.*;
import oracle.jdbc.*;
import java.math.*;
import java.io.*;
import java.awt.*;
import oracle.jdbc.pool.OracleDataSource;

public class query2 {

   public static void main (String args []) throws SQLException {
    try
    {

        //Connection to Oracle server
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("spatwa1", "98985432");

        // Input sid from keyboard
        BufferedReader  readKeyBoard; 
       // String          sid,firstname,lastname, status_in, gpa,email ;
      



        //Prepare to call stored procedure:
          // procedure show_status (sid_in in students.sid%type, 
          //                     status_out out students.status%type) is
          // begin select status into status_out from students where sid = sid_in;
          // end;
        CallableStatement cs = conn.prepareCall("begin show_students(:1); end;");

        //set the in parameter (the first parameter)     
        // cs.setString(1, sid);
        // cs.setString(2, firstname);
        // cs.setString(3, lastname);
        // cs.setString(4, status_in);
        // cs.setString(5, gpa);
        // cs.setString(6, email);
      
        

        //register the out parameter (the second parameter)
        cs.registerOutParameter(1, OracleTypes.CURSOR);

        //execute the store procedure
        cs.executeQuery();

        //get the out parameter result.
       // String message1 = cs.getString(1);
        //System.out.println(message1);

        ResultSet rs = (ResultSet)cs.getObject(1);

        // print the results
        while (rs.next()) {
            System.out.println(rs.getString(1) + "\t" +
               rs.getString(2) + "\t" + rs.getString(3) + 
                rs.getString(4) + 
                "\t" + rs.getDouble(5) + "\t" +
                rs.getString(6));
        }
        
        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   } 
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }
} 


