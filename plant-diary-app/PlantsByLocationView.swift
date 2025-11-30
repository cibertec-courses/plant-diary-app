import SwiftUI
import CoreData

struct PlantsByLocationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let ubicacion: String
    
    @FetchRequest private var plantas: FetchedResults<Plant>
    
    init(ubicacion: String) {
        self.ubicacion = ubicacion
        
        _plantas = FetchRequest<Plant>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
            predicate: NSPredicate(format: "ubicacion == %@", ubicacion),
            animation: .default
        )
    }
    
    var body: some View {
        List {
            ForEach(plantas) { planta in
                VStack(alignment: .leading, spacing: 4) {
                    Text(planta.name ?? "Sin nombre")
                        .font(.headline)
                    Text(planta.tipo ?? "Sin tipo")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    if let fecha = planta.ultimoRiego {
                        Text("Último riego: \(fecha, style: .date)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(ubicacion)
    }
}
