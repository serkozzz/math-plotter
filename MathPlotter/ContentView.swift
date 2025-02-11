import SwiftUI
import Charts

struct ContentView: View {
    @State var functionString: String = ""
    @State var parsers: [MathFunctionParser] = []
    @State var xScale: ClosedRange<Double> = -10...10
    @State var yScale: ClosedRange<Double> = -10...10
    @State var scale: CGFloat = 1.0
    
    var colors: [Color] = [.blue, .green, .orange, .purple, .pink, .black, .brown, .indigo, .yellow, .red]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(Array(parsers.enumerated()), id: \ .element.id) { index, parser in
                    LinePlot(x: "x", y: "y") { x in
                        parser.evaluate(x: x)
                    }
                    .foregroundStyle(colors[index % colors.count])
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartXScale(domain: xScale)
            .chartYScale(domain: yScale)
            .chartYAxisLabel("y = \(functionString)")
            .gesture(MagnificationGesture()
                .onChanged { value in
                    print(value)
                    let factor = scale * value
                    xScale = (-10.0 * factor)...(10.0 * factor)
                    yScale = (-10.0 * factor)...(10.0 * factor)
                }
                .onEnded { value in
                    scale *= value
                }
            )
            
            VStack {
                HStack {
                    TextField("Your math function", text: $functionString)
                    Button("Add") {
                        parsers.append(MathFunctionParser(expression: functionString))
                    }
                }
                .padding()
                
                Button("Clear") {
                    parsers.removeAll()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
