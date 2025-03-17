//
//  UserAreementView.swift
//  travel_schedule
//
//  Created by Maksim Zakharov on 17.03.2025.
//

import SwiftUI

struct UserAreementView: View {
    // MARK: - States
    @ObservedObject private var router: Router
    
    // MARK: - init
    init() {
        guard let r = DIContainer.shared.resolve(Router.self) else {
            fatalError("Dependencies not registered")
        }
        self.router = r
        setupNavBarTitle()
    }
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц")
                            .font(.system(size: 24, weight: .bold))
                        Text("Данный документ является действующим, если расположен по адресу: https://yandex.ru/legal/practicum_offer")
                        Text("Российская Федерация, город Москва")
                    }
                    .font(.system(size: 17, weight: .regular))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("1. ТЕРМИНЫ")
                            .font(.system(size: 24, weight: .bold))
                        Text("Понятия, используемые в Оферте, означают следующее:  Авторизованные адреса — адреса электронной почты каждой Стороны. Авторизованным адресом Исполнителя является адрес электронной почты, указанный в разделе 11 Оферты. Авторизованным адресом Студента является адрес электронной почты, указанный Студентом в Личном кабинете.  Вводный курс — начальный Курс обучения по представленным на Сервисе Программам обучения в рамках выбранной Студентом Профессии или Курсу, рассчитанный на определенное количество часов самостоятельного обучения, который предоставляется Студенту единожды при регистрации на Сервисе на безвозмездной основе. В процессе обучения в рамках Вводного курса Студенту предоставляется возможность ознакомления с работой Сервиса и определения возможности Студента продолжить обучение в рамках Полного курса по выбранной Студентом Программе обучения. Точное количество часов обучения в рамках Вводного курса зависит от выбранной Студентом Профессии или Курса и определяется в Программе обучения, размещенной на Сервисе. Максимальный срок освоения Вводного курса составляет 1 (один) год с даты начала обучения.")
                    }
                    .font(.system(size: 17, weight: .regular))
                    
                }
                .foregroundStyle(.ypBlack)
                .customNavigationModifier(router: router, title: "Пользовательское соглашение")
            }
            .padding([.top, .leading, .trailing], 16)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    let coordinator = AppCoordinator.shared
    coordinator.setupDependencies()
    
    return UserAreementView()
}
