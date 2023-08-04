import SwiftUI
import AVKit

struct PexelsVideoView: View {
    //creates video player using AVKit, passes pexels video url into it and automatically plays video
    var video: Video
    @State private var player = AVPlayer()
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                if let link = video.videoFiles.first?.link {
                    player = AVPlayer(url: URL(string: link)!)
                    player.play()
                }
            }
    }
}

struct PexelsVideoView_Previews: PreviewProvider {
    static var previews: some View {
        PexelsVideoView(video: previewVideo)
    }
}
