import SwiftUI

struct TopBoxingVideosView: View {
    @StateObject var videoManager = VideoManager() //requires video manager class from VideoManagment
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)] //sets grid for displaying video thumbnails
    var body: some View {
        //displays search query component and videos from pexels api
        NavigationView {
            VStack{
                Text("Top Videos")
                    .font(.title).foregroundColor(.white)
                //hstack is used to display search query tabs
                HStack{
                    ForEach(Query.allCases, id: \.self) {
                        searchQuery in
                        QueryTag(query: searchQuery, isQuerySelected: videoManager.selectedQuery == searchQuery)
                            .onTapGesture {
                                videoManager.selectedQuery = searchQuery
                            }
                    }
                }
                //scroll view is used display video thumbnail
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        //loops over api response and displays thumbnails for videos
                        ForEach(videoManager.videos, id: \.id) { video
                            in
                            NavigationLink {
                                //opens video in separate view
                                PexelsVideoView(video: video)
                            } label: {
                                VideoCard(video: video)
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct TopBoxingVideosView_Previews: PreviewProvider {
    static var previews: some View {
        TopBoxingVideosView()
    }
}
