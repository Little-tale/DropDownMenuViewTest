//
//  DropDownView.swift
//  DropDownMenuViewTest
//
//  Created by Jae hyung Kim on 8/27/24.
//

import SwiftUI

struct DropDownView: View {
    /// 해당 프로퍼티에 들어갈 옵션을 정해주세요
    let options: [String]
    /// 버튼의 대한 높이 입니다. 기본 50
    var buttonHeight: CGFloat  =  50
    /// 최대 보여질 갯수를 지정합니다. 기본 3
    var maxItemDisplayed: Int  =  3
    
    /// 해당 인덱스를 통해 선택된 옵션을 가져오거나 정하세요
    @Binding
    var selectedOptionIndex: Int
    
    @State
    private var showDropdown: Bool = false
    
    var body: some  View {
        VStack {
            VStack(spacing: 0) {
                // selected item
                selectedItemView()
                .padding(.horizontal, 20)
                .frame(height: buttonHeight, alignment: .leading)
                ifShowDownView()
            }
            .foregroundStyle(.black)
        }
        .frame(height: buttonHeight, alignment: .top)
        .padding(.horizontal, 125)
    }
}
extension DropDownView {
    
    @ViewBuilder
    private func ifShowDownView() -> some View {
        if showDropdown {
            let scrollViewHeight: CGFloat = dropDownViewHeight()
            ScrollViewReader { proxy in
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<options.count, id: \.self) { index in
                            openSelectedItemView(index: index, proxy: proxy)
                                .id(index)
                            .padding(.horizontal, 20)
                            .frame(height: buttonHeight, alignment: .leading)
                        }
                    }
                }
                .scrollDisabled(options.count <=  3)
                .frame(height: scrollViewHeight)
                .onAppear {
                    proxy.scrollTo(selectedOptionIndex)
                }
            }
        }
    }
    
    
    private func openSelectedItemView(index: Int, proxy: ScrollViewProxy) -> some View {
        Button(action: {
            withAnimation {
                selectedOptionIndex = index
                showDropdown.toggle()
            }
        }, label: {
            HStack {
                Text(options[index])
                Spacer()
                if (index == selectedOptionIndex) {
                    Image(systemName: "checkmark.circle.fill")
                }
            }
        })
    }
    
    private func selectedItemView() -> some View {
        VStack {
            Button{
                withAnimation {
                    showDropdown.toggle()
                }
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: nil) {
                        Text(options[selectedOptionIndex])
                        Spacer()
                        Image(systemName: "chevron.up")
                            .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                    }
                    .padding(.bottom, 4)
                    Divider()
                        .frame(height: 2)
                        .overlay(Color.green)
                }
            }
        }
    }
}

extension DropDownView {
    private func dropDownViewHeight() -> CGFloat {
        let condition = options.count > maxItemDisplayed
        return condition ? (buttonHeight * CGFloat(maxItemDisplayed)) : (buttonHeight * CGFloat(options.count))
    }
}


struct testView: View {
    
    @State
    var currentSelectedIndex = 0
    
    var body: some View {
        DropDownView(options: ["쉴휴","잭과 콩나물", "맨토스"], selectedOptionIndex: $currentSelectedIndex)
    }
}

#if DEBUG
#Preview {
    testView()
}
#endif
