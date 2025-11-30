import SwiftUI

struct AddPlantView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var nombre = ""
    @State private var tipo = ""
    @State private var ubicacion = "Sala"
    @State private var ultimoRiego = Date()
    
    let ubicaciones = ["Sala", "Cocina", "Balcón", "Habitación"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información de la planta")) {
                    TextField("Nombre", text: $nombre)
                    TextField("Tipo", text: $tipo)
                }
                
                Section(header: Text("Ubicación")) {
                    Picker("Ubicación", selection: $ubicacion) {
                        ForEach(ubicaciones, id: \.self) { ubicacion in
                            Text(ubicacion)
                        }
                    }
                }
                
                Section(header: Text("Último riego")) {
                    DatePicker("Fecha", selection: $ultimoRiego, displayedComponents: .date)
                }
            }
            .navigationTitle("Nueva Planta")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        guardarPlanta()
                    }
                }
            }
        }
    }
    
    private func guardarPlanta() {
        let nuevaPlanta = Plant(context: viewContext)
        nuevaPlanta.name = nombre
        nuevaPlanta.tipo = tipo
        nuevaPlanta.ubicacion = ubicacion
        nuevaPlanta.ultimoRiego = ultimoRiego
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error al guardar: \(error)")
        }
    }
}
