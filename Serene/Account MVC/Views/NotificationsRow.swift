//
//  NotificationsView.swift
//  Serene
//
//  Created by MSVI on 2.05.22.
//

import SwiftUI

struct NotificationsRow: View {
    @StateObject var notificationVM = NotificationViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Group {
            if notificationVM.permission == .authorized {
                Toggle(isOn: $notificationVM.subscribedToAllNotifications, label: {
                    HStack(spacing: 12) {
                        TextFieldIcon(iconName: "bell.fill", currentlyEditing: .constant(true), passedImage: .constant(nil))
                        VStack(alignment: .leading) {
                            Text("Remind me to journal")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Max once a day")
                                .font(.caption2)
                                .opacity(0.7)
                        }
                    }
                })
                .toggleStyle(SwitchToggleStyle(tint: Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1))))
            } else {
                VStack(alignment: .center, spacing: 12) {
                    Text("Notifications are disabled!")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Unfortunetly we can't remind to journal :(")
                        .font(.caption2)
                        .opacity(0.7)
                    
                    Link(destination: URL(string: UIApplication.openSettingsURLString)!, label: {
                        Text("Open Settings")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
        }
        .onAppear {
            notificationVM.getNotificationSettings()
        }
        .onChange(of: scenePhase, perform: { newPhase in
            print("onChange of scenePhase", newPhase)
            if newPhase == .active {
                notificationVM.getNotificationSettings()
             }
        })

    }
}

struct NotificationsRow_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsRow()
    }
}
