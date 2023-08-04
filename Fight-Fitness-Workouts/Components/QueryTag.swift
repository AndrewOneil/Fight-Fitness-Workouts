import SwiftUI
//creates resusable query tag component that is used in the top videos view
struct QueryTag: View {
    var query: Query
    var isQuerySelected: Bool
    
    var body: some View {
        Text(query.rawValue)
            .font(.caption)
            .bold()
            .foregroundColor(isQuerySelected ? .white : .black)
            .padding(10)
            .background(Color(isQuerySelected ? .red : .gray))
            .cornerRadius(10)
    }
}

struct QueryTag_Previews: PreviewProvider {
    static var previews: some View {
        QueryTag(query: Query.Boxing, isQuerySelected: true)
    }
}
