//
//  ScheduleView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 07.03.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject private var viewModel: ScheduleViewModel
    @ObservedObject private var router: Router
    
    init() {
        guard let vm = DIContainer.shared.resolve(ScheduleViewModel.self),
              let r = DIContainer.shared.resolve(Router.self) else {
            fatalError("Dependencies not registered")
        }
        self.viewModel = vm
        self.router = r
    }
    
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
                .simultaneousGesture(
                    TapGesture().onEnded {
                        viewModel.isEditingFromField = true
                        router.push(.firstView)
                    }
                )
            TextField("to", text: $viewModel.to, prompt: Text("Куда"))
                .padding(.trailing, 13)
                .padding(.leading, 16)
                .padding(.bottom, 14)
                .simultaneousGesture(
                    TapGesture().onEnded {
                        viewModel.isEditingFromField = false
                        router.push(.firstView)
                    }
                )
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        // Настраиваем предварительный просмотр
        let viewModel = ScheduleViewModel()
        let router = Router()
        DIContainer.shared.register(viewModel, for: ScheduleViewModel.self)
        DIContainer.shared.register(router, for: Router.self)
        
        return ScheduleView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
