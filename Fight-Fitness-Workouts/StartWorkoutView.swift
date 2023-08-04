import SwiftUI

struct StartWorkoutView: View {
    //booleans are used to control when to display workout views
    @State private var beginnerSheet = false
    @State private var intermediateSheet = false
    @State private var advancedSheet = false
    var body: some View {
        //Styled card that contains buttons to the three workout views
        NavigationView {
                ZStack{
                    //adds white background behind buttons
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.white)
                        .frame(width: 300, height: 400)
                    VStack{
                        Text("Choose a Workout")
                            .font(.system(size: 30)).bold().foregroundColor(.black)
                            .padding()
                    
                        
                        //takes user to beginner workout view
                        Button("Beginner"){
                            beginnerSheet.toggle()
                        }
                        .fullScreenCover(isPresented: $beginnerSheet) {
                            BeginnerWorkoutView.init()
                            Button("Back") {
                                    beginnerSheet = false
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.gray)
                                .cornerRadius(8)
                                .padding()
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding()
                        
                        
                        //takes user to intermediate workout view
                        Button("Intermediate"){
                            intermediateSheet.toggle()
                        }
                        .fullScreenCover(isPresented: $intermediateSheet) {
                            IntermediateWorkoutView.init()
                            Button("Back") {
                                    intermediateSheet = false
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.gray)
                                .cornerRadius(8)
                                .padding()
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .padding()
                        
                       //takes user to advanced workout view
                        Button("Advanced"){
                            advancedSheet.toggle()
                        }
                        .fullScreenCover(isPresented: $advancedSheet) {
                            AdvancedWorkoutView.init()
                            Button("Back") {
                                    advancedSheet = false
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.gray)
                                .cornerRadius(8)
                                .padding()
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding()
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
    }
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        StartWorkoutView()
    }
}
