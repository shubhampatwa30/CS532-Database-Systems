
import java.sql.*;
import oracle.jdbc.*;
import java.math.*;
import java.io.*;
import java.awt.*;
import oracle.jdbc.pool.OracleDataSource;

public class mydemo2 {

   public static void main (String args []) throws SQLException {
    try
    {

        //Connection to Oracle server
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("spatwa1", "98985432");

        // Input sid from keyboard
        BufferedReader  readKeyBoard; 
        String          sid,firstname,lastname, status_in, gpa,email ;
        readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
        System.out.print("Please Enter SID:");
        sid = readKeyBoard.readLine();
        readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
        System.out.print("Please Enter firstname:");
        firstname = readKeyBoard.readLine();
        readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
        System.out.print("Please Enter lastname:");
        lastname = readKeyBoard.readLine();
        readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
        System.out.print("Please Enter level of education :");
        status_in = readKeyBoard.readLine();
        readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
        System.out.print("Please Enter GPA:");
        gpa = readKeyBoard.readLine();
        readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
        System.out.print("Please Enter email:");
        email = readKeyBoard.readLine();



        //Prepare to call stored procedure:
          // procedure show_status (sid_in in students.sid%type, 
          //                     status_out out students.status%type) is
          // begin select status into status_out from students where sid = sid_in;
          // end;
        CallableStatement cs = conn.prepareCall("begin insert_values(:1,:2,:3,:4,:5,:6); end;");

        //set the in parameter (the first parameter)     
        cs.setString(1, sid);
        cs.setString(2, firstname);
        cs.setString(3, lastname);
        cs.setString(4, status_in);
        cs.setString(5, gpa);
        cs.setString(6, email);
      
        

        //register the out parameter (the second parameter)
      //  cs.registerOutParameter(7, Types.VARCHAR);

        //execute the store procedure
        cs.executeQuery();

        //get the out parameter result.
        //String status = cs.getString(7);
       // System.out.println("Error as : "+status);
        
        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   } 
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }
} 


