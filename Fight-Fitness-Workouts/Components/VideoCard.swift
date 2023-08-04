import SwiftUI
//video card class creates a reusable video thumbnail that is used in the top videos view
struct VideoCard: View {
    var video: Video
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                //displays video image on thumbnail
                AsyncImage(url: URL(string: video.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 250)
                        .cornerRadius(30)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                        .frame(width: 160, height: 250)
                        .cornerRadius(30)
                }
                VStack(alignment: .leading) {
                    //displays video duration at the bottom of thumbnail
                    Text("\(video.duration) sec")
                        .font(.caption).bold()
                    //displays video author at the bottom of thumbnail
                    Text("By \(video.user.name)")
                        .font(.caption).bold()
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.white)
                .shadow(radius: 20)
                .padding()
            }
            //play button is displayed in the middle of card
            Image(systemName: "play.fill")
                .foregroundColor(.red)
                .font(.title)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(50)
        }
    }
}

struct VideoCard_Previews: PreviewProvider {
    static var previews: some View {
        VideoCard(video: previewVideo)
    }
}
