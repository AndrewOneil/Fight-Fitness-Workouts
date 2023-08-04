import SwiftUI
import WebKit

struct BeginnerWorkoutView: View {
    @State var secondsRemaining = 10 * 60 //10 minutes in seconds, store number of seconds left in timer
    @State var timer: Timer? = nil //timer object will be used to handle countdown logic
    @State var isPaused = true //timer will be set to paused so it doesnt start when view loads and will be used to disable play and pause buttons
    @State var progress:Double = 0 //used to control circle animation on timer
    var body: some View {
        VStack {
            Text("Beginner Workout")
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
            WebView(url: URL(string: "https://www.youtube.com/embed/3NuaZx6pHzM")!)
                .frame(width: 300, height: 180)
                .cornerRadius(10)
            
            //displays workout details in horizontally scrollable cards
            ScrollView(.horizontal, showsIndicators: true){
                HStack(spacing: 16) {
                    VStack {
                        //round 1 details
                        Text("Round 1")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Jab-Cross (1-2) for 1 minute")
                        Text("Jab-Jab-Cross (1-1-2) for 1 minute")
                        Text("Rest 30 seconds")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    
                    VStack {
                        //round 2 details
                        Text("Round 2")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Jab-Cross-Lead Hook (1-2-3) for 1 minute").multilineTextAlignment(.center)
                        Text("Jab-Cross-Jab (1-2-1) for 1 minute").multilineTextAlignment(.center)
                        Text("Rest 30 seconds")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    VStack {
                        //round 3 details
                        Text("Round 3")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Jab-Jab (1-1) for 1 minute")
                        Text("Cross-Lead Hook (2-3) for 1 minute")
                        Text("Rest 30 seconds")
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.red)
                    .cornerRadius(16)
                    
                    VStack {
                        //round 4 details
                        Text("Round 4")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Cross-Lead Uppercut (2-5) for 1 minute").multilineTextAlignment(.center)
                        Text("Jab-Rear Uppercut (1-6) for 1 minute").multilineTextAlignment(.center)
                        Text("1-2 Burnout for 30 seconds")
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
    }
    
    
    //creates new timer object if it doesnt already exist and starts the countdown
    private func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                    //value determined by finding what percentage of 10 minutes 1 second is then finding that percentage of 1
                    //progress is used to animate circle around timer
                    progress += 0.00166666667
                
                } else {
                    //if secondsremaining reachers 0 then timer is stopped
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
    //stops the time and resets secondsRemaining variable to 10 minutes, isPaused is set to true so play button is enabled
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        progress = 0
        secondsRemaining = 10 * 60
        isPaused = true
    }
    //formats the time so it is displayed correctly for example "10:00"
    public func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
struct BeginnerWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        BeginnerWorkoutView()
    }
}


