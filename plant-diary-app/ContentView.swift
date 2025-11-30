import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            PlantListView()
                .tabItem {
                    Label("Mis Plantas", systemImage: "leaf.fill")
                }
            
            LocationGridView()
                .tabItem {
                    Label("Ubicaciones", systemImage: "square.grid.2x2.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
