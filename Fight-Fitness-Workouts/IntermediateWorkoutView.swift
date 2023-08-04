import SwiftUI

struct IntermediateWorkoutView: View {
    @State var secondsRemaining = 20 * 60 //20 minutes in seconds, store number of seconds left in timer
    @State var timer: Timer? = nil //timer object will be used to handle countdown logic
    @State var isPaused = true //timer will be set to paused so it doesnt start when view loads and will be used to disable play and pause buttons
    @State var progress:Double = 0 //used to control circle animation on timer
    var body: some View {
        VStack {
            Text("Intermediate Workout")
                .font(.title).bold()
            //zstack contains circle that animates and workout timer
            ZStack{
                Circle()
                    .stroke(Color.gray, lineWidth: 15)
                    .frame(width: 150, height: 150)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.red, style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeIn, value: progress)
                
                Text("\(formatTime(secondsRemaining))")
                    .font(.largeTitle).bold()
                    .padding()
            }
            //hstack contains the play, pause and reset button for timer
            HStack{
                Button(action: startTimer) {
                    Image(systemName: "play.fill")
                }
                .disabled(!isPaused)
                .foregroundColor(.white)
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button(action: pauseTimer) {
                    Image(systemName: "pause.fill")
                }
                .disabled(isPaused)
                .foregroundColor(.white)
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button(action: resetTimer) {
                    Image(systemName: "gobackward")
                }
                .disabled(timer == nil)
                .foregroundColor(.white)
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding()
            
            //embeds youtube video into the view
            WebView(url: URL(string: "https://www.youtube.com/embed/XIHvfwYVy4A")!)
                .frame(width: 300, height: 180)
                .cornerRadius(10)
            
            //displays workout details in horizontally scrollable cards
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 16) {
                    //round 1 details
                    VStack {
                        Text("Round 1")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Warmup")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    //round 2 details
                    VStack {
                        Text("Round 2")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("double-jab-slip")
                        Text("double-jab-stepback-slip")
                        Text("double-jab-stepforward-slip")
                        Text("double-jab-cross")
                        Text("45 second rest")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    //round 3 details
                    VStack {
                        Text("Round 3")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("3 Punch Combo")
                        Text("Double 3 Punch Combo")
                        Text("45 Seconds rest")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    //round 4 details
                    VStack {
                        Text("Round 4")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("3 punch Combo With Hook")
                        Text("Punching Sprint")
                        Text("45 Second Rest")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    
                    //round 5 details
                    VStack {
                        Text("Round 5")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Footwork").font(.caption2)
                        Text("Footwork 1-2").font(.caption2)
                        Text("Footwork Jab-Hook-2-Hook").font(.caption2)
                        Text("Footwork").font(.caption2)
                        Text("Footwork 1-2").font(.caption2)
                        Text("Footwork Jab-Hook-2-Hook").font(.caption2)
                        Text("Punching Sprint").font(.caption2)
                        Text("45 Seconds Rest").font(.caption2)
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    //round 6 details
                    VStack {
                        Text("Round 6")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Punch Combo With Hook")
                        Text("Punch Combo With Hook Slip")
                        Text("Punching Sprint")
                        
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                }
              }
            .frame(width: 300, height: 180)
            .background(Color.red)
            .cornerRadius(16)
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
            
    }
    //creates new timer object if it doesnt already exist and starts the countdown
    private func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                    //value determined by finding what percentage of 20 minutes 1 second is then finding that percentage of 1
                    //progress is used to animate circle around timer
                    progress += 0.000833333333
                } else {
                    timer?.invalidate()
                    timer = nil
                }
            }
            isPaused = false
        }
    }
    //stops timer and sets ispaused to true so the play button is enabled
    private func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isPaused = true
    }
    //stops the time and resets secondsRemaining variable to 20 minutes, isPaused is set to true so play button is enabled
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        progress = 0
        secondsRemaining = 20 * 60
        isPaused = true
    }
    //formats the time so it it is displayed correctly for example "20:00"
    public func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
struct IntermediateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        IntermediateWorkoutView()
    }
}
