
import java.sql.*;
import oracle.jdbc.*;
import java.math.*;
import java.io.*;
import java.awt.*;
import oracle.jdbc.pool.OracleDataSource;

public class query5 {

   public static void main (String args []) throws SQLException {
    try
    {

        //Connection to Oracle server
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("spatwa1", "98985432");
      
        // Input sid from keyboard
        //BufferedReader  readKeyBoard; 
       //String          sid,firstname,lastname, status_in, gpa,email ;
      String dept_code,course_no,checkvar;

      BufferedReader  readKeyBoard; 
       
      readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
       System.out.print("Please Enter dept_code:");
       dept_code = readKeyBoard.readLine();
       readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
       System.out.print("Please Enter course no:");
      course_no = readKeyBoard.readLine();
      readKeyBoard = new BufferedReader(new InputStreamReader(System.in)); 
       System.out.print("Please Enter 4th varible:");
      checkvar = readKeyBoard.readLine();

        //Prepare to call stored procedure:
          // procedure show_status (sid_in in students.sid%type, 
          //                     status_out out students.status%type) is
          // begin select status into status_out from students where sid = sid_in;
          // end;
        CallableStatement cs = conn.prepareCall("begin get_prerequisites(:1,:2,:3,:4,:5); end;");


        //set the in parameter (the first parameter)     
         cs.setString(1,dept_code);
         cs.setString(2, course_no);
         cs.setString(4, checkvar);
        // cs.setString(4, prereq);
        // cs.setString(5, gpa);
        // cs.setString(6, email);
      
        
        cs.registerOutParameter(3,Types.VARCHAR);
        cs.registerOutParameter(5, OracleTypes.NUMBER);
        
        cs.executeQuery();
     String message = cs.getString(3);
     if(message != null){
        System.out.println(message);
     }
     message = cs.getString(5);
     if(message != null){
        System.out.println(message);
     }
      

        // ResultSet rs = (ResultSet)cs.getObject(3);

        // // print the results
        // while (rs.next()) {
        //     System.out.println(rs.getString(1) + "\t" +
        //        rs.getString(2) + "\t" + rs.getString(3)  + "\t" +
        //         rs.getString(4) + 
        //         "\t" + 
        //         rs.getString(5)+ "\t" + 
        //         rs.getString(6) +"\t" + 
        //         rs.getString(7));
        // }
        
        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   } 
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }
} 


