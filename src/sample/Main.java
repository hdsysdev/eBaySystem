package sample;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import javax.swing.*;
import java.awt.*;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;

public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        primaryStage.setTitle("Hello World");
        primaryStage.setScene(new Scene(root, 300, 275));
        primaryStage.show();


        String connectionUrl = "jdbc:sqlserver://DESIGNER1:1433;databaseName=INTRANET;user=intranet;password=bathcountry110";

        String SQL = "";


        BufferedReader bufferedReader = new BufferedReader(
                new FileReader("C:\\Users\\hubert\\IdeaProjects\\eBaySystem\\src\\sample\\Price Pull.sql")
        );

        String thisLine, sqlQuery;
        try {
            sqlQuery = "";
            while ((thisLine = bufferedReader.readLine()) != null)
            {
                //Skip comments and empty lines
                if(thisLine.length() > 0 && thisLine.charAt(0) == '-' || thisLine.length() == 0 )
                    continue;
                sqlQuery = sqlQuery + " " + thisLine;
                //If one command complete
                if(sqlQuery.charAt(sqlQuery.length() - 1) == ';') {
                    sqlQuery = sqlQuery.replace(';' , ' '); //Remove the ; since jdbc complains
                    try {
                        // stmt.execute(sqlQuery);
                    }
                    catch(Exception ex) {
                        JOptionPane.showMessageDialog(null, "Error Creating the SQL Database : " + ex.getMessage());
                    }
                    sqlQuery = "";
                }
            }
            SQL = sqlQuery;
        }
        catch(IOException ex) {
        }


        try (Connection con = DriverManager.getConnection(connectionUrl); Statement stmt = con.createStatement();) {
            ResultSet rs = stmt.executeQuery(SQL);

            // Iterate through the data in the result set and display it.
            while (rs.next()) {
                System.out.println(rs);

            }
        }
        // Handle any errors that may have occurred.
        catch (SQLException e) {
            e.printStackTrace();
        }


    }


    public static void main(String[] args) {
        launch(args);
    }
}
