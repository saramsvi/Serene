//
//  CourseSectionDetail.swift
//  DesignCodeCourse
//
//  Created by Meng To on 2020-07-24.
//

import SwiftUI

struct EntryDetail: View {
    
    @Environment(\.presentationMode) var presentationMode
    var entry: Entry = entries[0]
    var namespace: Namespace.ID
    #if os(iOS)
    var cornerRadius: CGFloat = 10
    #else
    var cornerRadius: CGFloat = 0
    #endif
    var body: some View {
        #if os(iOS)
                content
                .edgesIgnoringSafeArea(.all)
                #else
                content
                #endif
    }
    
    var content: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
               EntryItem(entry: entry, cornerRadius: cornerRadius)
                .matchedGeometryEffect(id: entry.id, in: namespace)
                .frame(height: 300)
                VStack(alignment: .leading, spacing: 30) {
                    Text("Mood Check-in").font(.title).bold()
                    Text("A mood tracker is a tool that is used to keep a record of a person's mood at regular intervals. The purpose of this type of tool is to help look for patterns in how moods vary over time and due to different situations and circumstances.In some cases, a mood tracker can be useful for people with mental health conditions—such as depression and anxiety—to help identify and regulate moods. Mood trackers can range from the simple (a handwritten journal) to the complex (an online app that collects a range of information) and are available at a variety of price points.")
                    Text("Feelings").font(.title).bold()
                    Text("This type of journaling isn’t your typical record of daily activities. Rather, it’s a way to identify and take action around your feelings.If you can record how you are feeling and what you are thinking, you are better able to track your emotions, notice people or places that are triggers, and recognize warning signs of your strong emotions,” says therapist Amanda Ruiz, MS, LPC.Journaling your thoughts, emotions, and challenges has been shown to reduce anxietyTrusted Source and depression. ")
                    Text("Reasons").font(.title).bold()
                    Text("When you can recognize these patterns, you can work to eliminate or avoid certain triggers — or focus your energy on how best to respond next time.")
                    Text("Notes").font(.title).bold()
                    Text("Putting down our problems on paper often helps us see the causes — and therefore solutions — more clearly.A mood journal is similar, but since it’s focused on your emotions, it’ll bring clarity to how to improve your mental health.An emotion journal allows you to record your feelings over several days or weeks and then notice patterns or trends,” Ruiz says.")
                    Text("Blessings").font(.title).bold()
                    Text("Well, this is your personal blessings journal so you can write whatever you want. BUT the definitive difference between just a regular journal and a blessings book is that in a journal, you can write whatever you want...sad thoughts, happy thoughts, daydreams, etc. But in a Blessings Journal, you are only supposed to write your blessings. That would mean people, things, experiences for which you are truly grateful. And why you are thankful. When you are done writing an entry, re-read it with a grateful heart. You don't have to share this book with anyone else. Only you and God will know what's in it unless you choose to share it with others. That can be very freeing. If you are having a bad day, it will lift you up. If you are tired and weary of things going on in your life, it will remind you of all that you DO have, and give you strength to go on, hoping the next day will be better. But if you are having a great day, write it down, to help your spirit soar on this day, and on days to come when you may need to read something uplifting and be grateful for your blessings.")
                }
                .padding()
            }
            
//            CloseButton()
//                .padding()
//                .onTapGesture {
//                    presentationMode.wrappedValue.dismiss()
//                }
        }    
    }
}

struct EntryDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        EntryDetail(namespace: namespace)
    }
}
