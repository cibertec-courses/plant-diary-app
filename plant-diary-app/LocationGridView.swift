import SwiftUI

struct LocationGridView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
        animation: .default)
    private var plantas: FetchedResults<Plant>
    
    let ubicaciones = [
        ("Sala", "sofa"),
        ("Cocina", "fork.knife"),
        ("Balcón", "sun.max"),
        ("Habitación", "bed.double")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(ubicaciones, id: \.0) { ubicacion in
                        NavigationLink(destination: PlantsByLocationView(ubicacion: ubicacion.0)) {
                            VStack {
                                Image(systemName: ubicacion.1)
                                    .font(.system(size: 50))
                                    .foregroundColor(.green)
                                
                                Text(ubicacion.0)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("\(contarPlantas(ubicacion: ubicacion.0)) plantas")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Ubicaciones")
        }
    }
    
    private func contarPlantas(ubicacion: String) -> Int {
        plantas.filter { $0.ubicacion == ubicacion }.count
    }
}
