//
//  SrviceCardView.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//

import SwiftUI

struct ServiceCardView: View {
    
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text(service.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Circle()
                    .fill(service.status.color)
                    .frame(width: 8, height: 8)
            }
            
            HStack(spacing: 8) {
                Image("user")
                    .foregroundColor(.blue)
                Text(service.customerName)
                    .foregroundColor(.primary)
                    .font(.footnote)
            }
            
            HStack(alignment: .top, spacing: 8) {
                Image("file")
                    .foregroundColor(.blue)
                Text(service.description)
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .lineLimit(2)
                    .lineSpacing(0) 

            }
            
            HStack {
                ServiceStatusBadge(status: service.status)

                
                Spacer()
                
                Text(service.scheduledDate.smartFormatted())
                    .foregroundColor(.primary)
                    .font(.footnote)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}



