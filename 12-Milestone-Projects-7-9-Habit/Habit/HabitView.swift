//
//  HabitView.swift
//  Habit
//
//  Created by Nazarii Zomko on 12.09.2022.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits
    @State var selectedHabit: Binding<Habit>? = nil
    
    @FocusState private var isNameTextFieldFocused
    @FocusState private var isMotivationTextFieldFocused
    
    @State private var showColors = false
    @State private var name = ""
    @State private var motivation = ""
    
    @State private var color = UIColor.HabitColors.green
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                VStack {
                    HStack {
                        Text("NAME")
                            .padding(.horizontal)
                            .font(.caption)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    TextField("", text: $name)
                        .focused($isNameTextFieldFocused)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .placeHolder(
                            Text("Read a book, Meditate etc.")
                                .foregroundColor(.black)
                                .opacity(0.3)
                                .padding(.horizontal),
                            show: name.isEmpty)
                }
                .padding(.top, 40)
                .padding(.bottom, 15)
                .background(
                    Color(color)
                )
                
                VStack {
                    HStack {
                        Text("MOTIVATE YOURSELF")
                            .padding(.horizontal)
                            .font(.caption)
                        Spacer()
                    }
                    .padding(.top)
                    TextField("", text: $motivation)
                        .focused($isMotivationTextFieldFocused)
                        .padding(.horizontal)
                        .placeHolder(
                            Text("Yes, you can! 💪")
                                .opacity(0.3)
                                .padding(.horizontal),
                            show: motivation.isEmpty)
                }
                
                HStack {
                    Text("Choose color")
                    Spacer()
                    Circle()
                        .frame(height: 20)
                        .foregroundColor(Color(color))
                }
                .padding()
                .onTapGesture {
                    showColors = true
                }
                Spacer()
            }
            
            .toolbarBackground(Color(color), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveHabit()
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                
                if selectedHabit != nil {
                    ToolbarItem(placement: .bottomBar) {
                        Button(role: .destructive) {
                            deleteHabit()
                            dismiss()
                        } label: {
                            Text("Delete Habit")
                                .foregroundColor(.red)
                        }

                    }
                }
            }
        }
        .sheet(isPresented: $showColors) {
            ColorsView(showColorsView: $showColors, color: $color)
        }
        .onAppear() {
            if let selectedHabit {
                name = selectedHabit.title.wrappedValue
                color = selectedHabit.color.wrappedValue
                motivation = selectedHabit.motivation.wrappedValue
            } else {
                color = Styling.colors.randomElement() ?? UIColor.HabitColors.red
                isNameTextFieldFocused = true
            }
        }
        

    }
    
    func saveHabit() {
        if let selectedHabit = selectedHabit {
//            print("in saveHabit")
            selectedHabit.title.wrappedValue = name
            selectedHabit.motivation.wrappedValue = motivation
            selectedHabit.color.wrappedValue = color
            habits.update(habit: selectedHabit.wrappedValue)
        } else {
            let newHabit = Habit(title: name, motivation: motivation, checkedDates: [], color: color)
            habits.add(habit: newHabit)
        }
    }
    
    func deleteHabit() {
        if let selectedHabit {
            habits.delete(habit: selectedHabit.wrappedValue)
        }
    }
    
}

struct ColorsView: View {
    let colors = Styling.colors
    
    @State var showColorsView: Binding<Bool>
    @State var color: Binding<UIColor>
    
    let gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout) {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .foregroundColor(Color(color))
                    .onTapGesture {
                        self.color.wrappedValue = color
                        showColorsView.wrappedValue = false
                    }
            }
        }
        .padding(40)
    }
}


struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habits: Habits())
    }
}
