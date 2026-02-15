//
//  ServiceDetailView.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//


import SwiftUI
import MapKit

struct ServiceDetailView: View {
    
    let service: Service
    @Environment(\.dismiss) private var dismiss
    
    @State private var region: MKCoordinateRegion
    
    init(service: Service) {
        self.service = service
        
        _region = State(initialValue:
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: service.latitude,
                    longitude: service.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Divider()
            
            // MARK: - Scrollable Content
            ScrollView {
                VStack(spacing: 20) {
                    
                   
                    Map(coordinateRegion: $region,
                        annotationItems: [service]) { service in
                        
                        MapMarker(
                            coordinate: CLLocationCoordinate2D(
                                latitude: service.latitude,
                                longitude: service.longitude
                            )
                        )
                        
                    }
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        titleSection
                        
                        
                        detailRow(icon: "user",
                                  title: "Customer",
                                  value: service.customerName)
                        
                        detailRow(icon: "file",
                                  title: "Description",
                                  value: service.description)
                        
                        detailRow(icon: "clock-check",
                                  title: "Scheduled Time",
                                  value: service.scheduledDate.smartFormatted())
                        
                        detailRow(icon: "map-pin",
                                  title: "Location",
                                  value: "Seattle, WA")
                        
                        detailRow(icon: "message",
                                  title: "Service Notes",
                                  value: service.notes)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Services")
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Service Detail")
                    .font(.headline)
            }
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}


private extension ServiceDetailView {
    
    var titleSection: some View {
        HStack {
                
                Text(service.title)
                    .font(.title2)
                    .fontWeight(.semibold)
            Spacer()
            ServiceStatusBadge(status: service.status)
            
           
        }
    }
}

private extension ServiceDetailView {
    
    func detailRow(icon: String,
                   title: String,
                   value: String) -> some View {
        
        HStack(alignment: .top, spacing: 8) {
            
            Image(icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(value)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}



