//
//  ServicesListView.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//


import SwiftUI

struct ServicesListView: View {
    
    @StateObject private var viewModel = ServicesViewModel()
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                headerView
                    .padding(10)
                Divider()
                
                ScrollView {
                    
                    if viewModel.shouldShowEmptyState {
                        emptyStateView
                        
                    } else {
                        
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredServices) { service in
                                NavigationLink(value: service) {
                                    ServiceCardView(service: service)
                                }
                                .buttonStyle(.plain)
                                .simultaneousGesture(TapGesture().onEnded {
                                    isSearchFocused = false
                                })
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                    }
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    await viewModel.refresh()
                }
            }

            .background(Color(.systemBackground))
            .navigationDestination(for: Service.self) { service in
                if #available(iOS 17.0, *) {
                    ServiceDetailView(service: service)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}




private extension ServicesListView {
    
    var headerView: some View {
        VStack(spacing: 8) {
            
            Text("Services")
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            searchBar
            
        }
        .padding(.horizontal)
        .padding(.top)
        .background(Color(.systemBackground))
    }
}

private extension ServicesListView {
    
    var searchBar: some View {
        HStack(spacing: 8) {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .focused($isSearchFocused)
                .submitLabel(.done)
            

            
            Image(systemName: "mic.fill")
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(Color(.systemGray5))

        .cornerRadius(12)
    }
}



private extension ServicesListView {
    
    var emptyStateView: some View {
        VStack(spacing: 16) {
            
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No Services Found")
                .font(.headline)
            
            Text("Try adjusting your search.")
                .foregroundColor(.secondary)
        }
        .padding(.top, 60)
    }
}



