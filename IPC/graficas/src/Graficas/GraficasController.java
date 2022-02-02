/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Graficas;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Button;
import model.Model;

/**
 * FXML Controller class
 *
 * @author carolinaalbamaruganrubio
 */
public class GraficasController implements Initializable {

    @FXML
    private PieChart pie;
    @FXML
    private BarChart<String, Number> bar;

    /**
     * Initializes the controller class.
     */
    private Model datos;
    private XYChart.Series<String,Number> serie; 
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        datos = new Model();
        pie.setData(datos.getPieData()); // le pasa la lista observable del piChart
        serie = new XYChart.Series<>(datos.getBarData()); // crea nueva serie a partir del bardata del modelo
        serie.setData(datos.getBarData()); // inicializa la serie con el barData del modelo
        bar.getData().add(serie); // le añade la serie al barChart
    }    

    @FXML
    private void votar(ActionEvent event) {
        Button boton = (Button)event.getSource();
        datos.sumarTipoNota(boton.getText());
    }
    
}
