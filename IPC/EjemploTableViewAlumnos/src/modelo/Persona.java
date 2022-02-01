package modelo;


import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class Persona {
	
	private final StringProperty Nombre = new SimpleStringProperty();
	private final StringProperty Apellidos = new SimpleStringProperty();
        private final StringProperty pathImagen = new SimpleStringProperty();
		
	public Persona(String nombre, String apellidos, String path)
	{
		Nombre.setValue(nombre);
		Apellidos.setValue(apellidos);
                pathImagen.setValue(path);
	}
        public Persona()
	{
	}
	
	public final StringProperty NombreProperty() { 
		return this.Nombre;
	}
	public final java.lang.String getNombre() { 
		return this.NombreProperty().get();
	}
	public final void setNombre(final java.lang.String Nombre) {
		this.NombreProperty().set(Nombre);
	}
	public final StringProperty ApellidosProperty() {
		return this.Apellidos;
	}
	public final java.lang.String getApellidos() {
		return this.ApellidosProperty().get();
	}
	public final void setApellidos(final java.lang.String Apellidos) {
		this.ApellidosProperty().set(Apellidos);
	}

        public final StringProperty pathImageProperty() {
               return this.pathImagen;
        }
        public final java.lang.String getPath() { 
		return this.pathImageProperty().get();
	}
	public final void setPath(final java.lang.String pathImagen) {
		this.pathImageProperty().set(pathImagen);
	}

}