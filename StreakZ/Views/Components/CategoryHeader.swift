import SwiftUI

struct CategoryHeader: View {
    let title: String
    let imageName: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.bottom, 5)
        .overlay(Divider().background(Color.white), alignment: .bottom)
    }
}

struct CategoryHeader_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHeader(title: "Morning", imageName: "morningIcon")
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
