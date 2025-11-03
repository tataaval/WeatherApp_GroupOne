
import Foundation

extension String {
    func formattedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMM, h:mm a"
            outputFormatter.locale = Locale(identifier: "en_US")

            return outputFormatter.string(from: date)
        } else {
            return self
        }
    }
}
