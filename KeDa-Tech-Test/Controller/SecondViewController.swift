//
//  SecondView.swift
//  KeDa-Tech-Test
//
//  Created by Vincent on 06/07/23.
//

import Foundation
import SwiftUI
import CoreData

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(),
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var productImage = ""
    var productName = ""
    var productDesc = ""
    var productIsFavorite = false
    var productIndex = 0
    
    var body : some View {
        VStack {
            Image(productImage)
                .resizable()
                .frame(width: 100, height: 100)
            Text(productName)
            Text(productDesc)
        }
        Spacer()
        Button(productIsFavorite == false ? "Add To Favorite" : "Remove From Favorite") {
            if self.productIsFavorite == false {
                items.filter({ $0.productName == productName }).first?.isFavorite = true
            } else {
                items.filter({ $0.productName == productName }).first?.isFavorite = false
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            self.presentationMode.wrappedValue.dismiss()
        }
        .buttonStyle(.borderedProminent)
    }
}
