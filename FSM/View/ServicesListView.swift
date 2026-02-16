//
//  ServicesListView.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//


import SwiftUI

struct ServicesListView: View {
    
    @StateObject private var viewModel = ServicesViewModel()
    @State private var selectedService: Service? = nil
    @State private var showDetail = false
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                headerView
                    .padding(8)
                Divider()
                    .padding(8)
                
                if viewModel.shouldShowEmptyState {
                    emptyStateView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    
                    List {
                        ForEach(viewModel.filteredServices) { service in
                            
                            ServiceCardView(service: service)
                                .padding(.vertical, 8)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(
                                    top: 0,
                                    leading: 16,
                                    bottom: 0,
                                    trailing: 16
                                ))
                                .listRowBackground(Color.clear)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    isSearchFocused = false
                                    selectedService = service
                                    showDetail = true
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemBackground))
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationDestination(isPresented: $showDetail) {
                if let service = selectedService {
                    ServiceDetailView(service: service)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
            
            Text("No Search Results Found")
                .font(.headline)
            
            Text("Try something else.")
                .foregroundColor(.secondary)
        }
        .padding(.top, 60)
    }
}



