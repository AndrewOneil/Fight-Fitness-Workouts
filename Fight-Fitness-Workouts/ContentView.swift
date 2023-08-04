import SwiftUI
import FirebaseAuth


//AppViewModel contains variables and functions used by the sign up and sign in views
class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var signedIn = false
    @Published var errorText = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    
    func validateFields() -> String? {
        
        //checks all fields all filled
        if firstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        //checks first name is valid
        if Validation.isNameValid(firstName) == false {
            return "Please Enter Valid First Name"
        }
        
        //checks last name is valid
        if Validation.isNameValid(lastName) == false {
            return "Please Enter Valid Last Name"
        }
        
        //checks that password is valid, displays error if not
        let cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validation.isPasswordValid(cleanedPassword) == false {
            return "Please make sure password is at least 8 characters, contains uppercase & lowercase letters, numbers & special characters"
        }
        return nil
    }
    
    //checks if user is signed in
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    //authenticates user with firebase and sign user into the app
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result,
            error in
            if error != nil {
                self?.errorText = error!.localizedDescription
                debugPrint(error!.localizedDescription)
            }
            else {
                DispatchQueue.main.async {
                    //success
                    self?.signedIn = true
                }
            }
        }
    }
    //creates user account with firebase and signs user into app
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email,
                        password: password) { [weak self] result,
            error in
            if error != nil {
                
                self?.errorText = error!.localizedDescription
                debugPrint(error!.localizedDescription)
        
            }
            else {
                //creates and stores display name which can be used to welcome user in home view
                if let currentUser = Auth.auth().currentUser {
                    let changeRequest = currentUser.createProfileChangeRequest()
                    changeRequest.displayName = "\(self!.firstName) " + "\(self!.lastName)"
                    changeRequest.commitChanges(completion: {(error) in
                        if let error = error {
                            print("--> firebase user display name error:- ", error)
                        }
                    })
                }
                //delays sign in by 1 second so username cna be displayed on homepage
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    //success
                    self?.signedIn = true
                }
            }
        }
    }
    //sign user out of firebase and takes them back to login view
    func signOut() {
        do {
            try auth.signOut()
            self.signedIn = false
        } catch {
            print(error)
        }
    }
}
//content view contains tab navigation bar, is only displayed if signedIn is true
struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.signedIn {
                    TabView(){
                        HomeView()
                            .tabItem{
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        StartWorkoutView()
                            .tabItem{
                                Image(systemName: "stopwatch")
                                Text("Start Workout")
                            }
                        TopBoxingVideosView()
                            .tabItem{
                                Image(systemName: "video.fill")
                                Text("Top Boxing & Fitness Videos")
                            }
                    }.accentColor(Color.red)
                    
                }
                else {
                    SignInView()
                }
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
    
    //Sign in view displays sign in form to user, is loaded when app first opens and user is not signed into firebase
    struct SignInView: View {
        @EnvironmentObject var viewModel: AppViewModel
        var body: some View {
            //error text displays any firebase errors
            let errorText = Text(viewModel.errorText).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
            //login form
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                
                Text("Fight-Fitness Workouts").font(.largeTitle).bold().padding().multilineTextAlignment(.center)
                
                VStack {
                    TextField("Email Address", text: $viewModel.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    
                    SecureField("Password", text: $viewModel.password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        viewModel.signIn(email: viewModel.email, password: viewModel.password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .cornerRadius(8)
                    })
                    NavigationLink("Create Account", destination: SignUpView())
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.gray)
                        .cornerRadius(8)
                        .padding()
                    //firebase errors
                    errorText
                }
                .padding()
                Spacer()
            }
        }
    }
    //sign up view displays sign up form
    struct SignUpView: View {
        @State var isToggleOn = false
        @State var textFieldIsDisabled = true
        @State var buttonIsDisabled = true
        //requires appviewmodel to use functions
        @EnvironmentObject var viewModel: AppViewModel
        
        var body: some View {
            //displays firebase errors
            let errorText = Text(viewModel.errorText).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
            //displays client-side validation errors
            let validationError: String? = viewModel.validateFields()
            
            
            //sign up form
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                
                VStack {
                    //all text fields are disabled untill user toggles button at bottom of view
                    TextField("First Name", text: $viewModel.firstName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .disabled(textFieldIsDisabled)
                    
                    TextField("Last Name", text: $viewModel.lastName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .disabled(textFieldIsDisabled)
                    
                    TextField("Email Address", text: $viewModel.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .disabled(textFieldIsDisabled)
                    
                    
                    SecureField("Password", text: $viewModel.password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        //checks for any validation errors before creating firebase account
                        if validationError != nil {
                            return
                        } else {
                            viewModel.signUp(email: viewModel.email, password: viewModel.password)
                        }
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .cornerRadius(8)
                        //sign up button is disabled until user toggles button at bottom of view
                    }).disabled(buttonIsDisabled)
                    //displays firebase errors
                    errorText
                    //displays validaion error if validationError contains an error message
                    if validationError != nil {
                        Text(validationError!).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    }
                }
                .padding()
                Spacer()
                //toggle button, user must toggle this to agree to their data being collected, cannot sign up until they do
                VStack{
                    Text("Please check switch to confirm you are over 18 and consent to you data being collected").multilineTextAlignment(.center)
                    Toggle("", isOn: $isToggleOn)
                        .labelsHidden()
                        .frame(alignment: .center)
                        .onChange(of: isToggleOn) {
                            newValue in
                            textFieldIsDisabled = !newValue
                            buttonIsDisabled = !newValue
                        }
                }
            }
            .navigationTitle("Create Account")
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
