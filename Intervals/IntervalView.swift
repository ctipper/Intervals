import SwiftUI

struct IntervalView: View {
    @State private var start = Date()
    @State private var period = "Days"
    @State private var intervalValue = "1"
    @State private var end = Date()

    let periods = ["Days", "Weeks", "Months", "Years"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Interval Calculator")
                .font(.title2)
                .padding(.bottom, 8)

            // Start Date Picker
            DatePicker("Start Date", selection: $start, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()

            // Interval amount + unit
            HStack {
                TextField("Interval", text: $intervalValue)
                    .frame(width: 60)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Picker("Period", selection: $period) {
                    ForEach(periods, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)
            }

            // Computed End Date (non-editable but not greyed out)
            HStack {
                Text("End Date:")
                Text(end.formatted(date: .abbreviated, time: .omitted))
                    .fontWeight(.semibold)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            updateEndDate()
        }
        .onChange(of: start, perform: { _ in updateEndDate() })
        .onChange(of: period, perform: { _ in updateEndDate() })
        .onChange(of: intervalValue, perform: { _ in updateEndDate() })
    }

    private func updateEndDate() {
        guard let intervalInt = Int(intervalValue) else { return }

        var component = DateComponents()

        switch period {
        case "Days":
            component.day = intervalInt
        case "Weeks":
            component.weekOfYear = intervalInt
        case "Months":
            component.month = intervalInt
        case "Years":
            component.year = intervalInt
        default:
            break
        }

        if let calculated = Calendar.current.date(byAdding: component, to: start) {
            end = calculated
        }
    }
}
