//
//  ContentViewController.swift
//  KeDa-Tech-Test
//
//  Created by Vincent on 06/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Item.entity(),
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var searchText = ""
    @State private var filtered = false

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults.indices, id: \.self) { index in
                    NavigationLink {
                        SecondView(
                            productImage: searchResults[index].productImage ?? "Apel",
                            productName: searchResults[index].productName ?? "Apel",
                            productDesc: searchResults[index].productDesc ?? "Deskripsi Apel",
                            productIsFavorite: searchResults[index].isFavorite,
                            productIndex: items.firstIndex(of: searchResults.filter({ $0.productName == items[index].productName }).first ?? Item()) ?? 0
                        )
                    } label: {
                        ProductList(product: searchResults[index])
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    if !filtered {
                        Button(action: filter) {
                            Label("Filter", systemImage: "line.3.horizontal")
                        }
                    } else {
                        Button(action: filter) {
                            Label("Filter", systemImage: "line.3.horizontal")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Catalog Produk")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .toolbar)
        }
    }
    
    var searchResults: [Item] {
        let arrayProduct = items.map({ $0 })
        
        if searchText.isEmpty {
            return arrayProduct
        } else {
            return arrayProduct.filter { $0.productName?.contains(searchText) ?? true }
        }
    }
    
    func filter() {
        if !filtered {
            filtered = true
            items.nsPredicate = NSPredicate(format: "isFavorite == true", "Item")
        } else {
            filtered = false
            items.nsPredicate = nil
        }
    }
}
