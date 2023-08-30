//
//  ContentView.swift
//  Habit
//
//  Created by Nazarii Zomko on 06.09.2022.
//


import SwiftUI


struct ContentView: View {
    @ObservedObject var habits: Habits
    @Environment(\.scenePhase) var scenePhase
    
    @State var isAddNewHabitViewShowing = false
    
    init() {
        habits = Habits() // why??
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                HStack {
                    Text("Habit")
                        .font(.largeTitle.bold())
                        .padding(.horizontal, 8)
                    Spacer()
                    HStack(spacing: 0) {
                        ForEach(0..<5) { number in
                            let daysAgo = abs(number - 4) // reverse order
                            let dayInfo = getDayInfo(daysAgo: daysAgo)

                            VStack(spacing: 0) {
                                Text("\(dayInfo.dayNumber)")
                                    .frame(minWidth: Styling.dayOfTheWeekFrameSize)
                                Text("\(dayInfo.dayName)")
                                    .frame(minWidth: Styling.dayOfTheWeekFrameSize)
                            }
                            .font(.footnote.bold())
                            .opacity(daysAgo == 0 ? 1 : 0.5)
                        }
                    }
                    .padding(.trailing, 10)

                }
                .padding()
//                ForEach(habits.items) { habit in
//                        HabitRowView(habits: habits, habit: habit)
////                                .animation(.default)
//                }
//                Spacer()
                ScrollView {
                    ForEach(habits.items) { habit in
//                        Text("OK")
                        HabitRowView(habits: habits, habit: habit)
    //                                .animation(.default)
                    }
                }
                
//                ScrollView {
//                    LazyVStack {
//                        ForEach(habits.items) { habit in
//                            HabitRowView(habits: habits, habit: habit)
////                                .animation(.default)
//                        }
//                    }
//                }
                .sheet(isPresented: $isAddNewHabitViewShowing, onDismiss: {
//                    isAddNewHabitViewShowing = false
                }) {
                    HabitView(habits: habits)
                }

            }
//            .onChange(of: scenePhase, perform: { newPhase in
//                print("here1")
//                if newPhase != .active {
//                    print("here11")
//                    isAddNewHabitViewShowing = false
//                }
//            })


            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddNewHabitViewShowing = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2.weight(.light))
                            .foregroundColor(.primary)
                    }

                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2.weight(.light))
                }
            }
        }
    }
    
    
    func getDayInfo(daysAgo: Int) -> (dayNumber: String, dayName: String) {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEEEE"
        let dayName = dateFormatter.string(from: todayMinusDaysAgo)
        
        dateFormatter.dateFormat = "d"
        let dayNumber = dateFormatter.string(from: todayMinusDaysAgo)
        
        return (dayNumber: dayNumber, dayName: dayName)
    }
}

struct HabitRowView: View {
    @Environment(\.colorScheme) var colorScheme
    var boxColor: CGColor {
        return colorScheme == .dark ? CGColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1) : CGColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    }

    var habits: Habits
    @State var habit: Habit
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isEditHabitViewShowing = false
    @State private var isInfoHabitViewShowing = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 0) {
                    ForEach(0..<5) {number in
                        let daysAgo = abs(number - 4) // reverse order
                        
                        Button {
                            toggleCheckmark(daysAgo: daysAgo)
                        } label: {
//                            Image(systemName: isChecked(daysAgo: daysAgo) ? "checkmark": "circle")
                            Image(isChecked(daysAgo: daysAgo) ? "checkmark" : "circle")
                                .resizable()
//                                .border(.blue)
                                .padding(10)
                                .frame(width: Styling.dayOfTheWeekFrameSize, height: Styling.dayOfTheWeekFrameSize)
                                .contentShape(Rectangle())
//                                .border(.red)
                        }



//                        Image(systemName: isChecked(daysAgo: daysAgo) ? "checkmark": "circle")
//                            .border(.blue)
//
//                            .frame(width: Styling.dayOfTheWeekFrameSize, height: Styling.dayOfTheWeekFrameSize)
//                            .clipped()
////                                    .border(.green)
//
//                            .contentShape(Rectangle()) // make tappable area larger
//                            .border(.red)
//                            .onTapGesture {
//                                toggleCheckmark(daysAgo: daysAgo)
//                            }
                    }
//                            .border(.red)
                }
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
            Spacer()
        }
//        .sheet(isPresented: $isEditHabitViewShowing, content: {
////            Text("New view")
//            Button("Close sheet") {
//                isEditHabitViewShowing = false
//            }
//        })
        
//        .sheet(isPresented: $isEditHabitViewShowing, onDismiss: {
////            isEditHabitViewShowing = false
//        }, content: {
//            Button("Close sheet") {
//                isEditHabitViewShowing = false
//            }
//        })
//        .onChange(of: scenePhase, perform: { newPhase in
//            print("here2")
//            if newPhase == .background {
//                print("here22")
//                isEditHabitViewShowing = false
//            }
//        })
        .sheet(isPresented: $isEditHabitViewShowing, onDismiss: {
//            isEditHabitViewShowing = false
        }) {
//            Text("New view")
            HabitView(habits: habits, selectedHabit: $habit)
        }
        
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(boxColor))
                    .onTapGesture {
                        isEditHabitViewShowing = true
                    }
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            let percentage = habit.percentage
                            
                            HStack {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: CGFloat(percentage) * 6.4)) // workaround because setting size with frame does not work
                                    .background(Circle().fill(Color(habit.color))) // workaround to stroke and fill at the same time
                                    .frame(width: 30)
                                    .foregroundColor(Color(habit.color))
                                Spacer()
                            }
                            .offset(x: -6)
                                
                            HStack {
                                Text("\(percentage)%")
//                                    .frame(minWidth: 50, alignment: .leading)
                                    .font(.caption)
//                                    .border(.red)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        


                    }
                    
//                    .border(.red)
                    Spacer()
                    HStack {
                        Text(habit.title)
                            .font(.title3)
                            .padding(.horizontal)
//                            .blendMode(.difference)
                        Spacer()
                    }

                    Spacer()
                }
            }
        )
        
        .frame(minHeight: 100, maxHeight: 100)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .padding(.horizontal)
        .padding(.vertical, 2)

    }
    

    
    func toggleCheckmark(daysAgo: Int) {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        if isChecked(daysAgo: daysAgo) {
            habit.removeDate(todayMinusDaysAgo)
        } else {
            habit.addDate(todayMinusDaysAgo)
        }
        
        habits.update(habit: habit)
    }
    
    func isChecked(daysAgo: Int) -> Bool {
        let today = Date.now
        let todayMinusDaysAgo = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        
        for checkedDate in habit.checkedDates {
            if Calendar.current.isDate(checkedDate, inSameDayAs: todayMinusDaysAgo) {
                return true
            }
        }
        return false
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
