//
//  DictionaryContentView.swift
//  campair
//
//  Created by Lee Myeonghwan on 2022/06/17.
//

import Combine
import Foundation

final class DictionaryContentViewModel: ObservableObject {
    private let dictionaryUseCase = DictionaryUseCase(repository: DictionaryRepository())
    @Published var dictionaryEquipmentContent: DictionaryEquipmentContent?
    @Published var imageSet: [String: Data] = [:]
    func viewAppeared() {
        self.dictionaryUseCase.getDictionaryEquipmentContent {
            [weak self] dictionaryEquipmentContentData in
            guard let self = self else { return }
            self.dictionaryEquipmentContent = dictionaryEquipmentContentData
            print(dictionaryEquipmentContentData)
        }
    }
}
