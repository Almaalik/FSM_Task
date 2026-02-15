//
//  ServiceRowView.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//

import SwiftUI

struct ServiceRowView: View {
    
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text(service.title)
                    .font(.headline)
                
                Spacer()
                
                Circle()
                    .fill(service.status.color)
                    .frame(width: 10, height: 10)
            }
            
            Text(service.customerName)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(service.description)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Text(service.status.rawValue.capitalized)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(service.status.color.opacity(0.2))
                    .clipShape(Capsule())
                
                Spacer()
                
                Text(service.scheduledDate.smartFormatted())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

