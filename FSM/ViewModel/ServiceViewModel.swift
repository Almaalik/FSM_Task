//
//  ServiceViewModel.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//



import Foundation
import Combine

@MainActor
final class ServicesViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published private(set) var filteredServices: [Service] = []
    
    private var allServices: [Service] = []
    private var cancellables = Set<AnyCancellable>()
    private var hasLoaded = false
    
    init() {
        setupSearch()
        loadMockData()  
    }
    
    
    func loadInitialData() {
        guard !hasLoaded else { return }
        hasLoaded = true
        loadMockData()
    }
    
    
    func refresh() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        loadMockData()
    }
    
    var shouldShowEmptyState: Bool {
        !searchText.isEmpty && filteredServices.isEmpty
    }
    
    // MARK: - Private Methods
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.filterServices(with: query)
            }
            .store(in: &cancellables)
    }
    
    private func filterServices(with query: String) {
        guard !query.isEmpty else {
            filteredServices = allServices
            return
        }
        
        let lowercased = query.lowercased()
        
        filteredServices = allServices.filter {
            $0.title.lowercased().contains(lowercased) ||
            $0.customerName.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }
    
    private func loadMockData() {
        
        let calendar = Calendar.current
        
        allServices = [
            Service(
                title: "Office Space Revamp",
                customerName: "XYZ Industries",
                description: "Transform your office with sleek, contemporary furnishings.",
                scheduledDate: calendar.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!,
                status: .planned,
                latitude: 13.0500,
                longitude: 80.2824,
                notes: "Ensure all furniture is removed before renovation begins. Confirm layout and finalize colors."
            ),
            Service(
                title: "Modern Workspace Makeover",
                customerName: "Acme Corp",
                description: "Revitalize your workspace with stylish, modern decor that inspires creativity.",
                scheduledDate: calendar.date(bySettingHour: 15, minute: 30, second: 0, of: Date())!,
                status: .scheduled,
                latitude: 13.0418,
                longitude: 80.2341,
                notes: "Discuss ergonomic setups and lighting improvements."
            ),
            Service(
                title: "Contemporary Office Transformation",
                customerName: "Beta Solutions",
                description: "Elevate your office environment with chic, innovative designs that spark inspiration.",
                scheduledDate: calendar.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!,
                status: .confirmed,
                latitude: 12.9815,
                longitude: 80.2180,
                notes: "Finalize vendor delivery schedule."
            ),
            Service(
                title: "Modern Workspace Overhaul",
                customerName: "Alpha Innovations",
                description: "Transform your workspace with stylish, cutting-edge designs that inspire creativity.",
                scheduledDate: calendar.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!,
                status: .approved,
                latitude: 13.0850,
                longitude: 80.2101,
                notes: "Confirm budget and materials."
            )
        ]
        
        filteredServices = allServices
    }
}
