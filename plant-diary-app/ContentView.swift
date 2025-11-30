import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
            animation: .default
        )


    private var plantas: FetchedResults<Plant>
    
    var body: some View {
        Text("Total plantas: \(plantas.count)")
    }
}
