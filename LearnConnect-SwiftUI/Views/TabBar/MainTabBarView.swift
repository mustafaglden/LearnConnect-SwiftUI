//
//  MainTabBarView.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 29.11.2024.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case myCourses
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .myCourses:
            return "My Courses"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .myCourses:
            return "studentdesk"
        case .profile:
            return "person"
        }
    }
}


struct MainTabBarView: View {
    @State var selectedTab = 0
        init() {
            UITabBar.appearance().isHidden = true
        }
        var body: some View {
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    CoursesList()
                        .tag(0)
                    
                    MyCoursesView()
                        .tag(1)
                    
                    ProfileView()
                        .tag(2)
                }
                
                ZStack {
                    HStack {
                        ForEach((TabbedItems.allCases), id: \.self) { item in
                            Button {
                                selectedTab = item.rawValue
                            } label: {
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                            }
                        }
                    }
                    .padding(6)
                }
                .frame(height: 70)
                .background(.gray.opacity(0.5))
                .cornerRadius(35)
                .padding(.horizontal, 26)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

extension MainTabBarView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
            Spacer()
        }
        .frame(width: isActive ? 60 : 60, height: 60)
        .background(isActive ? .orange : .clear)
        .cornerRadius(30)
    }
}
