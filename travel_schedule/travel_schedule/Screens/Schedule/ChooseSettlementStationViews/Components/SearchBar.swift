//
//  SearchBar.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 14.03.2025.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - Properties
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var placeholder = "Введите запрос"
    
    // MARK: - Constants
    private let searchBarHeight: CGFloat = 37
    private let cornerRadius: CGFloat = 10
    private let iconSize: CGFloat = 17
    private let horizontalPadding: CGFloat = 16
    private let iconPadding: CGFloat = 10
    
    // MARK: - Body
    var body: some View {
        HStack {
            magnifyingGlassIcon
            searchTextField
            
            if isSearching && !searchText.isEmpty {
                clearButton
            }
        }
        .frame(height: searchBarHeight)
        .background(Color(red: 118.0/255, green: 118.0/255, blue: 128.0/255).opacity(0.12))
        .cornerRadius(cornerRadius)
        .padding(.horizontal, horizontalPadding)
    }
    
    private var magnifyingGlassIcon: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: iconSize, height: iconSize)
            .foregroundColor(.gray)
            .padding(.leading, 10)
    }
    
    private var searchTextField: some View {
        TextField(placeholder, text: $searchText, onEditingChanged: { editing in
            isSearching = editing
        })
        .font(.system(size: iconSize))
        .padding(.vertical, 8)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
    }
    
    private var clearButton: some View {
        Button(action: {
            searchText = ""
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
        .padding(.trailing, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("Москва"), isSearching: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
