import SwiftUI
import CoreData

struct PlantListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
        animation: .default)
    private var plantas: FetchedResults<Plant>
    
    @State private var showingAddPlant = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(plantas) { planta in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(planta.name ?? "Sin nombre")
                            .font(.headline)
                        Text(planta.tipo ?? "Sin tipo")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Ubicación: \(planta.ubicacion ?? "Sin ubicación")")
                            .font(.caption)
                        if let fecha = planta.ultimoRiego {
                            Text("Último riego: \(fecha, style: .date)")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deletePlantas)
            }
            .navigationTitle("Mis Plantas")
            .toolbar {
                Button(action: { showingAddPlant = true }) {
                    Label("Agregar", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddPlant) {
                AddPlantView()
            }
        }
    }
    
    private func deletePlantas(offsets: IndexSet) {
        withAnimation {
            offsets.map { plantas[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Error al eliminar: \(error)")
            }
        }
    }
}
