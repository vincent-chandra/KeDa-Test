//
//  ProductList.swift
//  KeDa-Tech-Test
//
//  Created by Vincent on 06/07/23.
//

import SwiftUI
import CoreData

struct ProductList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Item>
    
    var product: Item?

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(product?.productImage ?? "Apel")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(verbatim: product?.productName ?? "Product Name")
            }
            Spacer()
            Image(systemName: product?.isFavorite == true ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
