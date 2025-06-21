//
//  PDFViewerViewModel.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//


import Foundation

class PDFViewerViewModel {

    let pdfDocument = PDFDocumentModel(
        title: "Balance Sheet",
        url: URL(string: BookxpertPDF.apiURL)!
    )

    func loadPDF(completion: @escaping (Result<Data, Error>) -> Void) {
        PDFService.shared.fetchPDFData(from: pdfDocument.url, completion: completion)
    }
}

struct BookxpertPDF {
    static var apiURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BookXPert_PDF_URL") as? String else {
            fatalError("BookXPert_PDF_URL not set in Info.plist")
        }
        return url
    }
}
