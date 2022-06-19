//
//  DictionaryDetailedView.swift
//  campair
//
//  Created by 박진웅 on 2022/06/15.
//

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct DictionaryDetailedView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var selectedEquipmentNumber: Int = 0
    @State var scrollIndex: Int = 1
    @ObservedObject var viewModel = DictionaryDetailedViewModel()

    var body: some View {
            VStack(spacing: 0) {
                Rectangle()
                    .ignoresSafeArea()
                    .frame(height: 0)
                    .foregroundColor(Color(hex: "FEFCFB"))
                HStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.black)
                    })
                    .padding(.leading, 8)
                    Spacer()
                    Text(viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory[selectedEquipmentNumber].name)
                        .padding(.trailing, 179)
                }
                .padding(.bottom, 25)
                .background(Color(hex: "FEFCFB"))
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 0) {
                            ForEach(viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory.indices, id: \.self) { index in
                                Button {
                                    selectedEquipmentNumber = index
                                    scrollIndex = index
                                } label: {
                                    Text(viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory[index].name)
                                        .foregroundColor(self.selectedEquipmentNumber == index ? Color.white : Color(#colorLiteral(red: 0.6071556211, green: 0.603967011, blue: 0.6179282665, alpha: 1)))
                                        .font(.system(.subheadline, design: .default))
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, self.selectedEquipmentNumber == index ? 4 : 0)
                                        .background(RoundedRectangle(cornerRadius: 17.5)
                                            .foregroundColor(self.selectedEquipmentNumber == index ? Color(#colorLiteral(red: 0.3830943704, green: 0.3830943704, blue: 0.3830943704, alpha: 1)) : Color(hex:"FEFCFB"))
                                                     )
                                    }
                                }
                                .onChange(of: scrollIndex, perform: { value in
                                    withAnimation(.spring()) {
                                        proxy.scrollTo(value, anchor: .center)
                                    }
                                })
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 19)
                    .background(Color(hex:"FEFCFB"))

                Rectangle()
                    .frame(height:1)
                    .foregroundColor(Color(hex:"E8E8E8"))

                ScrollView {
                    ScrollViewReader { proxy in
                        ForEach(viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory.indices, id: \.self) { preindex in
                            VStack {
                                Text(viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory[preindex].name)
                                    .font(.system(.title))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: 350, alignment: .leading)
                                    .padding(.bottom, 14)
                                    .padding(.top, 41)
                                ForEach(viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory[preindex].equipmentList.indices, id: \.self) { index in
                                    NavigationLink(destination: DictionaryContentView(equipmentContent:
                                                                                        DictionaryEquipmentContent(
                                                                                            name: "그늘막 텐트",
                                                                                            paintingName: "paint_1",
                                                                                            paintingURLString: "",
                                                                                            content: "그늘막 텐트는 간편한 설치로 햇빛을 막을 수 있어요. 가격이 저렴한 편이고, 무게와 부피가 가벼워서 가벼운 피크닉 전용 텐트에요.",
                                                                                            pros: ["의자에서 누워있는 듯한 느낌이에요.", "'쉼'을 목적으로 나온 의자.", "다리 폭이 넓어서 넘어질 위험이 적어요."],
                                                                                            cons: ["접었을 때도 사이즈가 크고 무거워요.", "앉아서 음식을 먹거나 책을 읽을 때는 불편할 수 있어요."],
                                                                                            installationGuide: "접혀있는 의자를 그대로 펼치기 때문에 설치가 편리해요."
                                                                                        ), equipmentCategory: "텐트"
                                                                ), label: {
                                        EquipmentBox(imageSet: self.$viewModel.imageSet, imageName: self.viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory[preindex].equipmentList[index].paintingName, equipmentName: self.viewModel.dictionaryPreDetailCategory.dictionaryDetailCategory[preindex].equipmentList[index].name)
                                    })
                                    .padding(.bottom, index != 5 ? 6 : 40)
                                }
                                Rectangle()
                                    .frame(height: 8)
                                    .foregroundColor(Color(hex: "FEFCFB"))
                            }
                        }
                        .onChange(of: scrollIndex, perform: { value in
                            withAnimation(.spring()) {
                                proxy.scrollTo(value, anchor: .top)
                            }
                        })
                    }
                }
            }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .onAppear {
                    UINavigationBar.appearance().backgroundColor = .init(Color(hex:"FEFCFB")!)
                }
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    viewModel.viewAppeared()
                    //scrollIndex = 1
                }
    }
}

struct DictionaryDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DictionaryDetailedView()
        }
    }
}

struct EquipmentBox: View {
    @Binding var imageSet: [String: Data]
    let imageName: String
    let equipmentName: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(#colorLiteral(red: 0.9688159823, green: 0.9688159823, blue: 0.9688159823, alpha: 1)), lineWidth: 1)
                .frame(width: 350, height: 84)
            HStack(spacing: 0) {
                if let uiImage = UIImage(data: imageSet[self.imageName] ?? imageSet["none"]!) {
                    Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 66, height: 66)
                    .padding(.leading, 30)
                }
                Text(self.equipmentName)
                    .font(.system(.headline, design: .default))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 0.3830943704, green: 0.3830943704, blue: 0.3830943704, alpha: 1)))
                    .font(Font.system(size: 17))
                    .padding(.leading, 10)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(#colorLiteral(red: 0.8209876418, green: 0.821508944, blue: 0.8374733329, alpha: 1)))
                    .frame(width: 34, height: 34)
                    .padding(.trailing, 34)
            }
        }
    }
}
