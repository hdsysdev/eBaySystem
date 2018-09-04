package sample;

import javafx.fxml.FXML;

import java.awt.*;

public class ItemPullHandler {

    @FXML
    private TextField textfield;

    public void ItemPullHandler() {
        System.out.println("jeff");
    }

    public void setText(String string){
        textfield.setText(string);
    }
}