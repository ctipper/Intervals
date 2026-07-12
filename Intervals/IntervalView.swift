import SwiftUI

struct IntervalView: View {
    @State private var start = Date()
    @State private var period: IntervalPeriod = .days
    @State private var intervalValue = "1"
    @State private var end = Date()

    let periods = IntervalPeriod.allCases

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
                        Text(option.rawValue).tag(option)
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
        .onChange(of: start) { updateEndDate() }
        .onChange(of: period) { updateEndDate() }
        .onChange(of: intervalValue) { updateEndDate() }
    }

    private func updateEndDate() {
        guard let intervalInt = Int(intervalValue) else { return }
        end = IntervalCalculator.endDate(from: start, amount: intervalInt, period: period)
    }
}
