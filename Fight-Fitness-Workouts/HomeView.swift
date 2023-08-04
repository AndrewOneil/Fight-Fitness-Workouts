import SwiftUI
import FirebaseAuth

//home view is displayed when user signs in, contains button to sign out and navigate to workout and top videos views
struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isPresented = false
    
    
    //authenticated user stored as constant
    var currentUser = Auth.auth().currentUser
    
    let auth = Auth.auth()
    
    var body: some View {
        //users display name stored as constant
        let userName: String? = currentUser?.displayName
        //card that contains buttons
        NavigationView {
            ZStack{
                //adds white background behind buttons
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .frame(width: 300, height: 400)
                VStack{
                    //checks if user has a display name to prevent app from crashing
                    if userName == nil {
                        //generic welcome message
                        Text("Welcome to Fight-Fitness Workouts")
                            .font(.system(size: 25)).bold().foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.center)
                    } else {
                        //personalised welcome message
                        Text("Welcome to Fight-Fitness Workouts " + userName!)
                            .font(.system(size: 25)).bold().foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    
                    //takes user to start workout view
                    NavigationLink(destination: StartWorkoutView()) {
                        Label("Start Workout", systemImage: "stopwatch")
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .cornerRadius(8)
                    .padding()
                    
                    
                    //takes user to top videos view
                    NavigationLink(destination: TopBoxingVideosView()) {
                        Label("Top Videos", systemImage: "video.fill")
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .cornerRadius(8)
                    .padding()
                    
                    //signs user out of firebase and navigates back to login view
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("\(Image(systemName: "rectangle.portrait.and.arrow.right.fill")) Sign Out")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding()
                    })
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}
        

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
