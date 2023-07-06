//
//  ContentView.swift
//  KeDa-Tech-Test
//
//  Created by Vincent on 06/07/23.
//

import SwiftUI
import CoreData

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
