//
//  ScheduleView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 07.03.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        ZStack() {
            Background
            
            HStack(spacing: 16.0) {
                Textfields
                Button(action: {
                    viewModel.swapLocations()
                })
                {
                    ChangeButtonView
                }
            }
        }
    }
    private var Background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(.ypBlue))
            .frame(width: 343, height: 128)
    }
    
    private var Textfields: some View {
        VStack(spacing: 28.0) {
            TextField("from", text: $viewModel.from, prompt: Text("Откуда"))
                .padding(.trailing, 13)
                .padding(.leading, 16)
                .padding(.top, 14)
            TextField("to", text: $viewModel.to, prompt: Text("Куда"))
                .padding(.trailing, 13)
                .padding(.leading, 16)
                .padding(.bottom, 14)
        }
        .frame(width: 259, height: 96)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private var ChangeButtonView: some View {
        ZStack() {
            Circle()
                .foregroundColor(Color(.ypWhite))
            Image("change")
                .resizable()
                .foregroundColor(.ypBlue)
                .frame(width: 24, height: 24)
        }
        .frame(width: 36, height: 36)
    }
}

#Preview {
    ScheduleView(viewModel: MainScreenViewModel())
}
