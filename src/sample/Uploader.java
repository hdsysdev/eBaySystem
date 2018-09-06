package sample;

import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

public class Uploader extends Controller {

    private ArrayList<Product> prodList = new ArrayList<>();

    public Uploader(ArrayList<Product> prodList) {
        this.prodList = prodList;

    }

    public Uploader(ComboBox box) {
        box.getItems().addAll("Hello", "Name", "Jeff");
    }

    public Uploader() {
        comboBox.getItems().addAll("Hello", "Name", "Jeff");


    }

    public void uploadToTable()  {
        String connectionUrl = "jdbc:sqlserver://DESIGNER1:1433;databaseName=INTRANET;user=intranet;password=bathcountry110";
        String SQL = "";

        try (Connection con = DriverManager.getConnection(connectionUrl)) {
            Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery("USE [intranet-test] SELECT * FROM ebayTable");

            rs.moveToInsertRow();
            rs.updateString("DEPT_NO", "M13");

            rs.insertRow();
            rs.moveToCurrentRow();

            CSVReader reader = new CSVReader(new FileReader(showSaveFileDialog()), ',');

            // read line by line
            String[] record = null;

            while ((record = reader.readNext()) != null) {
                Product prod = new Product();
                prod.setProdcode(record[1]);
                prod.setSKU(record[2]);
                prod.setTitle(record[3]);
                prod.setImage1(record[4]);
                prod.setImage2(record[5]);
                prod.setImage3(record[6]);
                prod.setImage4(record[7]);
                prod.setImage5(record[8]);
                prod.setImage6(record[9]);
                prod.setImage7(record[10]);
                prod.setImage8(record[11]);
                prod.setImage9(record[12]);
                prod.setImage10(record[13]);
                prod.setImage11(record[14]);
                prod.setImage12(record[15]);
                prod.setDescription(record[16]);

            }

            System.out.println(prodList);

            reader.close();

        }
        // Handle any errors that may have occurred.
        catch (SQLException e) {
            e.printStackTrace();
        } catch (NullPointerException e){
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}